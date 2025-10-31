# FolioMesh - Professional Portfolio Platform

## 🚀 Despliegue en Producción

### Requisitos Previos

1. **Dominio**: foliomesh.com
2. **Cuenta Vercel**: Para el hosting
3. **Proyecto Supabase**: Para la base de datos
4. **AWS S3**: Para almacenamiento de archivos
5. **LemonSqueezy**: Para pagos

### Variables de Entorno Requeridas

```bash
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu_anon_key_aqui
SUPABASE_SERVICE_ROLE_KEY=tu_service_role_key_aqui

# AWS S3 Configuration
AWS_ACCESS_KEY_ID=tu_aws_access_key
AWS_SECRET_ACCESS_KEY=tu_aws_secret_key
AWS_REGION=us-east-1
AWS_S3_BUCKET_NAME=foliomesh-uploads

# LemonSqueezy Configuration
LEMONSQUEEZY_API_KEY=tu_lemonsqueezy_api_key
LEMONSQUEEZY_STORE_ID=tu_store_id
LEMONSQUEEZY_WEBHOOK_SECRET=tu_webhook_secret

# Resend Email Configuration
RESEND_API_KEY=tu_resend_api_key
FROM_EMAIL=noreply@foliomesh.com

# Google OAuth (opcional)
GOOGLE_CLIENT_ID=tu_google_client_id
GOOGLE_CLIENT_SECRET=tu_google_client_secret

# App Configuration
NEXT_PUBLIC_APP_URL=https://foliomesh.com
NEXT_PUBLIC_APP_NAME=FolioMesh
NEXT_PUBLIC_APP_DESCRIPTION=Professional Portfolio Platform

# Production settings
NODE_ENV=production
VERCEL_ENV=production
```

## 📋 Pasos de Configuración

### 1. Configurar Supabase

1. Ve a [supabase.com](https://supabase.com) y crea un nuevo proyecto
2. En el dashboard, ve a Settings > API
3. Copia la URL del proyecto y las API keys
4. Ve a SQL Editor y ejecuta el archivo `database/schema.sql`
5. Ejecuta también `database/rls_policies.sql`

### 2. Configurar AWS S3

1. Crea un bucket S3 llamado `foliomesh-uploads`
2. Configura CORS para permitir uploads desde tu dominio
3. Crea un usuario IAM con permisos S3
4. Guarda las credenciales ACCESS_KEY_ID y SECRET_ACCESS_KEY

### 3. Configurar LemonSqueezy

1. Crea una cuenta en LemonSqueezy
2. Configura tu tienda y productos (Plan FREE, PREMIUM, etc.)
3. Obtén las API keys desde el dashboard
4. Configura webhooks para `https://foliomesh.com/api/webhooks/lemonsqueezy`

### 4. Desplegar en Vercel

1. Conecta este repositorio a Vercel
2. Configura el dominio personalizado: `foliomesh.com`
3. Configura subdominios wildcard: `*.foliomesh.com`
4. Añade todas las variables de entorno en el dashboard de Vercel
5. Despliega el proyecto

### 5. Configurar DNS

En tu proveedor de DNS (Cloudflare, etc.):

```
A     foliomesh.com          → IP de Vercel
CNAME *.foliomesh.com        → foliomesh.com
CNAME www.foliomesh.com      → foliomesh.com
```

## 🔧 Comandos de Desarrollo

```bash
# Instalar dependencias
npm install

# Modo desarrollo
npm run dev

# Build de producción
npm run build

# Verificar tipos
npm run type-check

# Linting
npm run lint
```

## 📁 Estructura del Proyecto

```
foliomesh/
├── app/                    # Páginas Next.js App Router
│   ├── (auth)/            # Rutas de autenticación
│   ├── (dashboard)/       # Dashboard de usuario
│   ├── api/               # API endpoints
│   └── globals.css        # Estilos globales
├── components/            # Componentes React
│   ├── ui/               # Componentes UI reutilizables
│   ├── forms/            # Formularios
│   ├── pages/            # Componentes de página
│   └── providers/        # Context providers
├── database/             # Esquemas y migraciones
├── lib/                  # Utilidades y configuraciones
├── types/                # Definiciones de tipos TypeScript
├── utils/                # Funciones de utilidad
└── middleware.ts         # Middleware para subdominios
```

## 🌐 URLs del Sistema

- **Principal**: https://foliomesh.com
- **Portafolios**: https://[username].foliomesh.com
- **Dashboard**: https://foliomesh.com/dashboard
- **Admin**: https://foliomesh.com/admin
- **API**: https://foliomesh.com/api/*

## 📱 Características Principales

- ✅ Portafolios personalizables con subdominios
- ✅ Sistema de autenticación completo
- ✅ Feed social profesional
- ✅ Sistema de empleos
- ✅ Mensajería en tiempo real
- ✅ Pagos y suscripciones
- ✅ Analytics avanzados
- ✅ Soporte multiidioma
- ✅ Optimizado para SEO

## 🔒 Seguridad

- Row Level Security (RLS) en Supabase
- Rate limiting en API endpoints
- Validación de archivos
- Sanitización de datos
- Headers de seguridad
- Compliance GDPR

---

**¿Listo para lanzar? 🚀**

Sigue estos pasos y tendrás FolioMesh funcionando en producción!