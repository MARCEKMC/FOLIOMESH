-- =====================================================
-- FOLIOMESH SAMPLE DATA
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
),
-- Company owner
(
    '550e8400-e29b-41d4-a716-446655440005',
    'luis.admin@techcorp.com',
    'Luis',
    'Fernández',
    'luisfernandez',
    'Buenos Aires, Argentina',
    '1985-09-10',
    'CEO',
    true,
    'premium',
    'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400',
    'dark',
    'es'
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
),
(
    '6ba7b811-9dad-11d1-80b4-00c04fd430c8',
    'Diseño Creativo',
    'diseno-creativo',
    'Diseño',
    'small',
    'Barcelona, España',
    'https://disenocreativo.example.com',
    'Estudio de diseño especializado en branding y experiencia de usuario.',
    'small',
    NOW() + INTERVAL '15 days',
    true,
    'https://images.unsplash.com/photo-1553028826-f4804151e0b0?w=400'
);

-- Insert company admins
INSERT INTO company_admins (
    company_id, user_id, role, can_manage_admins
) VALUES 
('6ba7b810-9dad-11d1-80b4-00c04fd430c8', '550e8400-e29b-41d4-a716-446655440005', 'owner', true),
('6ba7b811-9dad-11d1-80b4-00c04fd430c8', '550e8400-e29b-41d4-a716-446655440002', 'owner', true);

-- Insert sample portfolios
INSERT INTO portfolios (
    id, user_id, is_active, status, title, gradient_color, font_style,
    available_languages, total_views
) VALUES 
-- Kevin's portfolio (free user)
(
    'p1111111-1111-1111-1111-111111111111',
    '11111111-1111-1111-1111-111111111111',
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
    'p2222222-2222-2222-2222-222222222222',
    '22222222-2222-2222-2222-222222222222',
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
    'p3333333-3333-3333-3333-333333333333',
    '33333333-3333-3333-3333-333333333333',
    true,
    'published',
    'Carlos Rodríguez - Full Stack',
    '#10B981',
    'pixelated',
    ARRAY['es', 'en', 'fr'],
    324
),
(
    'p3333334-3333-3333-3333-333333333333',
    '33333333-3333-3333-3333-333333333333',
    false,
    'draft',
    'Proyectos Personales',
    '#8B5CF6',
    'formal',
    ARRAY['es'],
    0
);

-- Insert portfolio sections (Sobre mí)
INSERT INTO portfolio_sections (
    portfolio_id, section_type, design_variant, position_order, content, translations
) VALUES 
-- Kevin's "About" section
(
    'p1111111-1111-1111-1111-111111111111',
    'about',
    'text_description',
    1,
    '{
        "name": "Kevin Mendoza",
        "occupation": "Desarrollador Frontend",
        "description": "Apasionado desarrollador con 3 años de experiencia en React y TypeScript. Me encanta crear interfaces de usuario intuitivas y accesibles.",
        "contact_buttons": [
            {"type": "email", "value": "kevin.mendoza@example.com"},
            {"type": "linkedin", "value": "https://linkedin.com/in/kevinmendoza"},
            {"type": "github", "value": "https://github.com/kevinmendoza"}
        ],
        "image_url": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400"
    }',
    '{
        "en": {
            "description": "Passionate frontend developer with 3 years of experience in React and TypeScript. I love creating intuitive and accessible user interfaces."
        }
    }'
),
-- Carlos's "About" section with 3D avatar
(
    'p3333333-3333-3333-3333-333333333333',
    'about',
    'interactive_3d',
    1,
    '{
        "name": "Carlos Rodríguez",
        "occupation": "Full Stack Developer",
        "description": "Desarrollador full stack con más de 5 años de experiencia. Especializado en arquitecturas escalables y tecnologías modernas.",
        "contact_buttons": [
            {"type": "email", "value": "carlos.rodriguez@example.com"},
            {"type": "website", "value": "https://carlosdev.com"},
            {"type": "twitter", "value": "https://twitter.com/carlosdev"}
        ],
        "avatar_config": {
            "gender": "male",
            "skin_tone": "medium",
            "hair_color": "brown",
            "eye_color": "brown",
            "suit_color": "navy",
            "tie_color": "red"
        }
    }',
    '{
        "en": {
            "description": "Full stack developer with over 5 years of experience. Specialized in scalable architectures and modern technologies."
        },
        "fr": {
            "description": "Développeur full stack avec plus de 5 ans d''expérience. Spécialisé dans les architectures évolutives et les technologies modernes."
        }
    }'
);

