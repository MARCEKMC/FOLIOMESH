-- =====================================================
-- FOLIOMESH DATABASE SCHEMA
-- Supabase PostgreSQL Database Structure
-- =====================================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =====================================================
-- USERS TABLE
-- =====================================================
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Authentication (managed by Supabase Auth)
    email TEXT UNIQUE NOT NULL,
    
    -- Personal Information
    first_name TEXT NOT NULL,
    middle_name TEXT,
    last_name TEXT NOT NULL,
    second_last_name TEXT,
    subdomain TEXT UNIQUE NOT NULL,
    
    -- Location and Contact
    location TEXT NOT NULL,
    phone TEXT,
    birth_date DATE NOT NULL,
    current_occupation TEXT NOT NULL,
    
    -- Plan and Verification
    is_verified BOOLEAN DEFAULT FALSE,
    plan_type TEXT DEFAULT 'free' CHECK (plan_type IN ('free', 'premium')),
    plan_expires_at TIMESTAMP WITH TIME ZONE,
    verification_provider_id TEXT, -- Persona ID reference
    
    -- Security
    last_login TIMESTAMP WITH TIME ZONE,
    login_attempts INTEGER DEFAULT 0,
    is_2fa_enabled BOOLEAN DEFAULT FALSE,
    failed_login_count INTEGER DEFAULT 0,
    locked_until TIMESTAMP WITH TIME ZONE,
    
    -- Configuration
    preferred_language TEXT DEFAULT 'es',
    theme TEXT DEFAULT 'auto' CHECK (theme IN ('light', 'dark', 'auto')),
    email_notifications BOOLEAN DEFAULT TRUE,
    push_notifications BOOLEAN DEFAULT TRUE,
    
    -- Social URLs
    website_url TEXT,
    linkedin_url TEXT,
    github_url TEXT,
    twitter_url TEXT,
    instagram_url TEXT,
    facebook_url TEXT,
    
    -- Profile Images
    profile_image_url TEXT,
    banner_image_url TEXT,
    
    -- Metrics
    total_profile_views INTEGER DEFAULT 0,
    total_portfolio_views INTEGER DEFAULT 0,
    total_connections INTEGER DEFAULT 0,
    
    -- Storage Limits
    used_storage_bytes BIGINT DEFAULT 0,
    image_count INTEGER DEFAULT 0
);

-- =====================================================
-- COMPANIES TABLE
-- =====================================================
CREATE TABLE companies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Basic Information
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    industry TEXT NOT NULL,
    company_size TEXT NOT NULL CHECK (company_size IN ('small', 'large')),
    location TEXT NOT NULL,
    website_url TEXT,
    description TEXT,
    
    -- Plan and Verification
    plan_type TEXT NOT NULL CHECK (plan_type IN ('small', 'large')),
    plan_expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    verification_provider_id TEXT, -- Trulioo reference
    tax_id TEXT, -- RUC or Tax ID
    
    -- Configuration
    logo_url TEXT,
    banner_url TEXT,
    
    -- Plan Limits
    max_active_jobs INTEGER NOT NULL DEFAULT 5, -- 5 for small, 20 for large
    max_admins INTEGER NOT NULL DEFAULT 3, -- 3 for small, 15 for large
    
    -- Metrics
    total_views INTEGER DEFAULT 0,
    total_followers INTEGER DEFAULT 0,
    total_job_views INTEGER DEFAULT 0,
    total_applications_received INTEGER DEFAULT 0,
    
    -- Payment Status
    subscription_status TEXT DEFAULT 'active' CHECK (subscription_status IN ('active', 'paused', 'cancelled')),
    last_payment_date TIMESTAMP WITH TIME ZONE,
    payment_method_id TEXT
);

