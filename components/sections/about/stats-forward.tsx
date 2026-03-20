"use client";

import { useBrand } from "@/contexts/brand-context";
import { AnimateOnScroll } from "@/components/animate-on-scroll";

export function AboutStatsForward() {
  const { brand } = useBrand();

  return (
    <section
      id="about"
      className="scroll-mt-28 relative overflow-hidden py-20 lg:py-32 bg-foreground text-background"
    >
      {/* Grid texture */}
      <div
        className="absolute inset-0 opacity-[0.04] pointer-events-none"
        style={{
          backgroundImage:
            "linear-gradient(hsl(var(--background)) 1px, transparent 1px), linear-gradient(90deg, hsl(var(--background)) 1px, transparent 1px)",
          backgroundSize: "48px 48px",
        }}
      />

      <div className="container relative mx-auto px-4">
        {/* Top row: headline + description */}
        <AnimateOnScroll animation="fade-up" triggerOnce={false}>
          <div className="grid lg:grid-cols-2 gap-8 lg:gap-16 mb-20">
            <div>
              <p className="text-xs font-semibold uppercase tracking-[0.2em] text-background/40 mb-4">
                {brand.about.headline}
              </p>
              <h2 className="text-3xl lg:text-5xl font-black leading-tight tracking-tight">
                {brand.about.subheadline}
              </h2>
            </div>
            <div className="flex items-end">
              <p className="text-lg text-background/60 leading-relaxed border-l-2 border-background/20 pl-6">
                {brand.about.description}
              </p>
            </div>
          </div>
        </AnimateOnScroll>

        {/* Stats strip */}
        <AnimateOnScroll animation="fade-up" triggerOnce={false}>
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-px bg-background/10 rounded-2xl overflow-hidden mb-20">
            {brand.hero.stats.map((stat, i) => (
              <div
                key={stat.label}
                className="bg-foreground px-8 py-10 group hover:bg-background/5 transition-colors duration-300"
              >
                <div
                  className="text-5xl lg:text-6xl font-black leading-none mb-2 transition-all duration-500"
                  style={{
                    background: `linear-gradient(135deg, hsl(var(--background)) 0%, hsl(var(--background)/0.5) 100%)`,
                    WebkitBackgroundClip: "text",
                    WebkitTextFillColor: "transparent",
                  }}
                >
                  {stat.value}
                </div>
                <div className="text-xs uppercase tracking-widest text-background/40">
                  {stat.label}
                </div>
              </div>
            ))}
          </div>
        </AnimateOnScroll>

        {/* Values grid */}
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-px bg-background/10 rounded-2xl overflow-hidden">
          {brand.about.values.map((value, i) => (
            <AnimateOnScroll
              key={value.title}
              animation="fade-up"
              delay={i * 80}
              triggerOnce={false}
            >
              <div className="bg-foreground p-8 group hover:bg-background/5 transition-colors duration-300">
                <span className="text-4xl font-black text-background/10 block mb-4">
                  {String(i + 1).padStart(2, "0")}
                </span>
                <h3 className="text-lg font-semibold text-background mb-2 group-hover:text-background/80 transition-colors duration-300">
                  {value.title}
                </h3>
                <p className="text-sm text-background/50 leading-relaxed">
                  {value.description}
                </p>
              </div>
            </AnimateOnScroll>
          ))}
        </div>
      </div>
    </section>
  );
}