-- Insert experience sections
INSERT INTO portfolio_sections (
    portfolio_id, section_type, design_variant, position_order, content
) VALUES 
(
    'p1111111-1111-1111-1111-111111111111',
    'experience',
    'timeline_vertical',
    2,
    '{
        "experiences": [
            {
                "company": "StartupTech",
                "position": "Desarrollador Frontend Jr.",
                "period": "Enero 2023 - Presente",
                "description": "Desarrollo de aplicaciones web con React, TypeScript y Tailwind CSS. Colaboración en equipo ágil.",
                "company_url": "https://startuptech.example.com",
                "logo_url": "https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=100"
            },
            {
                "company": "FreelanceProjects",
                "position": "Desarrollador Freelance",
                "period": "Marzo 2022 - Diciembre 2022",
                "description": "Desarrollo de sitios web para pequeñas empresas usando WordPress y JavaScript vanilla.",
                "company_url": null,
                "logo_url": "https://images.unsplash.com/photo-1553028826-f4804151e0b0?w=100"
            }
        ]
    }'
);

-- Insert projects section
INSERT INTO portfolio_sections (
    portfolio_id, section_type, design_variant, position_order, content
) VALUES 
(
    'p3333333-3333-3333-3333-333333333333',
    'projects',
    'project_cards',
    3,
    '{
        "projects": [
            {
                "title": "E-commerce Platform",
                "description": "Plataforma completa de comercio electrónico con React, Node.js y PostgreSQL. Incluye pasarela de pagos y panel administrativo.",
                "technologies": ["React", "Node.js", "PostgreSQL", "Stripe", "Docker"],
                "image_url": "https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=600",
                "demo_url": "https://ecommerce-demo.carlosdev.com",
                "github_url": "https://github.com/carlosrodriguez/ecommerce-platform"
            },
            {
                "title": "Task Management App",
                "description": "Aplicación de gestión de tareas con funcionalidades de colaboración en tiempo real usando Socket.io.",
                "technologies": ["Vue.js", "Express", "MongoDB", "Socket.io", "JWT"],
                "image_url": "https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=600",
                "demo_url": "https://taskapp-demo.carlosdev.com",
                "github_url": "https://github.com/carlosrodriguez/task-management"
            }
        ]
    }'
);

-- Insert skills section
INSERT INTO portfolio_sections (
    portfolio_id, section_type, design_variant, position_order, content
) VALUES 
(
    'p2222222-2222-2222-2222-222222222222',
    'skills',
    'hexagon_skills',
    2,
    '{
        "soft_skills": [
            {"name": "Comunicación", "level": "avanzado", "icon": "💬", "description": "Excelente comunicación con equipos multidisciplinarios"},
            {"name": "Creatividad", "level": "experto", "icon": "🎨", "description": "Capacidad para generar soluciones innovadoras"}
        ],
        "technical_skills": [
            {"name": "Figma", "level": "experto", "icon": "🎨", "description": "Diseño de interfaces y prototipos interactivos"},
            {"name": "Adobe Creative Suite", "level": "avanzado", "icon": "📐", "description": "Photoshop, Illustrator, After Effects"}
        ],
        "tools": [
            {"name": "Sketch", "level": "avanzado", "icon": "✏️", "description": "Herramienta de diseño digital"},
            {"name": "InVision", "level": "intermedio", "icon": "🔗", "description": "Prototipado y colaboración"}
        ],
        "methodologies": [
            {"name": "Design Thinking", "level": "avanzado", "icon": "💭", "description": "Metodología centrada en el usuario"},
            {"name": "Agile/Scrum", "level": "intermedio", "icon": "🔄", "description": "Desarrollo ágil y colaborativo"}
        ]
    }'
);

