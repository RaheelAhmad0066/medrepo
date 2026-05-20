-- MedRep Pro - Supabase Schema Initialization
-- Execute this script in the Supabase SQL Editor to set up all tables and seed data.

-- 1. Create EXTENSION for UUIDs if not exists
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Drop existing tables if they exist (in reverse order of dependencies)
DROP TABLE IF EXISTS competitor_activities CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS expenses CASCADE;
DROP TABLE IF EXISTS sample_distributions CASCADE;
DROP TABLE IF EXISTS sample_inventory CASCADE;
DROP TABLE IF EXISTS targets CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS dcr_chemist_visits CASCADE;
DROP TABLE IF EXISTS dcr_visit_products CASCADE;
DROP TABLE IF EXISTS dcr_doctor_visits CASCADE;
DROP TABLE IF EXISTS dcrs CASCADE;
DROP TABLE IF EXISTS tour_plan_entries CASCADE;
DROP TABLE IF EXISTS tour_plans CASCADE;
DROP TABLE IF EXISTS product_price_history CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS chemists CASCADE;
DROP TABLE IF EXISTS doctors CASCADE;
DROP TABLE IF EXISTS profiles CASCADE;
DROP TABLE IF EXISTS territories CASCADE;

-- 3. Create Tables
-- TERRITORIES
CREATE TABLE territories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  region text CHECK (region IN ('North', 'South', 'East', 'West')),
  created_at timestamptz DEFAULT now()
);

-- PROFILES
CREATE TABLE profiles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  clerk_user_id text UNIQUE NOT NULL,
  full_name text NOT NULL,
  email text UNIQUE NOT NULL,
  phone text,
  role text CHECK (role IN ('admin','manager','medical_rep')),
  territory_id uuid references territories(id) ON DELETE SET NULL,
  manager_id uuid references profiles(id) ON DELETE SET NULL,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

-- DOCTORS
CREATE TABLE doctors (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  specialty text,
  clinic_name text,
  area text,
  city text,
  phone text,
  email text,
  tier text CHECK (tier IN ('A','B','C')),
  preferred_visit_time text,
  notes text,
  territory_id uuid references territories(id) ON DELETE SET NULL,
  created_by uuid references profiles(id) ON DELETE SET NULL,
  lat double precision,
  lng double precision,
  created_at timestamptz DEFAULT now()
);

-- CHEMISTS
CREATE TABLE chemists (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  shop_name text NOT NULL,
  owner_name text,
  area text,
  city text,
  phone text,
  credit_limit numeric DEFAULT 0,
  outstanding_balance numeric DEFAULT 0,
  priority text CHECK (priority IN ('high','regular','occasional')),
  territory_id uuid references territories(id) ON DELETE SET NULL,
  created_by uuid references profiles(id) ON DELETE SET NULL,
  lat double precision,
  lng double precision,
  last_visited_at timestamptz,
  created_at timestamptz DEFAULT now()
);

-- PRODUCTS
CREATE TABLE products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  sku text UNIQUE NOT NULL,
  formulation text,
  category text,
  net_price numeric NOT NULL,
  pack_size text,
  is_sample_eligible boolean DEFAULT false,
  is_active boolean DEFAULT true,
  visual_aid_url text,
  created_at timestamptz DEFAULT now()
);

-- ORDERS
CREATE TABLE orders (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rep_id uuid references profiles(id) ON DELETE SET NULL,
  chemist_id uuid references chemists(id) ON DELETE SET NULL,
  order_date date NOT NULL DEFAULT current_date,
  status text CHECK (status IN ('draft','submitted','confirmed','dispatched','delivered','paid')),
  total_amount numeric DEFAULT 0,
  invoice_number text,
  manager_note text,
  created_at timestamptz DEFAULT now()
);

-- ORDER ITEMS
CREATE TABLE order_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id uuid references orders(id) ON DELETE CASCADE,
  product_id uuid references products(id) ON DELETE RESTRICT,
  quantity int NOT NULL,
  unit_price numeric NOT NULL,
  subtotal numeric GENERATED ALWAYS AS (quantity * unit_price) STORED
);

-- DCRS
CREATE TABLE dcrs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  rep_id uuid references profiles(id) ON DELETE SET NULL,
  date date NOT NULL DEFAULT current_date,
  status text CHECK (status IN ('draft','submitted','acknowledged')),
  manager_comment text,
  voice_memo_url text,
  submitted_at timestamptz,
  created_at timestamptz DEFAULT now()
);

-- 4. Enable Row Level Security (RLS) on all tables
ALTER TABLE territories ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE doctors ENABLE ROW LEVEL SECURITY;
ALTER TABLE chemists ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE dcrs ENABLE ROW LEVEL SECURITY;

-- 5. Create Permissive Policies for Development
-- (Allows full read/write for verified applications)
CREATE POLICY "Allow public read" ON territories FOR SELECT USING (true);
CREATE POLICY "Allow public write" ON territories FOR ALL USING (true);

CREATE POLICY "Allow public read" ON profiles FOR SELECT USING (true);
CREATE POLICY "Allow public write" ON profiles FOR ALL USING (true);

CREATE POLICY "Allow public read" ON doctors FOR SELECT USING (true);
CREATE POLICY "Allow public write" ON doctors FOR ALL USING (true);