-- =====================================================
-- COMPANY ADMINS TABLE
-- =====================================================
CREATE TABLE company_admins (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Role and Permissions
    role TEXT NOT NULL CHECK (role IN ('owner', 'admin')),
    can_manage_jobs BOOLEAN DEFAULT TRUE,
    can_manage_posts BOOLEAN DEFAULT TRUE,
    can_view_analytics BOOLEAN DEFAULT TRUE,
    can_manage_admins BOOLEAN DEFAULT FALSE, -- only owners can manage admins
    can_edit_company_profile BOOLEAN DEFAULT TRUE,
    can_export_data BOOLEAN DEFAULT TRUE,
    
    -- Status
    is_active BOOLEAN DEFAULT TRUE,
    invited_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    accepted_at TIMESTAMP WITH TIME ZONE,
    
    UNIQUE(company_id, user_id)
);

-- =====================================================
-- PORTFOLIOS TABLE
-- =====================================================
CREATE TABLE portfolios (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Status
    is_active BOOLEAN DEFAULT FALSE, -- only one active per user
    status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'published')),
    title TEXT DEFAULT 'Mi Portafolio',
    
    -- Customization
    gradient_color TEXT DEFAULT '#3B82F6', -- hex color
    font_style TEXT DEFAULT 'formal' CHECK (font_style IN ('formal', 'pixelated', 'technological')),
    
    -- Metrics
    total_views INTEGER DEFAULT 0,
    total_downloads INTEGER DEFAULT 0,
    last_viewed_at TIMESTAMP WITH TIME ZONE,
    unique_visitors INTEGER DEFAULT 0,
    
    -- Translations
    available_languages TEXT[] DEFAULT ARRAY['es'], -- array of language codes
    last_translation_update TIMESTAMP WITH TIME ZONE,
    translation_count INTEGER DEFAULT 0,
    
    -- SEO
    meta_title TEXT,
    meta_description TEXT,
    
    -- PDF Generation
    last_pdf_generated_at TIMESTAMP WITH TIME ZONE,
    pdf_url TEXT
);

-- =====================================================
-- PORTFOLIO SECTIONS TABLE
-- =====================================================
CREATE TABLE portfolio_sections (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    portfolio_id UUID NOT NULL REFERENCES portfolios(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Configuration
    section_type TEXT NOT NULL CHECK (section_type IN (
        'about', 'experience', 'education', 'projects', 'skills', 'impact', 'objectives'
    )),
    design_variant TEXT NOT NULL, -- specific to each section type
    position_order INTEGER NOT NULL DEFAULT 1,
    is_visible BOOLEAN DEFAULT TRUE,
    
    -- Content (base language, usually Spanish)
    content JSONB NOT NULL DEFAULT '{}',
    
    -- Translations (structure: {language_code: {translated_content}})
    translations JSONB DEFAULT '{}',
    
    -- Section-specific metadata
    metadata JSONB DEFAULT '{}', -- for 3D settings, images, etc.
    
    UNIQUE(portfolio_id, section_type)
);

-- =====================================================
-- POSTS TABLE
-- =====================================================
CREATE TABLE posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Author (either user or company)
    author_type TEXT NOT NULL CHECK (author_type IN ('user', 'company')),
    author_user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    author_company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- Content
    content_type TEXT NOT NULL CHECK (content_type IN ('portfolio_share', 'company_post', 'job_posting')),
    text_content TEXT NOT NULL,
    image_urls TEXT[], -- only companies can upload images
    
    -- Related Content
    shared_portfolio_id UUID REFERENCES portfolios(id) ON DELETE SET NULL,
    job_id UUID REFERENCES jobs(id) ON DELETE SET NULL,
    
    -- Engagement
    likes_count INTEGER DEFAULT 0,
    comments_count INTEGER DEFAULT 0,
    views_count INTEGER DEFAULT 0,
    
    -- Publishing
    scheduled_at TIMESTAMP WITH TIME ZONE,
    is_published BOOLEAN DEFAULT TRUE,
    published_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Moderation
    is_reported BOOLEAN DEFAULT FALSE,
    report_count INTEGER DEFAULT 0,
    is_hidden BOOLEAN DEFAULT FALSE,
    moderated_at TIMESTAMP WITH TIME ZONE,
    
    -- Check constraints
    CONSTRAINT valid_author CHECK (
        (author_type = 'user' AND author_user_id IS NOT NULL AND author_company_id IS NULL) OR
        (author_type = 'company' AND author_company_id IS NOT NULL AND author_user_id IS NULL)
    )
);

