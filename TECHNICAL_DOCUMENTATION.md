# 📚 FOLIOMESH - DOCUMENTACIÓN TÉCNICA COMPLETA

## 🎯 RESUMEN EJECUTIVO

**FolioMesh** es una plataforma profesional que permite a los usuarios crear portafolios personalizados con subdominios únicos (ej: `kevinmendoza.foliomesh.com`). Combina elementos de LinkedIn con portafolios visualmente atractivos, incluyendo modelos 3D, múltiples diseños, y funcionalidades empresariales.

---

## 🏗️ ARQUITECTURA TÉCNICA

### Stack Tecnológico Principal
```
Frontend: Next.js 14 + App Router + TypeScript + Tailwind CSS
Backend: Supabase (PostgreSQL + Auth + APIs + RLS)
Storage: AWS S3 + CloudFront CDN
Hosting: Vercel + DNS Wildcard
Email: Resend
Pagos: LemonSqueezy
Domain: Namecheap (foliomesh.com)
Analytics: Vercel Analytics
```

### Integraciones Externas
```
✅ GitHub API - Importar repositorios (GRATIS)
✅ YouTube API - Videos embebidos (GRATIS) 
✅ Google Translate API - Traducciones automáticas
✅ Google Maps API - Ubicaciones en planeta 3D
✅ Persona ID - Verificación usuarios
✅ Trulioo - Verificación empresas
✅ Google OAuth - Autenticación
```

---

## 👥 TIPOS DE USUARIOS Y LÍMITES

### 🆓 USUARIOS GRATUITOS
```
Precio: $0
Portafolios: 1 activo
Proyectos: Máximo 5
Experiencias: Máximo 5
Certificados: Máximo 6 fotos
Contribuciones: Máximo 3 (con 3 fotos c/u)
Total imágenes: 24 (incluye perfil/banner)
Peso imagen: Cualquier peso → Compresión automática → Max 1MB final
Verificación: ❌ No disponible
Modelos 3D: ❌ No disponible
Traducciones: 3 idiomas, 1 vez por semana
```

### ⭐ USUARIOS PREMIUM
```
Precio: $9.90 anual
Portafolios: 3 máximo
Proyectos: 20 por portafolio
Experiencias: 20 por portafolio  
Certificados: Ilimitados
Contribuciones: 5 (con 3 fotos c/u)
Total imágenes: 180 por usuario
Peso imagen: Compresión automática → Max 3MB final
Verificación: ✅ Con Persona ID
Modelos 3D: ✅ Disponible
Traducciones: 7 idiomas, 1 vez diaria
```

### 🏢 EMPRESAS PEQUEÑAS
```
Precio: $19.99 mensual
Empleos activos: Máximo 5
Administradores: 3 + creador
Publicaciones: Ilimitadas
Imágenes: Hasta 10MB por imagen
2FA: Obligatorio con Google
Verificación: Trulioo automática
Analytics: Panel completo
```

### 🏢 EMPRESAS GRANDES  
```
Precio: $69.99 mensual
Empleos activos: Máximo 20
Administradores: 15 + creador
Publicaciones: Ilimitadas
Imágenes: Hasta 10MB por imagen
2FA: Obligatorio con Google
Verificación: Trulioo automática
Analytics: Panel completo + exportación
```

---

## 🌐 SISTEMA DE SUBDOMINIOS

### Generación Automática
```
Regla base: {primer_nombre}{primer_apellido}.foliomesh.com

Ejemplos:
✅ Kevin Mendoza → kevinmendoza.foliomesh.com
✅ María José García López → mariajosegarcia.foliomesh.com

En caso de duplicados:
1. Se agrega primera letra del segundo apellido
2. Luego segunda letra, tercera, etc.
3. Si se agotan, se usa segundo nombre
4. Como último recurso: números (1, 2, 3...)
```

### Caracteres Especiales
```
Automáticamente se convierten:
á, é, í, ó, ú → a, e, i, o, u
ñ → n
Espacios → eliminados
Mayúsculas → minúsculas
```

