import type { Metadata } from "next";
import { Inter, JetBrains_Mono } from "next/font/google";
import "./globals.css";
import { ThemeProvider } from "@/components/theme-provider";
import { BrandProvider } from "@/contexts/brand-context";
import type { InitialBrandData } from "@/contexts/brand-context";
import { ThemeInjector } from "@/components/theme-injector";
import { ScrollBackground } from "@/components/scroll-background";
import { HashScrollFix } from "@/components/hash-scroll-fix";
import { ScrollToTop } from "@/components/scroll-to-top";
import { WidgetRenderer } from "@/components/widget-renderer";
import { createClient } from "@supabase/supabase-js";
import type { BrandRow, BrandPhotoRow, BrandCertificationRow } from "@/lib/supabase";
import { getPreset } from "@/config/presets";

const sans = Inter({
  variable: "--font-sans",
  subsets: ["latin"],
  weight: ["300", "400", "500", "600", "700", "800", "900"],
});

const mono = JetBrains_Mono({
  variable: "--font-mono",
  subsets: ["latin"],
});

let SITE_URL = process.env.NEXT_PUBLIC_SITE_URL || "https://example.com";

async function fetchBrandReviews(): Promise<{ ratingValue: number; reviewCount: number } | null> {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  const userId = process.env.NEXT_PUBLIC_BRAND_USER_ID;
  if (!supabaseUrl || !supabaseKey || !userId) return null;
  try {
    const client = createClient(supabaseUrl, supabaseKey);
    const { data } = await client
      .from("brand_reviews")
      .select("rating")
      .eq("user_id", userId)
      .returns<{ rating: number }[]>();
    if (!data?.length) return null;
    const avg = data.reduce((sum, r) => sum + r.rating, 0) / data.length;
    return { ratingValue: Math.round(avg * 10) / 10, reviewCount: data.length };
  } catch {
    return null;
  }
}

async function fetchServerBrandData(): Promise<{
  initialData: InitialBrandData;
  primaryColor: string;
  mode: "light" | "dark" | "system";
} | null> {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  const userId = process.env.NEXT_PUBLIC_BRAND_USER_ID;
  if (!supabaseUrl || !supabaseKey || !userId) return null;

  try {
    const client = createClient(supabaseUrl, supabaseKey);
    const [{ data: brand }, { data: photos }, { data: certifications }] = await Promise.all([
      client.from("brands").select("*").eq("user_id", userId).single<BrandRow>(),
      client.from("brand_photos").select("*").eq("user_id", userId).order("sort_order").returns<BrandPhotoRow[]>(),
      client.from("brand_certifications").select("*").eq("user_id", userId).order("sort_order").returns<BrandCertificationRow[]>(),
    ]);

    // Resolve primary color and mode from theme + preset
    const presetName = brand?.layout?.preset ?? "bold-craft";
    const preset = getPreset(presetName);
    const primaryColor = brand?.theme?.primaryColor ?? preset.theme.primaryColor ?? "oklch(0.7 0.15 260)";
    const mode = brand?.theme?.mode ?? preset.theme.mode ?? "system";

    return {
      initialData: {
        brand: brand ?? null,
        photos: photos ?? null,
        certifications: certifications ?? null,
      },
      primaryColor,
      mode: mode as "light" | "dark" | "system",
    };
  } catch {
    return null;
  }
}

