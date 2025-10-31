# Configuración LemonSqueezy para FolioMesh

## 1. Crear Cuenta LemonSqueezy

1. Ve a https://lemonsqueezy.com
2. Crea una cuenta
3. Verifica tu email
4. Completa la configuración de tu tienda

## 2. Configurar Tienda

### Información Básica
- **Nombre de la tienda**: FolioMesh
- **URL de la tienda**: foliomesh
- **Moneda**: USD
- **País**: Estados Unidos (o tu país)

### Configuración de Pagos
1. Conecta tu cuenta bancaria o Stripe
2. Configura los métodos de pago:
   - ✅ Tarjetas de crédito/débito
   - ✅ PayPal
   - ✅ Apple Pay
   - ✅ Google Pay

## 3. Crear Productos

### Plan Premium Individual
- **Nombre**: Premium Individual
- **Precio**: $9.00 USD
- **Tipo**: Suscripción
- **Intervalo**: Mensual
- **Descripción**: 
  ```
  Plan Premium para usuarios individuales
  
  ✅ Portafolios ilimitados
  ✅ Templates premium
  ✅ Analytics avanzados
  ✅ Soporte prioritario
  ✅ Modelos 3D
  ✅ Múltiples idiomas
  ✅ Dominio personalizado
  ```

### Plan Premium Anual
- **Nombre**: Premium Annual
- **Precio**: $90.00 USD (25% descuento)
- **Tipo**: Suscripción
- **Intervalo**: Anual

### Plan Empresarial Pequeño
- **Nombre**: Business Small
- **Precio**: $29.00 USD
- **Tipo**: Suscripción
- **Intervalo**: Mensual
- **Descripción**:
  ```
  Plan para empresas pequeñas (hasta 10 empleados)
  
  ✅ Hasta 5 administradores
  ✅ Hasta 10 empleos activos
  ✅ Analytics empresariales
  ✅ Gestión de candidatos
  ✅ Perfil de empresa verificado
  ✅ Soporte prioritario
  ```

### Plan Empresarial Grande
- **Nombre**: Business Large
- **Precio**: $99.00 USD
- **Tipo**: Suscripción
- **Intervalo**: Mensual
- **Descripción**:
  ```
  Plan para empresas grandes (más de 10 empleados)
  
  ✅ Administradores ilimitados
  ✅ Empleos ilimitados
  ✅ Analytics avanzados
  ✅ Exportación de datos
  ✅ API access
  ✅ Soporte dedicado
  ✅ Verificación empresarial
  ```

## 4. Configurar Webhooks

### Crear Webhook
1. Ve a Settings > Webhooks
2. Crea nuevo webhook:
   - **URL**: `https://foliomesh.com/api/webhooks/lemonsqueezy`
   - **Events**:
     - ✅ subscription_created
     - ✅ subscription_updated
     - ✅ subscription_cancelled
     - ✅ subscription_resumed
     - ✅ subscription_expired
     - ✅ subscription_payment_success
     - ✅ subscription_payment_failed
     - ✅ order_created
     - ✅ order_refunded

### Configurar Firma
- **Secret**: Genera un secret seguro (guárdalo para las variables de entorno)

## 5. Obtener API Keys

### API Settings
1. Ve a Settings > API
2. Crea nueva API key:
   - **Nombre**: FolioMesh Production
   - **Permisos**: Read/Write

### Credenciales Necesarias
- **API Key**: `lmsq_api_...`
- **Store ID**: Número de tu tienda
- **Webhook Secret**: El secret que configuraste

## 6. Variables de Entorno para Vercel

```env
LEMONSQUEEZY_API_KEY=[tu-api-key]
LEMONSQUEEZY_STORE_ID=[tu-store-id]
LEMONSQUEEZY_WEBHOOK_SECRET=[tu-webhook-secret]

# IDs de productos (los obtienes después de crear los productos)
LEMONSQUEEZY_PREMIUM_MONTHLY_ID=[product-id]
LEMONSQUEEZY_PREMIUM_ANNUAL_ID=[product-id]
LEMONSQUEEZY_BUSINESS_SMALL_ID=[product-id]
LEMONSQUEEZY_BUSINESS_LARGE_ID=[product-id]
```

## 7. Configurar Customer Portal

### Personalización
1. Ve a Settings > Customer Portal
2. Personaliza:
   - **Logo**: Logo de FolioMesh
   - **Colors**: Azul #2563eb (primary), etc.
   - **Return URL**: `https://foliomesh.com/dashboard/billing`

### Configurar Cancelaciones
- **Cancelation URL**: `https://foliomesh.com/dashboard/billing/cancelled`
- **Pause Options**: Permitir pausar suscripciones
- **Downgrade Options**: Permitir cambiar planes

## 8. Configurar Emails

### Email Templates
Personaliza los templates en Settings > Emails:
- **Receipt**: Recibo de compra
- **Refund**: Confirmación de reembolso
- **Subscription**: Confirmaciones de suscripción

### SMTP (Opcional)
Puedes usar tu propio SMTP para emails personalizados

## 9. Configurar Impuestos

### Tax Settings
1. Ve a Settings > Tax
2. Configura:
   - **Tax ID**: Tu número de identificación fiscal
   - **Tax inclusive pricing**: Según tu región
   - **EU VAT**: Si vendes en Europa

## 10. Testing

### Modo Test
1. Usa las API keys de test para desarrollo
2. Realiza compras de prueba
3. Verifica que los webhooks funcionen

### URLs de Test
- **Webhook Test**: `https://foliomesh-staging.vercel.app/api/webhooks/lemonsqueezy`

## 11. Verificar Configuración

Antes de lanzar:
- ✅ Productos creados correctamente
- ✅ Webhooks configurados y funcionando
- ✅ API keys configuradas
- ✅ Customer portal personalizado
- ✅ Emails personalizados
- ✅ Impuestos configurados
- ✅ Testing completado

¡Tu LemonSqueezy está listo para FolioMesh! 🍋