---

## 📊 ESQUEMA DE BASE DE DATOS

### Tabla: users
```sql
users:
  id: uuid (PK)
  email: string (unique)
  created_at: timestamp
  
  -- Datos personales
  first_name: string
  middle_name: string (nullable)
  last_name: string
  second_last_name: string (nullable)
  subdomain: string (unique) -- generado automáticamente
  
  -- Ubicación y contacto
  location: string
  phone: string (nullable)
  birth_date: date
  current_occupation: string
  
  -- Verificación y planes
  is_verified: boolean (default false)
  plan_type: enum ('free', 'premium')
  plan_expires_at: timestamp (nullable)
  verification_provider_id: string (nullable) -- Persona ID
  
  -- Seguridad
  last_login: timestamp
  login_attempts: integer (default 0)
  is_2fa_enabled: boolean (default false)
  
  -- Configuración
  preferred_language: string (default 'es')
  theme: enum ('light', 'dark', 'auto')
  email_notifications: boolean (default true)
  
  -- URLs sociales
  website_url: string (nullable)
  linkedin_url: string (nullable) 
  github_url: string (nullable)
  twitter_url: string (nullable)
  instagram_url: string (nullable)
  facebook_url: string (nullable)
  
  -- Imágenes
  profile_image_url: string (nullable)
  banner_image_url: string (nullable)
```

### Tabla: companies
```sql
companies:
  id: uuid (PK)
  created_at: timestamp
  
  -- Datos básicos
  name: string
  slug: string (unique) -- para URL
  industry: string
  company_size: enum ('small', 'large')
  location: string
  website_url: string
  description: text
  
  -- Plan y verificación
  plan_type: enum ('small', 'large')
  plan_expires_at: timestamp
  is_verified: boolean (default false)
  verification_provider_id: string (nullable) -- Trulioo
  
  -- Configuración
  logo_url: string (nullable)
  banner_url: string (nullable)
  
  -- Límites según plan
  max_active_jobs: integer -- 5 para small, 20 para large
  max_admins: integer -- 3 para small, 15 para large
  
  -- Métricas
  total_views: integer (default 0)
  total_followers: integer (default 0)
```

### Tabla: company_admins
```sql
company_admins:
  id: uuid (PK)
  company_id: uuid (FK → companies.id)
  user_id: uuid (FK → users.id)
  role: enum ('owner', 'admin')
  permissions: jsonb -- publicaciones, empleos, analytics, etc.
  created_at: timestamp
  
  UNIQUE(company_id, user_id)
```

### Tabla: portfolios
```sql
portfolios:
  id: uuid (PK)
  user_id: uuid (FK → users.id)
  created_at: timestamp
  updated_at: timestamp
  
  -- Estado
  is_active: boolean (default false) -- solo uno activo por usuario
  status: enum ('draft', 'published')
  
  -- Personalización
  title: string
  gradient_color: string (hex color)
  font_style: enum ('formal', 'pixelated', 'technological')
  
  -- Métricas
  total_views: integer (default 0)
  total_downloads: integer (default 0)
  last_viewed_at: timestamp
  
  -- Traducciones
  available_languages: text[] -- array de códigos de idioma
  last_translation_update: timestamp
```

### Tabla: portfolio_sections
```sql
portfolio_sections:
  id: uuid (PK)
  portfolio_id: uuid (FK → portfolios.id)
  created_at: timestamp
  updated_at: timestamp
  
  -- Configuración
  section_type: enum ('about', 'experience', 'education', 'projects', 'skills', 'impact', 'objectives')
  design_variant: string -- específico por tipo de sección
  position_order: integer
  is_visible: boolean (default true)
  
  -- Contenido base (español)
  content: jsonb -- estructura específica por tipo
  
  -- Traducciones
  translations: jsonb -- {es: {}, en: {}, fr: {}} etc.
```

