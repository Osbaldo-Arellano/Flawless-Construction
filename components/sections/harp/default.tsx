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
    body: "The ShingleMaster credential is a company-level certification that requires passing rigorous training on CertainTeed's installation standards and employing certified Master Craftsman installers — it is not a dealer agreement or a purchase volume reward. For homeowners, this matters because only ShingleMaster-credentialed contractors are authorized to offer CertainTeed's enhanced SureStart PLUS extended warranty, which covers labor costs and extends protection periods up to 50 years depending on the product. At the SELECT ShingleMaster tier, CertainTeed itself backs a 25-year workmanship guarantee — meaning if an installation error causes a leak, CertainTeed is obligated to cover the repair, not just the local contractor.",
    link: "https://www.certainteed.com/roofing-education-credential-us",
  },
  {
    eyebrow: "Energy Efficiency",
    headline: "Trade Ally of Energy Trust of Oregon",
    subheadline: "Energy Trust of Oregon Trade Ally",
    body: "Energy Trust of Oregon is an independent nonprofit that administers energy-efficiency incentive programs funded through a small charge on utility bills paid by customers of Portland General Electric, Pacific Power, NW Natural, and others — meaning if you're on one of those utilities, a portion of your bill has already been funding these programs, and qualifying work lets you draw that money back as a cash incentive. As a certified Trade Ally, we're trained on the program's technical requirements and can help homeowners access incentives for qualifying insulation improvements — currently ranging from roughly $0.90 to $2.85 per square foot for attic, wall, and roof insulation upgrades. Low- and moderate-income households may qualify for even larger incentives through Energy Trust's Savings Within Reach program; we identify which measures qualify, ensure the work meets specifications, and submit the applications on your behalf.",
    link: "https://www.energytrust.org/residential/incentive/up-to-50-percent-off-insulation/?utm_source=paidsearch&utm_medium=Google&utm_campaign=ETO-Res_NWN-Insulation_EVG&gad_source=1&gad_campaignid=23531919034&gclid=Cj0KCQjw4PPNBhD8ARIsAMo-iczXVzgYTpKruqPyo3JQRQofuf4VbUqwbMHhTCDCxZka8l5Xy15lB60aAhDQEALw_wcB",
  },
  {
    eyebrow: "State Housing Partner",
    headline: "Oregon Housing & Community Services Department Partner",
    subheadline: "Oregon Housing and Community Services",
    body: "Oregon Housing and Community Services administers housing stability, weatherization, and repair programs funded through federal and state sources, designed for low-to-moderate income Oregonians who need help maintaining safe, livable housing. Their Weatherization Assistance Program provides qualifying households — generally at or below 200% of the Federal Poverty Level — with no-cost home energy audits and improvements including insulation, air sealing, and heating system repairs. OHCS also administers home repair funding programs offering up to $15,000 per home for health-and-safety repairs on single-family and manufactured homes for households at or below 60% of Area Median Income, making these programs a meaningful resource for homeowners who need roofing or structural work but face financial barriers.",
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
