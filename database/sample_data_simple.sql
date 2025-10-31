-- =====================================================
-- FOLIOMESH SAMPLE DATA - SIMPLIFIED VERSION
-- Test data for development and testing
-- =====================================================

-- Insert sample users
INSERT INTO users (
    id, email, first_name, last_name, subdomain, location, 
    birth_date, current_occupation, is_verified, plan_type,
    profile_image_url, theme, preferred_language
) VALUES 
-- Free users
(
    '550e8400-e29b-41d4-a716-446655440001',
    'kevin.mendoza@example.com',
    'Kevin',
    'Mendoza',
    'kevinmendoza',
    'Lima, Perú',
    '1995-03-15',
    'Desarrollador Frontend',
    false,
    'free',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
    'light',
    'es'
),
(
    '550e8400-e29b-41d4-a716-446655440002',
    'maria.garcia@example.com',
    'María José',
    'García',
    'mariagarcia',
    'Madrid, España',
    '1992-07-22',
    'Diseñadora UX/UI',
    false,
    'free',
    'https://images.unsplash.com/photo-1494790108755-2616b1e5c01?w=400',
    'dark',
    'es'
),
-- Premium users
(
    '550e8400-e29b-41d4-a716-446655440003',
    'carlos.rodriguez@example.com',
    'Carlos',
    'Rodríguez',
    'carlosrodriguez',
    'Ciudad de México, México',
    '1988-11-30',
    'Full Stack Developer',
    true,
    'premium',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400',
    'auto',
    'es'
),
(
    '550e8400-e29b-41d4-a716-446655440004',
    'ana.silva@example.com',
    'Ana',
    'Silva',
    'anasilva',
    'São Paulo, Brasil',
    '1990-05-18',
    'Product Manager',
    true,
    'premium',
    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400',
    'light',
    'pt'
);

-- Insert sample companies
INSERT INTO companies (
    id, name, slug, industry, company_size, location, website_url,
    description, plan_type, plan_expires_at, is_verified, logo_url
) VALUES 
(
    '6ba7b810-9dad-11d1-80b4-00c04fd430c8',
    'TechCorp Solutions',
    'techcorp-solutions',
    'Tecnología',
    'large',
    'Buenos Aires, Argentina',
    'https://techcorp.example.com',
    'Empresa líder en desarrollo de software y soluciones tecnológicas innovadoras.',
    'large',
    NOW() + INTERVAL '30 days',
    true,
    'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=400'
);

-- Insert sample portfolios
INSERT INTO portfolios (
    id, user_id, is_active, status, title, gradient_color, font_style,
    available_languages, total_views
) VALUES 
-- Kevin's portfolio (free user)
(
    '123e4567-e89b-12d3-a456-426614174001',
    '550e8400-e29b-41d4-a716-446655440001',
    true,
    'published',
    'Portafolio de Kevin Mendoza',
    '#3B82F6',
    'formal',
    ARRAY['es', 'en'],
    156
),
-- María's portfolio (free user)
(
    '123e4567-e89b-12d3-a456-426614174002',
    '550e8400-e29b-41d4-a716-446655440002',
    true,
    'published',
    'Portfolio de María García',
    '#EF4444',
    'technological',
    ARRAY['es'],
    89
),
-- Carlos's portfolios (premium user - multiple)
(
    '123e4567-e89b-12d3-a456-426614174003',
    '550e8400-e29b-41d4-a716-446655440003',
    true,
    'published',
    'Carlos Rodríguez - Full Stack',
    '#10B981',
    'pixelated',
    ARRAY['es', 'en', 'fr'],
    324
);

-- Insert portfolio sections (Sobre mí)
INSERT INTO portfolio_sections (
    portfolio_id, section_type, design_variant, position_order, content
) VALUES 
-- Kevin's "About" section
(
    '123e4567-e89b-12d3-a456-426614174001',
    'about',
    'text_description',
    1,
    '{
        "name": "Kevin Mendoza",
        "occupation": "Desarrollador Frontend",
        "description": "Apasionado desarrollador con 3 años de experiencia en React y TypeScript.",
        "contact_buttons": [
            {"type": "email", "value": "kevin.mendoza@example.com"},
            {"type": "linkedin", "value": "https://linkedin.com/in/kevinmendoza"}
        ]
    }'
),
-- Carlos's "About" section
(
    '123e4567-e89b-12d3-a456-426614174003',
    'about',
    'interactive_3d',
    1,
    '{
        "name": "Carlos Rodríguez",
        "occupation": "Full Stack Developer",
        "description": "Desarrollador full stack con más de 5 años de experiencia.",
        "contact_buttons": [
            {"type": "email", "value": "carlos.rodriguez@example.com"},
            {"type": "website", "value": "https://carlosdev.com"}
        ]
    }'
);

-- Insert sample jobs
INSERT INTO jobs (
    id, company_id, title, description, requirements, responsibilities,
    work_type, location, contract_type, application_deadline,
    required_languages, experience_level, applicants_count
) VALUES 
(
    'f47ac10b-58cc-4372-a567-0e02b2c3d479',
    '6ba7b810-9dad-11d1-80b4-00c04fd430c8',
    'Desarrollador Frontend Senior',
    'Únete a nuestro equipo como Desarrollador Frontend Senior.',
    'Mínimo 3 años de experiencia en React, TypeScript.',
    'Desarrollar interfaces de usuario responsive.',
    'hybrid',
    'Buenos Aires, Argentina',
    'full_time',
    NOW() + INTERVAL '30 days',
    ARRAY['es', 'en'],
    'senior',
    8
);

-- Insert sample posts
INSERT INTO posts (
    id, author_type, author_user_id, author_company_id, content_type, text_content, 
    shared_portfolio_id, job_id, likes_count, comments_count, views_count
) VALUES 
-- User sharing portfolio
(
    '9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d',
    'user',
    '550e8400-e29b-41d4-a716-446655440001',
    null,
    'portfolio_share',
    '¡Acabo de actualizar mi portafolio! 🚀',
    '123e4567-e89b-12d3-a456-426614174001',
    null,
    5,
    2,
    50
);