### Tabla: posts
```sql
posts:
  id: uuid (PK)
  created_at: timestamp
  updated_at: timestamp
  
  -- Autor
  author_type: enum ('user', 'company')
  author_user_id: uuid (FK → users.id, nullable)
  author_company_id: uuid (FK → companies.id, nullable)
  
  -- Contenido
  content_type: enum ('portfolio_share', 'company_post', 'job_posting')
  text_content: text
  image_urls: text[] (nullable) -- solo empresas pueden subir imágenes
  
  -- Si es portfolio_share
  shared_portfolio_id: uuid (FK → portfolios.id, nullable)
  
  -- Si es job_posting
  job_id: uuid (FK → jobs.id, nullable)
  
  -- Engagement
  likes_count: integer (default 0)
  comments_count: integer (default 0)
  
  -- Programación
  scheduled_at: timestamp (nullable)
  is_published: boolean (default true)
```

### Tabla: jobs
```sql
jobs:
  id: uuid (PK)
  company_id: uuid (FK → companies.id)
  created_at: timestamp
  updated_at: timestamp
  
  -- Información básica
  title: string
  description: text
  requirements: text
  responsibilities: text
  
  -- Ubicación y tipo
  work_type: enum ('remote', 'onsite', 'hybrid')
  location: string (nullable) -- para onsite/hybrid
  contract_type: enum ('full_time', 'part_time', 'freelance', 'internship')
  
  -- Configuración
  application_deadline: timestamp
  required_languages: text[] -- ['es', 'en', 'fr']
  experience_level: enum ('entry', 'mid', 'senior', 'lead')
  
  -- Estado
  is_active: boolean (default true)
  applicants_count: integer (default 0)
  views_count: integer (default 0)
```

### Tabla: job_applications
```sql
job_applications:
  id: uuid (PK)
  job_id: uuid (FK → jobs.id)
  user_id: uuid (FK → users.id)
  created_at: timestamp
  
  -- Estado de aplicación
  status: enum ('received', 'reviewed', 'rejected', 'preselected', 'selected')
  reviewed_at: timestamp (nullable)
  reviewed_by: uuid (FK → users.id, nullable)
  
  -- Datos en momento de aplicación
  portfolio_snapshot: jsonb -- copia del portafolio activo al momento
  user_qualifications: jsonb -- skills, languages, etc.
  
  UNIQUE(job_id, user_id)
```

### Tabla: connections
```sql
connections:
  id: uuid (PK)
  requester_id: uuid (FK → users.id)
  requested_id: uuid (FK → users.id)
  created_at: timestamp
  
  -- Estado
  status: enum ('pending', 'accepted', 'declined', 'blocked')
  responded_at: timestamp (nullable)
  
  UNIQUE(requester_id, requested_id)
```

### Tabla: company_follows
```sql
company_follows:
  id: uuid (PK)
  user_id: uuid (FK → users.id)
  company_id: uuid (FK → companies.id)
  created_at: timestamp
  
  -- Configuración
  notifications_enabled: boolean (default true)
  
  UNIQUE(user_id, company_id)
```

### Tabla: messages
```sql
messages:
  id: uuid (PK)
  created_at: timestamp
  
  -- Participantes
  sender_type: enum ('user', 'company')
  sender_user_id: uuid (FK → users.id, nullable)
  sender_company_id: uuid (FK → companies.id, nullable)
  
  receiver_user_id: uuid (FK → users.id) -- solo usuarios reciben mensajes
  
  -- Contenido
  content: text
  image_urls: text[] (nullable) -- solo empresas pueden enviar imágenes
  
  -- Estado
  is_read: boolean (default false)
  read_at: timestamp (nullable)
  
  -- Conversación
  conversation_id: uuid -- para agrupar mensajes
```

