// This file is auto-generated from your Supabase schema
// Run: npm run db:generate to update

export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      analytics_events: {
        Row: {
          country: string | null
          created_at: string
          device_type: Database["public"]["Enums"]["device_type"] | null
          entity_id: string
          entity_type: Database["public"]["Enums"]["analytics_entity_type"]
          event_type: Database["public"]["Enums"]["analytics_event_type"]
          id: string
          ip_address: unknown | null
          metadata: Json
          referrer: string | null
          session_id: string | null
          user_agent: string | null
          user_id: string | null
        }
        Insert: {
          country?: string | null
          created_at?: string
          device_type?: Database["public"]["Enums"]["device_type"] | null
          entity_id: string
          entity_type: Database["public"]["Enums"]["analytics_entity_type"]
          event_type: Database["public"]["Enums"]["analytics_event_type"]
          id?: string
          ip_address?: unknown | null
          metadata?: Json
          referrer?: string | null
          session_id?: string | null
          user_agent?: string | null
          user_id?: string | null
        }
        Update: {
          country?: string | null
          created_at?: string
          device_type?: Database["public"]["Enums"]["device_type"] | null
          entity_id?: string
          entity_type?: Database["public"]["Enums"]["analytics_entity_type"]
          event_type?: Database["public"]["Enums"]["analytics_event_type"]
          id?: string
          ip_address?: unknown | null
          metadata?: Json
          referrer?: string | null
          session_id?: string | null
          user_agent?: string | null
          user_id?: string | null
        }
      }
      comment_likes: {
        Row: {
          comment_id: string
          created_at: string
          id: string
          user_id: string
        }
        Insert: {
          comment_id: string
          created_at?: string
          id?: string
          user_id: string
        }
        Update: {
          comment_id?: string
          created_at?: string
          id?: string
          user_id?: string
        }
      }
      companies: {
        Row: {
          banner_url: string | null
          company_size: Database["public"]["Enums"]["company_size"]
          created_at: string
          description: string | null
          id: string
          industry: string
          is_verified: boolean
          last_payment_date: string | null
          location: string
          logo_url: string | null
          max_active_jobs: number
          max_admins: number
          name: string
          payment_method_id: string | null
          plan_expires_at: string
          plan_type: Database["public"]["Enums"]["company_plan_type"]
          slug: string
          subscription_status: Database["public"]["Enums"]["subscription_status"]
          tax_id: string | null
          total_applications_received: number
          total_followers: number
          total_job_views: number
          total_views: number
          updated_at: string
          verification_provider_id: string | null
          website_url: string | null
        }
        Insert: {
          banner_url?: string | null
          company_size: Database["public"]["Enums"]["company_size"]
          created_at?: string
          description?: string | null
          id?: string
          industry: string
          is_verified?: boolean
          last_payment_date?: string | null
          location: string
          logo_url?: string | null
          max_active_jobs?: number
          max_admins?: number
          name: string
          payment_method_id?: string | null
          plan_expires_at: string
          plan_type: Database["public"]["Enums"]["company_plan_type"]
          slug: string
          subscription_status?: Database["public"]["Enums"]["subscription_status"]
          tax_id?: string | null
          total_applications_received?: number
          total_followers?: number
          total_job_views?: number
          total_views?: number
          updated_at?: string
          verification_provider_id?: string | null
          website_url?: string | null
        }
        Update: {
          banner_url?: string | null
          company_size?: Database["public"]["Enums"]["company_size"]
          created_at?: string
          description?: string | null
          id?: string
          industry?: string
          is_verified?: boolean
          last_payment_date?: string | null
          location?: string
          logo_url?: string | null
          max_active_jobs?: number
          max_admins?: number
          name?: string
          payment_method_id?: string | null
          plan_expires_at?: string
          plan_type?: Database["public"]["Enums"]["company_plan_type"]
          slug?: string
          subscription_status?: Database["public"]["Enums"]["subscription_status"]
          tax_id?: string | null
          total_applications_received?: number
          total_followers?: number
          total_job_views?: number
          total_views?: number
          updated_at?: string
          verification_provider_id?: string | null
          website_url?: string | null
        }
      }
      company_admins: {
        Row: {
          accepted_at: string | null
          can_edit_company_profile: boolean
          can_export_data: boolean
          can_manage_admins: boolean
          can_manage_jobs: boolean
          can_manage_posts: boolean
          can_view_analytics: boolean
          company_id: string
          created_at: string
          id: string
          invited_at: string
          is_active: boolean
          role: Database["public"]["Enums"]["admin_role"]
          user_id: string
        }
        Insert: {
          accepted_at?: string | null
          can_edit_company_profile?: boolean
          can_export_data?: boolean
          can_manage_admins?: boolean
          can_manage_jobs?: boolean
          can_manage_posts?: boolean
          can_view_analytics?: boolean
          company_id: string
          created_at?: string
          id?: string
          invited_at?: string
          is_active?: boolean
          role: Database["public"]["Enums"]["admin_role"]
          user_id: string
        }
        Update: {
          accepted_at?: string | null
          can_edit_company_profile?: boolean
          can_export_data?: boolean
          can_manage_admins?: boolean
          can_manage_jobs?: boolean
          can_manage_posts?: boolean
          can_view_analytics?: boolean
          company_id?: string
          created_at?: string
          id?: string
          invited_at?: string
          is_active?: boolean
          role?: Database["public"]["Enums"]["admin_role"]
          user_id?: string
        }
      }
      company_follows: {
        Row: {
          company_id: string
          created_at: string
          id: string
          job_notifications: boolean
          notifications_enabled: boolean
          post_notifications: boolean
          user_id: string
        }
        Insert: {
          company_id: string
          created_at?: string
          id?: string
          job_notifications?: boolean
          notifications_enabled?: boolean
          post_notifications?: boolean
          user_id: string
        }
        Update: {
          company_id?: string
          created_at?: string
          id?: string
          job_notifications?: boolean
          notifications_enabled?: boolean
          post_notifications?: boolean
          user_id?: string
        }
      }
      connections: {
        Row: {
          created_at: string
          id: string
          mutual_connections_count: number
          request_message: string | null
          requested_id: string
          requester_id: string
          responded_at: string | null
          status: Database["public"]["Enums"]["connection_status"]
          updated_at: string
        }
        Insert: {
          created_at?: string
          id?: string
          mutual_connections_count?: number
          request_message?: string | null
          requested_id: string
          requester_id: string
          responded_at?: string | null
          status?: Database["public"]["Enums"]["connection_status"]
          updated_at?: string
        }
        Update: {
          created_at?: string
          id?: string
          mutual_connections_count?: number
          request_message?: string | null
          requested_id?: string
          requester_id?: string
          responded_at?: string | null
          status?: Database["public"]["Enums"]["connection_status"]
          updated_at?: string
        }
      }
      content_translations: {
        Row: {
          confidence_score: number | null
          content_id: string
          content_type: Database["public"]["Enums"]["translation_content_type"]
          created_at: string
          id: string
          is_manual_review: boolean
          reviewed_by: string | null
          source_language: string
          source_text: string
          target_language: string
          translated_text: string
          translation_provider: string
          updated_at: string
          used_in_public: boolean
        }
        Insert: {
          confidence_score?: number | null
          content_id: string
          content_type: Database["public"]["Enums"]["translation_content_type"]
          created_at?: string
          id?: string
          is_manual_review?: boolean
          reviewed_by?: string | null
          source_language?: string
          source_text: string
          target_language: string
          translated_text: string
          translation_provider?: string
          updated_at?: string
          used_in_public?: boolean
        }
        Update: {
          confidence_score?: number | null
          content_id?: string
          content_type?: Database["public"]["Enums"]["translation_content_type"]
          created_at?: string
          id?: string
          is_manual_review?: boolean
          reviewed_by?: string | null
          source_language?: string
          source_text?: string
          target_language?: string
          translated_text?: string
          translation_provider?: string
          updated_at?: string
          used_in_public?: boolean
        }
      }
      file_uploads: {
        Row: {
          company_id: string | null
          created_at: string
          file_size_bytes: number
          file_type: string
          filename: string
          id: string
          image_height: number | null
          image_width: number | null
          is_active: boolean
          is_compressed: boolean
          original_filename: string
          original_size_bytes: number | null
          public_url: string
          storage_path: string
          storage_provider: string
          used_in_id: string | null
          used_in_type: Database["public"]["Enums"]["file_usage_type"] | null
          user_id: string | null
        }
        Insert: {
          company_id?: string | null
          created_at?: string
          file_size_bytes: number
          file_type: string
          filename: string
          id?: string
          image_height?: number | null
          image_width?: number | null
          is_active?: boolean
          is_compressed?: boolean
          original_filename: string
          original_size_bytes?: number | null
          public_url: string
          storage_path: string
          storage_provider?: string
          used_in_id?: string | null
          used_in_type?: Database["public"]["Enums"]["file_usage_type"] | null
          user_id?: string | null
        }
        Update: {
          company_id?: string | null
          created_at?: string
          file_size_bytes?: number
          file_type?: string
          filename?: string
          id?: string
          image_height?: number | null
          image_width?: number | null
          is_active?: boolean
          is_compressed?: boolean
          original_filename?: string
          original_size_bytes?: number | null
          public_url?: string
          storage_path?: string
          storage_provider?: string
          used_in_id?: string | null
          used_in_type?: Database["public"]["Enums"]["file_usage_type"] | null
          user_id?: string | null
        }
      }
      job_applications: {
        Row: {
          cover_letter: string | null
          created_at: string
          expected_salary: number | null
          feedback_to_candidate: string | null
          id: string
          internal_notes: string | null
          job_id: string
          portfolio_snapshot: Json
          qualification_score: number
          reviewed_at: string | null
          reviewed_by: string | null
          status: Database["public"]["Enums"]["application_status"]
          updated_at: string
          user_id: string
          user_qualifications: Json
        }
        Insert: {
          cover_letter?: string | null
          created_at?: string
          expected_salary?: number | null
          feedback_to_candidate?: string | null
          id?: string
          internal_notes?: string | null
          job_id: string
          portfolio_snapshot: Json
          qualification_score?: number
          reviewed_at?: string | null
          reviewed_by?: string | null
          status?: Database["public"]["Enums"]["application_status"]
          updated_at?: string
          user_id: string
          user_qualifications: Json
        }
        Update: {
          cover_letter?: string | null
          created_at?: string
          expected_salary?: number | null
          feedback_to_candidate?: string | null
          id?: string
          internal_notes?: string | null
          job_id?: string
          portfolio_snapshot?: Json
          qualification_score?: number
          reviewed_at?: string | null
          reviewed_by?: string | null
          status?: Database["public"]["Enums"]["application_status"]
          updated_at?: string
          user_id?: string
          user_qualifications?: Json
        }
      }
      jobs: {
        Row: {
          application_deadline: string
          application_process: string | null
          applicants_count: number
          benefits: string[] | null
          company_id: string
          contract_type: Database["public"]["Enums"]["contract_type"]
          created_at: string
          description: string
          experience_level: Database["public"]["Enums"]["experience_level"]
          expires_at: string | null
          id: string
          is_active: boolean
          location: string | null
          qualified_applicants_count: number
          required_languages: string[]
          requirements: string
          responsibilities: string
          salary_currency: string
          salary_max: number | null
          salary_min: number | null
          slug: string | null
          title: string
          updated_at: string
          views_count: number
          work_type: Database["public"]["Enums"]["work_type"]
        }
        Insert: {
          application_deadline: string
          application_process?: string | null
          applicants_count?: number
          benefits?: string[] | null
          company_id: string
          contract_type: Database["public"]["Enums"]["contract_type"]
          created_at?: string
          description: string
          experience_level: Database["public"]["Enums"]["experience_level"]
          expires_at?: string | null
          id?: string
          is_active?: boolean
          location?: string | null
          qualified_applicants_count?: number
          required_languages?: string[]
          requirements: string
          responsibilities: string
          salary_currency?: string
          salary_max?: number | null
          salary_min?: number | null
          slug?: string | null
          title: string
          updated_at?: string
          views_count?: number
          work_type: Database["public"]["Enums"]["work_type"]
        }
        Update: {
          application_deadline?: string
          application_process?: string | null
          applicants_count?: number
          benefits?: string[] | null
          company_id?: string
          contract_type?: Database["public"]["Enums"]["contract_type"]
          created_at?: string
          description?: string
          experience_level?: Database["public"]["Enums"]["experience_level"]
          expires_at?: string | null
          id?: string
          is_active?: boolean
          location?: string | null
          qualified_applicants_count?: number
          required_languages?: string[]
          requirements?: string
          responsibilities?: string
          salary_currency?: string
          salary_max?: number | null
          salary_min?: number | null
          slug?: string | null
          title?: string
          updated_at?: string
          views_count?: number
          work_type?: Database["public"]["Enums"]["work_type"]
        }
      }
      messages: {
        Row: {
          content: string
          conversation_id: string
          created_at: string
          id: string
          image_urls: string[] | null
          is_read: boolean
          message_type: Database["public"]["Enums"]["message_type"]
          read_at: string | null
          receiver_user_id: string
          sender_company_id: string | null
          sender_type: Database["public"]["Enums"]["sender_type"]
          sender_user_id: string | null
        }
        Insert: {
          content: string
          conversation_id: string
          created_at?: string
          id?: string
          image_urls?: string[] | null
          is_read?: boolean
          message_type?: Database["public"]["Enums"]["message_type"]
          read_at?: string | null
          receiver_user_id: string
          sender_company_id?: string | null
          sender_type: Database["public"]["Enums"]["sender_type"]
          sender_user_id?: string | null
        }
        Update: {
          content?: string
          conversation_id?: string
          created_at?: string
          id?: string
          image_urls?: string[] | null
          is_read?: boolean
          message_type?: Database["public"]["Enums"]["message_type"]
          read_at?: string | null
          receiver_user_id?: string
          sender_company_id?: string | null
          sender_type?: Database["public"]["Enums"]["sender_type"]
          sender_user_id?: string | null
        }
      }
      notifications: {
        Row: {
          action_url: string | null
          content: string
          created_at: string
          id: string
          is_read: boolean
          priority: Database["public"]["Enums"]["notification_priority"]
          read_at: string | null
          related_entity_id: string | null
          related_entity_type: Database["public"]["Enums"]["notification_entity_type"] | null
          sent_via_email: boolean
          sent_via_push: boolean
          title: string
          type: Database["public"]["Enums"]["notification_type"]
          user_id: string
        }
        Insert: {
          action_url?: string | null
          content: string
          created_at?: string
          id?: string
          is_read?: boolean
          priority?: Database["public"]["Enums"]["notification_priority"]
          read_at?: string | null
          related_entity_id?: string | null
          related_entity_type?: Database["public"]["Enums"]["notification_entity_type"] | null
          sent_via_email?: boolean
          sent_via_push?: boolean
          title: string
          type: Database["public"]["Enums"]["notification_type"]
          user_id: string
        }
        Update: {
          action_url?: string | null
          content?: string
          created_at?: string
          id?: string
          is_read?: boolean
          priority?: Database["public"]["Enums"]["notification_priority"]
          read_at?: string | null
          related_entity_id?: string | null
          related_entity_type?: Database["public"]["Enums"]["notification_entity_type"] | null
          sent_via_email?: boolean
          sent_via_push?: boolean
          title?: string
          type?: Database["public"]["Enums"]["notification_type"]
          user_id?: string
        }
      }
      payment_history: {
        Row: {
          amount: number
          billing_period: Database["public"]["Enums"]["billing_period"]
          company_id: string | null
          created_at: string
          currency: string
          id: string
          invoice_url: string | null
          lemonsqueezy_order_id: string | null
          lemonsqueezy_subscription_id: string | null
          paid_at: string | null
          payer_type: Database["public"]["Enums"]["payer_type"]
          plan_type: string
          receipt_url: string | null
          refunded_at: string | null
          status: Database["public"]["Enums"]["payment_status"]
          user_id: string | null
        }
        Insert: {
          amount: number
          billing_period: Database["public"]["Enums"]["billing_period"]
          company_id?: string | null
          created_at?: string
          currency?: string
          id?: string
          invoice_url?: string | null
          lemonsqueezy_order_id?: string | null
          lemonsqueezy_subscription_id?: string | null
          paid_at?: string | null
          payer_type: Database["public"]["Enums"]["payer_type"]
          plan_type: string
          receipt_url?: string | null
          refunded_at?: string | null
          status: Database["public"]["Enums"]["payment_status"]
          user_id?: string | null
        }
        Update: {
          amount?: number
          billing_period?: Database["public"]["Enums"]["billing_period"]
          company_id?: string | null
          created_at?: string
          currency?: string
          id?: string
          invoice_url?: string | null
          lemonsqueezy_order_id?: string | null
          lemonsqueezy_subscription_id?: string | null
          paid_at?: string | null
          payer_type?: Database["public"]["Enums"]["payer_type"]
          plan_type?: string
          receipt_url?: string | null
          refunded_at?: string | null
          status?: Database["public"]["Enums"]["payment_status"]
          user_id?: string | null
        }
      }
      portfolio_sections: {
        Row: {
          content: Json
          created_at: string
          design_variant: string
          id: string
          is_visible: boolean
          metadata: Json
          portfolio_id: string
          position_order: number
          section_type: Database["public"]["Enums"]["portfolio_section_type"]
          translations: Json
          updated_at: string
        }
        Insert: {
          content: Json
          created_at?: string
          design_variant: string
          id?: string
          is_visible?: boolean
          metadata?: Json
          portfolio_id: string
          position_order?: number
          section_type: Database["public"]["Enums"]["portfolio_section_type"]
          translations?: Json
          updated_at?: string
        }
        Update: {
          content?: Json
          created_at?: string
          design_variant?: string
          id?: string
          is_visible?: boolean
          metadata?: Json
          portfolio_id?: string
          position_order?: number
          section_type?: Database["public"]["Enums"]["portfolio_section_type"]
          translations?: Json
          updated_at?: string
        }
      }
      portfolios: {
        Row: {
          available_languages: string[]
          created_at: string
          font_style: Database["public"]["Enums"]["portfolio_font_style"]
          gradient_color: string
          id: string
          is_active: boolean
          last_pdf_generated_at: string | null
          last_translation_update: string | null
          last_viewed_at: string | null
          meta_description: string | null
          meta_title: string | null
          pdf_url: string | null
          status: Database["public"]["Enums"]["portfolio_status"]
          title: string
          total_downloads: number
          total_views: number
          translation_count: number
          unique_visitors: number
          updated_at: string
          user_id: string
        }
        Insert: {
          available_languages?: string[]
          created_at?: string
          font_style?: Database["public"]["Enums"]["portfolio_font_style"]
          gradient_color?: string
          id?: string
          is_active?: boolean
          last_pdf_generated_at?: string | null
          last_translation_update?: string | null
          last_viewed_at?: string | null
          meta_description?: string | null
          meta_title?: string | null
          pdf_url?: string | null
          status?: Database["public"]["Enums"]["portfolio_status"]
          title?: string
          total_downloads?: number
          total_views?: number
          translation_count?: number
          unique_visitors?: number
          updated_at?: string
          user_id: string
        }
        Update: {
          available_languages?: string[]
          created_at?: string
          font_style?: Database["public"]["Enums"]["portfolio_font_style"]
          gradient_color?: string
          id?: string
          is_active?: boolean
          last_pdf_generated_at?: string | null
          last_translation_update?: string | null
          last_viewed_at?: string | null
          meta_description?: string | null
          meta_title?: string | null
          pdf_url?: string | null
          status?: Database["public"]["Enums"]["portfolio_status"]
          title?: string
          total_downloads?: number
          total_views?: number
          translation_count?: number
          unique_visitors?: number
          updated_at?: string
          user_id?: string
        }
      }
      post_comments: {
        Row: {
          content: string
          created_at: string
          id: string
          is_hidden: boolean
          is_reported: boolean
          likes_count: number
          parent_comment_id: string | null
          post_id: string
          updated_at: string
          user_id: string
        }
        Insert: {
          content: string
          created_at?: string
          id?: string
          is_hidden?: boolean
          is_reported?: boolean
          likes_count?: number
          parent_comment_id?: string | null
          post_id: string
          updated_at?: string
          user_id: string
        }
        Update: {
          content?: string
          created_at?: string
          id?: string
          is_hidden?: boolean
          is_reported?: boolean
          likes_count?: number
          parent_comment_id?: string | null
          post_id?: string
          updated_at?: string
          user_id?: string
        }
      }
      post_likes: {
        Row: {
          created_at: string
          id: string
          post_id: string
          user_id: string
        }
        Insert: {
          created_at?: string
          id?: string
          post_id: string
          user_id: string
        }
        Update: {
          created_at?: string
          id?: string
          post_id?: string
          user_id?: string
        }
      }
      posts: {
        Row: {
          author_company_id: string | null
          author_type: Database["public"]["Enums"]["author_type"]
          author_user_id: string | null
          comments_count: number
          content_type: Database["public"]["Enums"]["post_content_type"]
          created_at: string
          id: string
          image_urls: string[] | null
          is_hidden: boolean
          is_published: boolean
          is_reported: boolean
          job_id: string | null
          likes_count: number
          moderated_at: string | null
          published_at: string
          report_count: number
          scheduled_at: string | null
          shared_portfolio_id: string | null
          text_content: string
          updated_at: string
          views_count: number
        }
        Insert: {
          author_company_id?: string | null
          author_type: Database["public"]["Enums"]["author_type"]
          author_user_id?: string | null
          comments_count?: number
          content_type: Database["public"]["Enums"]["post_content_type"]
          created_at?: string
          id?: string
          image_urls?: string[] | null
          is_hidden?: boolean
          is_published?: boolean
          is_reported?: boolean
          job_id?: string | null
          likes_count?: number
          moderated_at?: string | null
          published_at?: string
          report_count?: number
          scheduled_at?: string | null
          shared_portfolio_id?: string | null
          text_content: string
          updated_at?: string
          views_count?: number
        }
        Update: {
          author_company_id?: string | null
          author_type?: Database["public"]["Enums"]["author_type"]
          author_user_id?: string | null
          comments_count?: number
          content_type?: Database["public"]["Enums"]["post_content_type"]
          created_at?: string
          id?: string
          image_urls?: string[] | null
          is_hidden?: boolean
          is_published?: boolean
          is_reported?: boolean
          job_id?: string | null
          likes_count?: number
          moderated_at?: string | null
          published_at?: string
          report_count?: number
          scheduled_at?: string | null
          shared_portfolio_id?: string | null
          text_content?: string
          updated_at?: string
          views_count?: number
        }
      }
      reports: {
        Row: {
          admin_notes: string | null
          auto_action_at: string | null
          auto_action_taken: Database["public"]["Enums"]["auto_action_type"] | null
          created_at: string
          description: string | null
          id: string
          report_reason: Database["public"]["Enums"]["report_reason"]
          reported_entity_id: string
          reported_entity_type: Database["public"]["Enums"]["reported_entity_type"]
          reporter_user_id: string
          resolved_at: string | null
          resolved_by_admin: boolean
          status: Database["public"]["Enums"]["report_status"]
        }
        Insert: {
          admin_notes?: string | null
          auto_action_at?: string | null
          auto_action_taken?: Database["public"]["Enums"]["auto_action_type"] | null
          created_at?: string
          description?: string | null
          id?: string
          report_reason: Database["public"]["Enums"]["report_reason"]
          reported_entity_id: string
          reported_entity_type: Database["public"]["Enums"]["reported_entity_type"]
          reporter_user_id: string
          resolved_at?: string | null
          resolved_by_admin?: boolean
          status?: Database["public"]["Enums"]["report_status"]
        }
        Update: {
          admin_notes?: string | null
          auto_action_at?: string | null
          auto_action_taken?: Database["public"]["Enums"]["auto_action_type"] | null
          created_at?: string
          description?: string | null
          id?: string
          report_reason?: Database["public"]["Enums"]["report_reason"]
          reported_entity_id?: string
          reported_entity_type?: Database["public"]["Enums"]["reported_entity_type"]
          reporter_user_id?: string
          resolved_at?: string | null
          resolved_by_admin?: boolean
          status?: Database["public"]["Enums"]["report_status"]
        }
      }
      system_settings: {
        Row: {
          description: string | null
          id: string
          key: string
          updated_at: string
          updated_by: string | null
          value: Json
        }
        Insert: {
          description?: string | null
          id?: string
          key: string
          updated_at?: string
          updated_by?: string | null
          value: Json
        }
        Update: {
          description?: string | null
          id?: string
          key?: string
          updated_at?: string
          updated_by?: string | null
          value?: Json
        }
      }
      users: {
        Row: {
          banner_image_url: string | null
          birth_date: string
          created_at: string
          current_occupation: string
          email: string
          facebook_url: string | null
          failed_login_count: number
          first_name: string
          github_url: string | null
          id: string
          image_count: number
          instagram_url: string | null
          is_2fa_enabled: boolean
          is_verified: boolean
          last_login: string | null
          last_name: string
          linkedin_url: string | null
          location: string
          locked_until: string | null
          login_attempts: number
          middle_name: string | null
          phone: string | null
          plan_expires_at: string | null
          plan_type: Database["public"]["Enums"]["user_plan_type"]
          preferred_language: string
          profile_image_url: string | null
          push_notifications: boolean
          second_last_name: string | null
          subdomain: string
          theme: Database["public"]["Enums"]["theme_preference"]
          total_connections: number
          total_portfolio_views: number
          total_profile_views: number
          twitter_url: string | null
          updated_at: string
          used_storage_bytes: number
          verification_provider_id: string | null
          website_url: string | null
        }
        Insert: {
          banner_image_url?: string | null
          birth_date: string
          created_at?: string
          current_occupation: string
          email: string
          facebook_url?: string | null
          failed_login_count?: number
          first_name: string
          github_url?: string | null
          id: string
          image_count?: number
          instagram_url?: string | null
          is_2fa_enabled?: boolean
          is_verified?: boolean
          last_login?: string | null
          last_name: string
          linkedin_url?: string | null
          location: string
          locked_until?: string | null
          login_attempts?: number
          middle_name?: string | null
          phone?: string | null
          plan_expires_at?: string | null
          plan_type?: Database["public"]["Enums"]["user_plan_type"]
          preferred_language?: string
          profile_image_url?: string | null
          push_notifications?: boolean
          second_last_name?: string | null
          subdomain: string
          theme?: Database["public"]["Enums"]["theme_preference"]
          total_connections?: number
          total_portfolio_views?: number
          total_profile_views?: number
          twitter_url?: string | null
          updated_at?: string
          used_storage_bytes?: number
          verification_provider_id?: string | null
          website_url?: string | null
        }
        Update: {
          banner_image_url?: string | null
          birth_date?: string
          created_at?: string
          current_occupation?: string
          email?: string
          facebook_url?: string | null
          failed_login_count?: number
          first_name?: string
          github_url?: string | null
          id?: string
          image_count?: number
          instagram_url?: string | null
          is_2fa_enabled?: boolean
          is_verified?: boolean
          last_login?: string | null
          last_name?: string
          linkedin_url?: string | null
          location?: string
          locked_until?: string | null
          login_attempts?: number
          middle_name?: string | null
          phone?: string | null
          plan_expires_at?: string | null
          plan_type?: Database["public"]["Enums"]["user_plan_type"]
          preferred_language?: string
          profile_image_url?: string | null
          push_notifications?: boolean
          second_last_name?: string | null
          subdomain?: string
          theme?: Database["public"]["Enums"]["theme_preference"]
          total_connections?: number
          total_portfolio_views?: number
          total_profile_views?: number
          twitter_url?: string | null
          updated_at?: string
          used_storage_bytes?: number
          verification_provider_id?: string | null
          website_url?: string | null
        }
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      generate_unique_subdomain: {
        Args: {
          first_name: string
          last_name: string
          second_last_name?: string
          middle_name?: string
        }
        Returns: string
      }
      is_company_admin: {
        Args: {
          company_uuid: string
          user_uuid?: string
        }
        Returns: boolean
      }
      is_company_owner: {
        Args: {
          company_uuid: string
          user_uuid?: string
        }
        Returns: boolean
      }
      is_portfolio_published: {
        Args: {
          portfolio_uuid: string
        }
        Returns: boolean
      }
    }
    Enums: {
      admin_role: "owner" | "admin"
      analytics_entity_type: "portfolio" | "company" | "post" | "job" | "user"
      analytics_event_type:
        | "view"
        | "like"
        | "comment"
        | "share"
        | "download"
        | "application"
        | "follow"
        | "message"
      application_status:
        | "received"
        | "reviewed"
        | "rejected"
        | "preselected"
        | "selected"
      author_type: "user" | "company"
      auto_action_type: "hidden" | "warning_sent" | "account_suspended"
      billing_period: "monthly" | "annually"
      company_plan_type: "small" | "large"
      company_size: "small" | "large"
      connection_status: "pending" | "accepted" | "declined" | "blocked"
      contract_type: "full_time" | "part_time" | "freelance" | "internship"
      device_type: "desktop" | "mobile" | "tablet"
      experience_level: "entry" | "mid" | "senior" | "lead"
      file_usage_type: "profile" | "banner" | "portfolio" | "post" | "company"
      message_type: "text" | "image" | "system"
      notification_entity_type:
        | "user"
        | "company"
        | "job"
        | "post"
        | "portfolio"
      notification_priority: "low" | "normal" | "high" | "urgent"
      notification_type:
        | "connection_request"
        | "job_match"
        | "message"
        | "company_update"
        | "system"
        | "portfolio_view"
        | "job_application"
      payment_status: "pending" | "completed" | "failed" | "refunded"
      payer_type: "user" | "company"
      portfolio_font_style: "formal" | "pixelated" | "technological"
      portfolio_section_type:
        | "about"
        | "experience"
        | "education"
        | "projects"
        | "skills"
        | "impact"
        | "objectives"
      portfolio_status: "draft" | "published"
      post_content_type: "portfolio_share" | "company_post" | "job_posting"
      report_reason:
        | "inappropriate"
        | "spam"
        | "fake_content"
        | "impersonation"
        | "harassment"
        | "other"
      report_status: "pending" | "reviewing" | "resolved" | "dismissed"
      reported_entity_type:
        | "user"
        | "company"
        | "post"
        | "portfolio"
        | "job"
      sender_type: "user" | "company"
      subscription_status: "active" | "paused" | "cancelled"
      theme_preference: "light" | "dark" | "auto"
      translation_content_type: "portfolio_section" | "post" | "job"
      user_plan_type: "free" | "premium"
      work_type: "remote" | "onsite" | "hybrid"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

export type Tables<
  PublicTableNameOrOptions extends
    | keyof (Database["public"]["Tables"] & Database["public"]["Views"])
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
        Database[PublicTableNameOrOptions["schema"]]["Views"])
    : never = never
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
      Database[PublicTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : PublicTableNameOrOptions extends keyof (Database["public"]["Tables"] &
      Database["public"]["Views"])
  ? (Database["public"]["Tables"] &
      Database["public"]["Views"])[PublicTableNameOrOptions] extends {
      Row: infer R
    }
    ? R
    : never
  : never

export type TablesInsert<
  PublicTableNameOrOptions extends
    | keyof Database["public"]["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : PublicTableNameOrOptions extends keyof Database["public"]["Tables"]
  ? Database["public"]["Tables"][PublicTableNameOrOptions] extends {
      Insert: infer I
    }
    ? I
    : never
  : never

export type TablesUpdate<
  PublicTableNameOrOptions extends
    | keyof Database["public"]["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : PublicTableNameOrOptions extends keyof Database["public"]["Tables"]
  ? Database["public"]["Tables"][PublicTableNameOrOptions] extends {
      Update: infer U
    }
    ? U
    : never
  : never

export type Enums<
  PublicEnumNameOrOptions extends
    | keyof Database["public"]["Enums"]
    | { schema: keyof Database },
  EnumName extends PublicEnumNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicEnumNameOrOptions["schema"]]["Enums"]
    : never = never
> = PublicEnumNameOrOptions extends { schema: keyof Database }
  ? Database[PublicEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : PublicEnumNameOrOptions extends keyof Database["public"]["Enums"]
  ? Database["public"]["Enums"][PublicEnumNameOrOptions]
  : never

// Additional helper types
export type User = Tables<"users">
export type Company = Tables<"companies">
export type Portfolio = Tables<"portfolios">
export type PortfolioSection = Tables<"portfolio_sections">
export type Post = Tables<"posts">
export type Job = Tables<"jobs">
export type JobApplication = Tables<"job_applications">
export type Connection = Tables<"connections">
export type Message = Tables<"messages">
export type Notification = Tables<"notifications">
export type Report = Tables<"reports">
export type AnalyticsEvent = Tables<"analytics_events">
export type PaymentHistory = Tables<"payment_history">
export type FileUpload = Tables<"file_uploads">

// Insert types
export type UserInsert = TablesInsert<"users">
export type CompanyInsert = TablesInsert<"companies">
export type PortfolioInsert = TablesInsert<"portfolios">
export type PortfolioSectionInsert = TablesInsert<"portfolio_sections">
export type PostInsert = TablesInsert<"posts">
export type JobInsert = TablesInsert<"jobs">
export type JobApplicationInsert = TablesInsert<"job_applications">
export type MessageInsert = TablesInsert<"messages">
export type NotificationInsert = TablesInsert<"notifications">

// Update types
export type UserUpdate = TablesUpdate<"users">
export type CompanyUpdate = TablesUpdate<"companies">
export type PortfolioUpdate = TablesUpdate<"portfolios">
export type PortfolioSectionUpdate = TablesUpdate<"portfolio_sections">
export type PostUpdate = TablesUpdate<"posts">
export type JobUpdate = TablesUpdate<"jobs">

// Enum types
export type UserPlanType = Enums<"user_plan_type">
export type CompanyPlanType = Enums<"company_plan_type">
export type PortfolioFontStyle = Enums<"portfolio_font_style">
export type PortfolioSectionType = Enums<"portfolio_section_type">
export type WorkType = Enums<"work_type">
export type ExperienceLevel = Enums<"experience_level">
export type ApplicationStatus = Enums<"application_status">
export type ConnectionStatus = Enums<"connection_status">
export type NotificationType = Enums<"notification_type">
export type ReportReason = Enums<"report_reason">
export type ThemePreference = Enums<"theme_preference">;