-- Insert sample posts
INSERT INTO posts (
    id, author_type, author_user_id, content_type, text_content, 
    shared_portfolio_id, likes_count, comments_count, views_count
) VALUES 
-- User sharing portfolio
(
    's1111111-1111-1111-1111-111111111111',
    'user',
    '11111111-1111-1111-1111-111111111111',
    'portfolio_share',
    '¡Acabo de actualizar mi portafolio! Incluye mis últimos proyectos en React y TypeScript. ¿Qué les parece? 🚀',
    'p1111111-1111-1111-1111-111111111111',
    12,
    3,
    156
),
-- Company post
(
    's2222222-2222-2222-2222-222222222222',
    'company',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'company_post',
    'Estamos creciendo nuestro equipo de desarrollo. Buscamos desarrolladores apasionados que quieran trabajar con las últimas tecnologías. ¡Únete a TechCorp! 💪',
    null,
    28,
    7,
    445
);

-- Insert sample jobs
INSERT INTO jobs (
    id, company_id, title, description, requirements, responsibilities,
    work_type, location, contract_type, application_deadline,
    required_languages, experience_level, applicants_count
) VALUES 
(
    'j1111111-1111-1111-1111-111111111111',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'Desarrollador Frontend Senior',
    'Únete a nuestro equipo como Desarrollador Frontend Senior. Trabajarás en proyectos innovadores usando React, TypeScript y las últimas tecnologías web.',
    'Mínimo 3 años de experiencia en React, TypeScript, HTML5, CSS3. Conocimiento en Git, testing automatizado. Inglés intermedio.',
    'Desarrollar interfaces de usuario responsive, colaborar con el equipo de diseño, optimizar performance, mentorear desarrolladores junior.',
    'hybrid',
    'Buenos Aires, Argentina',
    'full_time',
    NOW() + INTERVAL '30 days',
    ARRAY['es', 'en'],
    'senior',
    8
),
(
    'j2222222-2222-2222-2222-222222222222',
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
    'Diseñador UX/UI',
    'Buscamos un diseñador creativo para unirse a nuestro estudio. Trabajarás en proyectos variados desde branding hasta aplicaciones web.',
    'Portfolio sólido, experiencia con Figma, Adobe Creative Suite. Conocimiento en design systems y metodologías ágiles.',
    'Crear wireframes y prototipos, investigación de usuarios, diseño de interfaces, colaboración con desarrolladores.',
    'onsite',
    'Barcelona, España',
    'full_time',
    NOW() + INTERVAL '21 days',
    ARRAY['es', 'en'],
    'mid',
    12
);

-- Insert sample job applications
INSERT INTO job_applications (
    job_id, user_id, status, portfolio_snapshot, user_qualifications
) VALUES 
(
    'j1111111-1111-1111-1111-111111111111',
    '33333333-3333-3333-3333-333333333333',
    'preselected',
    '{"portfolio_title": "Carlos Rodríguez - Full Stack", "skills": ["React", "TypeScript", "Node.js"], "experience_years": 5}',
    '{"languages": ["es", "en", "fr"], "skills": ["React", "TypeScript", "PostgreSQL"], "experience_level": "senior"}'
),
(
    'j2222222-2222-2222-2222-222222222222',
    '22222222-2222-2222-2222-222222222222',
    'received',
    '{"portfolio_title": "Portfolio de María García", "skills": ["Figma", "Adobe Creative Suite"], "experience_years": 3}',
    '{"languages": ["es"], "skills": ["UX/UI", "Figma", "Design Thinking"], "experience_level": "mid"}'
);

-- Insert sample connections
INSERT INTO connections (
    requester_id, requested_id, status, request_message, responded_at
) VALUES 
(
    '11111111-1111-1111-1111-111111111111',
    '33333333-3333-3333-3333-333333333333',
    'accepted',
    'Hola Carlos! Vi tu portafolio y me parece increíble tu experiencia. Me encantaría conectar contigo.',
    NOW() - INTERVAL '2 days'
),
(
    '22222222-2222-2222-2222-222222222222',
    '44444444-4444-4444-4444-444444444444',
    'pending',
    'Hola Ana! Somos ambas del área de diseño, me gustaría conocer más sobre tu experiencia.',
    null
);

