# Despliegue en Vercel para FolioMesh

## 1. Preparar Repositorio

### Subir a GitHub
1. Crea un repositorio en GitHub llamado `foliomesh`
2. Conecta tu repositorio local:
   ```bash
   git remote add origin https://github.com/tu-usuario/foliomesh.git
   git branch -M main
   git push -u origin main
   ```

## 2. Configurar Proyecto en Vercel

### Importar Proyecto
1. Ve a https://vercel.com
2. Clic en "New Project"
3. Importa desde GitHub: `tu-usuario/foliomesh`
4. Framework: **Next.js**
5. Root Directory: `./`

### Configuración de Build
- **Build Command**: `npm run build`
- **Output Directory**: `.next`
- **Install Command**: `npm install`

## 3. Configurar Dominio Personalizado

### Añadir Dominio
1. Ve a Settings > Domains
2. Añade: `foliomesh.com`
3. Configura subdominios wildcard: `*.foliomesh.com`

### Configurar DNS
En tu proveedor de DNS (Cloudflare, GoDaddy, etc.):

```
# Records principales
A     foliomesh.com          → 76.76.19.19
AAAA  foliomesh.com          → 2606:4700:4700::1111

# Subdominio www
CNAME www.foliomesh.com      → foliomesh.com

# Subdominios wildcard para portfolios
CNAME *.foliomesh.com        → cname.vercel-dns.com

# Verificación de dominio (temporal)
TXT   _vercel                → [verification-code]
```

## 4. Variables de Entorno

### En Vercel Dashboard
Ve a Settings > Environment Variables y añade:

#### Supabase
```
NEXT_PUBLIC_SUPABASE_URL=https://[tu-proyecto].supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=[anon-key]
SUPABASE_SERVICE_ROLE_KEY=[service-role-key]
```

#### AWS S3
```
AWS_ACCESS_KEY_ID=[access-key]
AWS_SECRET_ACCESS_KEY=[secret-key]
AWS_REGION=us-east-1
AWS_S3_BUCKET_NAME=foliomesh-uploads
```

#### LemonSqueezy
```
LEMONSQUEEZY_API_KEY=[api-key]
LEMONSQUEEZY_STORE_ID=[store-id]
LEMONSQUEEZY_WEBHOOK_SECRET=[webhook-secret]
LEMONSQUEEZY_PREMIUM_MONTHLY_ID=[product-id]
LEMONSQUEEZY_PREMIUM_ANNUAL_ID=[product-id]
LEMONSQUEEZY_BUSINESS_SMALL_ID=[product-id]
LEMONSQUEEZY_BUSINESS_LARGE_ID=[product-id]
```

#### Resend (Email)
```
RESEND_API_KEY=[resend-api-key]
FROM_EMAIL=noreply@foliomesh.com
```

#### Google OAuth (Opcional)
```
GOOGLE_CLIENT_ID=[google-client-id]
GOOGLE_CLIENT_SECRET=[google-client-secret]
```

#### App Configuration
```
NEXT_PUBLIC_APP_URL=https://foliomesh.com
NEXT_PUBLIC_APP_NAME=FolioMesh
NEXT_PUBLIC_APP_DESCRIPTION=Professional Portfolio Platform
NODE_ENV=production
VERCEL_ENV=production
```

#### Security & Analytics
```
NEXTAUTH_SECRET=[random-secret-32-chars]
NEXTAUTH_URL=https://foliomesh.com
VERCEL_ANALYTICS_ID=[analytics-id]
```

### Configurar por Entorno
- **Production**: Todas las variables de arriba
- **Preview**: Las mismas pero con URLs de staging
- **Development**: Las mismas pero con localhost

## 5. Configurar Headers de Seguridad

### En vercel.json (ya configurado)
```json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "Referrer-Policy",
          "value": "strict-origin-when-cross-origin"
        }
      ]
    }
  ]
}
```

## 6. Configurar Rewrites para Subdominios

