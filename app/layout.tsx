import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import './globals.css';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  title: 'FolioMesh - Professional Portfolio Platform',
  description: 'Create stunning portfolios, connect with professionals, and discover amazing job opportunities.',
  keywords: [
    'portfolio',
    'professional',
    'jobs',
    'networking',
    'career',
    'showcase',
    'projects',
    'skills',
  ],
  authors: [{ name: 'FolioMesh Team' }],
  creator: 'FolioMesh',
  publisher: 'FolioMesh',
  formatDetection: {
    email: false,
    address: false,
    telephone: false,
  },
  metadataBase: new URL(process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000'),
  alternates: {
    canonical: '/',
  },
  openGraph: {
    type: 'website',
    locale: 'en_US',
    url: '/',
    title: 'FolioMesh - Professional Portfolio Platform',
    description: 'Create stunning portfolios, connect with professionals, and discover amazing job opportunities.',
    siteName: 'FolioMesh',
    images: [
      {
        url: '/og-image.jpg',
        width: 1200,
        height: 630,
        alt: 'FolioMesh - Professional Portfolio Platform',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'FolioMesh - Professional Portfolio Platform',
    description: 'Create stunning portfolios, connect with professionals, and discover amazing job opportunities.',
    images: ['/og-image.jpg'],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
  verification: {
    google: 'your-google-verification-code',
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className={inter.className}>
        {children}
      </body>
    </html>
  );
}