-- =====================================================
-- JOBS TABLE
-- =====================================================
CREATE TABLE jobs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Basic Information
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    requirements TEXT NOT NULL,
    responsibilities TEXT NOT NULL,
    
    -- Work Details
    work_type TEXT NOT NULL CHECK (work_type IN ('remote', 'onsite', 'hybrid')),
    location TEXT, -- required for onsite/hybrid
    contract_type TEXT NOT NULL CHECK (contract_type IN ('full_time', 'part_time', 'freelance', 'internship')),
    
    -- Application Settings
    application_deadline TIMESTAMP WITH TIME ZONE NOT NULL,
    required_languages TEXT[] DEFAULT ARRAY['es'],
    experience_level TEXT NOT NULL CHECK (experience_level IN ('entry', 'mid', 'senior', 'lead')),
    
    -- Status and Metrics
    is_active BOOLEAN DEFAULT TRUE,
    applicants_count INTEGER DEFAULT 0,
    views_count INTEGER DEFAULT 0,
    qualified_applicants_count INTEGER DEFAULT 0,
    
    -- Salary Information (optional)
    salary_min INTEGER,
    salary_max INTEGER,
    salary_currency TEXT DEFAULT 'USD',
    
    -- Benefits and Perks
    benefits TEXT[],
    
    -- Application Process
    application_process TEXT,
    
    -- SEO
    slug TEXT UNIQUE,
    
    -- Auto-generated fields
    expires_at TIMESTAMP WITH TIME ZONE GENERATED ALWAYS AS (application_deadline) STORED
);

-- =====================================================
-- JOB APPLICATIONS TABLE
-- =====================================================
CREATE TABLE job_applications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    job_id UUID NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Application Status
    status TEXT DEFAULT 'received' CHECK (status IN ('received', 'reviewed', 'rejected', 'preselected', 'selected')),
    reviewed_at TIMESTAMP WITH TIME ZONE,
    reviewed_by UUID REFERENCES users(id), -- admin who reviewed
    
    -- Snapshot Data (at time of application)
    portfolio_snapshot JSONB NOT NULL, -- copy of active portfolio
    user_qualifications JSONB NOT NULL, -- skills, languages, experience at time of application
    
    -- Notes and Feedback
    internal_notes TEXT, -- for company use
    feedback_to_candidate TEXT, -- if rejected
    
    -- Qualification Score (auto-calculated)
    qualification_score INTEGER DEFAULT 0, -- 0-100 based on requirements match
    
    -- Additional Data
    cover_letter TEXT,
    expected_salary INTEGER,
    
    UNIQUE(job_id, user_id)
);

-- =====================================================
-- CONNECTIONS TABLE
-- =====================================================
CREATE TABLE connections (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    requester_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    requested_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Status
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'declined', 'blocked')),
    responded_at TIMESTAMP WITH TIME ZONE,
    
    -- Message
    request_message TEXT,
    
    -- Mutual Connections
    mutual_connections_count INTEGER DEFAULT 0,
    
    UNIQUE(requester_id, requested_id),
    CONSTRAINT different_users CHECK (requester_id != requested_id)
);

-- =====================================================
-- COMPANY FOLLOWS TABLE
-- =====================================================
CREATE TABLE company_follows (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Notification Settings
    notifications_enabled BOOLEAN DEFAULT TRUE,
    job_notifications BOOLEAN DEFAULT TRUE,
    post_notifications BOOLEAN DEFAULT FALSE,
    
    UNIQUE(user_id, company_id)
);