### Tabla: notifications
```sql
notifications:
  id: uuid (PK)
  user_id: uuid (FK → users.id)
  created_at: timestamp
  
  -- Contenido
  type: enum ('connection_request', 'job_match', 'message', 'company_update', 'system')
  title: string
  content: text
  
  -- Metadata
  related_entity_type: enum ('user', 'company', 'job', 'post')
  related_entity_id: uuid (nullable)
  
  -- Estado
  is_read: boolean (default false)
  read_at: timestamp (nullable)
```

### Tabla: reports
```sql
reports:
  id: uuid (PK)
  created_at: timestamp
  
  -- Reportador
  reporter_user_id: uuid (FK → users.id)
  
  -- Contenido reportado
  reported_entity_type: enum ('user', 'company', 'post', 'portfolio')
  reported_entity_id: uuid
  
  -- Detalles
  report_reason: enum ('inappropriate', 'spam', 'fake_content', 'impersonation', 'other')
  description: text (nullable)
  
  -- Estado
  status: enum ('pending', 'reviewing', 'resolved', 'dismissed')
  resolved_at: timestamp (nullable)
  resolved_by_admin: boolean (default false)
```

### Tabla: analytics_events
```sql
analytics_events:
  id: uuid (PK)
  created_at: timestamp
  
  -- Entidad
  entity_type: enum ('portfolio', 'company', 'post', 'job')
  entity_id: uuid
  
  -- Evento
  event_type: enum ('view', 'like', 'comment', 'share', 'download', 'application')
  
  -- Contexto
  user_id: uuid (FK → users.id, nullable) -- null para visitantes anónimos
  ip_address: inet
  user_agent: text
  referrer: text (nullable)
  country: string (nullable)
```

---

## 🎨 DISEÑOS DE PORTAFOLIO

### 1. SOBRE MÍ (3 diseños)

#### Perfil con texto descriptivo
```
Layout: 2 columnas
- Columna 1: Texto (nombre, ocupación, descripción, botones contacto)
- Columna 2: Imagen usuario (2x2)
- Usuario elige qué columna para imagen/texto
```

#### Presentación visual interactiva (PREMIUM)
```
Layout: 2 columnas  
- Columna 1: Texto (nombre, ocupación, descripción, botones)
- Columna 2: Modelo 3D avatar (2x2)
- Interacciones: sigue cursor, salta al click con efecto brillo
- Colores personalizables: piel, cabello, ojos, traje, corbata
```

#### Video de introducción personal
```
Layout: Vertical
- Nombre + ocupación
- Video YouTube embebido
- Botones de contacto
```

### 2. EXPERIENCIA LABORAL (3 diseños)

#### Línea del tiempo vertical
```
- Línea vertical izquierda con nodos
- Max 5 experiencias visibles, resto con "ver más"
- Info: empresa, cargo, período, descripción, botón "more info"
```

#### Cinta horizontal
```
- Carousel horizontal deslizable
- Más reciente a la izquierda
- Navegación con botones
```

#### Ruta profesional
```
- Mapa de ruta vertical
- Nodos conectados con líneas suaves
- Hover para expandir detalles
```

### 3. PROYECTOS Y LOGROS (3 diseños)

#### Tarjetas de proyectos
```
Layout: 2 columnas
- Imagen del proyecto
- Título, descripción, tecnologías, enlaces
- Integración con GitHub API para datos automáticos
```

#### Tarjetas para documentos
```
- Vista previa de Google Docs (proporción A4)
- Solo lectura, enlace al documento completo
```

#### Video de YouTube
```
- Video embebido 16:9
- Información del proyecto al lado
```

### 4. HABILIDADES Y COMPETENCIAS (3 diseños)

#### Lista de habilidades
```
4 categorías: Blandas, Técnicas, Herramientas, Metodologías
- Ícono + título + nivel + descripción
```

#### Bloques de habilidades
```
- 3 columnas de bloques compactos
- Ícono + título + nivel (sin descripción)
```

#### Hexágonos de habilidades (PREMIUM)
```
- Hexágonos con íconos
- Color de borde según nivel: verde/naranja/rojo/morado
- Hover para mostrar detalles
```

