import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Video Gallery",
  description: "Watch video walkthroughs of our completed roofing and construction projects. See before-and-after transformations and detailed project tours.",
  alternates: {
    canonical: "/gallery/video",
  },
  openGraph: {
    title: "Video Gallery",
    description: "Watch video walkthroughs of our completed roofing and construction projects. See before-and-after transformations and detailed project tours.",
    url: "/gallery/video",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Video Gallery",
    description: "Watch video walkthroughs of our completed roofing and construction projects. See before-and-after transformations and detailed project tours.",
  },
};

const breadcrumbJsonLd = {
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  itemListElement: [
    { "@type": "ListItem", position: 1, name: "Home", item: "/" },
    { "@type": "ListItem", position: 2, name: "Project Gallery", item: "/gallery" },
    { "@type": "ListItem", position: 3, name: "Video Gallery", item: "/gallery/video" },
  ],
};

export default function VideoGalleryLayout({
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