-- =====================================================
-- MESSAGES TABLE
-- =====================================================
CREATE TABLE messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Participants
    sender_type TEXT NOT NULL CHECK (sender_type IN ('user', 'company')),
    sender_user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    sender_company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    receiver_user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    
    -- Content
    content TEXT NOT NULL,
    image_urls TEXT[], -- only companies can send images
    
    -- Conversation
    conversation_id UUID NOT NULL, -- group messages by conversation
    
    -- Status
    is_read BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMP WITH TIME ZONE,
    
    -- Message Type
    message_type TEXT DEFAULT 'text' CHECK (message_type IN ('text', 'image', 'system')),
    
    -- Check constraints
    CONSTRAINT valid_sender CHECK (
        (sender_type = 'user' AND sender_user_id IS NOT NULL AND sender_company_id IS NULL) OR
        (sender_type = 'company' AND sender_company_id IS NOT NULL AND sender_user_id IS NULL)
    ),
    
    -- Index for performance
    CONSTRAINT valid_images CHECK (
        (sender_type = 'company' AND image_urls IS NOT NULL) OR
        (sender_type = 'user' AND image_urls IS NULL)
    )
);

-- =====================================================
-- NOTIFICATIONS TABLE
-- =====================================================
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Content
    type TEXT NOT NULL CHECK (type IN ('connection_request', 'job_match', 'message', 'company_update', 'system', 'portfolio_view', 'job_application')),
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    
    -- Related Entity
    related_entity_type TEXT CHECK (related_entity_type IN ('user', 'company', 'job', 'post', 'portfolio')),
    related_entity_id UUID,
    
    -- Action URL
    action_url TEXT,
    
    -- Status
    is_read BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMP WITH TIME ZONE,
    
    -- Priority
    priority TEXT DEFAULT 'normal' CHECK (priority IN ('low', 'normal', 'high', 'urgent')),
    
    -- Delivery
    sent_via_email BOOLEAN DEFAULT FALSE,
    sent_via_push BOOLEAN DEFAULT FALSE
);

-- =====================================================
-- REPORTS TABLE
-- =====================================================
CREATE TABLE reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Reporter
    reporter_user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    
    -- Reported Content
    reported_entity_type TEXT NOT NULL CHECK (reported_entity_type IN ('user', 'company', 'post', 'portfolio', 'job')),
    reported_entity_id UUID NOT NULL,
    
    -- Report Details
    report_reason TEXT NOT NULL CHECK (report_reason IN ('inappropriate', 'spam', 'fake_content', 'impersonation', 'harassment', 'other')),
    description TEXT,
    
    -- Status
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'reviewing', 'resolved', 'dismissed')),
    resolved_at TIMESTAMP WITH TIME ZONE,
    resolved_by_admin BOOLEAN DEFAULT FALSE,
    admin_notes TEXT,
    
    -- Auto-moderation
    auto_action_taken TEXT CHECK (auto_action_taken IN ('hidden', 'warning_sent', 'account_suspended')),
    auto_action_at TIMESTAMP WITH TIME ZONE
);

-- =====================================================
-- ANALYTICS EVENTS TABLE
-- =====================================================
CREATE TABLE analytics_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Entity being tracked
    entity_type TEXT NOT NULL CHECK (entity_type IN ('portfolio', 'company', 'post', 'job', 'user')),
    entity_id UUID NOT NULL,
    
    -- Event Details
    event_type TEXT NOT NULL CHECK (event_type IN ('view', 'like', 'comment', 'share', 'download', 'application', 'follow', 'message')),
    
    -- Context
    user_id UUID REFERENCES users(id) ON DELETE SET NULL, -- null for anonymous
    session_id TEXT,
    
    -- Technical Details
    ip_address INET,
    user_agent TEXT,
    referrer TEXT,
    country TEXT,
    device_type TEXT CHECK (device_type IN ('desktop', 'mobile', 'tablet')),
    
    -- Additional Data
    metadata JSONB DEFAULT '{}'
);

