"use client";

import Link from "next/link";
import { ArrowUpRight } from "lucide-react";
import { useBrand } from "@/contexts/brand-context";
import { AnimateOnScroll } from "@/components/animate-on-scroll";

const PARTNERSHIPS = [
  {
    eyebrow: "Manufacturer Certification",
    headline: "CertainTeed ShingleMaster Credentialed",
    subheadline: "CertainTeed's Highest Installer Certification",
    body: "ShingleMaster is CertainTeed's highest installer certification — earned through hands-on training, not sales volume. It's what allows us to offer extended warranties covering both materials and labor, up to 50 years depending on the product.",
    link: "https://www.certainteed.com/roofing-education-credential-us",
  },
  {
    eyebrow: "Energy Efficiency",
    headline: "Trade Ally of Energy Trust of Oregon",
    subheadline: "Energy Trust of Oregon Trade Ally",
    body: "If you're on PGE, Pacific Power, or NW Natural, you've already been funding Energy Trust incentives through your utility bill — qualifying insulation work lets you draw that money back. As a certified Trade Ally, we handle the application so you get the credit without the paperwork.",
    link: "https://www.energytrust.org/residential/incentive/up-to-50-percent-off-insulation/?utm_source=paidsearch&utm_medium=Google&utm_campaign=ETO-Res_NWN-Insulation_EVG&gad_source=1&gad_campaignid=23531919034&gclid=Cj0KCQjw4PPNBhD8ARIsAMo-iczXVzgYTpKruqPyo3JQRQofuf4VbUqwbMHhTCDCxZka8l5Xy15lB60aAhDQEALw_wcB",
  },
  {
    eyebrow: "State Housing Partner",
    headline: "Oregon Housing & Community Services Department Partner",
    subheadline: "Oregon Housing and Community Services",
    body: "OHCS runs state-funded weatherization and repair programs that can cover insulation, air sealing, and structural work at no cost to qualifying Oregon homeowners. We'll help you find out what you're eligible for and take care of the process from there.",
    link: "https://www.oregon.gov/ohcs/development/pages/index.aspx",
  },
];

export function HarpDefault() {
  const { brand } = useBrand();

  if (!brand.harp) return null;

  const { headline, subheadline, body, link } = brand.harp;

  return (
    <section
      id="harp"
      className="scroll-mt-28 py-20 lg:py-32 bg-muted/40"
    >
      <div className="container mx-auto px-6 space-y-16">

        {/* ── HARP ────────────────────────────────────────────────────── */}
        <AnimateOnScroll animation="fade-up">
          <div className="max-w-3xl mx-auto text-center">
            <div className="flex items-center gap-4 justify-center mb-3">
              <div className="h-px w-12 bg-primary/40" />
              <p className="text-sm font-semibold tracking-widest text-primary uppercase">
                Wildfire Recovery
              </p>
              <div className="h-px w-12 bg-primary/40" />
            </div>
            <h2 className="text-3xl lg:text-4xl font-bold text-foreground mb-2">
              {headline}
            </h2>
            <p className="text-base font-medium text-muted-foreground mb-6">
              {subheadline}
            </p>
            <div className="border-l-4 border-primary pl-6 py-1 mb-8 text-left">
              <p className="text-base text-foreground/80 leading-relaxed">
                {body}
              </p>
            </div>
            {link?.href && (
              <div className="flex justify-center">
                <Link
                  href={link.href}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center gap-2 text-sm font-semibold text-primary hover:underline underline-offset-4 transition-colors"
                >
                  {link.label}
                  <ArrowUpRight className="w-4 h-4 flex-shrink-0" />
                </Link>
              </div>
            )}
          </div>
        </AnimateOnScroll>

        {/* ── Partnerships ─────────────────────────────────────────────── */}
        {PARTNERSHIPS.map((p, i) => (
          <AnimateOnScroll key={p.headline} animation="fade-up" delay={i * 80}>
            <div className="max-w-3xl mx-auto text-center">
              <div className="flex items-center gap-4 justify-center mb-3">
                <div className="h-px w-12 bg-primary/40" />
                <p className="text-sm font-semibold tracking-widest text-primary uppercase">
                  {p.eyebrow}
                </p>
                <div className="h-px w-12 bg-primary/40" />
              </div>
              <h2 className="text-3xl lg:text-4xl font-bold text-foreground mb-2">
                {p.headline}
              </h2>
              <p className="text-base font-medium text-muted-foreground mb-6">
                {p.subheadline}
              </p>
              <div className="border-l-4 border-primary pl-6 py-1 mb-8">
                <p className="text-base text-foreground/80 leading-relaxed">
                  {p.body}
                </p>
              </div>
              {p.link && (
                <Link
                  href={p.link}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center gap-2 text-sm font-semibold text-primary hover:underline underline-offset-4 transition-colors"
                >
                  Learn more
                  <ArrowUpRight className="w-4 h-4 flex-shrink-0" />
                </Link>
              )}
            </div>
          </AnimateOnScroll>
        ))}

      </div>
    </section>
  );
}