### En next.config.js (ya configurado)
```javascript
async rewrites() {
  return [
    {
      source: '/:path*',
      has: [
        {
          type: 'host',
          value: '(?<subdomain>.*)\\.foliomesh\\.com',
        },
      ],
      destination: '/:subdomain/:path*',
    },
  ];
}
```

## 7. Configurar Analytics

### Vercel Analytics
1. Ve a Analytics tab en tu proyecto
2. Activa Vercel Analytics
3. Copia el Analytics ID a las variables de entorno

### Google Analytics (Opcional)
```
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX
```

## 8. Configurar Monitoreo

### Vercel Speed Insights
1. Activa Speed Insights en tu dashboard
2. Se configurará automáticamente

### Error Tracking (Opcional con Sentry)
```
SENTRY_DSN=[sentry-dsn]
SENTRY_ORG=[org-name]
SENTRY_PROJECT=[project-name]
```

## 9. Configurar Webhooks

### Deployment Hooks
Para rebuild automático:
- **Supabase**: Webhook cuando cambien datos críticos
- **GitHub**: Auto-deploy en push a main

### External Webhooks
URLs que necesitas configurar en servicios externos:
- **LemonSqueezy**: `https://foliomesh.com/api/webhooks/lemonsqueezy`
- **Supabase**: `https://foliomesh.com/api/webhooks/supabase`

## 10. Configurar SSL

### Certificate Management
- Vercel maneja SSL automáticamente
- Certificate renewal automático
- HTTP/2 y HTTP/3 habilitados

### Custom SSL (Si necesario)
- Puedes subir tu propio certificado
- Configurar en Settings > Domains

## 11. Performance Optimization

### Edge Functions
- API routes se ejecutan en el edge
- Cache global automático
- ISR (Incremental Static Regeneration) configurado

### Image Optimization
```javascript
// next.config.js
images: {
  domains: [
    'foliomesh-uploads.s3.amazonaws.com',
    'images.unsplash.com',
    'avatars.githubusercontent.com'
  ],
  formats: ['image/webp', 'image/avif'],
}
```

## 12. Configurar Staging

### Branch Deployments
- **main**: Producción (foliomesh.com)
- **staging**: Staging (foliomesh-staging.vercel.app)
- **feature/***: Preview deployments

### Variables por Entorno
- Staging usa las mismas APIs pero con prefijos de test
- Preview deployments usan datos de desarrollo

## 13. Monitoring y Logs

### Vercel Logs
- Real-time function logs
- Error tracking
- Performance metrics

### Alerts
Configura alerts para:
- Errores 5xx
- High response times
- Failed deployments

## 14. Backup y Recovery

### Database Backups
- Supabase maneja backups automáticos
- Point-in-time recovery disponible

### File Backups
- S3 tiene versioning habilitado
- Cross-region replication configurado

## 15. Pre-Launch Checklist

### Testing
- ✅ Subdominios funcionando
- ✅ Authentication flow completo
- ✅ Payment flow funcionando
- ✅ File uploads funcionando
- ✅ Email notifications
- ✅ Mobile responsive
- ✅ SEO optimizado

### Performance
- ✅ Core Web Vitals < 2.5s
- ✅ Images optimizadas
- ✅ CDN configurado
- ✅ Caching strategies

### Security
- ✅ HTTPS everywhere
- ✅ CORS configurado
- ✅ Rate limiting activo
- ✅ Data validation
- ✅ Security headers

### Monitoring
- ✅ Analytics configurado
- ✅ Error tracking
- ✅ Performance monitoring
- ✅ Uptime monitoring

## 16. Launch!

### Go Live Steps
1. Verifica todas las configuraciones
2. Ejecuta tests finales
3. Deploy a producción
4. Verifica DNS propagation
5. Test completo en producción
6. Monitorea errores

### Post-Launch
- Monitor performance y errores
- Set up alertas
- Document any issues
- Plan siguiente iteración

¡FolioMesh está listo para el mundo! 🚀

### URLs Finales
- **App**: https://foliomesh.com
- **Portfolios**: https://[username].foliomesh.com
- **Dashboard**: https://foliomesh.com/dashboard
- **Admin**: https://foliomesh.com/admin