-- =====================================================
-- POST LIKES TABLE
-- =====================================================
CREATE TABLE post_likes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    UNIQUE(post_id, user_id)
);

-- =====================================================
-- POST COMMENTS TABLE
-- =====================================================
CREATE TABLE post_comments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Content
    content TEXT NOT NULL,
    
    -- Threading (for replies)
    parent_comment_id UUID REFERENCES post_comments(id) ON DELETE CASCADE,
    
    -- Engagement
    likes_count INTEGER DEFAULT 0,
    
    -- Moderation
    is_reported BOOLEAN DEFAULT FALSE,
    is_hidden BOOLEAN DEFAULT FALSE
);

-- =====================================================
-- COMMENT LIKES TABLE
-- =====================================================
CREATE TABLE comment_likes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    comment_id UUID NOT NULL REFERENCES post_comments(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    UNIQUE(comment_id, user_id)
);

-- =====================================================
-- PAYMENT HISTORY TABLE
-- =====================================================
CREATE TABLE payment_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Payer
    payer_type TEXT NOT NULL CHECK (payer_type IN ('user', 'company')),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    company_id UUID REFERENCES companies(id) ON DELETE SET NULL,
    
    -- Payment Details
    amount DECIMAL(10,2) NOT NULL,
    currency TEXT DEFAULT 'USD',
    plan_type TEXT NOT NULL,
    billing_period TEXT NOT NULL CHECK (billing_period IN ('monthly', 'annually')),
    
    -- External References
    lemonsqueezy_order_id TEXT UNIQUE,
    lemonsqueezy_subscription_id TEXT,
    
    -- Status
    status TEXT NOT NULL CHECK (status IN ('pending', 'completed', 'failed', 'refunded')),
    paid_at TIMESTAMP WITH TIME ZONE,
    refunded_at TIMESTAMP WITH TIME ZONE,
    
    -- Metadata
    receipt_url TEXT,
    invoice_url TEXT
);

-- =====================================================
-- CONTENT TRANSLATIONS TABLE
-- =====================================================
CREATE TABLE content_translations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Content Reference
    content_type TEXT NOT NULL CHECK (content_type IN ('portfolio_section', 'post', 'job')),
    content_id UUID NOT NULL,
    
    -- Translation Details
    source_language TEXT NOT NULL DEFAULT 'es',
    target_language TEXT NOT NULL,
    source_text TEXT NOT NULL,
    translated_text TEXT NOT NULL,
    
    -- Quality and Status
    translation_provider TEXT DEFAULT 'google',
    confidence_score DECIMAL(3,2), -- 0.00 to 1.00
    is_manual_review BOOLEAN DEFAULT FALSE,
    reviewed_by UUID REFERENCES users(id),
    
    -- Usage Tracking
    used_in_public BOOLEAN DEFAULT FALSE,
    
    UNIQUE(content_type, content_id, target_language)
);

-- =====================================================
-- FILE UPLOADS TABLE
-- =====================================================
CREATE TABLE file_uploads (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Owner
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    
    -- File Details
    filename TEXT NOT NULL,
    original_filename TEXT NOT NULL,
    file_type TEXT NOT NULL,
    file_size_bytes BIGINT NOT NULL,
    
    -- Storage
    storage_provider TEXT DEFAULT 'aws_s3',
    storage_path TEXT NOT NULL,
    public_url TEXT NOT NULL,
    
    -- Image Specific
    image_width INTEGER,
    image_height INTEGER,
    is_compressed BOOLEAN DEFAULT FALSE,
    original_size_bytes BIGINT,
    
    -- Usage
    used_in_type TEXT CHECK (used_in_type IN ('profile', 'banner', 'portfolio', 'post', 'company')),
    used_in_id UUID,
    
    -- Status
    is_active BOOLEAN DEFAULT TRUE,
    
    CONSTRAINT owner_constraint CHECK (
        (user_id IS NOT NULL AND company_id IS NULL) OR
        (user_id IS NULL AND company_id IS NOT NULL)
    )
);

