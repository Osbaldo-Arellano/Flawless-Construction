create table public.brand_photos (
  id uuid not null default gen_random_uuid (),
  user_id text not null,
  url text not null,
  alt_text text null,
  caption text null,
  sort_order integer not null default 0,
  created_at timestamp with time zone not null default now(),
  constraint brand_photos_pkey primary key (id),
  constraint brand_photos_user_id_fkey foreign KEY (user_id) references brands (user_id) on delete CASCADE
) TABLESPACE pg_default;

create index IF not exists brand_photos_user_id_idx on public.brand_photos using btree (user_id) TABLESPACE pg_default;

create index IF not exists brand_photos_user_sort_idx on public.brand_photos using btree (user_id, sort_order) TABLESPACE pg_default;


create table public.brands (
  id uuid not null default gen_random_uuid (),
  user_id text not null,
  name text null,
  tagline text null,
  email text null,
  phone text null,
  logo_url text null,
  updated_at timestamp with time zone null default now(),
  about_us text null,
  address jsonb not null default '{}'::jsonb,
  social_links jsonb not null default '[]'::jsonb,
  logo_variants jsonb not null default '{}'::jsonb,
  icon_url text null,
  website_url text null,
  constraint brands_pkey primary key (id),
  constraint brands_user_id_key unique (user_id),
  constraint address_is_object check ((jsonb_typeof(address) = 'object'::text)),
  constraint logo_variants_is_object check ((jsonb_typeof(logo_variants) = 'object'::text)),
  constraint social_links_is_array check ((jsonb_typeof(social_links) = 'array'::text))
) TABLESPACE pg_default;

create trigger brands_set_updated_at BEFORE
update on brands for EACH row
execute FUNCTION set_updated_at ();


create table public.customers (
  id uuid not null default gen_random_uuid (),
  tenant_id uuid not null,
  name text not null,
  email text null,
  phone text null,
  address jsonb not null default '{}'::jsonb,
  created_at timestamp with time zone not null default now(),
  constraint customers_pkey primary key (id),
  constraint customers_tenant_id_fkey foreign KEY (tenant_id) references tenants (id) on delete CASCADE
) TABLESPACE pg_default;

create index IF not exists customers_tenant_id_idx on public.customers using btree (tenant_id) TABLESPACE pg_default;


create table public.estimate_items (
  id uuid not null default gen_random_uuid (),
  estimate_id uuid not null,
  description text not null default ''::text,
  quantity numeric(10, 2) not null default 1,
  unit_price numeric(10, 2) not null default 0,
  line_total numeric(10, 2) not null default 0,
  constraint estimate_items_pkey primary key (id),
  constraint estimate_items_estimate_id_fkey foreign KEY (estimate_id) references estimates (id) on delete CASCADE
) TABLESPACE pg_default;

create index IF not exists estimate_items_estimate_id_idx on public.estimate_items using btree (estimate_id) TABLESPACE pg_default;



create table public.estimates (
  id uuid not null default gen_random_uuid (),
  tenant_id uuid not null,
  customer_id uuid null,
  status text not null default 'draft'::text,
  notes text not null default ''::text,
  total numeric(10, 2) not null default 0,
  created_at timestamp with time zone not null default now(),
  customer_name text not null default ''::text,
  customer_address text not null default ''::text,
  salesperson text not null default ''::text,
  job text not null default ''::text,
  payment_terms text not null default ''::text,
  due_date text not null default 'TBD'::text,
  deposit numeric(10, 2) not null default 0,
  cash_note text not null default ''::text,
  customer_email text null,
  customer_phone text null,
  signature_url text null,
  signed_at timestamp with time zone null,
  signed_by_name text null,
  signed_ip text null,
  sent_at timestamp with time zone null,
  estimate_number integer not null,
  expires_at timestamp with time zone null,
  tax_rate numeric(5, 2) not null default 0,
  tax_amount numeric(10, 2) not null default 0,
  discount_amount numeric(10, 2) not null default 0,
  delivery_method text null,
  job_id uuid null,
  constraint estimates_pkey primary key (id),
  constraint estimates_customer_id_fkey foreign KEY (customer_id) references customers (id) on delete set null,
  constraint estimates_job_id_fkey foreign KEY (job_id) references jobs (id) on delete set null,
  constraint estimates_tenant_id_fkey foreign KEY (tenant_id) references tenants (id) on delete CASCADE,
  constraint estimates_delivery_method_check check (
    (
      delivery_method = any (array['email'::text, 'link'::text, 'print'::text])
    )
  ),
  constraint estimates_status_check check (
    (
      status = any (
        array[
          'draft'::text,
          'sent'::text,
          'approved'::text,
          'invoiced'::text,
          'declined'::text
        ]
      )
    )
  )
) TABLESPACE pg_default;

