import { boldCraft } from "./bold-craft";
import { editorialAgency } from "./editorial-agency";
import { techForward } from "./tech-forward";
import { premiumLocal } from "./premium-local";
import { stormBreak } from "./storm-break";
import { craftsmansMark } from "./craftsmans-mark";
import { theAerial } from "./the-aerial";
import { rooferPro } from "./roofer-pro";
import type { LayoutPreset } from "./types";

export const presets: Record<string, LayoutPreset> = {
  // ── General purpose ──────────────────────────────────────────
  "bold-craft": boldCraft,
  "editorial-agency": editorialAgency,
  "tech-forward": techForward,
  "premium-local": premiumLocal,
  // ── Roofer Package ───────────────────────────────────────────
  "storm-break": stormBreak,
  "craftsmans-mark": craftsmansMark,
  "the-aerial": theAerial,
  "roofer-pro": rooferPro,
};

export function getPreset(name: string): LayoutPreset {
  return presets[name] ?? boldCraft;
}

export type { LayoutPreset };
export type { LayoutPresetConfig, ThemePresetConfig } from "./types";
