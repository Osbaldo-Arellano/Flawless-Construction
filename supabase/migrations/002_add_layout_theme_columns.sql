-- ============================================================
-- BrandSync V2 — Add layout + theme columns to existing brands table
-- ============================================================
-- Run this migration if you already have a V1 brands table and
-- are upgrading to V2. Safe to run multiple times (uses IF NOT EXISTS).
-- ============================================================

-- Add layout column (V2 section/variant/order config)
alter table brands
  add column if not exists layout jsonb;

-- Add theme column (V2 CSS variable overrides)
alter table brands
  add column if not exists theme jsonb;

-- Helpful comment on the columns for future DBAs
comment on column brands.layout is
  'V2 layout config: { preset, sections?, overrides?, order? }. '
  'Null means "use the preset defaults". '
  'preset: named preset key (bold-craft | editorial-agency | tech-forward | premium-local). '
  'sections: map of sectionId → enabled bool. '
  'overrides: map of sectionId → variantName. '
  'order: explicit array of sectionIds controlling render order.';

comment on column brands.theme is
  'V2 theme config: { primaryColor?, radius?, density?, font?, mode? }. '
  'Null means "use the preset theme defaults". '
  'primaryColor: OKLch string e.g. "oklch(0.65 0.22 25)". '
  'radius: sharp | rounded | pill. '
  'density: compact | comfortable | spacious. '
  'mode: light | dark | system.';