-- =====================================================
-- SYSTEM SETTINGS TABLE
-- =====================================================
CREATE TABLE system_settings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    key TEXT UNIQUE NOT NULL,
    value JSONB NOT NULL,
    description TEXT,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_by UUID REFERENCES users(id)
);

-- Insert default system settings
INSERT INTO system_settings (key, value, description) VALUES
('max_free_images', '24', 'Maximum images for free users'),
('max_premium_images', '180', 'Maximum images for premium users'),
('max_free_projects', '5', 'Maximum projects for free users'),
('max_premium_projects', '20', 'Maximum projects for premium users per portfolio'),
('max_premium_portfolios', '3', 'Maximum portfolios for premium users'),
('report_threshold_notification', '5', 'Reports needed to send notification'),
('report_threshold_hide', '10', 'Reports needed to hide content'),
('report_threshold_suspend', '50', 'Reports needed to suspend account'),
('premium_price_annual', '9.90', 'Premium plan annual price in USD'),
('company_small_price_monthly', '19.99', 'Small company plan monthly price'),
('company_large_price_monthly', '69.99', 'Large company plan monthly price'),
('translation_free_limit_weekly', '1', 'Free translation updates per week'),
('translation_premium_limit_daily', '1', 'Premium translation updates per day'),
('max_image_size_free', '1048576', 'Max image size for free users in bytes (1MB)'),
('max_image_size_premium', '3145728', 'Max image size for premium users in bytes (3MB)'),
('max_image_size_company', '10485760', 'Max image size for companies in bytes (10MB)');

-- =====================================================
-- CREATE INDEXES FOR PERFORMANCE
-- =====================================================

-- Users
CREATE INDEX idx_users_subdomain ON users(subdomain);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_plan_type ON users(plan_type);
CREATE INDEX idx_users_location ON users(location);

-- Companies
CREATE INDEX idx_companies_slug ON companies(slug);
CREATE INDEX idx_companies_industry ON companies(industry);
CREATE INDEX idx_companies_location ON companies(location);
CREATE INDEX idx_companies_plan_expires ON companies(plan_expires_at);

-- Portfolios
CREATE INDEX idx_portfolios_user_active ON portfolios(user_id, is_active);
CREATE INDEX idx_portfolios_status ON portfolios(status);

-- Posts
CREATE INDEX idx_posts_author_user ON posts(author_user_id, created_at DESC);
CREATE INDEX idx_posts_author_company ON posts(author_company_id, created_at DESC);
CREATE INDEX idx_posts_published ON posts(is_published, created_at DESC);
CREATE INDEX idx_posts_content_type ON posts(content_type);

-- Jobs
CREATE INDEX idx_jobs_company ON jobs(company_id, is_active);
CREATE INDEX idx_jobs_location ON jobs(location);
CREATE INDEX idx_jobs_work_type ON jobs(work_type);
CREATE INDEX idx_jobs_deadline ON jobs(application_deadline);

-- Messages
CREATE INDEX idx_messages_conversation ON messages(conversation_id, created_at);
CREATE INDEX idx_messages_receiver ON messages(receiver_user_id, is_read);

-- Notifications
CREATE INDEX idx_notifications_user_unread ON notifications(user_id, is_read, created_at DESC);

-- Analytics
CREATE INDEX idx_analytics_entity ON analytics_events(entity_type, entity_id, created_at);
CREATE INDEX idx_analytics_created ON analytics_events(created_at);

-- File Uploads
CREATE INDEX idx_uploads_user ON file_uploads(user_id, created_at DESC);
CREATE INDEX idx_uploads_company ON file_uploads(company_id, created_at DESC);