export async function generateMetadata(): Promise<Metadata> {
  let faviconUrl = "/favicon.ico";
  let siteName = "BrandSync";
  let siteDescription = "Professional services tailored for your needs.";
  let ogImage: string | null = null;

  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  const userId = process.env.NEXT_PUBLIC_BRAND_USER_ID;

  if (supabaseUrl && supabaseKey && userId) {
    try {
      const client = createClient(supabaseUrl, supabaseKey);
      const { data } = await client
        .from("brands")
        .select("name, tagline, logo_variants, icon_url, logo_url, hero_image_url, website_url")
        .eq("user_id", userId)
        .single();

      if (data?.name) siteName = data.name;
      if (data?.tagline) siteDescription = data.tagline;
      if (data?.website_url) SITE_URL = data.website_url;
      const variants = data?.logo_variants ?? {};
      const remote = data?.icon_url ?? variants.favicon ?? variants.primary ?? variants.light ?? data?.logo_url ?? null;
      if (remote) faviconUrl = remote;
      // Prefer hero image for OG (better social preview); fall back to logo
      ogImage = data?.hero_image_url ?? data?.logo_url ?? variants.primary ?? null;
    } catch {
      // fall back to defaults
    }
  }

  return {
    metadataBase: new URL(SITE_URL),
    title: {
      default: siteName,
      template: `%s | ${siteName}`,
    },
    description: siteDescription,
    alternates: {
      canonical: "/",
    },
    openGraph: {
      type: "website",
      locale: "en_US",
      url: SITE_URL,
      siteName,
      title: siteName,
      description: siteDescription,
      ...(ogImage && {
        images: [{ url: ogImage, width: 1200, height: 630, alt: siteName }],
      }),
    },
    twitter: {
      card: "summary_large_image",
      title: siteName,
      description: siteDescription,
      ...(ogImage && { images: [ogImage] }),
    },
    robots: {
      index: true,
      follow: true,
      googleBot: {
        index: true,
        follow: true,
        "max-video-preview": -1,
        "max-image-preview": "large",
        "max-snippet": -1,
      },
    },
    icons: {
      icon: faviconUrl,
      shortcut: faviconUrl,
      apple: faviconUrl,
    },
  };
}

export default async function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const [serverData, reviewSummary] = await Promise.all([
    fetchServerBrandData(),
    fetchBrandReviews(),
  ]);
  const primaryColor = serverData?.primaryColor ?? "oklch(0.7 0.15 260)";
  const mode = serverData?.mode ?? "system";
  const defaultTheme = mode === "system" ? "system" : mode;
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || "https://example.com";

  const brand = serverData?.initialData.brand;
  const businessJsonLd = brand
    ? {
        "@context": "https://schema.org",
        "@type": "HomeAndConstructionBusiness",
        ...(brand.name && { name: brand.name }),
        ...(brand.tagline && { description: brand.tagline }),
        ...(brand.website_url && { url: brand.website_url }),
        ...(brand.logo_url && { logo: brand.logo_url }),
        ...(brand.phone && { telephone: brand.phone }),
        ...(brand.email && { email: brand.email }),
        ...(brand.address && {
          address: {
            "@type": "PostalAddress",
            ...(brand.address.street && { streetAddress: brand.address.street }),
            ...(brand.address.city && { addressLocality: brand.address.city }),
            ...(brand.address.state && { addressRegion: brand.address.state }),
            ...(brand.address.zip && { postalCode: brand.address.zip }),
            addressCountry: brand.address.country ?? "US",
          },
        }),
        ...(brand.social_links?.length && {
          sameAs: brand.social_links.map((s) => s.url).filter(Boolean),
        }),
        ...(reviewSummary && {
          aggregateRating: {
            "@type": "AggregateRating",
            ratingValue: reviewSummary.ratingValue,
            reviewCount: reviewSummary.reviewCount,
            bestRating: 5,
            worstRating: 1,
          },
        }),
      }
    : null;

  const websiteJsonLd = {
    "@context": "https://schema.org",
    "@type": "WebSite",
    url: brand?.website_url ?? siteUrl,
    ...(brand?.name && { name: brand.name }),
  };

  return (
    <html lang="en" suppressHydrationWarning className={mode === "dark" ? "dark" : "light"}>
      <head>
        {/* Inject primary color before paint to eliminate color flash */}
        <style dangerouslySetInnerHTML={{ __html: `:root { --primary: ${primaryColor}; }` }} />
        <meta name="theme-color" content={primaryColor} />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(websiteJsonLd) }}
        />
        {businessJsonLd && (
          <script
            type="application/ld+json"
            dangerouslySetInnerHTML={{ __html: JSON.stringify(businessJsonLd) }}
          />
        )}
      </head>
      <body className={`${sans.variable} ${mono.variable} antialiased`}>
        <ThemeProvider
          attribute="class"
          defaultTheme={defaultTheme}
          enableSystem={false}
          disableTransitionOnChange
        >
          <BrandProvider initialData={serverData?.initialData}>
            <ThemeInjector />
            <ScrollBackground />
            <HashScrollFix />
            {children}
            <ScrollToTop />
            <WidgetRenderer />
          </BrandProvider>
        </ThemeProvider>
      </body>
    </html>
  );
}
