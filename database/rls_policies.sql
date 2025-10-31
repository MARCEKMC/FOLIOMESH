-- =====================================================
-- FOLIOMESH ROW LEVEL SECURITY (RLS) POLICIES
-- Supabase Security Configuration
-- =====================================================

-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE company_admins ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolios ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio_sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE jobs ENABLE ROW LEVEL SECURITY;
ALTER TABLE job_applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE connections ENABLE ROW LEVEL SECURITY;
ALTER TABLE company_follows ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE analytics_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE post_likes ENABLE ROW LEVEL SECURITY;
ALTER TABLE post_comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE comment_likes ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_translations ENABLE ROW LEVEL SECURITY;
ALTER TABLE file_uploads ENABLE ROW LEVEL SECURITY;
ALTER TABLE system_settings ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- USERS TABLE POLICIES
-- =====================================================

-- Users can read their own data
CREATE POLICY "Users can view own profile" ON users
    FOR SELECT USING (auth.uid() = id);

-- Users can update their own data
CREATE POLICY "Users can update own profile" ON users
    FOR UPDATE USING (auth.uid() = id);

-- Public can read basic user info for published portfolios
CREATE POLICY "Public can view basic user info" ON users
    FOR SELECT USING (
        id IN (
            SELECT user_id FROM portfolios 
            WHERE status = 'published' AND is_active = true
        )
    );

-- Users can insert their own record (registration)
CREATE POLICY "Users can insert own record" ON users
    FOR INSERT WITH CHECK (auth.uid() = id);

-- =====================================================
-- COMPANIES TABLE POLICIES
-- =====================================================

-- Company admins can view their company
CREATE POLICY "Admins can view company" ON companies
    FOR SELECT USING (
        id IN (
            SELECT company_id FROM company_admins 
            WHERE user_id = auth.uid() AND is_active = true
        )
    );

-- Company owners can update their company
CREATE POLICY "Owners can update company" ON companies
    FOR UPDATE USING (
        id IN (
            SELECT company_id FROM company_admins 
            WHERE user_id = auth.uid() AND role = 'owner' AND is_active = true
        )
    );

-- Public can view verified companies
CREATE POLICY "Public can view verified companies" ON companies
    FOR SELECT USING (is_verified = true);

-- =====================================================
-- COMPANY ADMINS POLICIES
-- =====================================================

-- Admins can view other admins of their company
CREATE POLICY "Admins can view company admins" ON company_admins
    FOR SELECT USING (
        company_id IN (
            SELECT company_id FROM company_admins 
            WHERE user_id = auth.uid() AND is_active = true
        )
    );

-- Only owners can manage admins
CREATE POLICY "Owners can manage admins" ON company_admins
    FOR ALL USING (
        company_id IN (
            SELECT company_id FROM company_admins 
            WHERE user_id = auth.uid() AND role = 'owner' AND is_active = true
        )
    );

-- =====================================================
-- PORTFOLIOS TABLE POLICIES
-- =====================================================

-- Users can manage their own portfolios
CREATE POLICY "Users can manage own portfolios" ON portfolios
    FOR ALL USING (auth.uid() = user_id);

-- Public can view published portfolios
CREATE POLICY "Public can view published portfolios" ON portfolios
    FOR SELECT USING (status = 'published');

-- =====================================================
-- PORTFOLIO SECTIONS POLICIES
-- =====================================================

-- Users can manage their own portfolio sections
CREATE POLICY "Users can manage own sections" ON portfolio_sections
    FOR ALL USING (
        portfolio_id IN (
            SELECT id FROM portfolios WHERE user_id = auth.uid()
        )
    );

-- Public can view sections of published portfolios
CREATE POLICY "Public can view published sections" ON portfolio_sections
    FOR SELECT USING (
        portfolio_id IN (
            SELECT id FROM portfolios WHERE status = 'published'
        )
    );

-- =====================================================
-- POSTS TABLE POLICIES
-- =====================================================

-- Users can manage their own posts
CREATE POLICY "Users can manage own posts" ON posts
    FOR ALL USING (author_user_id = auth.uid());

