-- ============================================================
-- Migration 004 — Certifications + HARP
-- ============================================================

-- 1. Add harp JSONB column to brands
ALTER TABLE public.brands
  ADD COLUMN IF NOT EXISTS harp jsonb;

-- 2. brand_certifications table
CREATE TABLE IF NOT EXISTS public.brand_certifications (
  id           uuid                     NOT NULL DEFAULT gen_random_uuid(),
  user_id      text                     NOT NULL,
  name         text                     NOT NULL,
  logo_url     text                     NULL,
  logo_alt     text                     NULL,
  description  text                     NULL,
  sort_order   integer                  NOT NULL DEFAULT 0,
  created_at   timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT brand_certifications_pkey PRIMARY KEY (id),
  CONSTRAINT brand_certifications_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES public.brands (user_id) ON DELETE CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS brand_certifications_user_id_idx
  ON public.brand_certifications USING btree (user_id) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS brand_certifications_user_sort_idx
  ON public.brand_certifications USING btree (user_id, sort_order) TABLESPACE pg_default;

-- RLS: public read, no browser writes
ALTER TABLE public.brand_certifications ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read brand_certifications"
  ON public.brand_certifications
  FOR SELECT
  USING (true);
