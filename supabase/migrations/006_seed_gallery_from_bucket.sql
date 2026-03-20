-- ============================================================
-- Migration 006 — Seed brand_photos from flawless_roofing_gallery bucket
-- ============================================================
-- Replace YOUR_PROJECT_REF with your Supabase project ref.
-- Find it in your NEXT_PUBLIC_SUPABASE_URL:
--   https://YOUR_PROJECT_REF.supabase.co
-- ============================================================

INSERT INTO public.brand_photos (user_id, url, alt_text, caption, sort_order)
SELECT
  'f93fd325-bf93-4dc5-8db7-8124f7e50c6b'::uuid,

  -- Full public URL for each file
  'https://knhgoaphmtewjhtvglpe.supabase.co/storage/v1/object/public/flawless_roofing_gallery/' || name,

  -- alt_text: filename only (no path, no extension), dashes/underscores → spaces, title-cased
  initcap(
    replace(
      replace(
        regexp_replace(
          reverse(split_part(reverse(name), '/', 1)),  -- strip folder path
          '\.[^.]+$', ''                                -- strip extension
        ),
        '-', ' '
      ),
      '_', ' '
    )
  ),

  -- caption: same as alt_text
  initcap(
    replace(
      replace(
        regexp_replace(
          reverse(split_part(reverse(name), '/', 1)),
          '\.[^.]+$', ''
        ),
        '-', ' '
      ),
      '_', ' '
    )
  ),

  -- sort_order: alphabetical by filename
  (ROW_NUMBER() OVER (ORDER BY name))::integer

FROM storage.objects
WHERE bucket_id = 'flawless_roofing_gallery'
  -- skip any hidden/system files (e.g. .emptyFolderPlaceholder)
  AND name NOT LIKE '.%'
  AND name NOT LIKE '%/.%';