-- Company admins can manage company posts
CREATE POLICY "Admins can manage company posts" ON posts
    FOR ALL USING (
        author_company_id IN (
            SELECT company_id FROM company_admins 
            WHERE user_id = auth.uid() AND is_active = true AND can_manage_posts = true
        )
    );

-- Public can view published posts
CREATE POLICY "Public can view published posts" ON posts
    FOR SELECT USING (is_published = true AND is_hidden = false);

-- =====================================================
-- JOBS TABLE POLICIES
-- =====================================================

-- Company admins can manage jobs
CREATE POLICY "Admins can manage jobs" ON jobs
    FOR ALL USING (
        company_id IN (
            SELECT company_id FROM company_admins 
            WHERE user_id = auth.uid() AND is_active = true AND can_manage_jobs = true
        )
    );

-- Public can view active jobs
CREATE POLICY "Public can view active jobs" ON jobs
    FOR SELECT USING (is_active = true AND application_deadline > NOW());

-- =====================================================
-- JOB APPLICATIONS POLICIES
-- =====================================================

-- Users can manage their own applications
CREATE POLICY "Users can manage own applications" ON job_applications
    FOR ALL USING (auth.uid() = user_id);

-- Company admins can view applications for their jobs
CREATE POLICY "Companies can view job applications" ON job_applications
    FOR SELECT USING (
        job_id IN (
            SELECT id FROM jobs WHERE company_id IN (
                SELECT company_id FROM company_admins 
                WHERE user_id = auth.uid() AND is_active = true
            )
        )
    );

-- Company admins can update application status
CREATE POLICY "Companies can update applications" ON job_applications
    FOR UPDATE USING (
        job_id IN (
            SELECT id FROM jobs WHERE company_id IN (
                SELECT company_id FROM company_admins 
                WHERE user_id = auth.uid() AND is_active = true
            )
        )
    );

-- =====================================================
-- CONNECTIONS POLICIES
-- =====================================================

-- Users can manage their own connections
CREATE POLICY "Users can manage connections" ON connections
    FOR ALL USING (auth.uid() = requester_id OR auth.uid() = requested_id);

-- =====================================================
-- COMPANY FOLLOWS POLICIES
-- =====================================================

-- Users can manage their own follows
CREATE POLICY "Users can manage follows" ON company_follows
    FOR ALL USING (auth.uid() = user_id);

-- =====================================================
-- MESSAGES POLICIES
-- =====================================================

-- Users can view messages they're involved in
CREATE POLICY "Users can view own messages" ON messages
    FOR SELECT USING (
        auth.uid() = receiver_user_id OR 
        auth.uid() = sender_user_id
    );

-- Users can send messages
CREATE POLICY "Users can send messages" ON messages
    FOR INSERT WITH CHECK (auth.uid() = sender_user_id);

-- Company admins can send messages as company
CREATE POLICY "Companies can send messages" ON messages
    FOR INSERT WITH CHECK (
        sender_company_id IN (
            SELECT company_id FROM company_admins 
            WHERE user_id = auth.uid() AND is_active = true
        )
    );

-- =====================================================
-- NOTIFICATIONS POLICIES
-- =====================================================

-- Users can view their own notifications
CREATE POLICY "Users can view own notifications" ON notifications
    FOR SELECT USING (auth.uid() = user_id);

-- Users can update their notification status
CREATE POLICY "Users can update notifications" ON notifications
    FOR UPDATE USING (auth.uid() = user_id);

-- =====================================================
-- REPORTS POLICIES
-- =====================================================

-- Users can create reports
CREATE POLICY "Users can create reports" ON reports
    FOR INSERT WITH CHECK (auth.uid() = reporter_user_id);

-- Users can view their own reports
CREATE POLICY "Users can view own reports" ON reports
    FOR SELECT USING (auth.uid() = reporter_user_id);

-- =====================================================
-- ANALYTICS EVENTS POLICIES
-- =====================================================

-- Anyone can insert analytics events
CREATE POLICY "Anyone can track events" ON analytics_events
    FOR INSERT WITH CHECK (true);

-- Users can view analytics for their content
CREATE POLICY "Users can view own analytics" ON analytics_events
    FOR SELECT USING (
        (entity_type = 'portfolio' AND entity_id IN (
            SELECT id FROM portfolios WHERE user_id = auth.uid()
        )) OR
        (entity_type = 'user' AND entity_id = auth.uid()) OR
        (entity_type = 'company' AND entity_id IN (
            SELECT company_id FROM company_admins 
            WHERE user_id = auth.uid() AND is_active = true
        ))
    );

