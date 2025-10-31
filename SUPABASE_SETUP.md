# Instrucciones para configurar Supabase

## 1. Crear Proyecto Supabase

1. Ve a https://supabase.com
2. Haz clic en "New Project"
3. Nombre: "FolioMesh"
4. Password: [elige una contraseña segura]
5. Región: US East (Virginia) para mejor rendimiento

## 2. Obtener Credenciales

### API Settings
Ve a Settings > API y copia:
- Project URL: `https://[tu-proyecto-id].supabase.co`
- API Key (anon public): `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`
- API Key (service_role): `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`

## 3. Configurar Base de Datos

### Ejecutar Schema Principal
1. Ve a SQL Editor en Supabase
2. Crea una nueva query
3. Copia y pega el contenido de `database/schema.sql`
4. Ejecuta la query

### Configurar Row Level Security
1. Crea otra nueva query
2. Copia y pega el contenido de `database/rls_policies.sql`
3. Ejecuta la query

### Datos de Ejemplo (Opcional)
1. Crea otra nueva query
2. Copia y pega el contenido de `database/sample_data.sql`
3. Ejecuta la query

## 4. Configurar Autenticación

### Auth Settings
Ve a Authentication > Settings:

- **Site URL**: `https://foliomesh.com`
- **Redirect URLs**: 
  ```
  https://foliomesh.com/auth/callback
  https://*.foliomesh.com/auth/callback
  ```

### Email Templates
Personaliza los templates en Authentication > Templates:
- **Confirm signup**: Personaliza con tu marca
- **Reset password**: Personaliza con tu marca
- **Magic link**: Personaliza con tu marca

### Providers (Opcional)
Configura Google OAuth en Authentication > Providers:
- **Google**: Activar
- **Client ID**: [De Google Console]
- **Client Secret**: [De Google Console]

## 5. Configurar Storage

### Crear Buckets
Ve a Storage y crea estos buckets:
- `avatars` (público)
- `banners` (público)
- `portfolio-files` (público)
- `company-logos` (público)

### Políticas de Storage
```sql
-- Política para avatars (usuarios pueden subir sus propios avatars)
CREATE POLICY "Users can upload their own avatar" ON storage.objects
FOR INSERT WITH CHECK (bucket_id = 'avatars' AND auth.uid()::text = (storage.foldername(name))[1]);

-- Política para ver avatars públicos
CREATE POLICY "Avatar images are publicly accessible" ON storage.objects
FOR SELECT USING (bucket_id = 'avatars');
```

## 6. Variables de Entorno para Vercel

```env
NEXT_PUBLIC_SUPABASE_URL=https://[tu-proyecto-id].supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=[tu-anon-key]
SUPABASE_SERVICE_ROLE_KEY=[tu-service-role-key]
```

## 7. Verificar Configuración

Una vez configurado todo, deberías poder:
- ✅ Ver las tablas en Database > Tables
- ✅ Autenticación funcionando
- ✅ Storage configurado
- ✅ RLS políticas activas

¡Tu Supabase está listo para FolioMesh! 🎉