create index IF not exists estimates_tenant_id_idx on public.estimates using btree (tenant_id) TABLESPACE pg_default;

create trigger estimates_assign_number BEFORE INSERT on estimates for EACH row
execute FUNCTION assign_estimate_number ();


create table public.invoice_items (
  id uuid not null default gen_random_uuid (),
  invoice_id uuid not null,
  description text not null default ''::text,
  quantity numeric(10, 2) not null default 1,
  unit_price numeric(10, 2) not null default 0,
  line_total numeric(10, 2) not null default 0,
  constraint invoice_items_pkey primary key (id),
  constraint invoice_items_invoice_id_fkey foreign KEY (invoice_id) references invoices (id) on delete CASCADE
) TABLESPACE pg_default;


create table public.invoices (
  id uuid not null default gen_random_uuid (),
  tenant_id uuid not null,
  customer_id uuid null,
  status text not null default 'draft'::text,
  total numeric(10, 2) not null default 0,
  created_at timestamp with time zone not null default now(),
  estimate_id uuid null,
  customer_name text not null default ''::text,
  amount_paid numeric(10, 2) not null default 0,
  customer_email text null,
  invoice_number integer not null default nextval('invoice_number_seq'::regclass),
  due_date text null,
  notes text not null default ''::text,
  discount_amount numeric(10, 2) not null default 0,
  tax_rate numeric(5, 2) not null default 0,
  tax_amount numeric(10, 2) not null default 0,
  customer_address text null,
  customer_phone text null,
  delivery_method text null,
  job_id uuid null,
  constraint invoices_pkey primary key (id),
  constraint invoices_estimate_id_fkey foreign KEY (estimate_id) references estimates (id) on delete set null,
  constraint invoices_customer_id_fkey foreign KEY (customer_id) references customers (id) on delete set null,
  constraint invoices_job_id_fkey foreign KEY (job_id) references jobs (id) on delete set null,
  constraint invoices_tenant_id_fkey foreign KEY (tenant_id) references tenants (id) on delete CASCADE,
  constraint invoices_status_check check (
    (
      status = any (
        array[
          'draft'::text,
          'sent'::text,
          'paid'::text,
          'overdue'::text,
          'partial'::text,
          'cash'::text,
          'cashapp'::text,
          'deferred'::text,
          'void'::text
        ]
      )
    )
  ),
  constraint invoices_delivery_method_check check (
    (
      delivery_method = any (array['email'::text, 'link'::text, 'print'::text])
    )
  )
) TABLESPACE pg_default;

create index IF not exists invoices_tenant_id_idx on public.invoices using btree (tenant_id) TABLESPACE pg_default;

create index IF not exists invoices_customer_id_idx on public.invoices using btree (customer_id) TABLESPACE pg_default;

create index IF not exists invoices_estimate_id_idx on public.invoices using btree (estimate_id) TABLESPACE pg_default;

create trigger invoices_assign_number BEFORE INSERT on invoices for EACH row
execute FUNCTION assign_invoice_number ();


create table public.jobs (
  id uuid not null default gen_random_uuid (),
  tenant_id uuid not null,
  customer_id uuid null,
  title text not null default ''::text,
  address text null,
  status text not null default 'active'::text,
  notes text null,
  created_at timestamp with time zone not null default now(),
  constraint jobs_pkey primary key (id),
  constraint jobs_customer_id_fkey foreign KEY (customer_id) references customers (id) on delete set null,
  constraint jobs_tenant_id_fkey foreign KEY (tenant_id) references auth.users (id) on delete CASCADE,
  constraint jobs_status_check check (
    (
      status = any (
        array[
          'active'::text,
          'completed'::text,
          'cancelled'::text
        ]
      )
    )
  )
) TABLESPACE pg_default;


create table public.tenants (
  id uuid not null,
  name text not null default ''::text,
  created_at timestamp with time zone not null default now(),
  ccb_number text null,
  tagline text null,
  email text null,
  phone text null,
  website text null,
  address_street text null,
  address_city text null,
  address_state text null,
  address_zip text null,
  cashapp_tag text null,
  constraint tenants_pkey primary key (id),
  constraint tenants_id_fkey foreign KEY (id) references auth.users (id) on delete CASCADE
) TABLESPACE pg_default;







