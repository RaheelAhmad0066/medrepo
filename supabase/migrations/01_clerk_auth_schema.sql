-- Migrations for Clerk Authentication & Role Management

-- Enable RLS on all tables
create table if not exists territories (
  id serial primary key,
  name text not null,
  zone text not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

create table if not exists profiles (
  id text primary key, -- Clerk User ID (sub)
  email text not null,
  full_name text,
  role text not null default 'medical_rep', -- 'admin', 'manager', 'medical_rep'
  tenant_id text not null,
  territory_ids integer[] not null default '{}',
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Helper functions to parse claims from the Clerk JWT (auth.jwt())
create or replace function requesting_user_id() returns text as $$
  select coalesce(nullif(auth.jwt() ->> 'sub', ''), '');
$$ language sql security definer;

create or replace function requesting_user_role() returns text as $$
  select coalesce(nullif(auth.jwt() ->> 'role', ''), 'medical_rep');
$$ language sql security definer;

create or replace function requesting_user_tenant_id() returns text as $$
  select coalesce(nullif(auth.jwt() ->> 'tenant_id', ''), '');
$$ language sql security definer;

create or replace function requesting_user_territory_ids() returns integer[] as $$
declare
  t_ids jsonb;
  arr integer[];
begin
  t_ids := auth.jwt() -> 'territory_ids';
  if t_ids is null or jsonb_typeof(t_ids) != 'array' then
    return '{}'::integer[];
  end if;
  select array_agg(value::integer) into arr from jsonb_array_elements_text(t_ids);
  return coalesce(arr, '{}'::integer[]);
end;
$$ language plpgsql security definer;

-- Enable Row Level Security
alter table territories enable row level security;
alter table profiles enable row level security;

-- RLS policies for territories
create policy "Territory select policy" on territories
  for select using (
    requesting_user_role() = 'admin' or
    requesting_user_role() = 'manager' or
    id = any(requesting_user_territory_ids())
  );

create policy "Territory modification policy" on territories
  for all using (
    requesting_user_role() = 'admin'
  );

-- RLS policies for profiles
create policy "Profile select policy" on profiles
  for select using (
    requesting_user_id() = id or
    requesting_user_role() = 'admin' or
    (requesting_user_role() = 'manager' and tenant_id = requesting_user_tenant_id())
  );

create policy "Profile update policy" on profiles
  for update using (
    requesting_user_id() = id or
    requesting_user_role() = 'admin'
  );