-- Insert sample company follows
INSERT INTO company_follows (
    user_id, company_id, notifications_enabled
) VALUES 
('11111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', true),
('33333333-3333-3333-3333-333333333333', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', true),
('22222222-2222-2222-2222-222222222222', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', true);

-- Insert sample messages
INSERT INTO messages (
    sender_type, sender_user_id, receiver_user_id, content, conversation_id, is_read
) VALUES 
(
    'user',
    '33333333-3333-3333-3333-333333333333',
    '11111111-1111-1111-1111-111111111111',
    'Hola Kevin! Gracias por conectar. Vi que trabajas con React, yo también. ¿Te interesaría colaborar en algún proyecto?',
    '11111111-3333-3333-3333-111111111111',
    true
),
(
    'user',
    '11111111-1111-1111-1111-111111111111',
    '33333333-3333-3333-3333-333333333333',
    '¡Hola Carlos! Claro, me encantaría. Estoy trabajando en un proyecto personal de e-commerce. ¿Tienes experiencia con pasarelas de pago?',
    '11111111-3333-3333-3333-111111111111',
    false
);

-- Insert sample notifications
INSERT INTO notifications (
    user_id, type, title, content, related_entity_type, related_entity_id
) VALUES 
(
    '11111111-1111-1111-1111-111111111111',
    'connection_request',
    'Nueva solicitud de conexión',
    'Carlos Rodríguez quiere conectar contigo',
    'user',
    '33333333-3333-3333-3333-333333333333'
),
(
    '33333333-3333-3333-3333-333333333333',
    'job_application',
    'Aplicación actualizada',
    'Tu aplicación para Desarrollador Frontend Senior ha sido preseleccionada',
    'job',
    'j1111111-1111-1111-1111-111111111111'
),
(
    '22222222-2222-2222-2222-222222222222',
    'company_update',
    'Nueva oferta de trabajo',
    'Diseño Creativo ha publicado: Diseñador UX/UI',
    'job',
    'j2222222-2222-2222-2222-222222222222'
);

-- Insert sample post likes
INSERT INTO post_likes (post_id, user_id) VALUES 
('s1111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222'),
('s1111111-1111-1111-1111-111111111111', '33333333-3333-3333-3333-333333333333'),
('s2222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111'),
('s2222222-2222-2222-2222-222222222222', '44444444-4444-4444-4444-444444444444');

-- Insert sample comments
INSERT INTO post_comments (
    id, post_id, user_id, content
) VALUES 
(
    'c1111111-1111-1111-1111-111111111111',
    's1111111-1111-1111-1111-111111111111',
    '22222222-2222-2222-2222-222222222222',
    '¡Se ve genial Kevin! Me gusta mucho el diseño limpio que usaste.'
),
(
    'c2222222-2222-2222-2222-222222222222',
    's1111111-1111-1111-1111-111111111111',
    '33333333-3333-3333-3333-333333333333',
    'Buen trabajo con TypeScript. ¿Has considerado añadir tests automatizados?'
);

-- Insert sample analytics events
INSERT INTO analytics_events (
    entity_type, entity_id, event_type, user_id, ip_address, country, device_type
) VALUES 
('portfolio', 'p1111111-1111-1111-1111-111111111111', 'view', '22222222-2222-2222-2222-222222222222', '192.168.1.1', 'ES', 'desktop'),
('portfolio', 'p1111111-1111-1111-1111-111111111111', 'view', null, '10.0.0.1', 'PE', 'mobile'),
('portfolio', 'p3333333-3333-3333-3333-333333333333', 'download', '44444444-4444-4444-4444-444444444444', '172.16.0.1', 'BR', 'desktop'),
('job', 'j1111111-1111-1111-1111-111111111111', 'view', '11111111-1111-1111-1111-111111111111', '192.168.1.2', 'PE', 'mobile'),
('company', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'view', '22222222-2222-2222-2222-222222222222', '10.0.0.2', 'ES', 'desktop');

-- Update view counts based on analytics
UPDATE portfolios SET total_views = (
    SELECT COUNT(*) FROM analytics_events 
    WHERE entity_type = 'portfolio' AND entity_id = portfolios.id AND event_type = 'view'
);

UPDATE jobs SET views_count = (
    SELECT COUNT(*) FROM analytics_events 
    WHERE entity_type = 'job' AND entity_id = jobs.id AND event_type = 'view'
);

UPDATE companies SET total_views = (
    SELECT COUNT(*) FROM analytics_events 
    WHERE entity_type = 'company' AND entity_id = companies.id AND event_type = 'view'
);