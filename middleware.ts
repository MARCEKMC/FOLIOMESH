import { NextRequest, NextResponse } from 'next/server';

export function middleware(request: NextRequest) {
  const url = request.nextUrl.clone();
  const hostname = request.headers.get('host') || '';
  
  // Extract subdomain from hostname
  const currentHost = hostname.replace(`.${process.env.NEXT_PUBLIC_ROOT_DOMAIN}`, '');
  
  // Check if this is a subdomain request (not www or the main domain)
  const isSubdomain = 
    hostname.includes('.') && 
    !hostname.startsWith('www.') && 
    currentHost !== process.env.NEXT_PUBLIC_ROOT_DOMAIN &&
    currentHost.length > 0;

  // Security headers
  const headers = new Headers(request.headers);
  headers.set('X-Frame-Options', 'DENY');
  headers.set('X-Content-Type-Options', 'nosniff');
  headers.set('Referrer-Policy', 'strict-origin-when-cross-origin');
  headers.set('X-XSS-Protection', '1; mode=block');

  // Main domain handling
  if (!isSubdomain) {
    // Allow API routes and static files
    if (
      url.pathname.startsWith('/api/') ||
      url.pathname.startsWith('/_next/') ||
      url.pathname.startsWith('/favicon.ico') ||
      url.pathname.startsWith('/robots.txt') ||
      url.pathname.startsWith('/sitemap.xml')
    ) {
      return NextResponse.next({ headers });
    }

    // Main app routes
    return NextResponse.next({ headers });
  }

  // Subdomain handling - serve portfolio
  if (isSubdomain) {
    // Block API routes on subdomains for security
    if (url.pathname.startsWith('/api/')) {
      return new NextResponse('Not Found', { status: 404 });
    }

    // Allow static files
    if (
      url.pathname.startsWith('/_next/') ||
      url.pathname.startsWith('/favicon.ico')
    ) {
      return NextResponse.next({ headers });
    }

    // Rewrite subdomain to portfolio page
    url.pathname = `/portfolio/${currentHost}${url.pathname}`;
    
    return NextResponse.rewrite(url, { headers });
  }

  return NextResponse.next({ headers });
}

export const config = {
  matcher: [
    /*
     * Match all request paths except:
     * - _next/static (static files)
     * - _next/image (image optimization files)
     * - favicon.ico (favicon file)
     * - public folder files
     */
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
  ],
};