# Configuración AWS S3 SEGURA para FolioMesh

## 🔒 Configuración Moderna y Segura

### ¿Por qué esta configuración es mejor?
- ✅ Bucket completamente privado (nunca expuesto)
- ✅ CloudFront con Origin Access Control (OAC)
- ✅ Pre-signed URLs para uploads seguros
- ✅ CDN global para performance
- ✅ SSL/TLS automático

---

## 1. Crear Bucket S3 (PRIVADO)

1. Ve a AWS Console > S3
2. Crea un nuevo bucket:
   - **Nombre**: `foliomesh-uploads`
   - **Región**: US East (N. Virginia) us-east-1
   - **Block Public Access**: ✅ **MANTENER ACTIVADO** (Seguridad)
   - **Bucket Versioning**: Enabled (recomendado)
   - **Default Encryption**: SSE-S3 (recomendado)

## 2. Crear Usuario IAM

### Paso 1: Crear Usuario
1. Ve a IAM > Users
2. Crea usuario: `foliomesh-s3-user`
3. **NO** asignar permisos todavía

### Paso 2: Crear Política Personalizada
1. Ve a IAM > Policies > Create Policy
2. JSON tab y pega:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ListBucket",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::foliomesh-uploads"
        },
        {
            "Sid": "ObjectOperations",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:GetObjectVersion",
                "s3:DeleteObjectVersion"
            ],
            "Resource": "arn:aws:s3:::foliomesh-uploads/*"
        },
        {
            "Sid": "GeneratePresignedUrls",
            "Effect": "Allow",
            "Action": [
                "s3:PutObjectAcl",
                "s3:GetObjectAcl"
            ],
            "Resource": "arn:aws:s3:::foliomesh-uploads/*"
        }
    ]
}
```

3. **Nombre de la política**: `FolioMeshS3SecurePolicy`
4. Create Policy

### Paso 3: Asignar Política al Usuario
1. Ve al usuario `foliomesh-s3-user`
2. Add permissions > Attach existing policies
3. Busca y selecciona `FolioMeshS3SecurePolicy`
4. Add permissions

### Paso 4: Crear Access Keys
1. En el usuario, ve a Security credentials
2. Create access key
3. **Use case**: Application running outside AWS
4. **GUARDA ESTAS CREDENCIALES**:
   - Access Key ID: `AKIA...`
   - Secret Access Key: `...`

## 3. Configurar CloudFront Distribution

### Paso 1: Crear Distribution
1. Ve a CloudFront > Create Distribution
2. **Origin**:
   - Origin domain: `foliomesh-uploads.s3.us-east-1.amazonaws.com`
   - Origin access: **Origin access control settings (recommended)**
   - Create control setting:
     - Name: `foliomesh-oac`
     - Sign requests: Yes
     - Origin type: S3

### Paso 2: Distribution Settings
- **Default Cache Behavior**:
  - Allowed HTTP Methods: `GET, HEAD, OPTIONS, PUT, POST, PATCH, DELETE`
  - Cache policy: `CachingOptimized`
  - Origin request policy: `CORS-S3Origin`
  - Response headers policy: `SimpleCORS`

- **Settings**:
  - Price class: `Use all edge locations (best performance)`
  - Custom SSL certificate: `*.foliomesh.com` (si tienes)
  - Security policy: `TLSv1.2_2021`

### Paso 3: Copiar la S3 Bucket Policy
CloudFront te dará una bucket policy. Ve a tu bucket S3 > Permissions > Bucket Policy y pégala:

```json
{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::foliomesh-uploads/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "arn:aws:cloudfront::[TU-ACCOUNT-ID]:distribution/[DISTRIBUTION-ID]"
                }
            }
        }
    ]
}
```

## 4. Configurar CORS en S3

En tu bucket, ve a Permissions > CORS:

```json
[
    {
        "AllowedHeaders": [
            "*"
        ],
        "AllowedMethods": [
            "GET",
            "POST",
            "PUT",
            "DELETE",
            "HEAD"
        ],
        "AllowedOrigins": [
            "https://foliomesh.com",
            "https://*.foliomesh.com",
            "http://localhost:3000"
        ],
        "ExposeHeaders": [
            "ETag",
            "x-amz-request-id"
        ],
        "MaxAgeSeconds": 3000
    }
]
```

## 5. Variables de Entorno para .env

```env
# AWS S3 Configuration
AWS_ACCESS_KEY_ID=[tu-access-key-id]
AWS_SECRET_ACCESS_KEY=[tu-secret-access-key]
AWS_REGION=us-east-1
AWS_S3_BUCKET_NAME=foliomesh-uploads

# CloudFront CDN
NEXT_PUBLIC_CDN_URL=https://[tu-cloudfront-domain].cloudfront.net
# O si configuraste dominio personalizado:
# NEXT_PUBLIC_CDN_URL=https://cdn.foliomesh.com
```

## 6. Configurar DNS (Opcional)

Si quieres dominio personalizado `cdn.foliomesh.com`:

1. **En CloudFront**:
   - Alternate domain names: `cdn.foliomesh.com`
   - SSL Certificate: Request certificate for `*.foliomesh.com`

2. **En tu DNS provider**:
   ```
   CNAME cdn.foliomesh.com → [cloudfront-domain].cloudfront.net
   ```

## 7. Estructura de Carpetas en S3

```
foliomesh-uploads/
├── users/
│   └── [user-id]/
│       ├── avatar/
│       ├── banner/
│       └── portfolio/
│           ├── images/
│           └── documents/
├── companies/
│   └── [company-id]/
│       ├── logo/
│       ├── banner/
│       └── posts/
└── temp/
    └── [session-id]/
```

## 8. Verificar Configuración

✅ **Checklist de Seguridad**:
- [ ] Bucket es privado (Block Public Access activo)
- [ ] CloudFront creado con OAC
- [ ] Bucket policy permite solo CloudFront
- [ ] Usuario IAM con permisos mínimos
- [ ] CORS configurado
- [ ] CDN funcionando
- [ ] SSL/TLS activo

## 🚀 ¡Tu configuración AWS S3 es ahora PROFESIONAL y SEGURA!

**Beneficios de esta configuración**:
- 🔒 **Máxima seguridad**: Bucket nunca expuesto públicamente
- ⚡ **Performance**: CDN global con CloudFront
- 💰 **Costo-efectivo**: Bandwidth optimizado
- 🛡️ **SSL automático**: HTTPS en todos los archivos
- 📈 **Escalable**: Soporta millones de usuarios