### 5. IMPACTO Y CONTRIBUCIÓN (3 diseños)

#### Tarjetas con ubicación
```
- Mapa cuadrado con ubicación
- Fecha, descripción, enlace opcional
```

#### Tarjetas con galería
```
- 3 imágenes horizontales 16:9
- Información debajo
```

#### Planeta 3D interactivo (PREMIUM)
```
- Planeta rotable con marcadores
- Click en marcador muestra información
- Layout 2 columnas: planeta + info
```

### 6. OBJETIVOS Y DISPONIBILIDAD (3 diseños)

#### Post-its
```
- 2 notas con clips de colores
- "Objetivo" + "Disponible" (tachado si no disponible)
- Click lleva a "Sobre mí"
```

#### Foto y texto
```
- Imagen cuadrada + texto objetivos
- Botón disponibilidad (verde/rojo)
```

#### Declaración de propósito
```
- Párrafo centrado con emojis a los lados
- Botón disponibilidad debajo
```

---

## 🔐 SEGURIDAD Y AUTENTICACIÓN

### Flujo de Registro
```
1. Email/contraseña O Google OAuth
2. Completar datos personales (nombre, apellido, ocupación, ubicación, fecha nacimiento)
3. Verificación por email (código 6 dígitos)
4. Generación automática de subdominio
5. Onboarding (tutorial de funcionalidades)
```

### Verificación Premium
```
- Persona ID: Documento + selfie
- Verificación de nombre/apellidos
- Usuario puede elegir mostrar uno o dos nombres
- Teléfono opcional pero recomendado para recuperación
```

### Verificación Empresarial
```
1. Usuario crea cuenta personal
2. Paga plan empresarial ($19.99 o $69.99)
3. Verificación automática con Trulioo
4. 2FA obligatorio con Google
5. Acceso a funciones empresariales
```

### Medidas de Seguridad
```
✅ Rate limiting por IP (100 req/min)
✅ CAPTCHA tras intentos fallidos
✅ Sanitización automática de inputs
✅ Validación estricta de archivos (JPG/PNG únicamente)
✅ Eliminación automática de metadatos EXIF
✅ Protección XSS, SQL Injection, CSRF
✅ Sesiones seguras con Supabase
✅ Logout automático por inactividad
✅ Detección de logins sospechosos
```

---

## 💳 SISTEMA DE PAGOS

### Integración LemonSqueezy
```
- Facturación automática
- Compliance global (impuestos incluidos)
- Webhooks para actualizaciones de estado
- Reembolsos: 3 días (sin verificación), no reembolsable si verificado
```

### Flujos de Upgrade/Downgrade
```
Usuario FREE → PREMIUM:
- Pago inmediato → Upgrade automático
- Desbloqueo de funciones premium

Usuario PREMIUM → FREE:
- Contenido extra se oculta (no se borra)
- 3 meses para reactivar antes de eliminación
- Portafolios extra (2 y 3) se ocultan

Empresa sin pagar:
- 15 días, 7 días, 1 día de aviso
- 3 días después: pausa total
- 3 meses para reactivar
```

### Espacio Publicitario
```
"Colaboradores Principales":
- 9 empresas máximo en vista principal
- Pago voluntario desde $5 USD
- Posición según monto aportado
- Renovación mensual
- Expansible con "Ver más"
```

---

## 🌐 SISTEMA DE TRADUCCIONES

### Límites por Usuario
```
FREE: 3 idiomas, 1 vez por semana
PREMIUM: 7 idiomas, 1 vez diario
```

### Flujo de Traducción
```
1. Usuario crea contenido en idioma base
2. Solicita traducción a idiomas específicos
3. Google Translate API procesa contenido
4. Se guarda en BD: {es: "texto", en: "text", fr: "texte"}
5. Visitante ve automáticamente en su idioma del navegador
6. Si no coincide → fallback a inglés → fallback a idioma base
```

