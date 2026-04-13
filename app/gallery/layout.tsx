import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Project Gallery",
  description: "Browse our portfolio of completed projects. View photos of our craftsmanship across roofing, siding, and construction work.",
  alternates: {
    canonical: "/gallery",
  },
  openGraph: {
    title: "Project Gallery",
    description: "Browse our portfolio of completed projects. View photos of our craftsmanship across roofing, siding, and construction work.",
    url: "/gallery",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Project Gallery",
    description: "Browse our portfolio of completed projects. View photos of our craftsmanship across roofing, siding, and construction work.",
  },
};

const breadcrumbJsonLd = {
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  itemListElement: [
    { "@type": "ListItem", position: 1, name: "Home", item: "/" },
    { "@type": "ListItem", position: 2, name: "Project Gallery", item: "/gallery" },
  ],
};

export default function GalleryLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }}
      />
      {children}
    </>
  );
}
