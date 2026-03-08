--
-- PostgreSQL database dump
--

\restrict WvtLLj6XWluns2hKdF5cPPbPi9ebKdFNfYnJSPkaudsNX0vnlcg0Wg93932eTUr

-- Dumped from database version 16.11
-- Dumped by pg_dump version 16.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: update_invoices_updated_at(); Type: FUNCTION; Schema: public; Owner: pronto
--

CREATE FUNCTION public.update_invoices_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_invoices_updated_at() OWNER TO pronto;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.audit_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    employee_id uuid,
    action character varying(50) NOT NULL,
    details text,
    ip_address character varying(45),
    user_agent text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.audit_logs OWNER TO pronto;

--
-- Name: branding_config; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.branding_config (
    id integer NOT NULL,
    config jsonb DEFAULT '{}'::jsonb NOT NULL,
    logo_bytes bytea,
    logo_mime text,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.branding_config OWNER TO pronto;

--
-- Name: customer_sessions; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.customer_sessions (
    customer_ref uuid NOT NULL,
    customer_id character varying(255),
    email character varying(255),
    name character varying(255),
    phone character varying(50),
    kind character varying(50) DEFAULT 'customer'::character varying,
    kiosk_location character varying(255),
    created_at timestamp with time zone DEFAULT now(),
    last_seen_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.customer_sessions OWNER TO pronto;

--
-- Name: pronto_areas; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_areas (
    name character varying(100) NOT NULL,
    description text,
    sort_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    color character varying(20),
    prefix character varying(10),
    background_image text,
    id integer NOT NULL
);


ALTER TABLE public.pronto_areas OWNER TO pronto;

--
-- Name: pronto_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_areas_id_seq OWNER TO pronto;

--
-- Name: pronto_areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_areas_id_seq OWNED BY public.pronto_areas.id;


--
-- Name: pronto_audit_logs; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_audit_logs (
    id integer NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id character varying(36) NOT NULL,
    action character varying(50) NOT NULL,
    actor_id uuid,
    actor_type character varying(32) NOT NULL,
    old_value jsonb,
    new_value jsonb,
    changed_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_audit_logs OWNER TO pronto;

--
-- Name: pronto_audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_audit_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_audit_logs_id_seq OWNER TO pronto;

--
-- Name: pronto_audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_audit_logs_id_seq OWNED BY public.pronto_audit_logs.id;


--
-- Name: pronto_business_config; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_business_config (
    id integer NOT NULL,
    config_key character varying(255) NOT NULL,
    config_value text,
    value_type character varying(50) DEFAULT 'string'::character varying,
    category character varying(100) DEFAULT 'general'::character varying,
    display_name character varying(255),
    description text,
    min_value character varying(255),
    max_value character varying(255),
    unit character varying(50),
    updated_at timestamp with time zone DEFAULT now(),
    updated_by uuid,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.pronto_business_config OWNER TO pronto;

--
-- Name: pronto_business_config_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_business_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_business_config_id_seq OWNER TO pronto;

--
-- Name: pronto_business_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_business_config_id_seq OWNED BY public.pronto_business_config.id;


--
-- Name: pronto_business_info; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_business_info (
    id integer NOT NULL,
    business_name character varying(200) NOT NULL,
    address text,
    city character varying(100),
    state character varying(100),
    postal_code character varying(20),
    country character varying(100),
    phone character varying(50),
    email character varying(200),
    website character varying(200),
    logo_url character varying(500),
    description text,
    currency character varying(10) DEFAULT 'MXN'::character varying NOT NULL,
    timezone character varying(50) DEFAULT 'America/Mexico_City'::character varying NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    restaurant_name character varying(255) DEFAULT 'PRONTO'::character varying,
    restaurant_slug character varying(100) DEFAULT 'default'::character varying,
    currency_symbol character varying(10) DEFAULT '$'::character varying,
    currency_code character varying(10) DEFAULT 'MXN'::character varying,
    logo_path character varying(500),
    favicon_path character varying(500),
    primary_color character varying(7) DEFAULT '#FF6B35'::character varying,
    secondary_color character varying(7) DEFAULT '#2D3142'::character varying,
    accent_color character varying(7) DEFAULT '#4ECDC4'::character varying,
    website_url character varying(500),
    tax_rate numeric(5,2) DEFAULT 16.00,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    tax_id character varying(50),
    settings jsonb
);


ALTER TABLE public.pronto_business_info OWNER TO pronto;

--
-- Name: TABLE pronto_business_info; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON TABLE public.pronto_business_info IS 'Restaurant business configuration and branding settings';


--
-- Name: COLUMN pronto_business_info.restaurant_slug; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_business_info.restaurant_slug IS 'URL-friendly identifier for the restaurant';


--
-- Name: pronto_business_info_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_business_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_business_info_id_seq OWNER TO pronto;

--
-- Name: pronto_business_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_business_info_id_seq OWNED BY public.pronto_business_info.id;


--
-- Name: pronto_business_schedule; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_business_schedule (
    id integer NOT NULL,
    day_of_week integer NOT NULL,
    is_open boolean DEFAULT true NOT NULL,
    open_time character varying(10),
    close_time character varying(10),
    notes character varying(200),
    CONSTRAINT pronto_business_schedule_day_of_week_check CHECK (((day_of_week >= 0) AND (day_of_week <= 6)))
);


ALTER TABLE public.pronto_business_schedule OWNER TO pronto;

--
-- Name: pronto_customers; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_customers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    anon_id character varying(36),
    first_name character varying(100) NOT NULL,
    last_name character varying(100),
    email_hash character varying(128),
    password_hash character varying(255),
    loyalty_points integer DEFAULT 0,
    total_spent numeric(12,2) DEFAULT 0.00,
    visit_count integer DEFAULT 0,
    notes text,
    preferences jsonb,
    email_encrypted text,
    name_encrypted text,
    phone_encrypted text,
    physical_description text,
    avatar character varying(255),
    kind character varying(20) DEFAULT 'customer'::character varying,
    kiosk_location character varying(50),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    name_search text,
    email_normalized text,
    phone_e164 character varying(50),
    tax_id character varying(32),
    tax_name character varying(255),
    tax_address text,
    tax_email character varying(255),
    auth_hash character varying(255),
    reset_token character varying(100),
    reset_token_expires_at timestamp without time zone,
    tax_regime character varying(3),
    facturapi_customer_id character varying(64),
    CONSTRAINT chk_customer_kind CHECK (((kind)::text = ANY ((ARRAY['customer'::character varying, 'kiosk'::character varying])::text[])))
);


ALTER TABLE public.pronto_customers OWNER TO pronto;

--
-- Name: pronto_day_periods; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_day_periods (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(50) NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    sort_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    period_key character varying(50),
    description text,
    icon character varying(100),
    color character varying(20),
    display_order integer DEFAULT 0 NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    updated_at timestamp with time zone
);


ALTER TABLE public.pronto_day_periods OWNER TO pronto;

--
-- Name: pronto_dining_sessions; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_dining_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    table_id uuid,
    customer_id uuid,
    employee_id uuid,
    opened_at timestamp with time zone DEFAULT now(),
    closed_at timestamp with time zone,
    party_size integer DEFAULT 2,
    status character varying(50) DEFAULT 'active'::character varying,
    subtotal numeric(12,2) DEFAULT 0.00,
    tax_amount numeric(12,2) DEFAULT 0.00,
    tip_amount numeric(12,2) DEFAULT 0.00,
    total_amount numeric(12,2) DEFAULT 0.00,
    payment_status character varying(20) DEFAULT 'pending'::character varying,
    payment_method character varying(50),
    notes text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    anon_id character varying(36),
    total_paid numeric(12,2) DEFAULT 0.00,
    table_number character varying(32),
    expires_at timestamp with time zone,
    payment_reference character varying(128),
    payment_confirmed_at timestamp with time zone,
    tip_requested_at timestamp with time zone,
    tip_confirmed_at timestamp with time zone,
    check_requested_at timestamp with time zone,
    feedback_requested_at timestamp with time zone,
    feedback_completed_at timestamp with time zone,
    email_encrypted text,
    email_hash character varying(128),
    feedback_rating integer,
    feedback_comment text
);


ALTER TABLE public.pronto_dining_sessions OWNER TO pronto;

--
-- Name: COLUMN pronto_dining_sessions.status; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_dining_sessions.status IS 'Session status: open, active, awaiting_tip, awaiting_payment, awaiting_payment_confirmation, closed, paid';


--
-- Name: pronto_discount_codes; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_discount_codes (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    description text,
    discount_type character varying(32) NOT NULL,
    discount_percentage numeric(5,2),
    discount_amount numeric(10,2),
    min_purchase_amount numeric(10,2),
    usage_limit integer,
    times_used integer DEFAULT 0 NOT NULL,
    applies_to character varying(32) DEFAULT 'products'::character varying NOT NULL,
    applicable_tags jsonb,
    applicable_products jsonb,
    valid_from timestamp without time zone NOT NULL,
    valid_until timestamp without time zone,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_discount_codes_amount_positive CHECK ((discount_amount >= (0)::numeric)),
    CONSTRAINT chk_discount_codes_discount_valid CHECK (((discount_percentage >= (0)::numeric) AND (discount_percentage <= (100)::numeric))),
    CONSTRAINT chk_discount_codes_times_used_positive CHECK ((times_used >= 0)),
    CONSTRAINT chk_discount_codes_usage_limit_positive CHECK ((usage_limit >= 0))
);


ALTER TABLE public.pronto_discount_codes OWNER TO pronto;

--
-- Name: pronto_discount_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_discount_codes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_discount_codes_id_seq OWNER TO pronto;

--
-- Name: pronto_discount_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_discount_codes_id_seq OWNED BY public.pronto_discount_codes.id;


--
-- Name: pronto_employee_preferences; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_employee_preferences (
    employee_id uuid NOT NULL,
    key character varying(50) NOT NULL,
    value jsonb
);


ALTER TABLE public.pronto_employee_preferences OWNER TO pronto;

--
-- Name: pronto_employees; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_employees (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    employee_code character varying(50) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100),
    email character varying(255),
    phone character varying(20),
    pin character varying(10),
    role character varying(50) DEFAULT 'staff'::character varying,
    department character varying(100),
    hire_date date,
    status character varying(20) DEFAULT 'active'::character varying,
    permissions jsonb,
    clocked_in boolean DEFAULT false,
    current_session_id uuid,
    last_clock_in timestamp with time zone,
    total_hours numeric(10,2) DEFAULT 0.00,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    auth_hash character varying(255),
    email_hash character varying(128),
    email_encrypted text,
    name_encrypted text,
    is_active boolean DEFAULT true NOT NULL,
    allow_scopes jsonb,
    additional_roles text,
    signed_in_at timestamp without time zone,
    last_activity_at timestamp without time zone,
    preferences jsonb,
    phone_encrypted text,
    reset_token character varying(100),
    reset_token_expires_at timestamp without time zone
);


ALTER TABLE public.pronto_employees OWNER TO pronto;

--
-- Name: pronto_feedback; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_feedback (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    session_id uuid NOT NULL,
    customer_id uuid,
    employee_id uuid,
    category character varying(50) NOT NULL,
    rating integer NOT NULL,
    comment text,
    is_anonymous boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT pronto_feedback_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.pronto_feedback OWNER TO pronto;

--
-- Name: pronto_feedback_questions; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_feedback_questions (
    id integer NOT NULL,
    question_text text NOT NULL,
    question_type character varying(20) DEFAULT 'rating'::character varying NOT NULL,
    category character varying(50),
    is_required boolean DEFAULT true NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    min_rating integer DEFAULT 1 NOT NULL,
    max_rating integer DEFAULT 5 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_feedback_questions OWNER TO pronto;

--
-- Name: pronto_feedback_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_feedback_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_feedback_questions_id_seq OWNER TO pronto;

--
-- Name: pronto_feedback_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_feedback_questions_id_seq OWNED BY public.pronto_feedback_questions.id;


--
-- Name: pronto_feedback_tokens; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_feedback_tokens (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    token_hash character varying(128) NOT NULL,
    order_id uuid NOT NULL,
    session_id uuid NOT NULL,
    user_id uuid,
    email character varying(255),
    expires_at timestamp without time zone NOT NULL,
    used_at timestamp without time zone,
    email_sent_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_feedback_tokens OWNER TO pronto;

--
-- Name: pronto_init_runs; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_init_runs (
    run_id bigint NOT NULL,
    phase text NOT NULL,
    file_name text NOT NULL,
    sha256 text NOT NULL,
    sql_norm_sha text NOT NULL,
    executed_at timestamp with time zone DEFAULT now() NOT NULL,
    status text NOT NULL,
    error text,
    executed_by text,
    app_version text,
    git_sha text,
    sql_head_sha text,
    CONSTRAINT pronto_init_runs_status_check CHECK ((status = ANY (ARRAY['applied'::text, 'failed'::text])))
);


ALTER TABLE public.pronto_init_runs OWNER TO pronto;

--
-- Name: pronto_init_runs_run_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_init_runs_run_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_init_runs_run_id_seq OWNER TO pronto;

--
-- Name: pronto_init_runs_run_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_init_runs_run_id_seq OWNED BY public.pronto_init_runs.run_id;


--
-- Name: pronto_invoices; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_invoices (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id uuid,
    order_id uuid,
    dining_session_id uuid,
    facturapi_id character varying(255),
    cfdi_uuid character varying(36),
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    subtotal numeric(12,2) DEFAULT 0 NOT NULL,
    tax_amount numeric(12,2) DEFAULT 0 NOT NULL,
    total numeric(12,2) DEFAULT 0 NOT NULL,
    currency character varying(3) DEFAULT 'MXN'::character varying NOT NULL,
    payment_form character varying(2) DEFAULT '03'::character varying NOT NULL,
    payment_method character varying(3) DEFAULT 'PUE'::character varying NOT NULL,
    use_cfdi character varying(3) DEFAULT 'G03'::character varying NOT NULL,
    serie character varying(10),
    folio integer,
    pdf_url text,
    xml_url text,
    email_sent boolean DEFAULT false,
    email_sent_at timestamp without time zone,
    email_sent_to character varying(255),
    cancelled boolean DEFAULT false,
    cancelled_at timestamp without time zone,
    cancellation_motive character varying(3),
    cancellation_replacement_id uuid,
    error_message text,
    error_details jsonb,
    issued_at timestamp without time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    tax_id character varying(13),
    tax_name character varying(255),
    tax_system character varying(3),
    facturapi_customer_id character varying(64),
    cancelled_by uuid,
    notes text,
    raw_response jsonb,
    discount numeric(12,2) DEFAULT 0,
    series character varying(5)
);


ALTER TABLE public.pronto_invoices OWNER TO pronto;

--
-- Name: TABLE pronto_invoices; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON TABLE public.pronto_invoices IS 'Electronic invoices (CFDI 4.0) generated via Facturapi';


--
-- Name: COLUMN pronto_invoices.cfdi_uuid; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_invoices.cfdi_uuid IS 'SAT UUID (Folio Fiscal) assigned to the invoice';


--
-- Name: COLUMN pronto_invoices.payment_form; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_invoices.payment_form IS 'Payment form code from SAT catalog (01-31, 99)';


--
-- Name: COLUMN pronto_invoices.payment_method; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_invoices.payment_method IS 'Payment method: PUE (single payment) or PPD (deferred)';


--
-- Name: COLUMN pronto_invoices.use_cfdi; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_invoices.use_cfdi IS 'CFDI use code from SAT catalog';


--
-- Name: COLUMN pronto_invoices.tax_id; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_invoices.tax_id IS 'RFC of the customer receiving the invoice';


--
-- Name: COLUMN pronto_invoices.tax_name; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_invoices.tax_name IS 'Legal name of the customer for invoicing';


--
-- Name: COLUMN pronto_invoices.tax_system; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_invoices.tax_system IS 'SAT tax regime code (e.g., 601, 612, 621)';


--
-- Name: COLUMN pronto_invoices.facturapi_customer_id; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_invoices.facturapi_customer_id IS 'Facturapi customer ID for quick lookups';


--
-- Name: COLUMN pronto_invoices.cancelled_by; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_invoices.cancelled_by IS 'Employee who cancelled the invoice';


--
-- Name: COLUMN pronto_invoices.notes; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_invoices.notes IS 'Internal notes about the invoice';


--
-- Name: COLUMN pronto_invoices.raw_response; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_invoices.raw_response IS 'Full Facturapi response for debugging';


--
-- Name: pronto_keyboard_shortcuts; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_keyboard_shortcuts (
    id integer NOT NULL,
    combo character varying(50) NOT NULL,
    description character varying(200) NOT NULL,
    category character varying(50) DEFAULT 'General'::character varying NOT NULL,
    callback_function character varying(100) NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    prevent_default boolean DEFAULT false NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_keyboard_shortcuts OWNER TO pronto;

--
-- Name: pronto_keyboard_shortcuts_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_keyboard_shortcuts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_keyboard_shortcuts_id_seq OWNER TO pronto;

--
-- Name: pronto_keyboard_shortcuts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_keyboard_shortcuts_id_seq OWNED BY public.pronto_keyboard_shortcuts.id;


--
-- Name: pronto_kitchen_orders; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_kitchen_orders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    order_id uuid,
    order_item_ids uuid[],
    station character varying(50),
    priority integer DEFAULT 0,
    status character varying(20) DEFAULT 'pending'::character varying,
    started_at timestamp with time zone,
    completed_at timestamp with time zone,
    notes text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.pronto_kitchen_orders OWNER TO pronto;

--
-- Name: pronto_menu_categories; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_menu_categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    image_url text,
    parent_category_id uuid,
    sort_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    display_order integer DEFAULT 0 NOT NULL,
    slug character varying(120) NOT NULL,
    revision integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.pronto_menu_categories OWNER TO pronto;

--
-- Name: COLUMN pronto_menu_categories.display_order; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_menu_categories.display_order IS 'Numeric value for custom category ordering (lower = appears first)';


--
-- Name: pronto_menu_home_module_products; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_menu_home_module_products (
    module_id uuid NOT NULL,
    product_id uuid NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_menu_home_module_products OWNER TO pronto;

--
-- Name: pronto_menu_home_modules; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_menu_home_modules (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(160) NOT NULL,
    slug character varying(160) NOT NULL,
    module_type character varying(32) NOT NULL,
    source_type character varying(32) NOT NULL,
    source_ref_id uuid,
    source_item_kind character varying(16),
    placement character varying(32) DEFAULT 'home_client'::character varying NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    max_items integer DEFAULT 8 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    show_title boolean DEFAULT true NOT NULL,
    show_view_all boolean DEFAULT false NOT NULL,
    revision integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_menu_home_item_kind CHECK (((source_item_kind IS NULL) OR ((source_item_kind)::text = ANY ((ARRAY['product'::character varying, 'combo'::character varying, 'package'::character varying])::text[])))),
    CONSTRAINT chk_menu_home_module_type CHECK (((module_type)::text = ANY ((ARRAY['hero'::character varying, 'carousel'::character varying, 'grid'::character varying, 'chips'::character varying, 'category_section'::character varying])::text[]))),
    CONSTRAINT chk_menu_home_source_ref_rules CHECK (((((source_type)::text = 'manual'::text) AND (source_ref_id IS NULL)) OR (((source_type)::text = 'item_kind'::text) AND (source_ref_id IS NULL) AND (source_item_kind IS NOT NULL)) OR (((source_type)::text = ANY ((ARRAY['label'::character varying, 'category'::character varying, 'subcategory'::character varying])::text[])) AND (source_ref_id IS NOT NULL)))),
    CONSTRAINT chk_menu_home_source_type CHECK (((source_type)::text = ANY ((ARRAY['label'::character varying, 'category'::character varying, 'subcategory'::character varying, 'item_kind'::character varying, 'manual'::character varying])::text[])))
);


ALTER TABLE public.pronto_menu_home_modules OWNER TO pronto;

--
-- Name: pronto_menu_home_publication_state; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_menu_home_publication_state (
    placement character varying(32) NOT NULL,
    draft_version integer DEFAULT 1 NOT NULL,
    published_version integer DEFAULT 1 NOT NULL,
    snapshot_revision character varying(64) DEFAULT 'baseline-v1'::character varying NOT NULL,
    publish_lock boolean DEFAULT false NOT NULL,
    publish_status character varying(16) DEFAULT 'idle'::character varying NOT NULL,
    last_publish_at timestamp with time zone,
    last_publish_error text,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_menu_home_publish_status CHECK (((publish_status)::text = ANY ((ARRAY['idle'::character varying, 'running'::character varying, 'failed'::character varying, 'succeeded'::character varying])::text[])))
);


ALTER TABLE public.pronto_menu_home_publication_state OWNER TO pronto;

--
-- Name: pronto_menu_home_snapshots; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_menu_home_snapshots (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    placement character varying(32) NOT NULL,
    version integer NOT NULL,
    revision character varying(64) NOT NULL,
    payload jsonb NOT NULL,
    is_published boolean DEFAULT false NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_menu_home_snapshots OWNER TO pronto;

--
-- Name: pronto_menu_item_day_periods; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_menu_item_day_periods (
    id integer NOT NULL,
    menu_item_id uuid NOT NULL,
    period_id uuid NOT NULL,
    tag_type character varying(32) DEFAULT 'recommendation'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL
);


ALTER TABLE public.pronto_menu_item_day_periods OWNER TO pronto;

--
-- Name: pronto_menu_item_day_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_menu_item_day_periods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_menu_item_day_periods_id_seq OWNER TO pronto;

--
-- Name: pronto_menu_item_day_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_menu_item_day_periods_id_seq OWNED BY public.pronto_menu_item_day_periods.id;


--
-- Name: pronto_menu_item_modifier_groups; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_menu_item_modifier_groups (
    menu_item_id uuid NOT NULL,
    modifier_group_id uuid NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.pronto_menu_item_modifier_groups OWNER TO pronto;

--
-- Name: TABLE pronto_menu_item_modifier_groups; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON TABLE public.pronto_menu_item_modifier_groups IS 'Tabla de relación entre productos del menú y grupos de modificadores';


--
-- Name: COLUMN pronto_menu_item_modifier_groups.display_order; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_menu_item_modifier_groups.display_order IS 'Orden de visualización del grupo de modificadores en el producto';


--
-- Name: pronto_menu_items; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_menu_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    category_id uuid,
    image_url text,
    preparation_time_minutes integer DEFAULT 15,
    is_available boolean DEFAULT true,
    is_featured boolean DEFAULT false,
    calories integer,
    allergens text[],
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    image_path character varying(255),
    is_afternoon_recommended boolean DEFAULT false NOT NULL,
    is_night_recommended boolean DEFAULT false NOT NULL,
    track_inventory boolean DEFAULT false NOT NULL,
    stock_quantity integer,
    low_stock_threshold integer,
    is_quick_serve boolean DEFAULT false NOT NULL,
    is_breakfast_recommended boolean DEFAULT false NOT NULL,
    menu_category_id uuid NOT NULL,
    menu_subcategory_id uuid NOT NULL,
    item_kind character varying(16) DEFAULT 'product'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    CONSTRAINT chk_menu_items_item_kind CHECK (((item_kind)::text = ANY ((ARRAY['product'::character varying, 'combo'::character varying, 'package'::character varying])::text[])))
);


ALTER TABLE public.pronto_menu_items OWNER TO pronto;

--
-- Name: pronto_menu_subcategories; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_menu_subcategories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    menu_category_id uuid NOT NULL,
    name character varying(120) NOT NULL,
    slug character varying(120) NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    revision integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_menu_subcategories OWNER TO pronto;

--
-- Name: pronto_modifier_groups; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_modifier_groups (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    menu_item_id uuid,
    min_selection integer DEFAULT 0,
    max_selection integer DEFAULT 1,
    is_required boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    display_order integer DEFAULT 0
);


ALTER TABLE public.pronto_modifier_groups OWNER TO pronto;

--
-- Name: pronto_modifiers; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_modifiers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    price_adjustment numeric(10,2) DEFAULT 0.00,
    group_id uuid,
    is_default boolean DEFAULT false,
    is_available boolean DEFAULT true,
    display_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    image_path character varying(500)
);


ALTER TABLE public.pronto_modifiers OWNER TO pronto;

--
-- Name: pronto_notifications; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_notifications (
    id integer NOT NULL,
    notification_type character varying(64) NOT NULL,
    recipient_type character varying(32) NOT NULL,
    recipient_id uuid,
    title character varying(200) NOT NULL,
    message text NOT NULL,
    data jsonb,
    status character varying(32) DEFAULT 'unread'::character varying NOT NULL,
    priority character varying(32) DEFAULT 'normal'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    read_at timestamp without time zone,
    dismissed_at timestamp without time zone
);


ALTER TABLE public.pronto_notifications OWNER TO pronto;

--
-- Name: pronto_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_notifications_id_seq OWNER TO pronto;

--
-- Name: pronto_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_notifications_id_seq OWNED BY public.pronto_notifications.id;


--
-- Name: pronto_order_item_modifiers; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_order_item_modifiers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    order_item_id uuid NOT NULL,
    modifier_id uuid NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    unit_price_adjustment numeric(10,2) DEFAULT 0 NOT NULL
);


ALTER TABLE public.pronto_order_item_modifiers OWNER TO pronto;

--
-- Name: pronto_order_items; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_order_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    order_id uuid,
    menu_item_id uuid,
    quantity integer DEFAULT 1 NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    total_price numeric(10,2) NOT NULL,
    modifiers jsonb,
    special_instructions text,
    status character varying(20) DEFAULT 'pending'::character varying,
    delivered_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    delivered_quantity integer DEFAULT 0 NOT NULL,
    is_fully_delivered boolean DEFAULT false NOT NULL,
    delivered_by_employee_id uuid
);


ALTER TABLE public.pronto_order_items OWNER TO pronto;

--
-- Name: pronto_order_modifications; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_order_modifications (
    id integer NOT NULL,
    order_id uuid NOT NULL,
    initiated_by_role character varying(32) NOT NULL,
    initiated_by_customer_id uuid,
    initiated_by_employee_id uuid,
    status character varying(32) DEFAULT 'pending'::character varying NOT NULL,
    changes_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    reviewed_by_customer_id uuid,
    reviewed_by_employee_id uuid,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    reviewed_at timestamp without time zone,
    applied_at timestamp without time zone
);


ALTER TABLE public.pronto_order_modifications OWNER TO pronto;

--
-- Name: pronto_order_modifications_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_order_modifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_order_modifications_id_seq OWNER TO pronto;

--
-- Name: pronto_order_modifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_order_modifications_id_seq OWNED BY public.pronto_order_modifications.id;


--
-- Name: pronto_order_status_history; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_order_status_history (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    order_id uuid NOT NULL,
    status character varying(20) NOT NULL,
    changed_at timestamp with time zone DEFAULT now(),
    changed_by uuid,
    notes text
);


ALTER TABLE public.pronto_order_status_history OWNER TO pronto;

--
-- Name: pronto_order_status_labels; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_order_status_labels (
    status_key character varying(50) NOT NULL,
    client_label character varying(100),
    employee_label character varying(100),
    admin_desc text,
    updated_at timestamp with time zone DEFAULT now(),
    updated_by_emp_id uuid,
    version integer DEFAULT 1
);


ALTER TABLE public.pronto_order_status_labels OWNER TO pronto;

--
-- Name: pronto_orders_order_number_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_orders_order_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;


ALTER SEQUENCE public.pronto_orders_order_number_seq OWNER TO pronto;

--
-- Name: pronto_orders; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_orders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    session_id uuid,
    customer_id uuid,
    employee_id uuid,
    order_number bigint DEFAULT nextval('public.pronto_orders_order_number_seq'::regclass) NOT NULL,
    order_type character varying(20) DEFAULT 'dine-in'::character varying,
    status character varying(20) DEFAULT 'pending'::character varying,
    subtotal numeric(12,2) DEFAULT 0.00,
    tax_amount numeric(12,2) DEFAULT 0.00,
    discount_amount numeric(12,2) DEFAULT 0.00,
    total numeric(12,2) DEFAULT 0.00,
    notes text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    anonymous_client_id character varying(36),
    workflow_status character varying(20) DEFAULT 'queued'::character varying NOT NULL,
    customer_email character varying(255),
    payment_status character varying(20) DEFAULT 'pending'::character varying,
    payment_method character varying(50),
    payment_reference character varying(100),
    payment_meta jsonb,
    total_amount numeric(12,2) DEFAULT 0.00,
    tip_amount numeric(12,2) DEFAULT 0.00,
    waiter_id uuid,
    chef_id uuid,
    delivery_waiter_id uuid,
    accepted_at timestamp with time zone,
    waiter_accepted_at timestamp with time zone,
    chef_accepted_at timestamp with time zone,
    ready_at timestamp with time zone,
    delivered_at timestamp with time zone,
    check_requested_at timestamp with time zone,
    feedback_requested_at timestamp with time zone,
    feedback_completed_at timestamp with time zone,
    paid_at timestamp with time zone,
    CONSTRAINT ck_pronto_orders_order_number_range CHECK (((order_number >= 1) AND (order_number <= '9999999999'::bigint)))
);


ALTER TABLE public.pronto_orders OWNER TO pronto;

--
-- Name: COLUMN pronto_orders.anonymous_client_id; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_orders.anonymous_client_id IS 'UUID identifier for anonymous/guest client orders';


--
-- Name: pronto_payments; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    session_id uuid NOT NULL,
    amount numeric(10,2) NOT NULL,
    method character varying(32) NOT NULL,
    reference character varying(128),
    created_at timestamp with time zone DEFAULT now(),
    created_by uuid
);


ALTER TABLE public.pronto_payments OWNER TO pronto;

--
-- Name: pronto_product_label_map; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_product_label_map (
    product_id uuid NOT NULL,
    label_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_product_label_map OWNER TO pronto;

--
-- Name: pronto_product_labels; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_product_labels (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(120) NOT NULL,
    slug character varying(120) NOT NULL,
    label_type character varying(24) DEFAULT 'badge'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    is_quick_filter boolean DEFAULT false NOT NULL,
    quick_filter_sort_order integer DEFAULT 0 NOT NULL,
    revision integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_product_labels_type CHECK (((label_type)::text = ANY ((ARRAY['promo'::character varying, 'badge'::character varying, 'collection'::character varying])::text[])))
);


ALTER TABLE public.pronto_product_labels OWNER TO pronto;

--
-- Name: pronto_product_schedules; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_product_schedules (
    id integer NOT NULL,
    menu_item_id uuid NOT NULL,
    day_of_week integer,
    start_time character varying(5),
    end_time character varying(5),
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT pronto_product_schedules_day_of_week_check CHECK (((day_of_week >= 0) AND (day_of_week <= 6)))
);


ALTER TABLE public.pronto_product_schedules OWNER TO pronto;

--
-- Name: pronto_product_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_product_schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_product_schedules_id_seq OWNER TO pronto;

--
-- Name: pronto_product_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_product_schedules_id_seq OWNED BY public.pronto_product_schedules.id;


--
-- Name: pronto_promotions; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_promotions (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    promotion_type character varying(50) DEFAULT 'percentage'::character varying NOT NULL,
    discount_percentage numeric(5,2),
    discount_amount numeric(10,2),
    valid_from timestamp without time zone,
    valid_until timestamp without time zone,
    applies_to character varying(50) DEFAULT 'all'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_promotions OWNER TO pronto;

--
-- Name: pronto_promotions_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_promotions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_promotions_id_seq OWNER TO pronto;

--
-- Name: pronto_promotions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_promotions_id_seq OWNED BY public.pronto_promotions.id;


--
-- Name: pronto_realtime_events; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_realtime_events (
    id integer NOT NULL,
    event_type character varying(100) NOT NULL,
    payload text,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_realtime_events OWNER TO pronto;

--
-- Name: pronto_realtime_events_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_realtime_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_realtime_events_id_seq OWNER TO pronto;

--
-- Name: pronto_realtime_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_realtime_events_id_seq OWNED BY public.pronto_realtime_events.id;


--
-- Name: pronto_recommendation_change_log; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_recommendation_change_log (
    id integer NOT NULL,
    menu_item_id uuid NOT NULL,
    period_key character varying(50) NOT NULL,
    action character varying(20) NOT NULL,
    employee_id uuid,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_recommendation_change_log OWNER TO pronto;

--
-- Name: pronto_recommendation_change_log_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_recommendation_change_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_recommendation_change_log_id_seq OWNER TO pronto;

--
-- Name: pronto_recommendation_change_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_recommendation_change_log_id_seq OWNED BY public.pronto_recommendation_change_log.id;


--
-- Name: pronto_role_permission_bindings; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_role_permission_bindings (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.pronto_role_permission_bindings OWNER TO pronto;

--
-- Name: pronto_schema_migrations; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_schema_migrations (
    file_name text NOT NULL,
    sha256 text NOT NULL,
    sql_norm_sha text NOT NULL,
    executed_at timestamp with time zone DEFAULT now() NOT NULL,
    status text NOT NULL,
    error text,
    executed_by text,
    app_version text,
    git_sha text,
    sql_head_sha text,
    CONSTRAINT pronto_schema_migrations_status_check CHECK ((status = ANY (ARRAY['applied'::text, 'failed'::text])))
);


ALTER TABLE public.pronto_schema_migrations OWNER TO pronto;

--
-- Name: pronto_secrets; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_secrets (
    id integer NOT NULL,
    secret_key character varying(120) NOT NULL,
    secret_value text NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_secrets OWNER TO pronto;

--
-- Name: pronto_secrets_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_secrets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_secrets_id_seq OWNER TO pronto;

--
-- Name: pronto_secrets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_secrets_id_seq OWNED BY public.pronto_secrets.id;


--
-- Name: pronto_split_bill_assignments; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_split_bill_assignments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    split_bill_id uuid NOT NULL,
    person_id uuid NOT NULL,
    order_item_id uuid NOT NULL,
    quantity_portion numeric(10,2) DEFAULT 1.0 NOT NULL,
    amount numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_split_bill_assignments OWNER TO pronto;

--
-- Name: pronto_split_bill_people; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_split_bill_people (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    split_bill_id uuid NOT NULL,
    person_name character varying(100) NOT NULL,
    person_number integer NOT NULL,
    subtotal numeric(10,2) DEFAULT 0 NOT NULL,
    tax_amount numeric(10,2) DEFAULT 0 NOT NULL,
    tip_amount numeric(10,2) DEFAULT 0 NOT NULL,
    total_amount numeric(10,2) DEFAULT 0 NOT NULL,
    payment_status character varying(32) DEFAULT 'unpaid'::character varying NOT NULL,
    customer_email character varying(255),
    payment_method character varying(32),
    payment_reference character varying(128),
    paid_at timestamp without time zone
);


ALTER TABLE public.pronto_split_bill_people OWNER TO pronto;

--
-- Name: pronto_split_bills; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_split_bills (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    session_id uuid NOT NULL,
    split_type character varying(32) DEFAULT 'by_items'::character varying NOT NULL,
    status character varying(32) DEFAULT 'active'::character varying NOT NULL,
    number_of_people integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    completed_at timestamp without time zone
);


ALTER TABLE public.pronto_split_bills OWNER TO pronto;

--
-- Name: pronto_super_admin_handoff_tokens; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_super_admin_handoff_tokens (
    id integer NOT NULL,
    token character varying(64) NOT NULL,
    employee_id uuid NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    is_used boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_super_admin_handoff_tokens OWNER TO pronto;

--
-- Name: pronto_super_admin_handoff_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_super_admin_handoff_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_super_admin_handoff_tokens_id_seq OWNER TO pronto;

--
-- Name: pronto_super_admin_handoff_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_super_admin_handoff_tokens_id_seq OWNED BY public.pronto_super_admin_handoff_tokens.id;


--
-- Name: pronto_support_tickets; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_support_tickets (
    id integer NOT NULL,
    channel character varying(32) DEFAULT 'client'::character varying NOT NULL,
    name_encrypted text NOT NULL,
    email_encrypted text NOT NULL,
    description_encrypted text NOT NULL,
    page_url character varying(255),
    user_agent character varying(255),
    status character varying(32) DEFAULT 'open'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    resolved_at timestamp without time zone
);


ALTER TABLE public.pronto_support_tickets OWNER TO pronto;

--
-- Name: pronto_support_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_support_tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_support_tickets_id_seq OWNER TO pronto;

--
-- Name: pronto_support_tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_support_tickets_id_seq OWNED BY public.pronto_support_tickets.id;


--
-- Name: pronto_system_permissions; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_system_permissions (
    id integer NOT NULL,
    code character varying(64) NOT NULL,
    category character varying(32) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_system_permissions OWNER TO pronto;

--
-- Name: pronto_system_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_system_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_system_permissions_id_seq OWNER TO pronto;

--
-- Name: pronto_system_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_system_permissions_id_seq OWNED BY public.pronto_system_permissions.id;


--
-- Name: pronto_system_roles; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_system_roles (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    display_name character varying(120) NOT NULL,
    description text,
    is_custom boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pronto_system_roles OWNER TO pronto;

--
-- Name: pronto_system_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_system_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_system_roles_id_seq OWNER TO pronto;

--
-- Name: pronto_system_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_system_roles_id_seq OWNED BY public.pronto_system_roles.id;


--
-- Name: pronto_system_settings; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_system_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    key character varying(100) NOT NULL,
    value text NOT NULL,
    value_type character varying(20) DEFAULT 'string'::character varying NOT NULL,
    description text,
    category character varying(50) DEFAULT 'general'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    display_name character varying(255),
    min_value double precision,
    max_value double precision,
    unit character varying(32),
    updated_by integer,
    is_public boolean DEFAULT false
);


ALTER TABLE public.pronto_system_settings OWNER TO pronto;

--
-- Name: TABLE pronto_system_settings; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON TABLE public.pronto_system_settings IS 'Tabla de configuración de settings del sistema';


--
-- Name: COLUMN pronto_system_settings.key; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_system_settings.key IS 'Clave única del setting';


--
-- Name: COLUMN pronto_system_settings.value_type; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_system_settings.value_type IS 'Tipo de valor: string, integer, boolean, etc.';


--
-- Name: COLUMN pronto_system_settings.category; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_system_settings.category IS 'Categoría del setting (general, menu, checkout, etc.)';


--
-- Name: pronto_table_log; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_table_log (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    table_id uuid,
    session_id uuid,
    action character varying(50) NOT NULL,
    previous_value text,
    new_value text,
    employee_id uuid,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.pronto_table_log OWNER TO pronto;

--
-- Name: pronto_table_transfer_requests; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_table_transfer_requests (
    id integer NOT NULL,
    table_id uuid NOT NULL,
    from_waiter_id uuid NOT NULL,
    to_waiter_id uuid NOT NULL,
    status character varying(32) DEFAULT 'pending'::character varying NOT NULL,
    transfer_orders boolean DEFAULT false NOT NULL,
    message text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    resolved_at timestamp without time zone,
    resolved_by_employee_id uuid
);


ALTER TABLE public.pronto_table_transfer_requests OWNER TO pronto;

--
-- Name: pronto_table_transfer_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_table_transfer_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_table_transfer_requests_id_seq OWNER TO pronto;

--
-- Name: pronto_table_transfer_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_table_transfer_requests_id_seq OWNED BY public.pronto_table_transfer_requests.id;


--
-- Name: pronto_tables; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_tables (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    table_number character varying(20) NOT NULL,
    capacity integer DEFAULT 4,
    status character varying(20) DEFAULT 'available'::character varying,
    current_session_id uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    qr_code character varying(100),
    position_x integer,
    position_y integer,
    shape character varying(32) DEFAULT 'square'::character varying,
    notes text,
    is_active boolean DEFAULT true NOT NULL,
    area_id integer NOT NULL
);


ALTER TABLE public.pronto_tables OWNER TO pronto;

--
-- Name: TABLE pronto_tables; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON TABLE public.pronto_tables IS 'Mesas del restaurante';


--
-- Name: COLUMN pronto_tables.qr_code; Type: COMMENT; Schema: public; Owner: pronto
--

COMMENT ON COLUMN public.pronto_tables.qr_code IS 'Código QR único para la mesa';


--
-- Name: pronto_waiter_calls; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_waiter_calls (
    id integer NOT NULL,
    session_id uuid,
    table_number character varying(32),
    status character varying(32) DEFAULT 'pending'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    confirmed_at timestamp without time zone,
    confirmed_by uuid,
    cancelled_at timestamp without time zone,
    notes text
);


ALTER TABLE public.pronto_waiter_calls OWNER TO pronto;

--
-- Name: pronto_waiter_calls_id_seq; Type: SEQUENCE; Schema: public; Owner: pronto
--

CREATE SEQUENCE public.pronto_waiter_calls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pronto_waiter_calls_id_seq OWNER TO pronto;

--
-- Name: pronto_waiter_calls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pronto
--

ALTER SEQUENCE public.pronto_waiter_calls_id_seq OWNED BY public.pronto_waiter_calls.id;


--
-- Name: pronto_waiter_table_assignments; Type: TABLE; Schema: public; Owner: pronto
--

CREATE TABLE public.pronto_waiter_table_assignments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    waiter_id uuid NOT NULL,
    table_id uuid NOT NULL,
    assigned_at timestamp with time zone DEFAULT now(),
    unassigned_at timestamp with time zone,
    is_active boolean DEFAULT true,
    notes text
);


ALTER TABLE public.pronto_waiter_table_assignments OWNER TO pronto;

--
-- Name: pronto_areas id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_areas ALTER COLUMN id SET DEFAULT nextval('public.pronto_areas_id_seq'::regclass);


--
-- Name: pronto_audit_logs id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_audit_logs ALTER COLUMN id SET DEFAULT nextval('public.pronto_audit_logs_id_seq'::regclass);


--
-- Name: pronto_business_config id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_business_config ALTER COLUMN id SET DEFAULT nextval('public.pronto_business_config_id_seq'::regclass);


--
-- Name: pronto_business_info id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_business_info ALTER COLUMN id SET DEFAULT nextval('public.pronto_business_info_id_seq'::regclass);


--
-- Name: pronto_discount_codes id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_discount_codes ALTER COLUMN id SET DEFAULT nextval('public.pronto_discount_codes_id_seq'::regclass);


--
-- Name: pronto_feedback_questions id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_feedback_questions ALTER COLUMN id SET DEFAULT nextval('public.pronto_feedback_questions_id_seq'::regclass);


--
-- Name: pronto_init_runs run_id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_init_runs ALTER COLUMN run_id SET DEFAULT nextval('public.pronto_init_runs_run_id_seq'::regclass);


--
-- Name: pronto_keyboard_shortcuts id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_keyboard_shortcuts ALTER COLUMN id SET DEFAULT nextval('public.pronto_keyboard_shortcuts_id_seq'::regclass);


--
-- Name: pronto_menu_item_day_periods id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_item_day_periods ALTER COLUMN id SET DEFAULT nextval('public.pronto_menu_item_day_periods_id_seq'::regclass);


--
-- Name: pronto_notifications id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_notifications ALTER COLUMN id SET DEFAULT nextval('public.pronto_notifications_id_seq'::regclass);


--
-- Name: pronto_order_modifications id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_modifications ALTER COLUMN id SET DEFAULT nextval('public.pronto_order_modifications_id_seq'::regclass);


--
-- Name: pronto_product_schedules id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_product_schedules ALTER COLUMN id SET DEFAULT nextval('public.pronto_product_schedules_id_seq'::regclass);


--
-- Name: pronto_promotions id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_promotions ALTER COLUMN id SET DEFAULT nextval('public.pronto_promotions_id_seq'::regclass);


--
-- Name: pronto_realtime_events id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_realtime_events ALTER COLUMN id SET DEFAULT nextval('public.pronto_realtime_events_id_seq'::regclass);


--
-- Name: pronto_recommendation_change_log id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_recommendation_change_log ALTER COLUMN id SET DEFAULT nextval('public.pronto_recommendation_change_log_id_seq'::regclass);


--
-- Name: pronto_secrets id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_secrets ALTER COLUMN id SET DEFAULT nextval('public.pronto_secrets_id_seq'::regclass);


--
-- Name: pronto_super_admin_handoff_tokens id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_super_admin_handoff_tokens ALTER COLUMN id SET DEFAULT nextval('public.pronto_super_admin_handoff_tokens_id_seq'::regclass);


--
-- Name: pronto_support_tickets id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_support_tickets ALTER COLUMN id SET DEFAULT nextval('public.pronto_support_tickets_id_seq'::regclass);


--
-- Name: pronto_system_permissions id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_system_permissions ALTER COLUMN id SET DEFAULT nextval('public.pronto_system_permissions_id_seq'::regclass);


--
-- Name: pronto_system_roles id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_system_roles ALTER COLUMN id SET DEFAULT nextval('public.pronto_system_roles_id_seq'::regclass);


--
-- Name: pronto_table_transfer_requests id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_table_transfer_requests ALTER COLUMN id SET DEFAULT nextval('public.pronto_table_transfer_requests_id_seq'::regclass);


--
-- Name: pronto_waiter_calls id; Type: DEFAULT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_waiter_calls ALTER COLUMN id SET DEFAULT nextval('public.pronto_waiter_calls_id_seq'::regclass);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: branding_config branding_config_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.branding_config
    ADD CONSTRAINT branding_config_pkey PRIMARY KEY (id);


--
-- Name: customer_sessions customer_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.customer_sessions
    ADD CONSTRAINT customer_sessions_pkey PRIMARY KEY (customer_ref);


--
-- Name: pronto_areas pronto_areas_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_areas
    ADD CONSTRAINT pronto_areas_pkey PRIMARY KEY (id);


--
-- Name: pronto_audit_logs pronto_audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_audit_logs
    ADD CONSTRAINT pronto_audit_logs_pkey PRIMARY KEY (id);


--
-- Name: pronto_business_config pronto_business_config_config_key_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_business_config
    ADD CONSTRAINT pronto_business_config_config_key_key UNIQUE (config_key);


--
-- Name: pronto_business_config pronto_business_config_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_business_config
    ADD CONSTRAINT pronto_business_config_pkey PRIMARY KEY (id);


--
-- Name: pronto_business_info pronto_business_info_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_business_info
    ADD CONSTRAINT pronto_business_info_pkey PRIMARY KEY (id);


--
-- Name: pronto_business_info pronto_business_info_restaurant_slug_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_business_info
    ADD CONSTRAINT pronto_business_info_restaurant_slug_key UNIQUE (restaurant_slug);


--
-- Name: pronto_business_schedule pronto_business_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_business_schedule
    ADD CONSTRAINT pronto_business_schedule_pkey PRIMARY KEY (id);


--
-- Name: pronto_customers pronto_customers_anon_id_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_customers
    ADD CONSTRAINT pronto_customers_anon_id_key UNIQUE (anon_id);


--
-- Name: pronto_customers pronto_customers_email_hash_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_customers
    ADD CONSTRAINT pronto_customers_email_hash_key UNIQUE (email_hash);


--
-- Name: pronto_customers pronto_customers_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_customers
    ADD CONSTRAINT pronto_customers_pkey PRIMARY KEY (id);


--
-- Name: pronto_day_periods pronto_day_periods_period_key_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_day_periods
    ADD CONSTRAINT pronto_day_periods_period_key_key UNIQUE (period_key);


--
-- Name: pronto_day_periods pronto_day_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_day_periods
    ADD CONSTRAINT pronto_day_periods_pkey PRIMARY KEY (id);


--
-- Name: pronto_dining_sessions pronto_dining_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_dining_sessions
    ADD CONSTRAINT pronto_dining_sessions_pkey PRIMARY KEY (id);


--
-- Name: pronto_discount_codes pronto_discount_codes_code_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_discount_codes
    ADD CONSTRAINT pronto_discount_codes_code_key UNIQUE (code);


--
-- Name: pronto_discount_codes pronto_discount_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_discount_codes
    ADD CONSTRAINT pronto_discount_codes_pkey PRIMARY KEY (id);


--
-- Name: pronto_employee_preferences pronto_employee_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_employee_preferences
    ADD CONSTRAINT pronto_employee_preferences_pkey PRIMARY KEY (employee_id, key);


--
-- Name: pronto_employees pronto_employees_email_hash_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_employees
    ADD CONSTRAINT pronto_employees_email_hash_key UNIQUE (email_hash);


--
-- Name: pronto_employees pronto_employees_email_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_employees
    ADD CONSTRAINT pronto_employees_email_key UNIQUE (email);


--
-- Name: pronto_employees pronto_employees_employee_code_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_employees
    ADD CONSTRAINT pronto_employees_employee_code_key UNIQUE (employee_code);


--
-- Name: pronto_employees pronto_employees_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_employees
    ADD CONSTRAINT pronto_employees_pkey PRIMARY KEY (id);


--
-- Name: pronto_feedback pronto_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_feedback
    ADD CONSTRAINT pronto_feedback_pkey PRIMARY KEY (id);


--
-- Name: pronto_feedback_questions pronto_feedback_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_feedback_questions
    ADD CONSTRAINT pronto_feedback_questions_pkey PRIMARY KEY (id);


--
-- Name: pronto_feedback_tokens pronto_feedback_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_feedback_tokens
    ADD CONSTRAINT pronto_feedback_tokens_pkey PRIMARY KEY (id);


--
-- Name: pronto_feedback_tokens pronto_feedback_tokens_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_feedback_tokens
    ADD CONSTRAINT pronto_feedback_tokens_token_hash_key UNIQUE (token_hash);


--
-- Name: pronto_init_runs pronto_init_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_init_runs
    ADD CONSTRAINT pronto_init_runs_pkey PRIMARY KEY (run_id);


--
-- Name: pronto_invoices pronto_invoices_cfdi_uuid_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_invoices
    ADD CONSTRAINT pronto_invoices_cfdi_uuid_key UNIQUE (cfdi_uuid);


--
-- Name: pronto_invoices pronto_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_invoices
    ADD CONSTRAINT pronto_invoices_pkey PRIMARY KEY (id);


--
-- Name: pronto_keyboard_shortcuts pronto_keyboard_shortcuts_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_keyboard_shortcuts
    ADD CONSTRAINT pronto_keyboard_shortcuts_pkey PRIMARY KEY (id);


--
-- Name: pronto_kitchen_orders pronto_kitchen_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_kitchen_orders
    ADD CONSTRAINT pronto_kitchen_orders_pkey PRIMARY KEY (id);


--
-- Name: pronto_menu_categories pronto_menu_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_categories
    ADD CONSTRAINT pronto_menu_categories_pkey PRIMARY KEY (id);


--
-- Name: pronto_menu_home_module_products pronto_menu_home_module_products_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_home_module_products
    ADD CONSTRAINT pronto_menu_home_module_products_pkey PRIMARY KEY (module_id, product_id);


--
-- Name: pronto_menu_home_modules pronto_menu_home_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_home_modules
    ADD CONSTRAINT pronto_menu_home_modules_pkey PRIMARY KEY (id);


--
-- Name: pronto_menu_home_publication_state pronto_menu_home_publication_state_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_home_publication_state
    ADD CONSTRAINT pronto_menu_home_publication_state_pkey PRIMARY KEY (placement);


--
-- Name: pronto_menu_home_snapshots pronto_menu_home_snapshots_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_home_snapshots
    ADD CONSTRAINT pronto_menu_home_snapshots_pkey PRIMARY KEY (id);


--
-- Name: pronto_menu_item_day_periods pronto_menu_item_day_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_item_day_periods
    ADD CONSTRAINT pronto_menu_item_day_periods_pkey PRIMARY KEY (id);


--
-- Name: pronto_menu_item_modifier_groups pronto_menu_item_modifier_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_item_modifier_groups
    ADD CONSTRAINT pronto_menu_item_modifier_groups_pkey PRIMARY KEY (menu_item_id, modifier_group_id);


--
-- Name: pronto_menu_items pronto_menu_items_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_items
    ADD CONSTRAINT pronto_menu_items_pkey PRIMARY KEY (id);


--
-- Name: pronto_menu_subcategories pronto_menu_subcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_subcategories
    ADD CONSTRAINT pronto_menu_subcategories_pkey PRIMARY KEY (id);


--
-- Name: pronto_modifier_groups pronto_modifier_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_modifier_groups
    ADD CONSTRAINT pronto_modifier_groups_pkey PRIMARY KEY (id);


--
-- Name: pronto_modifiers pronto_modifiers_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_modifiers
    ADD CONSTRAINT pronto_modifiers_pkey PRIMARY KEY (id);


--
-- Name: pronto_notifications pronto_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_notifications
    ADD CONSTRAINT pronto_notifications_pkey PRIMARY KEY (id);


--
-- Name: pronto_order_item_modifiers pronto_order_item_modifiers_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_item_modifiers
    ADD CONSTRAINT pronto_order_item_modifiers_pkey PRIMARY KEY (id);


--
-- Name: pronto_order_items pronto_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_items
    ADD CONSTRAINT pronto_order_items_pkey PRIMARY KEY (id);


--
-- Name: pronto_order_modifications pronto_order_modifications_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_modifications
    ADD CONSTRAINT pronto_order_modifications_pkey PRIMARY KEY (id);


--
-- Name: pronto_order_status_history pronto_order_status_history_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_status_history
    ADD CONSTRAINT pronto_order_status_history_pkey PRIMARY KEY (id);


--
-- Name: pronto_order_status_labels pronto_order_status_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_status_labels
    ADD CONSTRAINT pronto_order_status_labels_pkey PRIMARY KEY (status_key);


--
-- Name: pronto_orders pronto_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_orders
    ADD CONSTRAINT pronto_orders_pkey PRIMARY KEY (id);


--
-- Name: pronto_payments pronto_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_payments
    ADD CONSTRAINT pronto_payments_pkey PRIMARY KEY (id);


--
-- Name: pronto_product_label_map pronto_product_label_map_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_product_label_map
    ADD CONSTRAINT pronto_product_label_map_pkey PRIMARY KEY (product_id, label_id);


--
-- Name: pronto_product_labels pronto_product_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_product_labels
    ADD CONSTRAINT pronto_product_labels_pkey PRIMARY KEY (id);


--
-- Name: pronto_product_schedules pronto_product_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_product_schedules
    ADD CONSTRAINT pronto_product_schedules_pkey PRIMARY KEY (id);


--
-- Name: pronto_promotions pronto_promotions_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_promotions
    ADD CONSTRAINT pronto_promotions_pkey PRIMARY KEY (id);


--
-- Name: pronto_realtime_events pronto_realtime_events_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_realtime_events
    ADD CONSTRAINT pronto_realtime_events_pkey PRIMARY KEY (id);


--
-- Name: pronto_recommendation_change_log pronto_recommendation_change_log_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_recommendation_change_log
    ADD CONSTRAINT pronto_recommendation_change_log_pkey PRIMARY KEY (id);


--
-- Name: pronto_role_permission_bindings pronto_role_permission_bindings_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_role_permission_bindings
    ADD CONSTRAINT pronto_role_permission_bindings_pkey PRIMARY KEY (role_id, permission_id);


--
-- Name: pronto_schema_migrations pronto_schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_schema_migrations
    ADD CONSTRAINT pronto_schema_migrations_pkey PRIMARY KEY (file_name);


--
-- Name: pronto_secrets pronto_secrets_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_secrets
    ADD CONSTRAINT pronto_secrets_pkey PRIMARY KEY (id);


--
-- Name: pronto_secrets pronto_secrets_secret_key_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_secrets
    ADD CONSTRAINT pronto_secrets_secret_key_key UNIQUE (secret_key);


--
-- Name: pronto_split_bill_assignments pronto_split_bill_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_split_bill_assignments
    ADD CONSTRAINT pronto_split_bill_assignments_pkey PRIMARY KEY (id);


--
-- Name: pronto_split_bill_people pronto_split_bill_people_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_split_bill_people
    ADD CONSTRAINT pronto_split_bill_people_pkey PRIMARY KEY (id);


--
-- Name: pronto_split_bills pronto_split_bills_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_split_bills
    ADD CONSTRAINT pronto_split_bills_pkey PRIMARY KEY (id);


--
-- Name: pronto_super_admin_handoff_tokens pronto_super_admin_handoff_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_super_admin_handoff_tokens
    ADD CONSTRAINT pronto_super_admin_handoff_tokens_pkey PRIMARY KEY (id);


--
-- Name: pronto_super_admin_handoff_tokens pronto_super_admin_handoff_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_super_admin_handoff_tokens
    ADD CONSTRAINT pronto_super_admin_handoff_tokens_token_key UNIQUE (token);


--
-- Name: pronto_support_tickets pronto_support_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_support_tickets
    ADD CONSTRAINT pronto_support_tickets_pkey PRIMARY KEY (id);


--
-- Name: pronto_system_permissions pronto_system_permissions_code_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_system_permissions
    ADD CONSTRAINT pronto_system_permissions_code_key UNIQUE (code);


--
-- Name: pronto_system_permissions pronto_system_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_system_permissions
    ADD CONSTRAINT pronto_system_permissions_pkey PRIMARY KEY (id);


--
-- Name: pronto_system_roles pronto_system_roles_name_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_system_roles
    ADD CONSTRAINT pronto_system_roles_name_key UNIQUE (name);


--
-- Name: pronto_system_roles pronto_system_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_system_roles
    ADD CONSTRAINT pronto_system_roles_pkey PRIMARY KEY (id);


--
-- Name: pronto_system_settings pronto_system_settings_key_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_system_settings
    ADD CONSTRAINT pronto_system_settings_key_key UNIQUE (key);


--
-- Name: pronto_system_settings pronto_system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_system_settings
    ADD CONSTRAINT pronto_system_settings_pkey PRIMARY KEY (id);


--
-- Name: pronto_table_log pronto_table_log_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_table_log
    ADD CONSTRAINT pronto_table_log_pkey PRIMARY KEY (id);


--
-- Name: pronto_table_transfer_requests pronto_table_transfer_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_table_transfer_requests
    ADD CONSTRAINT pronto_table_transfer_requests_pkey PRIMARY KEY (id);


--
-- Name: pronto_tables pronto_tables_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_tables
    ADD CONSTRAINT pronto_tables_pkey PRIMARY KEY (id);


--
-- Name: pronto_waiter_calls pronto_waiter_calls_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_waiter_calls
    ADD CONSTRAINT pronto_waiter_calls_pkey PRIMARY KEY (id);


--
-- Name: pronto_waiter_table_assignments pronto_waiter_table_assignment_waiter_id_table_id_is_active_key; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_waiter_table_assignments
    ADD CONSTRAINT pronto_waiter_table_assignment_waiter_id_table_id_is_active_key UNIQUE (waiter_id, table_id, is_active);


--
-- Name: pronto_waiter_table_assignments pronto_waiter_table_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_waiter_table_assignments
    ADD CONSTRAINT pronto_waiter_table_assignments_pkey PRIMARY KEY (id);


--
-- Name: pronto_menu_home_modules uq_menu_home_modules_slug; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_home_modules
    ADD CONSTRAINT uq_menu_home_modules_slug UNIQUE (slug);


--
-- Name: pronto_menu_home_snapshots uq_menu_home_snapshot_revision; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_home_snapshots
    ADD CONSTRAINT uq_menu_home_snapshot_revision UNIQUE (placement, revision);


--
-- Name: pronto_menu_home_snapshots uq_menu_home_snapshot_version; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_home_snapshots
    ADD CONSTRAINT uq_menu_home_snapshot_version UNIQUE (placement, version);


--
-- Name: pronto_menu_item_day_periods uq_menu_item_period_tag; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_item_day_periods
    ADD CONSTRAINT uq_menu_item_period_tag UNIQUE (menu_item_id, period_id, tag_type);


--
-- Name: pronto_menu_subcategories uq_menu_subcategories_category_slug; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_subcategories
    ADD CONSTRAINT uq_menu_subcategories_category_slug UNIQUE (menu_category_id, slug);


--
-- Name: pronto_product_labels uq_product_labels_slug; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_product_labels
    ADD CONSTRAINT uq_product_labels_slug UNIQUE (slug);


--
-- Name: pronto_keyboard_shortcuts uq_shortcut_combo; Type: CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_keyboard_shortcuts
    ADD CONSTRAINT uq_shortcut_combo UNIQUE (combo);


--
-- Name: idx_business_info_active; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_business_info_active ON public.pronto_business_info USING btree (is_active);


--
-- Name: idx_business_info_slug; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_business_info_slug ON public.pronto_business_info USING btree (restaurant_slug);


--
-- Name: idx_customer_sessions_customer_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_customer_sessions_customer_id ON public.customer_sessions USING btree (customer_id);


--
-- Name: idx_customer_sessions_last_seen_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_customer_sessions_last_seen_at ON public.customer_sessions USING btree (last_seen_at);


--
-- Name: idx_customers_anon_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_customers_anon_id ON public.pronto_customers USING btree (anon_id);


--
-- Name: idx_customers_facturapi_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_customers_facturapi_id ON public.pronto_customers USING btree (facturapi_customer_id);


--
-- Name: idx_employees_role_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_employees_role_status ON public.pronto_employees USING btree (role, status);


--
-- Name: idx_menu_category_display_order; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_menu_category_display_order ON public.pronto_menu_categories USING btree (display_order);


--
-- Name: idx_menu_item_modifier_groups_menu_item; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_menu_item_modifier_groups_menu_item ON public.pronto_menu_item_modifier_groups USING btree (menu_item_id);


--
-- Name: idx_menu_item_modifier_groups_modifier_group; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_menu_item_modifier_groups_modifier_group ON public.pronto_menu_item_modifier_groups USING btree (modifier_group_id);


--
-- Name: idx_menu_items_category; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_menu_items_category ON public.pronto_menu_items USING btree (category_id);


--
-- Name: idx_menu_items_name; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_menu_items_name ON public.pronto_menu_items USING btree (name);


--
-- Name: idx_order_status_history_order_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_order_status_history_order_id ON public.pronto_order_status_history USING btree (order_id);


--
-- Name: idx_orders_anonymous_client_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_orders_anonymous_client_id ON public.pronto_orders USING btree (anonymous_client_id);


--
-- Name: idx_orders_chef_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_orders_chef_id ON public.pronto_orders USING btree (chef_id) WHERE (chef_id IS NOT NULL);


--
-- Name: idx_orders_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_orders_created_at ON public.pronto_orders USING btree (created_at DESC);


--
-- Name: idx_orders_customer_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_orders_customer_id ON public.pronto_orders USING btree (customer_id);


--
-- Name: idx_pronto_business_info_updated_by; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_business_info_updated_by ON public.pronto_business_info USING btree (updated_by);


--
-- Name: idx_pronto_dining_sessions_customer_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_dining_sessions_customer_id ON public.pronto_dining_sessions USING btree (customer_id);


--
-- Name: idx_pronto_dining_sessions_employee_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_dining_sessions_employee_id ON public.pronto_dining_sessions USING btree (employee_id);


--
-- Name: idx_pronto_dining_sessions_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_dining_sessions_status ON public.pronto_dining_sessions USING btree (status);


--
-- Name: idx_pronto_dining_sessions_table; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_dining_sessions_table ON public.pronto_dining_sessions USING btree (table_id);


--
-- Name: idx_pronto_employees_code; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_employees_code ON public.pronto_employees USING btree (employee_code);


--
-- Name: idx_pronto_feedback_customer_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_feedback_customer_id ON public.pronto_feedback USING btree (customer_id);


--
-- Name: idx_pronto_kitchen_orders_order_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_kitchen_orders_order_id ON public.pronto_kitchen_orders USING btree (order_id);


--
-- Name: idx_pronto_kitchen_orders_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_kitchen_orders_status ON public.pronto_kitchen_orders USING btree (status);


--
-- Name: idx_pronto_menu_categories_parent_category_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_menu_categories_parent_category_id ON public.pronto_menu_categories USING btree (parent_category_id);


--
-- Name: idx_pronto_menu_items_available; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_menu_items_available ON public.pronto_menu_items USING btree (is_available);


--
-- Name: idx_pronto_menu_items_category; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_menu_items_category ON public.pronto_menu_items USING btree (category_id);


--
-- Name: idx_pronto_modifier_groups_menu_item_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_modifier_groups_menu_item_id ON public.pronto_modifier_groups USING btree (menu_item_id);


--
-- Name: idx_pronto_modifiers_group_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_modifiers_group_id ON public.pronto_modifiers USING btree (group_id);


--
-- Name: idx_pronto_order_items_delivered_by_employee_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_order_items_delivered_by_employee_id ON public.pronto_order_items USING btree (delivered_by_employee_id);


--
-- Name: idx_pronto_order_items_menu_item_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_order_items_menu_item_id ON public.pronto_order_items USING btree (menu_item_id);


--
-- Name: idx_pronto_order_status_history_changed_by; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_order_status_history_changed_by ON public.pronto_order_status_history USING btree (changed_by);


--
-- Name: idx_pronto_order_status_labels_updated_by_emp_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_order_status_labels_updated_by_emp_id ON public.pronto_order_status_labels USING btree (updated_by_emp_id);


--
-- Name: idx_pronto_orders_chef_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_orders_chef_id ON public.pronto_orders USING btree (chef_id);


--
-- Name: idx_pronto_orders_customer_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_orders_customer_id ON public.pronto_orders USING btree (customer_id);


--
-- Name: idx_pronto_orders_delivery_waiter_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_orders_delivery_waiter_id ON public.pronto_orders USING btree (delivery_waiter_id);


--
-- Name: idx_pronto_orders_employee_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_orders_employee_id ON public.pronto_orders USING btree (employee_id);


--
-- Name: idx_pronto_orders_session; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_orders_session ON public.pronto_orders USING btree (session_id);


--
-- Name: idx_pronto_orders_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_orders_status ON public.pronto_orders USING btree (status);


--
-- Name: idx_pronto_orders_waiter_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_orders_waiter_id ON public.pronto_orders USING btree (waiter_id);


--
-- Name: idx_pronto_recommendation_change_log_employee_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_recommendation_change_log_employee_id ON public.pronto_recommendation_change_log USING btree (employee_id);


--
-- Name: idx_pronto_table_log_employee_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_table_log_employee_id ON public.pronto_table_log USING btree (employee_id);


--
-- Name: idx_pronto_table_log_session_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_table_log_session_id ON public.pronto_table_log USING btree (session_id);


--
-- Name: idx_pronto_table_log_table_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_table_log_table_id ON public.pronto_table_log USING btree (table_id);


--
-- Name: idx_pronto_table_transfer_requests_resolved_by_employee_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_pronto_table_transfer_requests_resolved_by_employee_id ON public.pronto_table_transfer_requests USING btree (resolved_by_employee_id);


--
-- Name: idx_sessions_customer_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_sessions_customer_id ON public.pronto_dining_sessions USING btree (customer_id) WHERE (customer_id IS NOT NULL);


--
-- Name: idx_sessions_table_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_sessions_table_id ON public.pronto_dining_sessions USING btree (table_id) WHERE (table_id IS NOT NULL);


--
-- Name: idx_system_settings_category; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_system_settings_category ON public.pronto_system_settings USING btree (category);


--
-- Name: idx_system_settings_key; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX idx_system_settings_key ON public.pronto_system_settings USING btree (key);


--
-- Name: ix_area_active; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_area_active ON public.pronto_areas USING btree (is_active);


--
-- Name: ix_area_name; Type: INDEX; Schema: public; Owner: pronto
--

CREATE UNIQUE INDEX ix_area_name ON public.pronto_areas USING btree (name);


--
-- Name: ix_area_prefix; Type: INDEX; Schema: public; Owner: pronto
--

CREATE UNIQUE INDEX ix_area_prefix ON public.pronto_areas USING btree (prefix);


--
-- Name: ix_audit_action; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_audit_action ON public.audit_logs USING btree (action);


--
-- Name: ix_audit_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_audit_created_at ON public.audit_logs USING btree (created_at);


--
-- Name: ix_audit_employee_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_audit_employee_id ON public.audit_logs USING btree (employee_id);


--
-- Name: ix_audit_log_actor; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_audit_log_actor ON public.pronto_audit_logs USING btree (actor_id);


--
-- Name: ix_audit_log_changed_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_audit_log_changed_at ON public.pronto_audit_logs USING btree (changed_at);


--
-- Name: ix_audit_log_entity; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_audit_log_entity ON public.pronto_audit_logs USING btree (entity_type, entity_id);


--
-- Name: ix_business_schedule_day; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_business_schedule_day ON public.pronto_business_schedule USING btree (day_of_week);


--
-- Name: ix_customer_anon_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_customer_anon_id ON public.pronto_customers USING btree (anon_id);


--
-- Name: ix_customer_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_customer_created_at ON public.pronto_customers USING btree (created_at);


--
-- Name: ix_customer_email_hash; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_customer_email_hash ON public.pronto_customers USING btree (email_hash);


--
-- Name: ix_customer_email_normalized; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_customer_email_normalized ON public.pronto_customers USING btree (email_normalized);


--
-- Name: ix_customer_kind; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_customer_kind ON public.pronto_customers USING btree (kind);


--
-- Name: ix_customer_kiosk_location; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_customer_kiosk_location ON public.pronto_customers USING btree (kiosk_location) WHERE ((kind)::text = 'kiosk'::text);


--
-- Name: ix_customer_name_search; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_customer_name_search ON public.pronto_customers USING btree (name_search);


--
-- Name: ix_customer_phone_e164; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_customer_phone_e164 ON public.pronto_customers USING btree (phone_e164);


--
-- Name: ix_day_period_display_order; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_day_period_display_order ON public.pronto_day_periods USING btree (display_order);


--
-- Name: ix_dining_session_anon_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_dining_session_anon_id ON public.pronto_dining_sessions USING btree (anon_id);


--
-- Name: ix_dining_session_feedback_rating; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_dining_session_feedback_rating ON public.pronto_dining_sessions USING btree (feedback_rating) WHERE (feedback_rating IS NOT NULL);


--
-- Name: ix_discount_active_dates; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_discount_active_dates ON public.pronto_discount_codes USING btree (is_active, valid_from, valid_until);


--
-- Name: ix_discount_code; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_discount_code ON public.pronto_discount_codes USING btree (code);


--
-- Name: ix_employee_email_hash; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_employee_email_hash ON public.pronto_employees USING btree (email_hash);


--
-- Name: ix_employee_role_active; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_employee_role_active ON public.pronto_employees USING btree (role, status);


--
-- Name: ix_feedback_category; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_category ON public.pronto_feedback USING btree (category);


--
-- Name: ix_feedback_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_created_at ON public.pronto_feedback USING btree (created_at);


--
-- Name: ix_feedback_employee; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_employee ON public.pronto_feedback USING btree (employee_id);


--
-- Name: ix_feedback_question_enabled; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_question_enabled ON public.pronto_feedback_questions USING btree (is_enabled);


--
-- Name: ix_feedback_question_order; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_question_order ON public.pronto_feedback_questions USING btree (sort_order);


--
-- Name: ix_feedback_rating; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_rating ON public.pronto_feedback USING btree (rating);


--
-- Name: ix_feedback_session; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_session ON public.pronto_feedback USING btree (session_id);


--
-- Name: ix_feedback_token_expires; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_token_expires ON public.pronto_feedback_tokens USING btree (expires_at);


--
-- Name: ix_feedback_token_hash; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_token_hash ON public.pronto_feedback_tokens USING btree (token_hash);


--
-- Name: ix_feedback_token_order; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_token_order ON public.pronto_feedback_tokens USING btree (order_id);


--
-- Name: ix_feedback_token_session; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_token_session ON public.pronto_feedback_tokens USING btree (session_id);


--
-- Name: ix_feedback_token_used; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_token_used ON public.pronto_feedback_tokens USING btree (used_at);


--
-- Name: ix_feedback_token_user; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_feedback_token_user ON public.pronto_feedback_tokens USING btree (user_id);


--
-- Name: ix_handoff_token; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_handoff_token ON public.pronto_super_admin_handoff_tokens USING btree (token);


--
-- Name: ix_invoice_cfdi_uuid; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_invoice_cfdi_uuid ON public.pronto_invoices USING btree (cfdi_uuid);


--
-- Name: ix_invoice_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_invoice_created_at ON public.pronto_invoices USING btree (created_at);


--
-- Name: ix_invoice_customer_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_invoice_customer_id ON public.pronto_invoices USING btree (customer_id);


--
-- Name: ix_invoice_order_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_invoice_order_id ON public.pronto_invoices USING btree (order_id);


--
-- Name: ix_invoice_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_invoice_status ON public.pronto_invoices USING btree (status);


--
-- Name: ix_invoices_cfdi_uuid; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_invoices_cfdi_uuid ON public.pronto_invoices USING btree (cfdi_uuid);


--
-- Name: ix_invoices_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_invoices_created_at ON public.pronto_invoices USING btree (created_at);


--
-- Name: ix_invoices_customer_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_invoices_customer_id ON public.pronto_invoices USING btree (customer_id);


--
-- Name: ix_invoices_dining_session_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_invoices_dining_session_id ON public.pronto_invoices USING btree (dining_session_id);


--
-- Name: ix_invoices_facturapi_customer_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_invoices_facturapi_customer_id ON public.pronto_invoices USING btree (facturapi_customer_id);


--
-- Name: ix_invoices_facturapi_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_invoices_facturapi_id ON public.pronto_invoices USING btree (facturapi_id);


--
-- Name: ix_invoices_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_invoices_status ON public.pronto_invoices USING btree (status);


--
-- Name: ix_menu_categories_active_order; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_menu_categories_active_order ON public.pronto_menu_categories USING btree (is_active, sort_order, display_order);


--
-- Name: ix_menu_home_module_products_order; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_menu_home_module_products_order ON public.pronto_menu_home_module_products USING btree (module_id, sort_order);


--
-- Name: ix_menu_home_modules_placement_active_order; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_menu_home_modules_placement_active_order ON public.pronto_menu_home_modules USING btree (placement, is_active, sort_order);


--
-- Name: ix_menu_home_modules_source; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_menu_home_modules_source ON public.pronto_menu_home_modules USING btree (source_type, source_ref_id);


--
-- Name: ix_menu_item_period_menu; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_menu_item_period_menu ON public.pronto_menu_item_day_periods USING btree (menu_item_id);


--
-- Name: ix_menu_item_period_tag; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_menu_item_period_tag ON public.pronto_menu_item_day_periods USING btree (tag_type);


--
-- Name: ix_menu_items_structural_active_order; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_menu_items_structural_active_order ON public.pronto_menu_items USING btree (menu_category_id, menu_subcategory_id, is_active, sort_order);


--
-- Name: ix_menu_subcategories_category_active_order; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_menu_subcategories_category_active_order ON public.pronto_menu_subcategories USING btree (menu_category_id, is_active, sort_order);


--
-- Name: ix_notification_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_notification_created_at ON public.pronto_notifications USING btree (created_at);


--
-- Name: ix_notification_recipient_type_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_notification_recipient_type_status ON public.pronto_notifications USING btree (recipient_type, recipient_id, status);


--
-- Name: ix_notification_type; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_notification_type ON public.pronto_notifications USING btree (notification_type);


--
-- Name: ix_order_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_created_at ON public.pronto_orders USING btree (created_at);


--
-- Name: ix_order_customer_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_customer_id ON public.pronto_orders USING btree (customer_id);


--
-- Name: ix_order_item_delivery_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_item_delivery_status ON public.pronto_order_items USING btree (is_fully_delivered, delivered_at);


--
-- Name: ix_order_item_menu_item_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_item_menu_item_id ON public.pronto_order_items USING btree (menu_item_id);


--
-- Name: ix_order_item_modifier_item_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_item_modifier_item_id ON public.pronto_order_item_modifiers USING btree (order_item_id);


--
-- Name: ix_order_item_modifier_modifier_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_item_modifier_modifier_id ON public.pronto_order_item_modifiers USING btree (modifier_id);


--
-- Name: ix_order_item_order_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_item_order_id ON public.pronto_order_items USING btree (order_id);


--
-- Name: ix_order_items_order_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_items_order_id ON public.pronto_order_items USING btree (order_id);


--
-- Name: ix_order_modification_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_modification_created_at ON public.pronto_order_modifications USING btree (created_at);


--
-- Name: ix_order_modification_order; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_modification_order ON public.pronto_order_modifications USING btree (order_id);


--
-- Name: ix_order_modification_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_modification_status ON public.pronto_order_modifications USING btree (status);


--
-- Name: ix_order_session_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_session_id ON public.pronto_orders USING btree (session_id);


--
-- Name: ix_order_workflow_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_order_workflow_status ON public.pronto_orders USING btree (workflow_status);


--
-- Name: ix_orders_order_number; Type: INDEX; Schema: public; Owner: pronto
--

CREATE UNIQUE INDEX ix_orders_order_number ON public.pronto_orders USING btree (order_number);


--
-- Name: ix_orders_session_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_orders_session_id ON public.pronto_orders USING btree (session_id);


--
-- Name: ix_orders_workflow_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_orders_workflow_status ON public.pronto_orders USING btree (workflow_status);


--
-- Name: ix_product_label_map_label; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_product_label_map_label ON public.pronto_product_label_map USING btree (label_id);


--
-- Name: ix_product_schedule_active; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_product_schedule_active ON public.pronto_product_schedules USING btree (is_active);


--
-- Name: ix_product_schedule_day_active; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_product_schedule_day_active ON public.pronto_product_schedules USING btree (day_of_week, is_active);


--
-- Name: ix_product_schedule_item; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_product_schedule_item ON public.pronto_product_schedules USING btree (menu_item_id);


--
-- Name: ix_product_schedule_menu_item; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_product_schedule_menu_item ON public.pronto_product_schedules USING btree (menu_item_id);


--
-- Name: ix_pronto_init_runs_phase; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_pronto_init_runs_phase ON public.pronto_init_runs USING btree (phase);


--
-- Name: ix_pronto_payments_session_id; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_pronto_payments_session_id ON public.pronto_payments USING btree (session_id);


--
-- Name: ix_realtime_event_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_realtime_event_created_at ON public.pronto_realtime_events USING btree (created_at);


--
-- Name: ix_realtime_event_type; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_realtime_event_type ON public.pronto_realtime_events USING btree (event_type);


--
-- Name: ix_rec_log_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_rec_log_created_at ON public.pronto_recommendation_change_log USING btree (created_at);


--
-- Name: ix_rec_log_menu_item; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_rec_log_menu_item ON public.pronto_recommendation_change_log USING btree (menu_item_id);


--
-- Name: ix_rec_log_period; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_rec_log_period ON public.pronto_recommendation_change_log USING btree (period_key);


--
-- Name: ix_secret_key; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_secret_key ON public.pronto_secrets USING btree (secret_key);


--
-- Name: ix_session_email_hash; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_session_email_hash ON public.pronto_dining_sessions USING btree (email_hash);


--
-- Name: ix_shortcut_combo; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_shortcut_combo ON public.pronto_keyboard_shortcuts USING btree (combo);


--
-- Name: ix_shortcut_enabled; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_shortcut_enabled ON public.pronto_keyboard_shortcuts USING btree (is_enabled);


--
-- Name: ix_split_assignment_item; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_split_assignment_item ON public.pronto_split_bill_assignments USING btree (order_item_id);


--
-- Name: ix_split_assignment_person; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_split_assignment_person ON public.pronto_split_bill_assignments USING btree (person_id);


--
-- Name: ix_split_assignment_split; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_split_assignment_split ON public.pronto_split_bill_assignments USING btree (split_bill_id);


--
-- Name: ix_split_bill_person_split; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_split_bill_person_split ON public.pronto_split_bill_people USING btree (split_bill_id);


--
-- Name: ix_split_bill_session; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_split_bill_session ON public.pronto_split_bills USING btree (session_id);


--
-- Name: ix_split_bill_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_split_bill_status ON public.pronto_split_bills USING btree (status);


--
-- Name: ix_support_ticket_channel; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_support_ticket_channel ON public.pronto_support_tickets USING btree (channel);


--
-- Name: ix_support_ticket_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_support_ticket_created_at ON public.pronto_support_tickets USING btree (created_at);


--
-- Name: ix_support_ticket_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_support_ticket_status ON public.pronto_support_tickets USING btree (status);


--
-- Name: ix_system_setting_key; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_system_setting_key ON public.pronto_system_settings USING btree (key);


--
-- Name: ix_table_area; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_table_area ON public.pronto_tables USING btree (area_id);


--
-- Name: ix_table_qr_code; Type: INDEX; Schema: public; Owner: pronto
--

CREATE UNIQUE INDEX ix_table_qr_code ON public.pronto_tables USING btree (qr_code);


--
-- Name: ix_table_transfer_created; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_table_transfer_created ON public.pronto_table_transfer_requests USING btree (created_at);


--
-- Name: ix_table_transfer_from_waiter; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_table_transfer_from_waiter ON public.pronto_table_transfer_requests USING btree (from_waiter_id);


--
-- Name: ix_table_transfer_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_table_transfer_status ON public.pronto_table_transfer_requests USING btree (status);


--
-- Name: ix_table_transfer_table; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_table_transfer_table ON public.pronto_table_transfer_requests USING btree (table_id);


--
-- Name: ix_table_transfer_to_waiter; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_table_transfer_to_waiter ON public.pronto_table_transfer_requests USING btree (to_waiter_id);


--
-- Name: ix_waiter_assignments_active; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_waiter_assignments_active ON public.pronto_waiter_table_assignments USING btree (is_active);


--
-- Name: ix_waiter_assignments_table; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_waiter_assignments_table ON public.pronto_waiter_table_assignments USING btree (table_id);


--
-- Name: ix_waiter_assignments_waiter; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_waiter_assignments_waiter ON public.pronto_waiter_table_assignments USING btree (waiter_id);


--
-- Name: ix_waiter_call_confirmed_by; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_waiter_call_confirmed_by ON public.pronto_waiter_calls USING btree (confirmed_by);


--
-- Name: ix_waiter_call_created_at; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_waiter_call_created_at ON public.pronto_waiter_calls USING btree (created_at);


--
-- Name: ix_waiter_call_session; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_waiter_call_session ON public.pronto_waiter_calls USING btree (session_id);


--
-- Name: ix_waiter_call_status; Type: INDEX; Schema: public; Owner: pronto
--

CREATE INDEX ix_waiter_call_status ON public.pronto_waiter_calls USING btree (status);


--
-- Name: uq_menu_categories_slug; Type: INDEX; Schema: public; Owner: pronto
--

CREATE UNIQUE INDEX uq_menu_categories_slug ON public.pronto_menu_categories USING btree (slug);


--
-- Name: uq_menu_home_snapshot_published; Type: INDEX; Schema: public; Owner: pronto
--

CREATE UNIQUE INDEX uq_menu_home_snapshot_published ON public.pronto_menu_home_snapshots USING btree (placement) WHERE is_published;


--
-- Name: pronto_invoices trigger_invoices_updated_at; Type: TRIGGER; Schema: public; Owner: pronto
--

CREATE TRIGGER trigger_invoices_updated_at BEFORE UPDATE ON public.pronto_invoices FOR EACH ROW EXECUTE FUNCTION public.update_invoices_updated_at();


--
-- Name: audit_logs audit_logs_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_order_items fk_order_items_delivered_by; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_items
    ADD CONSTRAINT fk_order_items_delivered_by FOREIGN KEY (delivered_by_employee_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_audit_logs pronto_audit_logs_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_audit_logs
    ADD CONSTRAINT pronto_audit_logs_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_business_info pronto_business_info_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_business_info
    ADD CONSTRAINT pronto_business_info_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_dining_sessions pronto_dining_sessions_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_dining_sessions
    ADD CONSTRAINT pronto_dining_sessions_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_dining_sessions pronto_dining_sessions_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_dining_sessions
    ADD CONSTRAINT pronto_dining_sessions_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.pronto_tables(id);


--
-- Name: pronto_employee_preferences pronto_employee_preferences_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_employee_preferences
    ADD CONSTRAINT pronto_employee_preferences_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.pronto_employees(id) ON DELETE CASCADE;


--
-- Name: pronto_feedback pronto_feedback_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_feedback
    ADD CONSTRAINT pronto_feedback_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_feedback pronto_feedback_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_feedback
    ADD CONSTRAINT pronto_feedback_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.pronto_dining_sessions(id);


--
-- Name: pronto_feedback_tokens pronto_feedback_tokens_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_feedback_tokens
    ADD CONSTRAINT pronto_feedback_tokens_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.pronto_orders(id) ON DELETE CASCADE;


--
-- Name: pronto_feedback_tokens pronto_feedback_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_feedback_tokens
    ADD CONSTRAINT pronto_feedback_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.pronto_dining_sessions(id) ON DELETE CASCADE;


--
-- Name: pronto_invoices pronto_invoices_cancelled_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_invoices
    ADD CONSTRAINT pronto_invoices_cancelled_by_fkey FOREIGN KEY (cancelled_by) REFERENCES public.pronto_employees(id) ON DELETE SET NULL;


--
-- Name: pronto_invoices pronto_invoices_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_invoices
    ADD CONSTRAINT pronto_invoices_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.pronto_customers(id);


--
-- Name: pronto_invoices pronto_invoices_dining_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_invoices
    ADD CONSTRAINT pronto_invoices_dining_session_id_fkey FOREIGN KEY (dining_session_id) REFERENCES public.pronto_dining_sessions(id);


--
-- Name: pronto_invoices pronto_invoices_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_invoices
    ADD CONSTRAINT pronto_invoices_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.pronto_orders(id);


--
-- Name: pronto_kitchen_orders pronto_kitchen_orders_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_kitchen_orders
    ADD CONSTRAINT pronto_kitchen_orders_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.pronto_orders(id);


--
-- Name: pronto_menu_categories pronto_menu_categories_parent_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_categories
    ADD CONSTRAINT pronto_menu_categories_parent_category_id_fkey FOREIGN KEY (parent_category_id) REFERENCES public.pronto_menu_categories(id);


--
-- Name: pronto_menu_home_module_products pronto_menu_home_module_products_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_home_module_products
    ADD CONSTRAINT pronto_menu_home_module_products_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.pronto_menu_home_modules(id) ON DELETE CASCADE;


--
-- Name: pronto_menu_home_module_products pronto_menu_home_module_products_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_home_module_products
    ADD CONSTRAINT pronto_menu_home_module_products_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.pronto_menu_items(id) ON DELETE CASCADE;


--
-- Name: pronto_menu_item_day_periods pronto_menu_item_day_periods_menu_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_item_day_periods
    ADD CONSTRAINT pronto_menu_item_day_periods_menu_item_id_fkey FOREIGN KEY (menu_item_id) REFERENCES public.pronto_menu_items(id) ON DELETE CASCADE;


--
-- Name: pronto_menu_item_day_periods pronto_menu_item_day_periods_period_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_item_day_periods
    ADD CONSTRAINT pronto_menu_item_day_periods_period_id_fkey FOREIGN KEY (period_id) REFERENCES public.pronto_day_periods(id) ON DELETE CASCADE;


--
-- Name: pronto_menu_item_modifier_groups pronto_menu_item_modifier_groups_menu_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_item_modifier_groups
    ADD CONSTRAINT pronto_menu_item_modifier_groups_menu_item_id_fkey FOREIGN KEY (menu_item_id) REFERENCES public.pronto_menu_items(id) ON DELETE CASCADE;


--
-- Name: pronto_menu_item_modifier_groups pronto_menu_item_modifier_groups_modifier_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_item_modifier_groups
    ADD CONSTRAINT pronto_menu_item_modifier_groups_modifier_group_id_fkey FOREIGN KEY (modifier_group_id) REFERENCES public.pronto_modifier_groups(id) ON DELETE CASCADE;


--
-- Name: pronto_menu_items pronto_menu_items_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_items
    ADD CONSTRAINT pronto_menu_items_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.pronto_menu_categories(id);


--
-- Name: pronto_menu_subcategories pronto_menu_subcategories_menu_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_menu_subcategories
    ADD CONSTRAINT pronto_menu_subcategories_menu_category_id_fkey FOREIGN KEY (menu_category_id) REFERENCES public.pronto_menu_categories(id) ON DELETE CASCADE;


--
-- Name: pronto_modifier_groups pronto_modifier_groups_menu_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_modifier_groups
    ADD CONSTRAINT pronto_modifier_groups_menu_item_id_fkey FOREIGN KEY (menu_item_id) REFERENCES public.pronto_menu_items(id);


--
-- Name: pronto_modifiers pronto_modifiers_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_modifiers
    ADD CONSTRAINT pronto_modifiers_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.pronto_modifier_groups(id);


--
-- Name: pronto_order_item_modifiers pronto_order_item_modifiers_modifier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_item_modifiers
    ADD CONSTRAINT pronto_order_item_modifiers_modifier_id_fkey FOREIGN KEY (modifier_id) REFERENCES public.pronto_modifiers(id);


--
-- Name: pronto_order_item_modifiers pronto_order_item_modifiers_order_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_item_modifiers
    ADD CONSTRAINT pronto_order_item_modifiers_order_item_id_fkey FOREIGN KEY (order_item_id) REFERENCES public.pronto_order_items(id) ON DELETE CASCADE;


--
-- Name: pronto_order_items pronto_order_items_menu_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_items
    ADD CONSTRAINT pronto_order_items_menu_item_id_fkey FOREIGN KEY (menu_item_id) REFERENCES public.pronto_menu_items(id);


--
-- Name: pronto_order_items pronto_order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_items
    ADD CONSTRAINT pronto_order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.pronto_orders(id);


--
-- Name: pronto_order_modifications pronto_order_modifications_initiated_by_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_modifications
    ADD CONSTRAINT pronto_order_modifications_initiated_by_customer_id_fkey FOREIGN KEY (initiated_by_customer_id) REFERENCES public.pronto_customers(id);


--
-- Name: pronto_order_modifications pronto_order_modifications_initiated_by_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_modifications
    ADD CONSTRAINT pronto_order_modifications_initiated_by_employee_id_fkey FOREIGN KEY (initiated_by_employee_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_order_modifications pronto_order_modifications_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_modifications
    ADD CONSTRAINT pronto_order_modifications_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.pronto_orders(id);


--
-- Name: pronto_order_modifications pronto_order_modifications_reviewed_by_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_modifications
    ADD CONSTRAINT pronto_order_modifications_reviewed_by_customer_id_fkey FOREIGN KEY (reviewed_by_customer_id) REFERENCES public.pronto_customers(id);


--
-- Name: pronto_order_modifications pronto_order_modifications_reviewed_by_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_modifications
    ADD CONSTRAINT pronto_order_modifications_reviewed_by_employee_id_fkey FOREIGN KEY (reviewed_by_employee_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_order_status_history pronto_order_status_history_changed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_status_history
    ADD CONSTRAINT pronto_order_status_history_changed_by_fkey FOREIGN KEY (changed_by) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_order_status_history pronto_order_status_history_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_status_history
    ADD CONSTRAINT pronto_order_status_history_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.pronto_orders(id);


--
-- Name: pronto_order_status_labels pronto_order_status_labels_updated_by_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_order_status_labels
    ADD CONSTRAINT pronto_order_status_labels_updated_by_emp_id_fkey FOREIGN KEY (updated_by_emp_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_orders pronto_orders_chef_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_orders
    ADD CONSTRAINT pronto_orders_chef_id_fkey FOREIGN KEY (chef_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_orders pronto_orders_delivery_waiter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_orders
    ADD CONSTRAINT pronto_orders_delivery_waiter_id_fkey FOREIGN KEY (delivery_waiter_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_orders pronto_orders_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_orders
    ADD CONSTRAINT pronto_orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_orders pronto_orders_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_orders
    ADD CONSTRAINT pronto_orders_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.pronto_dining_sessions(id);


--
-- Name: pronto_orders pronto_orders_waiter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_orders
    ADD CONSTRAINT pronto_orders_waiter_id_fkey FOREIGN KEY (waiter_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_payments pronto_payments_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_payments
    ADD CONSTRAINT pronto_payments_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_payments pronto_payments_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_payments
    ADD CONSTRAINT pronto_payments_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.pronto_dining_sessions(id);


--
-- Name: pronto_product_label_map pronto_product_label_map_label_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_product_label_map
    ADD CONSTRAINT pronto_product_label_map_label_id_fkey FOREIGN KEY (label_id) REFERENCES public.pronto_product_labels(id) ON DELETE CASCADE;


--
-- Name: pronto_product_label_map pronto_product_label_map_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_product_label_map
    ADD CONSTRAINT pronto_product_label_map_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.pronto_menu_items(id) ON DELETE CASCADE;


--
-- Name: pronto_product_schedules pronto_product_schedules_menu_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_product_schedules
    ADD CONSTRAINT pronto_product_schedules_menu_item_id_fkey FOREIGN KEY (menu_item_id) REFERENCES public.pronto_menu_items(id);


--
-- Name: pronto_recommendation_change_log pronto_recommendation_change_log_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_recommendation_change_log
    ADD CONSTRAINT pronto_recommendation_change_log_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_recommendation_change_log pronto_recommendation_change_log_menu_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_recommendation_change_log
    ADD CONSTRAINT pronto_recommendation_change_log_menu_item_id_fkey FOREIGN KEY (menu_item_id) REFERENCES public.pronto_menu_items(id);


--
-- Name: pronto_role_permission_bindings pronto_role_permission_bindings_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_role_permission_bindings
    ADD CONSTRAINT pronto_role_permission_bindings_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.pronto_system_permissions(id);


--
-- Name: pronto_role_permission_bindings pronto_role_permission_bindings_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_role_permission_bindings
    ADD CONSTRAINT pronto_role_permission_bindings_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.pronto_system_roles(id);


--
-- Name: pronto_split_bill_assignments pronto_split_bill_assignments_order_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_split_bill_assignments
    ADD CONSTRAINT pronto_split_bill_assignments_order_item_id_fkey FOREIGN KEY (order_item_id) REFERENCES public.pronto_order_items(id);


--
-- Name: pronto_split_bill_assignments pronto_split_bill_assignments_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_split_bill_assignments
    ADD CONSTRAINT pronto_split_bill_assignments_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.pronto_split_bill_people(id);


--
-- Name: pronto_split_bill_assignments pronto_split_bill_assignments_split_bill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_split_bill_assignments
    ADD CONSTRAINT pronto_split_bill_assignments_split_bill_id_fkey FOREIGN KEY (split_bill_id) REFERENCES public.pronto_split_bills(id);


--
-- Name: pronto_split_bill_people pronto_split_bill_people_split_bill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_split_bill_people
    ADD CONSTRAINT pronto_split_bill_people_split_bill_id_fkey FOREIGN KEY (split_bill_id) REFERENCES public.pronto_split_bills(id);


--
-- Name: pronto_split_bills pronto_split_bills_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_split_bills
    ADD CONSTRAINT pronto_split_bills_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.pronto_dining_sessions(id);


--
-- Name: pronto_super_admin_handoff_tokens pronto_super_admin_handoff_tokens_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_super_admin_handoff_tokens
    ADD CONSTRAINT pronto_super_admin_handoff_tokens_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_table_log pronto_table_log_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_table_log
    ADD CONSTRAINT pronto_table_log_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_table_log pronto_table_log_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_table_log
    ADD CONSTRAINT pronto_table_log_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.pronto_dining_sessions(id);


--
-- Name: pronto_table_log pronto_table_log_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_table_log
    ADD CONSTRAINT pronto_table_log_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.pronto_tables(id);


--
-- Name: pronto_table_transfer_requests pronto_table_transfer_requests_from_waiter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_table_transfer_requests
    ADD CONSTRAINT pronto_table_transfer_requests_from_waiter_id_fkey FOREIGN KEY (from_waiter_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_table_transfer_requests pronto_table_transfer_requests_resolved_by_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_table_transfer_requests
    ADD CONSTRAINT pronto_table_transfer_requests_resolved_by_employee_id_fkey FOREIGN KEY (resolved_by_employee_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_table_transfer_requests pronto_table_transfer_requests_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_table_transfer_requests
    ADD CONSTRAINT pronto_table_transfer_requests_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.pronto_tables(id);


--
-- Name: pronto_table_transfer_requests pronto_table_transfer_requests_to_waiter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_table_transfer_requests
    ADD CONSTRAINT pronto_table_transfer_requests_to_waiter_id_fkey FOREIGN KEY (to_waiter_id) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_tables pronto_tables_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_tables
    ADD CONSTRAINT pronto_tables_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.pronto_areas(id) ON DELETE RESTRICT;


--
-- Name: pronto_waiter_calls pronto_waiter_calls_confirmed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_waiter_calls
    ADD CONSTRAINT pronto_waiter_calls_confirmed_by_fkey FOREIGN KEY (confirmed_by) REFERENCES public.pronto_employees(id);


--
-- Name: pronto_waiter_calls pronto_waiter_calls_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_waiter_calls
    ADD CONSTRAINT pronto_waiter_calls_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.pronto_dining_sessions(id);


--
-- Name: pronto_waiter_table_assignments pronto_waiter_table_assignments_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_waiter_table_assignments
    ADD CONSTRAINT pronto_waiter_table_assignments_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.pronto_tables(id);


--
-- Name: pronto_waiter_table_assignments pronto_waiter_table_assignments_waiter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pronto
--

ALTER TABLE ONLY public.pronto_waiter_table_assignments
    ADD CONSTRAINT pronto_waiter_table_assignments_waiter_id_fkey FOREIGN KEY (waiter_id) REFERENCES public.pronto_employees(id);


--
-- PostgreSQL database dump complete
--

\unrestrict WvtLLj6XWluns2hKdF5cPPbPi9ebKdFNfYnJSPkaudsNX0vnlcg0Wg93932eTUr