### Interfaz Multiidioma
```
- Header/botones: idioma del navegador del visitante
- Contenido del portafolio: según configuración del creador
- Detección automática via navigator.language
```

---

## 📊 ALGORITMO DEL FEED

### Distribución de Contenido
```
60% Cronológico (más reciente)
25% Relevancia (misma industria/ubicación)  
15% Conexiones (posts de contactos)
```

### Tipos de Contenido
```
- Portafolios compartidos por usuarios
- Publicaciones de empresas (con imágenes)
- Ofertas de trabajo destacadas
- Sin límite de frecuencia por usuario/empresa
```

### Interacciones Permitidas
```
✅ Like (corazón)
✅ Comentarios (solo texto)
✅ Responder comentarios
✅ Like a comentarios
❌ Compartir/repost
❌ Imágenes en comentarios
```

---

## 🔍 SISTEMA DE BÚSQUEDA

### Algoritmo de Priorización
```
1. Usuarios/empresas verificados
2. Misma ubicación/país
3. Conexiones mutuas
4. Relevancia por industria
5. Actividad reciente
```

### Filtros Avanzados
```
Usuarios:
- Ubicación (ciudad, país, remoto)
- Industria/sector
- Nivel experiencia (junior, mid, senior)
- Solo verificados
- Habilidades específicas

Empresas:
- Ubicación
- Industria
- Tamaño (pequeña, grande)
- Solo verificadas

Empleos:
- Tipo (presencial, remoto, híbrido)
- Ubicación
- Industria
- Nivel experiencia
- Tipo contrato
```

---

## 🛠️ SISTEMA DE MODERACIÓN

### Reportes Automáticos
```
5 reportes → Notificación al usuario + email
10 reportes → Perfil oculto hasta revisión
50 reportes → Suspensión + obligación de verificarse

Tipos de reporte:
- Perfil inapropiado
- Spam
- Contenido falso
- Suplantación de identidad
```

### Filtros Automáticos
```
- Lista de palabras prohibidas (9 idiomas principales)
- Validación de tipos de archivo
- Escaneo básico de contenido inapropiado
```

### Apelaciones
```
- Email con asunto "APELACION"
- Revisión manual por administrador
- Respuesta en 24-48 horas
```

---

## 📱 EXPERIENCIA MÓVIL

### Navegación
```
- Barra inferior con iconos
- Header fijo con búsqueda
- Scroll infinito en feed
- Optimización touch-first
```

### Funcionalidades Móviles
```
✅ PWA (Progressive Web App)
✅ Acceso a cámara/galería para fotos
✅ Push notifications del navegador
✅ Gestos táctiles para modelos 3D
✅ Diseño responsive completo
```

---

## ⚡ OPTIMIZACIÓN Y PERFORMANCE

### Caché Inteligente
```
- Portafolios cacheados 24h
- Imágenes servidas via CloudFront CDN
- Compresión automática WebP cuando posible
- Lazy loading para contenido pesado
```

### Compresión de Imágenes
```
FREE: Cualquier tamaño → Compresión → Max 1MB
PREMIUM: Compresión → Max 3MB  
EMPRESAS: Max 10MB sin compresión forzada
```

### Modelos 3D Optimizados
```
- Avatares low-poly (< 50KB cada uno)
- Planeta 3D simple (< 100KB)
- Carga bajo demanda (lazy loading)
- Fallback a imágenes estáticas si falla 3D
```

---

## 📈 ANALYTICS Y MÉTRICAS

### Para Empresas
```
Panel General:
- Visualizaciones perfil empresa
- Nuevos seguidores
- Interacciones con publicaciones
- Aplicaciones a empleos
- Comparativas períodos anteriores

Por Publicación:
- Visualizaciones
- Likes y comentarios
- Alcance geográfico

Por Empleo:
- Visualizaciones
- Aplicaciones totales
- Filtros: verificados, calificados, por ubicación
```

