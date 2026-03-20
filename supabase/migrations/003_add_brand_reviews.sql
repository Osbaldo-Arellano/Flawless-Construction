-- ── brand_reviews ─────────────────────────────────────────────────────────────
-- Stores curated Google reviews (or any source) per brand.
-- Public read via RLS so the frontend can fetch without auth.
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS brand_reviews (
  id                 uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id            uuid        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  reviewer_name      text        NOT NULL,
  rating             integer     NOT NULL CHECK (rating BETWEEN 1 AND 5),
  body               text        NOT NULL,
  source             text        NOT NULL DEFAULT 'google',
  reviewer_photo_url text,
  sort_order         integer     NOT NULL DEFAULT 0,
  created_at         timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS brand_reviews_user_id_idx
  ON brand_reviews (user_id, sort_order);

ALTER TABLE brand_reviews ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read brand_reviews"
  ON brand_reviews FOR SELECT USING (true);