-- =====================================================
-- FUNCTIONS AND TRIGGERS
-- =====================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply updated_at trigger to relevant tables
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_companies_updated_at BEFORE UPDATE ON companies FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_portfolios_updated_at BEFORE UPDATE ON portfolios FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_portfolio_sections_updated_at BEFORE UPDATE ON portfolio_sections FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_posts_updated_at BEFORE UPDATE ON posts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_jobs_updated_at BEFORE UPDATE ON jobs FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to ensure only one active portfolio per user
CREATE OR REPLACE FUNCTION ensure_single_active_portfolio()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.is_active = TRUE THEN
        -- Deactivate all other portfolios for this user
        UPDATE portfolios 
        SET is_active = FALSE 
        WHERE user_id = NEW.user_id AND id != NEW.id;
    END IF;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER trigger_single_active_portfolio 
    BEFORE INSERT OR UPDATE ON portfolios 
    FOR EACH ROW EXECUTE FUNCTION ensure_single_active_portfolio();

-- Function to update likes count on posts
CREATE OR REPLACE FUNCTION update_post_likes_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE posts SET likes_count = likes_count + 1 WHERE id = NEW.post_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE posts SET likes_count = likes_count - 1 WHERE id = OLD.post_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ language 'plpgsql';

CREATE TRIGGER trigger_post_likes_count 
    AFTER INSERT OR DELETE ON post_likes 
    FOR EACH ROW EXECUTE FUNCTION update_post_likes_count();

-- Function to update comments count on posts
CREATE OR REPLACE FUNCTION update_post_comments_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE posts SET comments_count = comments_count + 1 WHERE id = NEW.post_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE posts SET comments_count = comments_count - 1 WHERE id = OLD.post_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ language 'plpgsql';

CREATE TRIGGER trigger_post_comments_count 
    AFTER INSERT OR DELETE ON post_comments 
    FOR EACH ROW EXECUTE FUNCTION update_post_comments_count();

-- Function to generate unique subdomain
CREATE OR REPLACE FUNCTION generate_unique_subdomain(first_name TEXT, last_name TEXT, second_last_name TEXT DEFAULT NULL, middle_name TEXT DEFAULT NULL)
RETURNS TEXT AS $$
DECLARE
    base_subdomain TEXT;
    current_subdomain TEXT;
    counter INTEGER := 0;
    suffix TEXT := '';
BEGIN
    -- Clean and normalize names
    first_name := lower(regexp_replace(unaccent(first_name), '[^a-z]', '', 'g'));
    last_name := lower(regexp_replace(unaccent(last_name), '[^a-z]', '', 'g'));
    
    -- Base subdomain
    base_subdomain := first_name || last_name;
    current_subdomain := base_subdomain;
    
    -- Check if subdomain exists and find unique one
    WHILE EXISTS (SELECT 1 FROM users WHERE subdomain = current_subdomain) LOOP
        counter := counter + 1;
        
        -- Try adding letters from second last name
        IF second_last_name IS NOT NULL AND counter <= length(second_last_name) THEN
            suffix := left(lower(regexp_replace(unaccent(second_last_name), '[^a-z]', '', 'g')), counter);
            current_subdomain := base_subdomain || suffix;
        
        -- Then try middle name
        ELSIF middle_name IS NOT NULL AND counter - length(coalesce(second_last_name, '')) <= length(middle_name) THEN
            suffix := left(lower(regexp_replace(unaccent(middle_name), '[^a-z]', '', 'g')), 
                          counter - length(coalesce(second_last_name, '')));
            current_subdomain := base_subdomain || 
                                coalesce(lower(regexp_replace(unaccent(second_last_name), '[^a-z]', '', 'g')), '') || 
                                suffix;
        
        -- Finally use numbers
        ELSE
            current_subdomain := base_subdomain || counter::TEXT;
        END IF;
    END LOOP;
    
    RETURN current_subdomain;
END;
$$ language 'plpgsql';