-- Migrations for MedRep Pro Enterprise Database Schema (Idempotent Setup)

-- 1. Enable Required Extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- 2. Audit Logging System
CREATE TABLE IF NOT EXISTS audit_logs (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id text NOT NULL,
  table_name text NOT NULL,
  record_id uuid NOT NULL,
  action text NOT NULL,
  old_data jsonb,
  new_data jsonb,
  changed_by text,
  created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Trigger function to automatically log data modifications
CREATE OR REPLACE FUNCTION process_audit_logging() RETURNS trigger AS $$
DECLARE
  v_tenant_id text;
  v_user_id text;
  v_record_id uuid;
  v_old jsonb := null;
  v_new jsonb := null;
BEGIN
  BEGIN
    v_tenant_id := coalesce(nullif(auth.jwt() ->> 'tenant_id', ''), 'default');
    v_user_id := coalesce(nullif(auth.jwt() ->> 'sub', ''), 'system');
  EXCEPTION WHEN OTHERS THEN
    v_tenant_id := 'system';
    v_user_id := 'system';
  END;

  IF (TG_OP = 'DELETE') THEN
    v_record_id := COALESCE((to_jsonb(OLD) ->> 'id')::uuid, uuid_generate_v4());
    v_old := to_jsonb(OLD);
    INSERT INTO audit_logs (tenant_id, table_name, record_id, action, old_data, changed_by)
    VALUES (v_tenant_id, TG_TABLE_NAME, v_record_id, TG_OP, v_old, v_user_id);
    RETURN OLD;
  ELSIF (TG_OP = 'UPDATE') THEN
    v_record_id := (to_jsonb(NEW) ->> 'id')::uuid;
    v_old := to_jsonb(OLD);
    v_new := to_jsonb(NEW);
    INSERT INTO audit_logs (tenant_id, table_name, record_id, action, old_data, new_data, changed_by)
    VALUES (v_tenant_id, TG_TABLE_NAME, v_record_id, TG_OP, v_old, v_new, v_user_id);
    RETURN NEW;
  ELSIF (TG_OP = 'INSERT') THEN
    v_record_id := (to_jsonb(NEW) ->> 'id')::uuid;
    v_new := to_jsonb(NEW);
    INSERT INTO audit_logs (tenant_id, table_name, record_id, action, new_data, changed_by)
    VALUES (v_tenant_id, TG_TABLE_NAME, v_record_id, TG_OP, v_new, v_user_id);
    RETURN NEW;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 3. Core Master Tables

-- Doctors Module
CREATE TABLE IF NOT EXISTS doctors (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id text NOT NULL,
  name text NOT NULL,
  specialty text NOT NULL,
  email text,
  phone text,
  clinic_address text,
  geolocation geography(Point, 4326),
  territory_id integer REFERENCES territories(id) ON DELETE SET NULL,
  client_created_at timestamp with time zone NOT NULL,
  last_modified_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  is_deleted boolean DEFAULT false NOT NULL,
  server_synced_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Chemists Module
CREATE TABLE IF NOT EXISTS chemists (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id text NOT NULL,
  name text NOT NULL,
  contact_person text,
  phone text,
  address text,
  geolocation geography(Point, 4326),
  territory_id integer REFERENCES territories(id) ON DELETE SET NULL,
  client_created_at timestamp with time zone NOT NULL,
  last_modified_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  is_deleted boolean DEFAULT false NOT NULL,
  server_synced_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Products Catalog
CREATE TABLE IF NOT EXISTS products (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id text NOT NULL,
  name text NOT NULL,
  sku text NOT NULL UNIQUE,
  description text,
  price numeric(10,2) NOT NULL,
  category text NOT NULL,
  client_created_at timestamp with time zone NOT NULL,
  last_modified_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  is_deleted boolean DEFAULT false NOT NULL,
  server_synced_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


-- 4. High-Volume Transactional Tables (Region Partitioned)

-- Daily Call Reports (DCR) Table
CREATE TABLE IF NOT EXISTS dcr (
  id uuid NOT NULL,
  tenant_id text NOT NULL,
  user_id text REFERENCES profiles(id) ON DELETE CASCADE,
  target_type text NOT NULL,
  target_id uuid NOT NULL,
  visit_date date NOT NULL,
  visit_time time NOT NULL,
  status text DEFAULT 'completed' NOT NULL,
  notes text,
  region text NOT NULL,
  client_created_at timestamp with time zone NOT NULL,
  last_modified_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  is_deleted boolean DEFAULT false NOT NULL,
  server_synced_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  PRIMARY KEY (id, region)
) PARTITION BY LIST (region);

-- Create Regional Partitions for DCR
CREATE TABLE IF NOT EXISTS dcr_north PARTITION OF dcr FOR VALUES IN ('North');
CREATE TABLE IF NOT EXISTS dcr_south PARTITION OF dcr FOR VALUES IN ('South');
CREATE TABLE IF NOT EXISTS dcr_east PARTITION OF dcr FOR VALUES IN ('East');
CREATE TABLE IF NOT EXISTS dcr_west PARTITION OF dcr FOR VALUES IN ('West');
CREATE TABLE IF NOT EXISTS dcr_default PARTITION OF dcr DEFAULT;

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (
  id uuid NOT NULL,
  tenant_id text NOT NULL,
  user_id text REFERENCES profiles(id) ON DELETE CASCADE,
  chemist_id uuid REFERENCES chemists(id) ON DELETE RESTRICT,
  order_date date NOT NULL,
  status text DEFAULT 'pending' NOT NULL,
  total_amount numeric(12,2) NOT NULL,
  region text NOT NULL,
  client_created_at timestamp with time zone NOT NULL,
  last_modified_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  is_deleted boolean DEFAULT false NOT NULL,
  server_synced_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  PRIMARY KEY (id, region)
) PARTITION BY LIST (region);

-- Create Regional Partitions for Orders
CREATE TABLE IF NOT EXISTS orders_north PARTITION OF orders FOR VALUES IN ('North');
CREATE TABLE IF NOT EXISTS orders_south PARTITION OF orders FOR VALUES IN ('South');
CREATE TABLE IF NOT EXISTS orders_east PARTITION OF orders FOR VALUES IN ('East');
CREATE TABLE IF NOT EXISTS orders_west PARTITION OF orders FOR VALUES IN ('West');
CREATE TABLE IF NOT EXISTS orders_default PARTITION OF orders DEFAULT;

-- Order Items (Line Items) Table
CREATE TABLE IF NOT EXISTS order_items (
  id uuid NOT NULL,
  order_id uuid NOT NULL,
  product_id uuid REFERENCES products(id) ON DELETE RESTRICT,
  quantity integer NOT NULL,
  unit_price numeric(10,2) NOT NULL,
  region text NOT NULL,
  PRIMARY KEY (id, region)
) PARTITION BY LIST (region);

CREATE TABLE IF NOT EXISTS order_items_north PARTITION OF order_items FOR VALUES IN ('North');
CREATE TABLE IF NOT EXISTS order_items_south PARTITION OF order_items FOR VALUES IN ('South');
CREATE TABLE IF NOT EXISTS order_items_east PARTITION OF order_items FOR VALUES IN ('East');
CREATE TABLE IF NOT EXISTS order_items_west PARTITION OF order_items FOR VALUES IN ('West');
CREATE TABLE IF NOT EXISTS order_items_default PARTITION OF order_items DEFAULT;

-- Expenses Table
CREATE TABLE IF NOT EXISTS expenses (
  id uuid NOT NULL,
  tenant_id text NOT NULL,
  user_id text REFERENCES profiles(id) ON DELETE CASCADE,
  claim_date date NOT NULL,
  amount numeric(10,2) NOT NULL,
  category text NOT NULL,
  status text DEFAULT 'pending' NOT NULL,
  receipt_url text,
  region text NOT NULL,
  client_created_at timestamp with time zone NOT NULL,
  last_modified_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  is_deleted boolean DEFAULT false NOT NULL,
  server_synced_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  PRIMARY KEY (id, region)
) PARTITION BY LIST (region);

-- Create Regional Partitions for Expenses
CREATE TABLE IF NOT EXISTS expenses_north PARTITION OF expenses FOR VALUES IN ('North');
CREATE TABLE IF NOT EXISTS expenses_south PARTITION OF expenses FOR VALUES IN ('South');
CREATE TABLE IF NOT EXISTS expenses_east PARTITION OF expenses FOR VALUES IN ('East');
CREATE TABLE IF NOT EXISTS expenses_west PARTITION OF expenses FOR VALUES IN ('West');
CREATE TABLE IF NOT EXISTS expenses_default PARTITION OF expenses DEFAULT;


-- 5. Standard Standard Operations Tables

-- Targets Module
CREATE TABLE IF NOT EXISTS targets (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id text NOT NULL,
  user_id text REFERENCES profiles(id) ON DELETE CASCADE,
  target_month date NOT NULL,
  target_amount numeric(12,2) NOT NULL,
  achieved_amount numeric(12,2) DEFAULT 0.00 NOT NULL,
  client_created_at timestamp with time zone NOT NULL,
  last_modified_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  is_deleted boolean DEFAULT false NOT NULL,
  server_synced_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Samples Tracking (Distributed to Doctors)
CREATE TABLE IF NOT EXISTS samples (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id text NOT NULL,
  doctor_id uuid REFERENCES doctors(id) ON DELETE CASCADE,
  product_id uuid REFERENCES products(id) ON DELETE RESTRICT,
  quantity_distributed integer NOT NULL,
  distributed_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  client_created_at timestamp with time zone NOT NULL,
  last_modified_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  is_deleted boolean DEFAULT false NOT NULL,
  server_synced_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Payments Collection
CREATE TABLE IF NOT EXISTS payments (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id text NOT NULL,
  chemist_id uuid REFERENCES chemists(id) ON DELETE RESTRICT,
  amount_collected numeric(12,2) NOT NULL,
  payment_method text NOT NULL,
  payment_date date NOT NULL,
  status text DEFAULT 'pending_clearance' NOT NULL,
  client_created_at timestamp with time zone NOT NULL,
  last_modified_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  is_deleted boolean DEFAULT false NOT NULL,
  server_synced_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Notifications Queue
CREATE TABLE IF NOT EXISTS notifications (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  tenant_id text NOT NULL,
  user_id text REFERENCES profiles(id) ON DELETE CASCADE,
  title text NOT NULL,
  body text NOT NULL,
  is_read boolean DEFAULT false NOT NULL,
  client_created_at timestamp with time zone NOT NULL,
  last_modified_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  is_deleted boolean DEFAULT false NOT NULL,
  server_synced_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- AI Diagnostic & Query Logs
CREATE TABLE IF NOT EXISTS ai_logs (
  id uuid NOT NULL,
  tenant_id text NOT NULL,
  user_id text REFERENCES profiles(id) ON DELETE CASCADE,
  query_text text NOT NULL,
  response_text text,
  feedback_rating integer,
  region text NOT NULL,
  created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
  PRIMARY KEY (id, region)
) PARTITION BY LIST (region);

CREATE TABLE IF NOT EXISTS ai_logs_north PARTITION OF ai_logs FOR VALUES IN ('North');
CREATE TABLE IF NOT EXISTS ai_logs_south PARTITION OF ai_logs FOR VALUES IN ('South');
CREATE TABLE IF NOT EXISTS ai_logs_east PARTITION OF ai_logs FOR VALUES IN ('East');
CREATE TABLE IF NOT EXISTS ai_logs_west PARTITION OF ai_logs FOR VALUES IN ('West');
CREATE TABLE IF NOT EXISTS ai_logs_default PARTITION OF ai_logs DEFAULT;


-- 6. Setup Triggers for Change Capture (Audit Logging)
DROP TRIGGER IF EXISTS audit_doctors_trigger ON doctors;
CREATE TRIGGER audit_doctors_trigger AFTER INSERT OR UPDATE OR DELETE ON doctors FOR EACH ROW EXECUTE FUNCTION process_audit_logging();

DROP TRIGGER IF EXISTS audit_chemists_trigger ON chemists;
CREATE TRIGGER audit_chemists_trigger AFTER INSERT OR UPDATE OR DELETE ON chemists FOR EACH ROW EXECUTE FUNCTION process_audit_logging();

DROP TRIGGER IF EXISTS audit_products_trigger ON products;
CREATE TRIGGER audit_products_trigger AFTER INSERT OR UPDATE OR DELETE ON products FOR EACH ROW EXECUTE FUNCTION process_audit_logging();

DROP TRIGGER IF EXISTS audit_dcr_trigger ON dcr;
CREATE TRIGGER audit_dcr_trigger AFTER INSERT OR UPDATE OR DELETE ON dcr FOR EACH ROW EXECUTE FUNCTION process_audit_logging();

DROP TRIGGER IF EXISTS audit_orders_trigger ON orders;
CREATE TRIGGER audit_orders_trigger AFTER INSERT OR UPDATE OR DELETE ON orders FOR EACH ROW EXECUTE FUNCTION process_audit_logging();

DROP TRIGGER IF EXISTS audit_expenses_trigger ON expenses;
CREATE TRIGGER audit_expenses_trigger AFTER INSERT OR UPDATE OR DELETE ON expenses FOR EACH ROW EXECUTE FUNCTION process_audit_logging();

DROP TRIGGER IF EXISTS audit_targets_trigger ON targets;
CREATE TRIGGER audit_targets_trigger AFTER INSERT OR UPDATE OR DELETE ON targets FOR EACH ROW EXECUTE FUNCTION process_audit_logging();

DROP TRIGGER IF EXISTS audit_samples_trigger ON samples;
CREATE TRIGGER audit_samples_trigger AFTER INSERT OR UPDATE OR DELETE ON samples FOR EACH ROW EXECUTE FUNCTION process_audit_logging();

DROP TRIGGER IF EXISTS audit_payments_trigger ON payments;
CREATE TRIGGER audit_payments_trigger AFTER INSERT OR UPDATE OR DELETE ON payments FOR EACH ROW EXECUTE FUNCTION process_audit_logging();


-- 7. High-Performance Indexing Strategy
CREATE INDEX IF NOT EXISTS idx_doctors_tenant_territory ON doctors (tenant_id, territory_id);
CREATE INDEX IF NOT EXISTS idx_doctors_geo ON doctors USING gist (geolocation);

CREATE INDEX IF NOT EXISTS idx_chemists_tenant_territory ON chemists (tenant_id, territory_id);
CREATE INDEX IF NOT EXISTS idx_chemists_geo ON chemists USING gist (geolocation);

CREATE INDEX IF NOT EXISTS idx_products_tenant_sku ON products (tenant_id, sku);

CREATE INDEX IF NOT EXISTS idx_dcr_tenant_date ON dcr (tenant_id, visit_date);
CREATE INDEX IF NOT EXISTS idx_dcr_user ON dcr (user_id);

CREATE INDEX IF NOT EXISTS idx_orders_tenant_date ON orders (tenant_id, order_date);
CREATE INDEX IF NOT EXISTS idx_orders_chemist ON orders (chemist_id);

CREATE INDEX IF NOT EXISTS idx_expenses_tenant_status ON expenses (tenant_id, status);

CREATE INDEX IF NOT EXISTS idx_targets_user_month ON targets (user_id, target_month);

CREATE INDEX IF NOT EXISTS idx_payments_chemist ON payments (chemist_id);


-- 8. Row-Level Security (RLS) Configuration

-- Enable RLS on all operational tables
ALTER TABLE doctors ENABLE ROW LEVEL SECURITY;
ALTER TABLE chemists ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE dcr ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE targets ENABLE ROW LEVEL SECURITY;
ALTER TABLE samples ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_logs ENABLE ROW LEVEL SECURITY;

-- Dynamic RLS policies mapping (Clean Setup)
DROP POLICY IF EXISTS "Doctors select rules" ON doctors;
CREATE POLICY "Doctors select rules" ON doctors FOR SELECT USING (
  tenant_id = requesting_user_tenant_id() AND (
    requesting_user_role() IN ('admin', 'manager') OR territory_id = ANY(requesting_user_territory_ids())
  )
);

DROP POLICY IF EXISTS "Doctors modification rules" ON doctors;
CREATE POLICY "Doctors modification rules" ON doctors FOR ALL USING (
  tenant_id = requesting_user_tenant_id() AND requesting_user_role() IN ('admin', 'manager')
);

DROP POLICY IF EXISTS "Chemists select rules" ON chemists;
CREATE POLICY "Chemists select rules" ON chemists FOR SELECT USING (
  tenant_id = requesting_user_tenant_id() AND (
    requesting_user_role() IN ('admin', 'manager') OR territory_id = ANY(requesting_user_territory_ids())
  )
);

DROP POLICY IF EXISTS "Chemists modification rules" ON chemists;
CREATE POLICY "Chemists modification rules" ON chemists FOR ALL USING (
  tenant_id = requesting_user_tenant_id() AND requesting_user_role() IN ('admin', 'manager')
);

DROP POLICY IF EXISTS "Products tenant visible" ON products;
CREATE POLICY "Products tenant visible" ON products FOR SELECT USING (tenant_id = requesting_user_tenant_id());

DROP POLICY IF EXISTS "Products modifications admin" ON products;
CREATE POLICY "Products modifications admin" ON products FOR ALL USING (tenant_id = requesting_user_tenant_id() AND requesting_user_role() = 'admin');

DROP POLICY IF EXISTS "DCR view policy" ON dcr;
CREATE POLICY "DCR view policy" ON dcr FOR SELECT USING (
  tenant_id = requesting_user_tenant_id() AND (user_id = requesting_user_id() OR requesting_user_role() IN ('admin', 'manager'))
);

DROP POLICY IF EXISTS "DCR modification policy" ON dcr;
CREATE POLICY "DCR modification policy" ON dcr FOR ALL USING (tenant_id = requesting_user_tenant_id() AND user_id = requesting_user_id());

DROP POLICY IF EXISTS "Orders view policy" ON orders;
CREATE POLICY "Orders view policy" ON orders FOR SELECT USING (
  tenant_id = requesting_user_tenant_id() AND (user_id = requesting_user_id() OR requesting_user_role() IN ('admin', 'manager'))
);

DROP POLICY IF EXISTS "Orders modification policy" ON orders;
CREATE POLICY "Orders modification policy" ON orders FOR ALL USING (tenant_id = requesting_user_tenant_id() AND user_id = requesting_user_id());

DROP POLICY IF EXISTS "Order items visible if order visible" ON order_items;
CREATE POLICY "Order items visible if order visible" ON order_items FOR ALL USING (
  EXISTS (SELECT 1 FROM orders WHERE orders.id = order_items.order_id)
);

DROP POLICY IF EXISTS "Expenses view policy" ON expenses;
CREATE POLICY "Expenses view policy" ON expenses FOR SELECT USING (
  tenant_id = requesting_user_tenant_id() AND (user_id = requesting_user_id() OR requesting_user_role() IN ('admin', 'manager'))
);

DROP POLICY IF EXISTS "Expenses modification policy" ON expenses;
CREATE POLICY "Expenses modification policy" ON expenses FOR ALL USING (tenant_id = requesting_user_tenant_id() AND user_id = requesting_user_id());

DROP POLICY IF EXISTS "Targets view policy" ON targets;
CREATE POLICY "Targets view policy" ON targets FOR SELECT USING (
  tenant_id = requesting_user_tenant_id() AND (user_id = requesting_user_id() OR requesting_user_role() IN ('admin', 'manager'))
);

DROP POLICY IF EXISTS "Targets modification policy" ON targets;
CREATE POLICY "Targets modification policy" ON targets FOR ALL USING (tenant_id = requesting_user_tenant_id() AND requesting_user_role() = 'admin');

DROP POLICY IF EXISTS "Samples view policy" ON samples;
CREATE POLICY "Samples view policy" ON samples FOR SELECT USING (tenant_id = requesting_user_tenant_id());

DROP POLICY IF EXISTS "Samples modification policy" ON samples;
CREATE POLICY "Samples modification policy" ON samples FOR ALL USING (tenant_id = requesting_user_tenant_id() AND requesting_user_role() IN ('admin', 'manager'));

DROP POLICY IF EXISTS "Payments view policy" ON payments;
CREATE POLICY "Payments view policy" ON payments FOR SELECT USING (
  tenant_id = requesting_user_tenant_id() AND (
    requesting_user_role() IN ('admin', 'manager') OR
    chemist_id IN (SELECT id FROM chemists WHERE territory_id = ANY(requesting_user_territory_ids()))
  )
);

DROP POLICY IF EXISTS "Payments modification policy" ON payments;
CREATE POLICY "Payments modification policy" ON payments FOR ALL USING (tenant_id = requesting_user_tenant_id() AND requesting_user_role() IN ('admin', 'manager'));

DROP POLICY IF EXISTS "Notifications access policy" ON notifications;
CREATE POLICY "Notifications access policy" ON notifications FOR ALL USING (tenant_id = requesting_user_tenant_id() AND user_id = requesting_user_id());

DROP POLICY IF EXISTS "AI logs access policy" ON ai_logs;
CREATE POLICY "AI logs access policy" ON ai_logs FOR ALL USING (tenant_id = requesting_user_tenant_id() AND user_id = requesting_user_id());
