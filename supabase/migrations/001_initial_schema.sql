-- ============================================================
-- BrandSync V2 — Initial Schema
-- ============================================================
-- Run once against a fresh Supabase project.
-- Idempotent: uses IF NOT EXISTS / DO $$ blocks throughout.
-- ============================================================

-- ── Enable UUID generation ────────────────────────────────
create extension if not exists "pgcrypto";

-- ============================================================
-- brands
-- ============================================================
-- One row per client deployment. Keyed by user_id so that
-- NEXT_PUBLIC_BRAND_USER_ID is the only env var needed to
-- identify which row to fetch at runtime.
-- ============================================================

create table if not exists brands (
  id          uuid primary key default gen_random_uuid(),
  user_id     text not null unique,          -- matches NEXT_PUBLIC_BRAND_USER_ID

  -- ── Content fields ───────────────────────────────────────
  name        text,
  tagline     text,
  email       text,
  phone       text,
  logo_url    text,
  about_us    text,

  -- Structured address stored as JSONB
  -- { street, city, state, zip, country }
  address     jsonb not null default '{}'::jsonb,

  -- Array of { platform, url, handle? }
  social_links jsonb not null default '[]'::jsonb,

  -- Keyed logo variants { primary, horizontal, dark, light, favicon }
  logo_variants jsonb not null default '{}'::jsonb,

  -- Direct icon/app-icon URL (Supabase Storage). Used as favicon
  -- when logo_variants.favicon is not set.
  icon_url    text,

  -- Public URL of this client's deployed site. Used for canonical
  -- URLs and Open Graph metadata.
  website_url text,

  -- ── V2: Layout config ────────────────────────────────────
  -- Controls which preset is used as a base, which sections
  -- are enabled/disabled, custom section order, and per-section
  -- variant overrides.
  --
  -- Example:
  -- {
  --   "preset": "editorial-agency",
  --   "sections": { "gallery": false },
  --   "overrides": { "hero": "split", "contact": "split-form" },
  --   "order": ["hero", "trust-bar", "services", "about", "contact"]
  -- }
  --
  -- Any omitted key falls back to the preset default.
  layout      jsonb,

  -- ── V2: Theme config ─────────────────────────────────────
  -- Overrides CSS variables injected by ThemeInjector at runtime.
  --
  -- Example:
  -- {
  --   "primaryColor": "oklch(0.65 0.22 25)",
  --   "radius": "pill",
  --   "density": "comfortable",
  --   "font": { "heading": "Inter", "body": "Inter" },
  --   "mode": "system"
  -- }
  --
  -- Any omitted key falls back to the preset theme default.
  theme       jsonb,

  updated_at  timestamptz not null default now(),

  -- ── Constraints ──────────────────────────────────────────
  constraint address_is_object      check (jsonb_typeof(address)      = 'object'),
  constraint social_links_is_array  check (jsonb_typeof(social_links) = 'array'),
  constraint logo_variants_is_object check (jsonb_typeof(logo_variants) = 'object')
);

-- Keep updated_at current automatically
create or replace function set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists brands_set_updated_at on brands;
create trigger brands_set_updated_at
  before update on brands
  for each row execute procedure set_updated_at();

-- ============================================================
-- brand_photos
-- ============================================================
-- Gallery images for a brand, ordered by sort_order.
-- ============================================================

create table if not exists brand_photos (
  id          uuid primary key default gen_random_uuid(),
  user_id     text not null references brands(user_id) on delete cascade,
  url         text not null,
  alt_text    text,
  caption     text,
  sort_order  integer not null default 0,
  created_at  timestamptz not null default now()
);

create index if not exists brand_photos_user_id_idx
  on brand_photos(user_id);

create index if not exists brand_photos_user_sort_idx
  on brand_photos(user_id, sort_order);

-- ============================================================
-- Row Level Security
-- ============================================================
-- Public (anon) read access for the brand row and photos that
-- match the user_id supplied by the client. No write access
-- from the browser — all writes go through the Supabase dashboard
-- or a server-side admin key.
-- ============================================================

alter table brands      enable row level security;
alter table brand_photos enable row level security;

-- Drop policies before recreating (idempotent)
drop policy if exists "brands_public_read"       on brands;
drop policy if exists "brand_photos_public_read" on brand_photos;

-- Anon key can SELECT any row (filtering is done in application code
-- by matching user_id = NEXT_PUBLIC_BRAND_USER_ID).
create policy "brands_public_read"
  on brands for select
  to anon
  using (true);

create policy "brand_photos_public_read"
  on brand_photos for select
  to anon
  using (true);

-- ============================================================
-- Seed — example brand row
-- ============================================================
-- Uncomment and customise to pre-populate a test brand.
-- Replace 'YOUR_USER_ID' with the value you will set in
-- NEXT_PUBLIC_BRAND_USER_ID for that deployment.
-- ============================================================

/*
insert into brands (
  user_id,
  name,
  tagline,
  email,
  phone,
  address,
  social_links,
  logo_variants,
  layout,
  theme
) values (
  'YOUR_USER_ID',
  'Acme Electrical',
  'Veteran-owned. Licensed. Built to last.',
  'info@acmeelectrical.com',
  '+1 (503) 555-0100',
  '{"street": "123 Main St", "city": "Portland", "state": "OR", "zip": "97201", "country": "US"}',
  '[{"platform": "instagram", "url": "https://instagram.com/acme"}, {"platform": "facebook", "url": "https://facebook.com/acme"}]',
  '{"primary": "https://cdn.example.com/logo.png", "dark": "https://cdn.example.com/logo-dark.png", "favicon": "https://cdn.example.com/favicon.ico"}',
  '{"preset": "bold-craft"}',
  '{"primaryColor": "oklch(0.65 0.22 25)", "radius": "rounded", "mode": "system"}'
) on conflict (user_id) do nothing;
*/