-- =====================================================
-- POST INTERACTIONS POLICIES
-- =====================================================

-- Users can manage their own likes
CREATE POLICY "Users can manage post likes" ON post_likes
    FOR ALL USING (auth.uid() = user_id);

-- Users can manage their own comments
CREATE POLICY "Users can manage comments" ON post_comments
    FOR ALL USING (auth.uid() = user_id);

-- Public can view comments on published posts
CREATE POLICY "Public can view comments" ON post_comments
    FOR SELECT USING (
        post_id IN (
            SELECT id FROM posts WHERE is_published = true AND is_hidden = false
        )
    );

-- Users can manage comment likes
CREATE POLICY "Users can manage comment likes" ON comment_likes
    FOR ALL USING (auth.uid() = user_id);

-- =====================================================
-- PAYMENT HISTORY POLICIES
-- =====================================================

-- Users can view their own payment history
CREATE POLICY "Users can view own payments" ON payment_history
    FOR SELECT USING (auth.uid() = user_id);

-- Company admins can view company payments
CREATE POLICY "Companies can view payments" ON payment_history
    FOR SELECT USING (
        company_id IN (
            SELECT company_id FROM company_admins 
            WHERE user_id = auth.uid() AND is_active = true
        )
    );

-- =====================================================
-- FILE UPLOADS POLICIES
-- =====================================================

-- Users can manage their own uploads
CREATE POLICY "Users can manage uploads" ON file_uploads
    FOR ALL USING (auth.uid() = user_id);

-- Company admins can manage company uploads
CREATE POLICY "Companies can manage uploads" ON file_uploads
    FOR ALL USING (
        company_id IN (
            SELECT company_id FROM company_admins 
            WHERE user_id = auth.uid() AND is_active = true
        )
    );

-- Public can view active uploads
CREATE POLICY "Public can view active uploads" ON file_uploads
    FOR SELECT USING (is_active = true);

-- =====================================================
-- CONTENT TRANSLATIONS POLICIES
-- =====================================================

-- Users can view translations for their content
CREATE POLICY "Users can view own translations" ON content_translations
    FOR SELECT USING (
        (content_type = 'portfolio_section' AND content_id IN (
            SELECT ps.id FROM portfolio_sections ps
            JOIN portfolios p ON ps.portfolio_id = p.id
            WHERE p.user_id = auth.uid()
        )) OR
        (content_type = 'post' AND content_id IN (
            SELECT id FROM posts WHERE author_user_id = auth.uid()
        )) OR
        (content_type = 'job' AND content_id IN (
            SELECT j.id FROM jobs j
            JOIN company_admins ca ON j.company_id = ca.company_id
            WHERE ca.user_id = auth.uid() AND ca.is_active = true
        ))
    );

-- Public can view translations for published content
CREATE POLICY "Public can view published translations" ON content_translations
    FOR SELECT USING (used_in_public = true);

-- =====================================================
-- SYSTEM SETTINGS POLICIES
-- =====================================================

-- Only allow reading system settings
CREATE POLICY "Anyone can read system settings" ON system_settings
    FOR SELECT USING (true);

-- =====================================================
-- HELPER FUNCTIONS FOR RLS
-- =====================================================

-- Function to check if user is company admin
CREATE OR REPLACE FUNCTION is_company_admin(company_uuid UUID, user_uuid UUID DEFAULT auth.uid())
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM company_admins 
        WHERE company_id = company_uuid 
        AND user_id = user_uuid 
        AND is_active = true
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to check if user is company owner
CREATE OR REPLACE FUNCTION is_company_owner(company_uuid UUID, user_uuid UUID DEFAULT auth.uid())
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM company_admins 
        WHERE company_id = company_uuid 
        AND user_id = user_uuid 
        AND role = 'owner'
        AND is_active = true
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to check if portfolio is published
CREATE OR REPLACE FUNCTION is_portfolio_published(portfolio_uuid UUID)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM portfolios 
        WHERE id = portfolio_uuid 
        AND status = 'published'
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;