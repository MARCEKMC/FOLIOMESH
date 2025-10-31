# Configuración AWS S3 para FolioMesh

## 1. Crear Bucket S3

1. Ve a AWS Console > S3
2. Crea un nuevo bucket:
   - **Nombre**: `foliomesh-uploads`
   - **Región**: US East (N. Virginia) us-east-1
   - **Block Public Access**: Desactivar (necesitamos acceso público para imágenes)

## 2. Configurar CORS

En tu bucket, ve a Permissions > CORS y añade:

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
            "ETag"
        ],
        "MaxAgeSeconds": 3000
    }
]
```

## 3. Crear Usuario IAM

### Crear Usuario
1. Ve a IAM > Users
2. Crea usuario: `foliomesh-app`
3. Tipo de acceso: **Programmatic access**

### Crear Política Personalizada
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:GetObjectAcl",
                "s3:PutObjectAcl"
            ],
            "Resource": [
                "arn:aws:s3:::foliomesh-uploads/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::foliomesh-uploads"
            ]
        }
    ]
}
```

### Asignar Política
1. Crea la política con el nombre: `FolioMeshS3Policy`
2. Asigna la política al usuario `foliomesh-app`

## 4. Obtener Credenciales

Después de crear el usuario, AWS te dará:
- **Access Key ID**: `AKIA...`
- **Secret Access Key**: `...`

⚠️ **IMPORTANTE**: Guarda estas credenciales de forma segura, no las compartirás públicamente.

## 5. Configurar CloudFront (Opcional pero Recomendado)

### Crear Distribución
1. Ve a CloudFront
2. Crea nueva distribución
3. Origen: Tu bucket S3
4. Configurar para:
   - **Allowed HTTP Methods**: GET, HEAD, OPTIONS, PUT, POST, PATCH, DELETE
   - **Compress Objects Automatically**: Yes
   - **Price Class**: Use All Edge Locations

### Configurar Dominio Personalizado
- **Alternate Domain Names**: `cdn.foliomesh.com`
- **SSL Certificate**: Request new certificate for `cdn.foliomesh.com`

## 6. Variables de Entorno para Vercel

```env
AWS_ACCESS_KEY_ID=[tu-access-key-id]
AWS_SECRET_ACCESS_KEY=[tu-secret-access-key]
AWS_REGION=us-east-1
AWS_S3_BUCKET_NAME=foliomesh-uploads
NEXT_PUBLIC_CDN_URL=https://cdn.foliomesh.com (si usas CloudFront)
```

## 7. Configurar DNS (Si usas CloudFront)

En tu proveedor de DNS:
```
CNAME cdn.foliomesh.com → [cloudfront-domain].cloudfront.net
```

## 8. Estructura de Carpetas en S3

El bucket se organizará así:
```
foliomesh-uploads/
├── avatars/
│   └── [user-id]/
├── banners/
│   └── [user-id]/
├── portfolios/
│   └── [user-id]/
│       ├── projects/
│       └── documents/
├── companies/
│   └── [company-id]/
│       ├── logos/
│       └── banners/
└── temp/
    └── [temp-uploads]/
```

## 9. Verificar Configuración

Prueba que funcione:
- ✅ Upload de archivos
- ✅ Acceso público a archivos
- ✅ CORS configurado correctamente
- ✅ CloudFront funcionando (si se configuró)

¡Tu S3 está listo para FolioMesh! 📁