CREATE POLICY "Allow public read" ON chemists FOR SELECT USING (true);
CREATE POLICY "Allow public write" ON chemists FOR ALL USING (true);

CREATE POLICY "Allow public read" ON products FOR SELECT USING (true);
CREATE POLICY "Allow public write" ON products FOR ALL USING (true);

CREATE POLICY "Allow public read" ON orders FOR SELECT USING (true);
CREATE POLICY "Allow public write" ON orders FOR ALL USING (true);

CREATE POLICY "Allow public read" ON order_items FOR SELECT USING (true);
CREATE POLICY "Allow public write" ON order_items FOR ALL USING (true);

CREATE POLICY "Allow public read" ON dcrs FOR SELECT USING (true);
CREATE POLICY "Allow public write" ON dcrs FOR ALL USING (true);


-- 6. Insert Seeds Data
-- Seed Territories
INSERT INTO territories (id, name, region) VALUES
  ('10101010-1010-1010-1010-101010101010', 'Lahore Central', 'North'),
  ('20202020-2020-2020-2020-202020202020', 'Karachi South', 'South'),
  ('30303030-3030-3030-3030-303030303030', 'Islamabad Capital', 'North'),
  ('40404040-4040-4040-4040-404040404040', 'Multan City', 'West');

-- Seed Profiles (Admins, Managers, and Reps)
INSERT INTO profiles (id, clerk_user_id, full_name, email, role, territory_id, is_active) VALUES
  ('a1a1a1a1-a1a1-a1a1-a1a1-a1a1a1a1a1a1', 'clerk_admin_01', 'Raheel Ahmad', 'ahmad.admin@medrep.pro', 'admin', NULL, true),
  ('b2b2b2b2-b2b2-b2b2-b2b2-b2b2b2b2b2b2', 'clerk_manager_01', 'Dr. Khalid Jamil', 'khalid.manager@medrep.pro', 'manager', '30303030-3030-3030-3030-303030303030', true),
  ('c3c3c3c3-c3c3-c3c3-c3c3-c3c3c3c3c3c3', 'clerk_rep_01', 'Salman Khan', 'salman.rep@medrep.pro', 'medical_rep', '10101010-1010-1010-1010-101010101010', true),
  ('d4d4d4d4-d4d4-d4d4-d4d4-d4d4d4d4d4d4', 'clerk_rep_02', 'Zainab Bibi', 'zainab.rep@medrep.pro', 'medical_rep', '20202020-2020-2020-2020-202020202020', true);

-- Seed Chemists
INSERT INTO chemists (id, shop_name, owner_name, area, city, phone, credit_limit, outstanding_balance, priority, territory_id, created_by) VALUES
  ('e5e5e5e5-e5e5-e5e5-e5e5-e5e5e5e5e5e5', 'Time Medicos', 'Asif Raza', 'Saddar', 'Karachi', '03001234567', 150000, 45000, 'high', '20202020-2020-2020-2020-202020202020', 'd4d4d4d4-d4d4-d4d4-d4d4-d4d4d4d4d4d4'),
  ('f6f6f6f6-f6f6-f6f6-f6f6-f6f6f6f6f6f6', 'Kausar Medicos', 'Kausar Ali', 'Gulshan', 'Karachi', '03217654321', 200000, 12000, 'high', '20202020-2020-2020-2020-202020202020', 'd4d4d4d4-d4d4-d4d4-d4d4-d4d4d4d4d4d4');

-- Seed Products
INSERT INTO products (id, name, sku, formulation, category, net_price, pack_size, is_sample_eligible, is_active) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Panadol Extra 500mg', 'PAN-EXT-500', 'tablet', 'Analgesics', 12.50, '20s', true, true),
  ('22222222-2222-2222-2222-222222222222', 'Amoxil Syrup 250mg/5ml', 'AMX-SYR-250', 'syrup', 'Antibiotics', 45.00, '60ml', true, true),
  ('33333333-3333-3333-3333-333333333333', 'Augmentin Tablets 625mg', 'AUG-TAB-625', 'tablet', 'Antibiotics', 95.50, '12s', false, true),
  ('44444444-4444-4444-4444-444444444444', 'Lipitor Tablets 20mg', 'LIP-TAB-20', 'tablet', 'Cardiovascular', 120.00, '30s', false, true);

-- Seed Orders
INSERT INTO orders (id, rep_id, chemist_id, order_date, status, total_amount) VALUES
  ('88888888-8888-8888-8888-888888888888', 'd4d4d4d4-d4d4-d4d4-d4d4-d4d4d4d4d4d4', 'e5e5e5e5-e5e5-e5e5-e5e5-e5e5e5e5e5e5', '2026-05-19', 'confirmed', 12450.00),
  ('99999999-9999-9999-9999-999999999999', 'd4d4d4d4-d4d4-d4d4-d4d4-d4d4d4d4d4d4', 'f6f6f6f6-f6f6-f6f6-f6f6-f6f6f6f6f6f6', '2026-05-20', 'delivered', 32500.00);

-- Seed Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
  ('88888888-8888-8888-8888-888888888888', '11111111-1111-1111-1111-111111111111', 10, 12.50),
  ('99999999-9999-9999-9999-999999999999', '33333333-3333-3333-3333-333333333333', 100, 95.50);