### Para Usuarios
```
- Visualizaciones de portafolio
- Descargas de PDF
- Origen del tráfico
- Países de visitantes
```

---

## 🔄 BACKUP Y RECUPERACIÓN

### Estrategia de Respaldo
```
- Backup automático diario de PostgreSQL
- Point-in-Time Recovery en Supabase
- Imágenes replicadas en múltiples regiones AWS
- Logs de sistema 30 días retención
```

### Recuperación de Datos
```
- RTO (Recovery Time Objective): 4 horas
- RPO (Recovery Point Objective): 24 horas
- Pruebas de recuperación mensuales
```

---

## 📋 COMPLIANCE Y LEGAL

### GDPR / Protección de Datos
```
✅ Cookie consent banner
✅ Política de privacidad
✅ Términos de servicio
✅ Derecho al olvido (eliminación de cuenta)
✅ Exportación de datos personales
✅ Eliminación automática de metadatos de imágenes
```

### Documentos Requeridos
```
- Política de Privacidad
- Términos de Servicio  
- Política de Cookies
- Política de Moderación
- Proceso de Apelaciones
- Condiciones de Reembolso
```

---

## 🚀 ROADMAP DE DESARROLLO

### Fase 1: Core Platform (Semanas 1-4)
- ✅ Setup entorno desarrollo
- ✅ Autenticación y registro
- ✅ Perfiles básicos de usuario
- ✅ Sistema de subdominios
- ✅ Upload y gestión de imágenes

### Fase 2: Portafolios (Semanas 5-8)
- ✅ Editor de portafolios
- ✅ Diseños básicos (sin 3D)
- ✅ Sistema de traducciones
- ✅ Generación de PDF

### Fase 3: Social Features (Semanas 9-12)
- ✅ Feed y publicaciones
- ✅ Sistema de conexiones
- ✅ Mensajería básica
- ✅ Notificaciones

### Fase 4: Empresas (Semanas 13-16)
- ✅ Perfiles empresariales
- ✅ Sistema de empleos
- ✅ Panel de administración
- ✅ Analytics básicos

### Fase 5: Premium Features (Semanas 17-20)
- ✅ Modelos 3D (avatares y planeta)
- ✅ Diseños avanzados
- ✅ Sistema de pagos
- ✅ Verificación de usuarios

### Fase 6: Optimización (Semanas 21-24)
- ✅ Performance optimization
- ✅ SEO y indexación
- ✅ Testing completo
- ✅ Lanzamiento beta

---

## 🎯 MÉTRICAS DE ÉXITO

### KPIs Iniciales
```
- Registros únicos mensuales
- Portafolios creados vs completados
- Tasa de conversión FREE → PREMIUM
- Empresas registradas y verificadas
- Tiempo promedio en plataforma
- Tasa de retención (7 días, 30 días)
```

### Métricas de Engagement
```
- Publicaciones por usuario activo
- Conexiones promedio por usuario
- Aplicaciones a empleos por mes
- Visualizaciones de portafolio por usuario
```

---

## 🔧 CONFIGURACIÓN DE ENTORNO

### Variables de Entorno Requeridas
```env
# Supabase
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=

# AWS S3
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_S3_BUCKET=
AWS_REGION=

# LemonSqueezy
LEMONSQUEEZY_API_KEY=
LEMONSQUEEZY_WEBHOOK_SECRET=

# Email
RESEND_API_KEY=

# APIs Externas
GITHUB_API_TOKEN=
GOOGLE_TRANSLATE_API_KEY=
GOOGLE_MAPS_API_KEY=
YOUTUBE_API_KEY=

# Verificación
PERSONA_API_KEY=
TRULIOO_API_KEY=

# Otros
NEXTAUTH_SECRET=
NEXTAUTH_URL=
```

---

**📝 Documento actualizado:** Octubre 31, 2025  
**👨‍💻 Desarrollador:** GitHub Copilot  
**🎯 Proyecto:** FolioMesh Platform