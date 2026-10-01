--
-- PostgreSQL database dump
--

\restrict ZKBmQVxVB84hmoGE6ERRIUfTkuCxGmu2QNJB77e7HjFWd40UdwVkTC8ITjIlcqH

-- Dumped from database version 15.18
-- Dumped by pg_dump version 15.18

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

ALTER TABLE IF EXISTS ONLY source_company.work_authorizations DROP CONSTRAINT IF EXISTS work_authorizations_contact_fkey;
ALTER TABLE IF EXISTS ONLY source_company.vendor_discount_terms DROP CONSTRAINT IF EXISTS vendor_discount_terms_company_fkey;
ALTER TABLE IF EXISTS ONLY source_company.vendor_accounts DROP CONSTRAINT IF EXISTS vendor_accounts_company_fkey;
ALTER TABLE IF EXISTS ONLY source_company.projects DROP CONSTRAINT IF EXISTS projects_opportunity_fkey;
ALTER TABLE IF EXISTS ONLY source_company.projects DROP CONSTRAINT IF EXISTS projects_legal_entity_fkey;
ALTER TABLE IF EXISTS ONLY source_company.projects DROP CONSTRAINT IF EXISTS projects_contact_fkey;
ALTER TABLE IF EXISTS ONLY source_company.project_notes DROP CONSTRAINT IF EXISTS project_notes_project_fkey;
ALTER TABLE IF EXISTS ONLY source_company.project_documents DROP CONSTRAINT IF EXISTS project_documents_project_fkey;
ALTER TABLE IF EXISTS ONLY source_company.project_documents DROP CONSTRAINT IF EXISTS project_documents_document_fkey;
ALTER TABLE IF EXISTS ONLY source_company.opportunity_documents DROP CONSTRAINT IF EXISTS opportunity_documents_opportunity_fkey;
ALTER TABLE IF EXISTS ONLY source_company.opportunity_documents DROP CONSTRAINT IF EXISTS opportunity_documents_document_fkey;
ALTER TABLE IF EXISTS ONLY source_company.opportunities DROP CONSTRAINT IF EXISTS opportunities_site_contact_fkey;
ALTER TABLE IF EXISTS ONLY source_company.opportunities DROP CONSTRAINT IF EXISTS opportunities_reporting_branch_fkey;
ALTER TABLE IF EXISTS ONLY source_company.opportunities DROP CONSTRAINT IF EXISTS opportunities_referral_contact_fkey;
ALTER TABLE IF EXISTS ONLY source_company.opportunities DROP CONSTRAINT IF EXISTS opportunities_operating_branch_fkey;
ALTER TABLE IF EXISTS ONLY source_company.opportunities DROP CONSTRAINT IF EXISTS opportunities_contact_fkey;
ALTER TABLE IF EXISTS ONLY source_company.opportunities DROP CONSTRAINT IF EXISTS opportunities_catastrophe_event_fkey;
ALTER TABLE IF EXISTS ONLY source_company.opportunities DROP CONSTRAINT IF EXISTS opportunities_address_fkey;
ALTER TABLE IF EXISTS ONLY source_company.legal_entities DROP CONSTRAINT IF EXISTS legal_entities_billing_address_fkey;
ALTER TABLE IF EXISTS ONLY source_company.inbound_email_attachments DROP CONSTRAINT IF EXISTS inbound_email_attachments_email_fkey;
ALTER TABLE IF EXISTS ONLY source_company.gl_entries DROP CONSTRAINT IF EXISTS gl_entries_opportunity_fkey;
ALTER TABLE IF EXISTS ONLY source_company.engagement_assignments DROP CONSTRAINT IF EXISTS engagement_assignments_opportunity_fkey;
ALTER TABLE IF EXISTS ONLY source_company.engagement_assignments DROP CONSTRAINT IF EXISTS engagement_assignments_employee_fkey;
ALTER TABLE IF EXISTS ONLY source_company.employees DROP CONSTRAINT IF EXISTS employees_branch_fkey;
ALTER TABLE IF EXISTS ONLY source_company.contacts DROP CONSTRAINT IF EXISTS contacts_industry_fkey;
ALTER TABLE IF EXISTS ONLY source_company.contacts DROP CONSTRAINT IF EXISTS contacts_company_fkey;
ALTER TABLE IF EXISTS ONLY source_company.contact_interactions DROP CONSTRAINT IF EXISTS contact_interactions_contact_fkey;
ALTER TABLE IF EXISTS ONLY source_company.contact_addresses DROP CONSTRAINT IF EXISTS contact_addresses_contact_fkey;
ALTER TABLE IF EXISTS ONLY source_company.contact_addresses DROP CONSTRAINT IF EXISTS contact_addresses_address_fkey;
ALTER TABLE IF EXISTS ONLY source_company.company_documents DROP CONSTRAINT IF EXISTS company_documents_document_fkey;
ALTER TABLE IF EXISTS ONLY source_company.company_documents DROP CONSTRAINT IF EXISTS company_documents_company_fkey;
ALTER TABLE IF EXISTS ONLY source_company.companies DROP CONSTRAINT IF EXISTS companies_industry_fkey;
ALTER TABLE IF EXISTS ONLY source_company.companies DROP CONSTRAINT IF EXISTS companies_billing_contact_fkey;
ALTER TABLE IF EXISTS ONLY source_company.companies DROP CONSTRAINT IF EXISTS companies_address_fkey;
ALTER TABLE IF EXISTS ONLY source_company.commission_policies DROP CONSTRAINT IF EXISTS commission_policies_document_fkey;
ALTER TABLE IF EXISTS ONLY source_company.change_orders DROP CONSTRAINT IF EXISTS change_orders_project_fkey;
ALTER TABLE IF EXISTS ONLY source_company.change_orders DROP CONSTRAINT IF EXISTS change_orders_document_fkey;
ALTER TABLE IF EXISTS ONLY source_company.budgets DROP CONSTRAINT IF EXISTS budgets_opportunity_fkey;
ALTER TABLE IF EXISTS ONLY source_company.budget_lines DROP CONSTRAINT IF EXISTS budget_lines_budget_fkey;
ALTER TABLE IF EXISTS ONLY source_company.bids DROP CONSTRAINT IF EXISTS bids_opportunity_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_payments DROP CONSTRAINT IF EXISTS ar_payments_invoice_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoices DROP CONSTRAINT IF EXISTS ar_invoices_opportunity_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoices DROP CONSTRAINT IF EXISTS ar_invoices_legal_entity_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoices DROP CONSTRAINT IF EXISTS ar_invoices_document_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoices DROP CONSTRAINT IF EXISTS ar_invoices_contact_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoices DROP CONSTRAINT IF EXISTS ar_invoices_company_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoice_notes DROP CONSTRAINT IF EXISTS ar_invoice_notes_invoice_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoice_lines DROP CONSTRAINT IF EXISTS ar_invoice_lines_invoice_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoice_documents DROP CONSTRAINT IF EXISTS ar_invoice_documents_invoice_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoice_documents DROP CONSTRAINT IF EXISTS ar_invoice_documents_document_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ap_invoices DROP CONSTRAINT IF EXISTS ap_invoices_vendor_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ap_invoices DROP CONSTRAINT IF EXISTS ap_invoices_vendor_contact_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ap_invoices DROP CONSTRAINT IF EXISTS ap_invoices_opportunity_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ap_invoices DROP CONSTRAINT IF EXISTS ap_invoices_legal_entity_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ap_invoices DROP CONSTRAINT IF EXISTS ap_invoices_branch_fkey;
ALTER TABLE IF EXISTS ONLY source_company.ap_invoice_lines DROP CONSTRAINT IF EXISTS ap_invoice_lines_invoice_fkey;
ALTER TABLE IF EXISTS ONLY source_company.actual_costs DROP CONSTRAINT IF EXISTS actual_costs_vendor_fkey;
ALTER TABLE IF EXISTS ONLY source_company.actual_costs DROP CONSTRAINT IF EXISTS actual_costs_opportunity_fkey;
ALTER TABLE IF EXISTS ONLY source_company.actual_costs DROP CONSTRAINT IF EXISTS actual_costs_budget_fkey;
ALTER TABLE IF EXISTS ONLY source_company.actual_costs DROP CONSTRAINT IF EXISTS actual_costs_ap_invoice_fkey;
DROP INDEX IF EXISTS source_company.projects_project_number_idx;
DROP INDEX IF EXISTS source_company.opportunities_legacy_number_idx;
DROP INDEX IF EXISTS source_company.gl_entries_opportunity_idx;
DROP INDEX IF EXISTS source_company.engagement_assignments_opportunity_idx;
DROP INDEX IF EXISTS source_company.ar_invoices_number_idx;
DROP INDEX IF EXISTS source_company.ap_invoices_number_idx;
DROP INDEX IF EXISTS source_company.actual_costs_opportunity_idx;
ALTER TABLE IF EXISTS ONLY source_company.work_authorizations DROP CONSTRAINT IF EXISTS work_authorizations_pkey;
ALTER TABLE IF EXISTS ONLY source_company.vendor_discount_terms DROP CONSTRAINT IF EXISTS vendor_discount_terms_pkey;
ALTER TABLE IF EXISTS ONLY source_company.vendor_accounts DROP CONSTRAINT IF EXISTS vendor_accounts_pkey;
ALTER TABLE IF EXISTS ONLY source_company.standard_tasks DROP CONSTRAINT IF EXISTS standard_tasks_pkey;
ALTER TABLE IF EXISTS ONLY source_company.projects DROP CONSTRAINT IF EXISTS projects_pkey;
ALTER TABLE IF EXISTS ONLY source_company.project_notes DROP CONSTRAINT IF EXISTS project_notes_pkey;
ALTER TABLE IF EXISTS ONLY source_company.project_documents DROP CONSTRAINT IF EXISTS project_documents_pkey;
ALTER TABLE IF EXISTS ONLY source_company.opportunity_documents DROP CONSTRAINT IF EXISTS opportunity_documents_pkey;
ALTER TABLE IF EXISTS ONLY source_company.opportunities DROP CONSTRAINT IF EXISTS opportunities_pkey;
ALTER TABLE IF EXISTS ONLY source_company.legal_entities DROP CONSTRAINT IF EXISTS legal_entities_pkey;
ALTER TABLE IF EXISTS ONLY source_company.industries DROP CONSTRAINT IF EXISTS industries_pkey;
ALTER TABLE IF EXISTS ONLY source_company.inbound_emails DROP CONSTRAINT IF EXISTS inbound_emails_pkey;
ALTER TABLE IF EXISTS ONLY source_company.inbound_email_attachments DROP CONSTRAINT IF EXISTS inbound_email_attachments_pkey;
ALTER TABLE IF EXISTS ONLY source_company.gl_entries DROP CONSTRAINT IF EXISTS gl_entries_pkey;
ALTER TABLE IF EXISTS ONLY source_company.gl_accounts DROP CONSTRAINT IF EXISTS gl_accounts_pkey;
ALTER TABLE IF EXISTS ONLY source_company.engagement_assignments DROP CONSTRAINT IF EXISTS engagement_assignments_pkey;
ALTER TABLE IF EXISTS ONLY source_company.employees DROP CONSTRAINT IF EXISTS employees_pkey;
ALTER TABLE IF EXISTS ONLY source_company.documents DROP CONSTRAINT IF EXISTS documents_pkey;
ALTER TABLE IF EXISTS ONLY source_company.dataset_metadata DROP CONSTRAINT IF EXISTS dataset_metadata_pkey;
ALTER TABLE IF EXISTS ONLY source_company.cost_codes DROP CONSTRAINT IF EXISTS cost_codes_pkey;
ALTER TABLE IF EXISTS ONLY source_company.contacts DROP CONSTRAINT IF EXISTS contacts_pkey;
ALTER TABLE IF EXISTS ONLY source_company.contact_interactions DROP CONSTRAINT IF EXISTS contact_interactions_pkey;
ALTER TABLE IF EXISTS ONLY source_company.contact_addresses DROP CONSTRAINT IF EXISTS contact_addresses_pkey;
ALTER TABLE IF EXISTS ONLY source_company.company_documents DROP CONSTRAINT IF EXISTS company_documents_pkey;
ALTER TABLE IF EXISTS ONLY source_company.companies DROP CONSTRAINT IF EXISTS companies_pkey;
ALTER TABLE IF EXISTS ONLY source_company.commission_policies DROP CONSTRAINT IF EXISTS commission_policies_pkey;
ALTER TABLE IF EXISTS ONLY source_company.change_orders DROP CONSTRAINT IF EXISTS change_orders_pkey;
ALTER TABLE IF EXISTS ONLY source_company.catastrophe_events DROP CONSTRAINT IF EXISTS catastrophe_events_pkey;
ALTER TABLE IF EXISTS ONLY source_company.budgets DROP CONSTRAINT IF EXISTS budgets_pkey;
ALTER TABLE IF EXISTS ONLY source_company.budget_lines DROP CONSTRAINT IF EXISTS budget_lines_pkey;
ALTER TABLE IF EXISTS ONLY source_company.branches DROP CONSTRAINT IF EXISTS branches_pkey;
ALTER TABLE IF EXISTS ONLY source_company.bids DROP CONSTRAINT IF EXISTS bids_pkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_payments DROP CONSTRAINT IF EXISTS ar_payments_pkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoices DROP CONSTRAINT IF EXISTS ar_invoices_pkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoice_notes DROP CONSTRAINT IF EXISTS ar_invoice_notes_pkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoice_lines DROP CONSTRAINT IF EXISTS ar_invoice_lines_pkey;
ALTER TABLE IF EXISTS ONLY source_company.ar_invoice_documents DROP CONSTRAINT IF EXISTS ar_invoice_documents_pkey;
ALTER TABLE IF EXISTS ONLY source_company.ap_invoices DROP CONSTRAINT IF EXISTS ap_invoices_pkey;
ALTER TABLE IF EXISTS ONLY source_company.ap_invoice_lines DROP CONSTRAINT IF EXISTS ap_invoice_lines_pkey;
ALTER TABLE IF EXISTS ONLY source_company.addresses DROP CONSTRAINT IF EXISTS addresses_pkey;
ALTER TABLE IF EXISTS ONLY source_company.actual_costs DROP CONSTRAINT IF EXISTS actual_costs_pkey;
ALTER TABLE IF EXISTS ONLY source_company.accounting_periods DROP CONSTRAINT IF EXISTS accounting_periods_pkey;
DROP TABLE IF EXISTS source_company.work_authorizations;
DROP TABLE IF EXISTS source_company.vendor_discount_terms;
DROP TABLE IF EXISTS source_company.vendor_accounts;
DROP TABLE IF EXISTS source_company.standard_tasks;
DROP TABLE IF EXISTS source_company.projects;
DROP TABLE IF EXISTS source_company.project_notes;
DROP TABLE IF EXISTS source_company.project_documents;
DROP TABLE IF EXISTS source_company.opportunity_documents;
DROP TABLE IF EXISTS source_company.opportunities;
DROP TABLE IF EXISTS source_company.legal_entities;
DROP TABLE IF EXISTS source_company.industries;
DROP TABLE IF EXISTS source_company.inbound_emails;
DROP TABLE IF EXISTS source_company.inbound_email_attachments;
DROP TABLE IF EXISTS source_company.gl_entries;
DROP TABLE IF EXISTS source_company.gl_accounts;
DROP TABLE IF EXISTS source_company.engagement_assignments;
DROP TABLE IF EXISTS source_company.employees;
DROP TABLE IF EXISTS source_company.documents;
DROP TABLE IF EXISTS source_company.dataset_metadata;
DROP TABLE IF EXISTS source_company.cost_codes;
DROP TABLE IF EXISTS source_company.contacts;
DROP TABLE IF EXISTS source_company.contact_interactions;
DROP TABLE IF EXISTS source_company.contact_addresses;
DROP TABLE IF EXISTS source_company.company_documents;
DROP TABLE IF EXISTS source_company.companies;
DROP TABLE IF EXISTS source_company.commission_policies;
DROP TABLE IF EXISTS source_company.change_orders;
DROP TABLE IF EXISTS source_company.catastrophe_events;
DROP TABLE IF EXISTS source_company.budgets;
DROP TABLE IF EXISTS source_company.budget_lines;
DROP TABLE IF EXISTS source_company.branches;
DROP TABLE IF EXISTS source_company.bids;
DROP TABLE IF EXISTS source_company.ar_payments;
DROP TABLE IF EXISTS source_company.ar_invoices;
DROP TABLE IF EXISTS source_company.ar_invoice_notes;
DROP TABLE IF EXISTS source_company.ar_invoice_lines;
DROP TABLE IF EXISTS source_company.ar_invoice_documents;
DROP TABLE IF EXISTS source_company.ap_invoices;
DROP TABLE IF EXISTS source_company.ap_invoice_lines;
DROP TABLE IF EXISTS source_company.addresses;
DROP TABLE IF EXISTS source_company.actual_costs;
DROP TABLE IF EXISTS source_company.accounting_periods;
DROP SCHEMA IF EXISTS source_company;
--
-- Name: source_company; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA source_company;


--
-- Name: SCHEMA source_company; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA source_company IS 'Synthetic legacy company data for the engineering candidate take-home.';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounting_periods; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.accounting_periods (
    id character varying(36) NOT NULL,
    year integer,
    month integer,
    status character varying(10),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: actual_costs; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.actual_costs (
    id character varying(36) NOT NULL,
    budget_id character varying(36),
    opportunity_id character varying(36),
    vendor_id character varying(36),
    source_ap_invoice_id character varying(36),
    cost_date timestamp with time zone,
    cost_code text,
    item_name character varying(255),
    amount numeric(12,2),
    notes text,
    legacy_expense_id character varying(255),
    legacy_journal_line_id character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: addresses; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.addresses (
    id character varying(36) NOT NULL,
    street_address character varying(500),
    unit character varying(50),
    city character varying(100),
    state character varying(50),
    zip_code character varying(20),
    country character varying(50),
    normalized_address character varying(600),
    latitude numeric(10,8),
    longitude numeric(11,8),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: ap_invoice_lines; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.ap_invoice_lines (
    id character varying(36) NOT NULL,
    invoice_id character varying(36),
    description text,
    quantity numeric(10,3),
    unit_price numeric(12,2),
    amount numeric(12,2),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: ap_invoices; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.ap_invoices (
    id character varying(36) NOT NULL,
    invoice_number character varying(50),
    vendor_id character varying(36),
    vendor_contact_id character varying(36),
    vendor_name character varying(255),
    opportunity_id character varying(36),
    legal_entity_id character varying(36),
    branch_id character varying(36),
    invoice_date timestamp with time zone,
    due_date timestamp with time zone,
    posting_date timestamp with time zone,
    amount numeric(12,2),
    currency character varying(3),
    description text,
    cost_code character varying(50),
    document_type character varying(20),
    source character varying(10),
    status character varying,
    paid_status character varying(10),
    total_paid_amount numeric(12,2),
    overpaid_amount numeric(12,2),
    discount_type character varying(12),
    discount_value numeric(10,2),
    discount_deadline date,
    legacy_accounting_bill_id character varying(255),
    legacy_unified_invoice_id character varying(255),
    legacy_document_number character varying(255),
    legacy_gl_account_id character varying(36),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: ar_invoice_documents; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.ar_invoice_documents (
    id character varying(36) NOT NULL,
    invoice_id character varying(36),
    document_id character varying(36),
    document_type text,
    document_date timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: ar_invoice_lines; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.ar_invoice_lines (
    id character varying(36) NOT NULL,
    invoice_id character varying(36),
    legacy_contract_line_id character varying(36),
    description character varying(500),
    amount numeric(12,2),
    billing_percentage numeric(11,8),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: ar_invoice_notes; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.ar_invoice_notes (
    id character varying(36) NOT NULL,
    invoice_id character varying(36),
    content text,
    created_by_email character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: ar_invoices; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.ar_invoices (
    id character varying(36) NOT NULL,
    invoice_number character varying(255),
    invoice_type character varying(20),
    company_id character varying(36),
    contact_id character varying(36),
    opportunity_id character varying(36),
    legal_entity_id character varying(36),
    invoice_date timestamp with time zone,
    due_date timestamp with time zone,
    posting_date timestamp with time zone,
    sent_date timestamp with time zone,
    approval_date timestamp with time zone,
    subtotal numeric(12,2),
    tax_amount numeric(12,2),
    total numeric(12,2),
    status character varying(20),
    tax_treatment text,
    tax_exemption_reason text,
    notes text,
    document_id character varying(36),
    legacy_accounting_invoice_id character varying(255),
    legacy_accounting_invoice_number character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: ar_payments; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.ar_payments (
    id character varying(36) NOT NULL,
    invoice_id character varying(36),
    payment_date timestamp with time zone,
    amount numeric(12,2),
    payment_method character varying(50),
    reference_number character varying(100),
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: bids; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.bids (
    id character varying(36) NOT NULL,
    opportunity_id character varying(36),
    bid_owner_id character varying(36),
    proposal_recipient_id character varying(36),
    bid_type text,
    status text,
    estimate_due_date timestamp with time zone,
    loss_event_date timestamp with time zone,
    damage_description text,
    areas_of_damage jsonb,
    contract_value numeric(12,2),
    margin numeric(5,2),
    opportunity_notes text,
    date_approved timestamp with time zone,
    approved_by character varying(36),
    approved_at timestamp with time zone,
    submitted_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: branches; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.branches (
    id character varying(36) NOT NULL,
    name character varying(255),
    address text,
    city character varying(100),
    state character varying(50),
    zip_code character varying(20),
    phone character varying(50),
    email character varying(255),
    is_active boolean,
    latitude numeric(10,7),
    longitude numeric(10,7),
    legacy_accounting_id character varying(255),
    legacy_accounting_name character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: budget_lines; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.budget_lines (
    id character varying(36) NOT NULL,
    budget_id character varying(36),
    cost_code text,
    allocation_value numeric(12,2),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: budgets; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.budgets (
    id character varying(36) NOT NULL,
    opportunity_id character varying(36),
    total_budget_amount numeric(12,2),
    original_total_budget_amount numeric(12,2),
    original_margin numeric(5,2),
    status character varying(50),
    activated_at timestamp with time zone,
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: catastrophe_events; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.catastrophe_events (
    id character varying(36) NOT NULL,
    name character varying(255),
    description text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: change_orders; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.change_orders (
    id character varying(36) NOT NULL,
    project_id character varying(36),
    change_order_number integer,
    display_name character varying(100),
    original_contract_value numeric(12,2),
    new_contract_value numeric(12,2),
    original_margin numeric(5,2),
    new_margin numeric(5,2),
    original_completion_date timestamp with time zone,
    new_completion_date timestamp with time zone,
    signed_document_id character varying(36),
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: commission_policies; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.commission_policies (
    id character varying(36) NOT NULL,
    family text,
    version_label character varying(50),
    document_id character varying(36),
    original_filename character varying(255),
    content_type character varying(120),
    policy_text text,
    is_active boolean,
    activated_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: companies; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.companies (
    id character varying(36) NOT NULL,
    name character varying(255),
    industry_id character varying(36),
    billing_contact_id character varying(36),
    address_id character varying(36),
    customer_number integer,
    is_customer boolean,
    is_vendor boolean,
    is_active boolean,
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: company_documents; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.company_documents (
    id character varying(36) NOT NULL,
    company_id character varying(36),
    document_id character varying(36),
    notes character varying(1000),
    total_square_footage integer,
    expiration_date date,
    is_exclusive boolean,
    applies_to_all_addresses boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: contact_addresses; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.contact_addresses (
    id character varying(36) NOT NULL,
    contact_id character varying(36),
    address_id character varying(36),
    is_active boolean,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: contact_interactions; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.contact_interactions (
    id character varying(36) NOT NULL,
    contact_id character varying(36),
    interaction_date timestamp with time zone,
    action text,
    note text,
    created_by character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: contacts; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.contacts (
    id character varying(36) NOT NULL,
    company_id character varying(36),
    industry_id character varying(36),
    first_name character varying(100),
    last_name character varying(100),
    email character varying(255),
    phone character varying(50),
    mobile character varying(50),
    title character varying(100),
    status text,
    category text,
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: cost_codes; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.cost_codes (
    id character varying(36) NOT NULL,
    code character varying(50),
    name character varying(255),
    legacy_account_id character varying(255),
    legacy_account_name character varying(255),
    legacy_cost_type_id character varying(50),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: dataset_metadata; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.dataset_metadata (
    key text NOT NULL,
    value text NOT NULL
);


--
-- Name: documents; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.documents (
    id character varying(36) NOT NULL,
    original_filename character varying(255),
    file_size bigint,
    content_type character varying(100),
    document_type text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: employees; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.employees (
    id character varying(36) NOT NULL,
    legacy_worker_id character varying(100),
    legacy_associate_id character varying(100),
    legacy_reports_to_worker_id character varying(100),
    email character varying(255),
    first_name character varying(100),
    last_name character varying(100),
    display_name character varying(255),
    phone character varying(50),
    mobile character varying(50),
    branch_id character varying(36),
    hire_date date,
    termination_date date,
    employment_status character varying(20),
    business_unit character varying(100),
    business_unit_name character varying(255),
    department character varying(255),
    location character varying(255),
    job_title character varying(255),
    payroll_group_code character varying(50),
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: engagement_assignments; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.engagement_assignments (
    id character varying(36) NOT NULL,
    opportunity_id character varying(36),
    employee_id character varying(36),
    capacity character varying(50),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: gl_accounts; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.gl_accounts (
    id character varying(36) NOT NULL,
    cost_type character varying(50),
    service_line character varying(20),
    legacy_account_id character varying(255),
    account_name character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: gl_entries; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.gl_entries (
    id character varying(36) NOT NULL,
    source_object character varying(40),
    legacy_record_id character varying(255),
    legacy_line_id character varying(255),
    entry_type character varying(40),
    opportunity_id character varying(36),
    project_number character varying(255),
    account_no character varying(255),
    cost_code character varying(80),
    amount numeric(14,2),
    debit_amount numeric(14,2),
    credit_amount numeric(14,2),
    transaction_amount numeric(14,2),
    currency character varying(3),
    posting_date timestamp with time zone,
    document_date timestamp with time zone,
    due_date timestamp with time zone,
    payment_date timestamp with time zone,
    document_number character varying(255),
    counterparty_id character varying(255),
    counterparty_name character varying(512),
    source_status character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: inbound_email_attachments; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.inbound_email_attachments (
    id character varying(36) NOT NULL,
    inbound_email_id character varying(36),
    filename character varying(512),
    content_type character varying(255),
    size_bytes integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: inbound_emails; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.inbound_emails (
    id character varying(36) NOT NULL,
    legacy_message_id character varying(512),
    from_email character varying(255),
    to_emails jsonb,
    subject character varying(998),
    received_at timestamp with time zone,
    attachment_count integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: industries; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.industries (
    id character varying(36) NOT NULL,
    name character varying(100),
    description text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: legal_entities; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.legal_entities (
    id character varying(36) NOT NULL,
    legacy_accounting_id character varying(10),
    name character varying(100),
    legal_name character varying(255),
    is_california boolean,
    is_roofing boolean,
    is_project_entity boolean,
    is_active boolean,
    billing_address_id character varying(36),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: opportunities; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.opportunities (
    id character varying(36) NOT NULL,
    legacy_opportunity_number character varying(50),
    site_name character varying(50),
    contact_id character varying(36),
    site_contact_id character varying(36),
    referral_contact_id character varying(36),
    address_id character varying(36),
    reporting_branch_id character varying(36),
    operating_branch_id character varying(36),
    catastrophe_event_id character varying(36),
    status text,
    project_type text,
    miscellaneous_type text,
    source character varying(100),
    contact_date timestamp with time zone,
    contact_method character varying(100),
    urgency character varying(50),
    qualified_at timestamp with time zone,
    disqualified_at timestamp with time zone,
    disqualification_reason character varying(255),
    incident_date timestamp with time zone,
    reported_date timestamp with time zone,
    loss_type text,
    severity text,
    incident_description text,
    incident_cause character varying(255),
    affected_areas text,
    damage_description text,
    special_requirements text,
    estimated_value numeric(12,2),
    square_footage_potential integer,
    likelihood_conversion integer,
    bid_required boolean,
    won_date timestamp with time zone,
    lost_date timestamp with time zone,
    lost_reason character varying(255),
    cancelled_date timestamp with time zone,
    cancelled_reason character varying(255),
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: opportunity_documents; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.opportunity_documents (
    id character varying(36) NOT NULL,
    opportunity_id character varying(36),
    document_id character varying(36),
    notes character varying(1000),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: project_documents; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.project_documents (
    id character varying(36) NOT NULL,
    project_id character varying(36),
    document_id character varying(36),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: project_notes; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.project_notes (
    id character varying(36) NOT NULL,
    project_id character varying(36),
    content text,
    created_by_email character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: projects; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.projects (
    id character varying(36) NOT NULL,
    opportunity_id character varying(36),
    project_number character varying(50),
    site_name character varying(50),
    contact_id character varying(36),
    legal_entity_id character varying(36),
    project_type text,
    status text,
    contract_value numeric(12,2),
    default_profit_margin numeric(5,2),
    first_day_on_site timestamp with time zone,
    estimated_completion_date timestamp with time zone,
    actual_completion_date timestamp with time zone,
    completed_at timestamp with time zone,
    closed_at timestamp with time zone,
    original_closed_at timestamp with time zone,
    cancelled_date timestamp with time zone,
    cancelled_reason text,
    cancelled_from_status text,
    roof_access text,
    roof_access_notes text,
    special_requirements text,
    requires_authorization_for_invoicing boolean,
    wip_start_contract_value numeric(12,2),
    notes text,
    cancelled_by_email character varying,
    completed_by_email character varying,
    closed_by_email character varying,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: standard_tasks; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.standard_tasks (
    id character varying(36) NOT NULL,
    code character varying(50),
    name character varying(255),
    legacy_task_id character varying(50),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: vendor_accounts; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.vendor_accounts (
    id character varying(36) NOT NULL,
    company_id character varying(255),
    legacy_vendor_id character varying(255),
    legacy_vendor_name character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: vendor_discount_terms; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.vendor_discount_terms (
    id character varying(36) NOT NULL,
    company_id character varying(36),
    discount_percentage numeric(5,2),
    discount_days integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: work_authorizations; Type: TABLE; Schema: source_company; Owner: -
--

CREATE TABLE source_company.work_authorizations (
    id character varying(36) NOT NULL,
    contact_id character varying(36),
    authorization_number character varying(50),
    title character varying(255),
    description text,
    authorized_amount numeric(12,2),
    status text,
    customer_signed boolean,
    customer_signed_by character varying(255),
    customer_signed_at timestamp with time zone,
    contractor_signed boolean,
    contractor_signed_by character varying(255),
    contractor_signed_at timestamp with time zone,
    effective_date timestamp with time zone,
    expires_at timestamp with time zone,
    is_emergency_authorization boolean,
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Data for Name: accounting_periods; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.accounting_periods (id, year, month, status, created_at, updated_at) FROM stdin;
7ebca22c-392c-4a80-966a-eedd2c0d8760	2025	1	CLOSED	2026-07-24 18:24:02.713296+00	2026-07-24 18:24:02.713296+00
840a84eb-fdd1-49d0-8dc4-46cb6ec648dc	2025	2	CLOSED	2026-07-24 18:24:02.713296+00	2026-07-24 18:24:02.713296+00
771d5ec2-9152-4729-bd78-7d4d908e0f47	2025	3	CLOSED	2026-07-24 18:24:02.713296+00	2026-07-24 18:24:02.713296+00
d931f836-4126-4484-bad2-e41924ebd354	2025	4	CLOSED	2026-07-24 18:24:02.713296+00	2026-07-24 18:24:02.713296+00
d0e7edcb-4719-4bb5-a1d2-9579cc4a007f	2025	5	CLOSED	2026-07-24 18:24:02.713296+00	2026-07-24 18:24:02.713296+00
7641b3d9-6931-4e22-afef-fafd70b0b9fc	2025	6	CLOSED	2026-07-24 18:24:02.713296+00	2026-07-24 18:24:02.713296+00
a945fac6-a36e-4e77-a9d1-a4cd470eb8d1	2025	7	CLOSED	2026-07-24 18:24:02.713296+00	2026-07-24 18:24:02.713296+00
2630fe7d-7cab-4498-9446-f854c7c77e38	2025	8	CLOSED	2026-07-24 18:24:02.713296+00	2026-07-24 18:24:02.713296+00
8dc5b0c2-afa5-47c2-8271-3a328c605d5d	2025	9	CLOSED	2026-07-24 18:24:02.713296+00	2026-07-24 18:24:02.713296+00
129253ea-76f4-4e3b-8af8-168fac5def9e	2025	10	CLOSED	2026-07-24 18:24:02.713296+00	2026-07-24 18:24:08.125212+00
6f712f9c-9fe8-40db-b08e-773147be0c9c	2025	11	CLOSED	2026-07-24 18:24:02.713296+00	2026-07-24 18:24:08.125665+00
30a49d71-27c8-41e1-961f-44cedeb17075	2025	12	CLOSED	2026-07-24 18:24:02.713296+00	2026-07-24 18:24:08.125924+00
7fce685f-f008-56c7-9ba1-05708fac02b9	2026	1	CLOSED	2026-07-24 18:24:08.126357+00	2026-07-24 18:24:08.126358+00
d225e5c8-0c2e-5260-8099-70018e9309a4	2026	2	CLOSED	2026-07-24 18:24:08.126794+00	2026-07-24 18:24:08.126795+00
dd2ba097-a9a7-5d58-a150-e0073ba9ac55	2026	7	OPEN	2026-07-24 18:24:11.838733+00	2026-07-24 18:24:11.838734+00
279a4515-0711-5a22-8de4-1ea9cc4386bb	2026	8	OPEN	2026-07-24 18:24:11.838994+00	2026-07-24 18:24:11.838995+00
7d842071-b6de-5870-98b3-b325f878b338	2026	9	OPEN	2026-07-24 18:24:11.839234+00	2026-07-24 18:24:11.839234+00
320c6bc8-53f7-5ff4-a9ed-0a7ae5a55117	2026	6	CLOSED	2026-07-24 18:24:11.838388+00	2026-07-24 18:41:18.42136+00
38d00f5f-4b78-56ec-86db-0ae3cfe03421	2026	4	CLOSED	2026-07-24 18:24:08.127327+00	2026-07-25 19:17:47.41547+00
828bad21-25eb-5ac9-87f3-36c7ce6bfa4a	2026	5	CLOSED	2026-07-24 18:24:08.127588+00	2026-07-25 19:17:47.415473+00
ccb7886e-b39d-5660-a861-404a3aeca240	2026	3	CLOSED	2026-07-24 18:24:08.127065+00	2026-07-25 19:17:47.415473+00
\.


--
-- Data for Name: actual_costs; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.actual_costs (id, budget_id, opportunity_id, vendor_id, source_ap_invoice_id, cost_date, cost_code, item_name, amount, notes, legacy_expense_id, legacy_journal_line_id, created_at, updated_at) FROM stdin;
e4065ddb-7afe-44d6-ba1e-856f631c05f9	a933dbdd-3357-42d7-b5e7-bf91d75392d1	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	\N	\N	2026-07-17 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Antimicrobial & consumables	5760.00	\N	\N	\N	2026-07-24 18:24:10.565566+00	2026-07-24 18:24:10.565567+00
28202dcf-b8ed-4bac-b8b4-8a7b26212e9c	a933dbdd-3357-42d7-b5e7-bf91d75392d1	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	\N	\N	2026-07-16 18:24:07.827117+00	EQUIPMENT_RENTAL_AND_FUEL	Drying equipment rental	13440.00	\N	\N	\N	2026-07-24 18:24:10.564022+00	2026-07-24 18:24:10.564023+00
12d1dc2e-da06-4395-94ed-4ea2df51b717	a933dbdd-3357-42d7-b5e7-bf91d75392d1	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	\N	\N	2026-07-14 18:24:07.827117+00	INTERNAL_LABOR	Emergency crew labor — week 1	21120.00	\N	\N	\N	2026-07-24 18:24:10.561686+00	2026-07-24 18:24:10.561687+00
1cb32d20-3ddd-4bf8-ba5d-1d89e550dbd1	083c0384-ea66-44c8-afaa-0aa166559328	f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	\N	\N	2026-07-19 18:24:07.827117+00	EQUIPMENT_RENTAL_AND_FUEL	Dehumidifier fleet	6960.00	\N	\N	\N	2026-07-24 18:24:10.568434+00	2026-07-24 18:24:10.568435+00
ae95641b-009f-4e47-b767-bc0d85014ca8	083c0384-ea66-44c8-afaa-0aa166559328	f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	\N	\N	2026-07-18 18:24:07.827117+00	INTERNAL_LABOR	Containment build & demolition labor	11600.00	\N	\N	\N	2026-07-24 18:24:10.567004+00	2026-07-24 18:24:10.567004+00
e6510eca-54b1-4bba-8f3b-759c394064d6	b54a0bb4-25da-4f89-a4bf-074e4d5443ad	509e5e53-df5e-42c4-bd79-3ea5b49497d8	\N	\N	2026-07-12 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Metal panels & skylight order	48280.00	\N	\N	\N	2026-07-24 18:24:10.571255+00	2026-07-24 18:24:10.571255+00
ad495ada-2b5d-4362-aba8-ee529f4afd31	b54a0bb4-25da-4f89-a4bf-074e4d5443ad	509e5e53-df5e-42c4-bd79-3ea5b49497d8	\N	\N	2026-07-09 18:24:07.827117+00	INTERNAL_LABOR	Roofing crew labor — mobilization	25560.00	\N	\N	\N	2026-07-24 18:24:10.569821+00	2026-07-24 18:24:10.569821+00
06b4e13f-193d-43b2-975e-7a5d5784e6f5	3ec45ca8-1671-4246-9d1d-fa244ee3ee13	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	\N	\N	2026-07-14 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Finish materials	27360.00	\N	\N	\N	2026-07-24 18:24:10.575772+00	2026-07-24 18:24:10.575772+00
fa02a9ab-6889-4252-b1be-6c2846c3c510	3ec45ca8-1671-4246-9d1d-fa244ee3ee13	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	\N	\N	2026-07-04 18:24:07.827117+00	INTERNAL_LABOR	Acoustic ceiling & framing labor	50160.00	\N	\N	\N	2026-07-24 18:24:10.574208+00	2026-07-24 18:24:10.574209+00
83cfbbfe-e4ff-436c-a7b3-9fb9345f0fee	3ec45ca8-1671-4246-9d1d-fa244ee3ee13	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	\N	\N	2026-06-24 18:24:07.827117+00	SPECIALTY_SUBCONTRACTOR	Millwork package deposit	63840.00	\N	\N	\N	2026-07-24 18:24:10.572737+00	2026-07-24 18:24:10.572737+00
42f3ceaf-1e30-4f1b-9bd5-e80767668a91	abb76735-d7c4-41d3-bcb8-c4b2d5eb037d	71cf10e3-2ca6-4256-8e3c-6b10ee266997	\N	\N	2026-07-02 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Modified bitumen & insulation	116200.00	\N	\N	\N	2026-07-24 18:24:10.578616+00	2026-07-24 18:24:10.578616+00
2f2c461d-2dfe-41cc-a4c0-4b92bf4ea85c	abb76735-d7c4-41d3-bcb8-c4b2d5eb037d	71cf10e3-2ca6-4256-8e3c-6b10ee266997	\N	\N	2026-06-29 18:24:07.827117+00	INTERNAL_LABOR	Tear-off crew labor	66400.00	\N	\N	\N	2026-07-24 18:24:10.577232+00	2026-07-24 18:24:10.577233+00
7166b171-e557-4c70-8d60-ec80fc8488c7	f8d906ba-4068-4ef0-a3d5-283fb6029105	f2717f36-697a-430f-a485-bcafc9482a32	\N	\N	2026-06-29 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Sprinkler main materials	36400.00	\N	\N	\N	2026-07-24 18:24:10.584519+00	2026-07-24 18:24:10.58452+00
6b8b26ee-50f2-4b20-91ac-3eeb1ffa1ddd	f8d906ba-4068-4ef0-a3d5-283fb6029105	f2717f36-697a-430f-a485-bcafc9482a32	\N	\N	2026-06-24 18:24:07.827117+00	INTERNAL_LABOR	Field labor — framing	72800.00	\N	\N	\N	2026-07-24 18:24:10.583021+00	2026-07-24 18:24:10.583021+00
f589d3d9-3503-4468-a82d-2ed6db79d92b	f8d906ba-4068-4ef0-a3d5-283fb6029105	f2717f36-697a-430f-a485-bcafc9482a32	\N	\N	2026-06-09 18:24:07.827117+00	SPECIALTY_SUBCONTRACTOR	Concrete & masonry	81900.00	\N	\N	\N	2026-07-24 18:24:10.58124+00	2026-07-24 18:24:10.581241+00
65b401bc-98c6-4dc3-a90f-05d1e2962e19	f8d906ba-4068-4ef0-a3d5-283fb6029105	f2717f36-697a-430f-a485-bcafc9482a32	\N	\N	2026-05-25 18:24:07.827117+00	SPECIALTY_SUBCONTRACTOR	Structural steel subcontract	136500.00	\N	\N	\N	2026-07-24 18:24:10.579899+00	2026-07-24 18:24:10.5799+00
25a5aa8f-8428-4dfe-8f5f-c1b839a4494a	f62f0e7d-5ce7-4765-96e0-3cff028b000b	d80d6bca-688a-4dad-9204-89366f709b4f	\N	\N	2026-07-06 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Finish materials	46240.00	\N	\N	\N	2026-07-24 18:24:10.589081+00	2026-07-24 18:24:10.589081+00
931c126a-a1dc-4450-b39e-4b0a4ff606f5	f62f0e7d-5ce7-4765-96e0-3cff028b000b	d80d6bca-688a-4dad-9204-89366f709b4f	\N	\N	2026-06-22 18:24:07.827117+00	SPECIALTY_SUBCONTRACTOR	Duct cleaning subcontract	40460.00	\N	\N	\N	2026-07-24 18:24:10.587596+00	2026-07-24 18:24:10.587596+00
12dee962-a084-435e-9b02-871f55516d09	f62f0e7d-5ce7-4765-96e0-3cff028b000b	d80d6bca-688a-4dad-9204-89366f709b4f	\N	\N	2026-06-14 18:24:07.827117+00	INTERNAL_LABOR	Smoke remediation labor	69360.00	\N	\N	\N	2026-07-24 18:24:10.585983+00	2026-07-24 18:24:10.585983+00
d1aa6933-7739-4dde-b472-3cd0f0374bf7	c437b9bd-2dea-4be3-ae90-d59b17928a30	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	\N	\N	2026-06-30 18:24:07.827117+00	EQUIPMENT_RENTAL_AND_FUEL	Generator & equipment rental	32040.00	\N	\N	\N	2026-07-24 18:24:10.592272+00	2026-07-24 18:24:10.592273+00
c3bed3ca-c4bf-4253-9f87-3c1ebc80ea75	c437b9bd-2dea-4be3-ae90-d59b17928a30	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	\N	\N	2026-06-26 18:24:07.827117+00	INTERNAL_LABOR	Extraction & drying labor	53400.00	\N	\N	\N	2026-07-24 18:24:10.590546+00	2026-07-24 18:24:10.590547+00
3bc849e8-229b-4f33-b5ed-1ccde2574323	9e3a6080-5814-4d19-94c7-61c3bfa59039	36fd7907-a7d3-4f4b-a838-0810a2a81669	\N	\N	2026-07-18 18:24:07.827117+00	INTERNAL_LABOR	Deck repair labor	27150.00	\N	\N	\N	2026-07-24 18:24:10.597096+00	2026-07-24 18:24:10.597097+00
1c687d74-1c0b-4be5-b32a-af08ba5115f3	9e3a6080-5814-4d19-94c7-61c3bfa59039	36fd7907-a7d3-4f4b-a838-0810a2a81669	\N	\N	2026-07-12 18:24:07.827117+00	SPECIALTY_SUBCONTRACTOR	Electrical subcontract	61540.00	\N	\N	\N	2026-07-24 18:24:10.595551+00	2026-07-24 18:24:10.595552+00
9b9adeb6-b265-4f30-8d15-91a711c1f127	9e3a6080-5814-4d19-94c7-61c3bfa59039	36fd7907-a7d3-4f4b-a838-0810a2a81669	\N	\N	2026-07-04 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Switchgear procurement	99550.00	\N	\N	\N	2026-07-24 18:24:10.593894+00	2026-07-24 18:24:10.593895+00
de1ac255-93f3-4079-ac44-4dc67a70a441	f1dbebe5-e960-46d4-82b5-95a56bc4c6c0	328b7c55-274d-421b-aee2-163df067ffd1	\N	\N	2026-07-21 18:24:07.827117+00	SPECIALTY_SUBCONTRACTOR	Pole bases & boring	8900.00	\N	\N	\N	2026-07-24 18:24:10.598541+00	2026-07-24 18:24:10.598541+00
7124dbe8-9a18-442b-b454-8b976839885b	3cfb5915-512b-4547-b15c-cd8a3accb54b	9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	\N	\N	2026-07-06 18:24:07.827117+00	SPECIALTY_SUBCONTRACTOR	Paint subcontract	16400.00	\N	\N	\N	2026-07-24 18:24:10.603201+00	2026-07-24 18:24:10.603201+00
8e3e42fc-5a63-4cc8-ac20-f3a77448c91f	3cfb5915-512b-4547-b15c-cd8a3accb54b	9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	\N	\N	2026-07-02 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Flooring & finish materials	24600.00	\N	\N	\N	2026-07-24 18:24:10.601561+00	2026-07-24 18:24:10.601562+00
9f657317-cbbd-4217-a34e-068f1a37eaed	3cfb5915-512b-4547-b15c-cd8a3accb54b	9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	\N	\N	2026-06-24 18:24:07.827117+00	INTERNAL_LABOR	Restoration labor	34440.00	\N	\N	\N	2026-07-24 18:24:10.599999+00	2026-07-24 18:24:10.599999+00
67bb6afb-97cd-409b-87f0-b1fca3d372c8	690e89e9-95ec-4209-950c-f0f6a05efc76	774de069-49ca-4cd5-a20e-9bb97382cdd2	\N	\N	2026-07-04 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Pipe & valve materials	18480.00	\N	\N	\N	2026-07-24 18:24:10.605875+00	2026-07-24 18:24:10.605876+00
696a24c7-ba6c-422b-8cbb-2641aafdc7bb	690e89e9-95ec-4209-950c-f0f6a05efc76	774de069-49ca-4cd5-a20e-9bb97382cdd2	\N	\N	2026-06-29 18:24:07.827117+00	SPECIALTY_SUBCONTRACTOR	Fire protection subcontract	36300.00	\N	\N	\N	2026-07-24 18:24:10.604542+00	2026-07-24 18:24:10.604542+00
31f4cc90-465a-414f-b971-79831e1054e6	1f85489c-24cc-4dfa-9b96-b4b10f9998f8	4539b766-a4f6-4871-a6dc-0b1820f0f627	\N	\N	2026-07-12 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Drainage materials	12450.00	\N	\N	\N	2026-07-24 18:24:10.608514+00	2026-07-24 18:24:10.608515+00
9ad0e677-fb85-427b-b4f7-6ef63514cb23	1f85489c-24cc-4dfa-9b96-b4b10f9998f8	4539b766-a4f6-4871-a6dc-0b1820f0f627	\N	\N	2026-07-09 18:24:07.827117+00	INTERNAL_LABOR	Excavation & pipe crew	19920.00	\N	\N	\N	2026-07-24 18:24:10.60713+00	2026-07-24 18:24:10.607131+00
1aaa779b-c02b-4272-a8f6-349acb9e2a4f	d4f0ef96-7456-470f-83c7-38137be20653	08ed21da-c5f3-40d0-b44c-15897cfdd3b1	\N	\N	2026-07-12 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	FF&E and finish materials	30560.00	\N	\N	\N	2026-07-24 18:24:10.611107+00	2026-07-24 18:24:10.611107+00
5f3a94c1-b48f-468f-aa4f-5233cc5be83e	d4f0ef96-7456-470f-83c7-38137be20653	08ed21da-c5f3-40d0-b44c-15897cfdd3b1	\N	\N	2026-07-06 18:24:07.827117+00	INTERNAL_LABOR	Guest room restoration labor	38200.00	\N	\N	\N	2026-07-24 18:24:10.609795+00	2026-07-24 18:24:10.609796+00
51f9e126-7d99-4bc5-9a02-bdb5f81bc04d	86c8ea96-f125-4925-8fef-38f245ec9f8a	d32da9f2-4215-48f9-a1ec-71e967453305	\N	\N	2026-06-09 18:24:07.827117+00	INTERNAL_LABOR	Supervision labor	42800.00	\N	\N	\N	2026-07-24 18:24:10.615822+00	2026-07-24 18:24:10.615822+00
31997c91-e49a-49af-8570-fc73ae4140a8	86c8ea96-f125-4925-8fef-38f245ec9f8a	d32da9f2-4215-48f9-a1ec-71e967453305	\N	\N	2026-05-30 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	TPO membrane & insulation	145520.00	\N	\N	\N	2026-07-24 18:24:10.614354+00	2026-07-24 18:24:10.614355+00
57d8a37c-c33e-438f-86de-253f4cb6f486	86c8ea96-f125-4925-8fef-38f245ec9f8a	d32da9f2-4215-48f9-a1ec-71e967453305	\N	\N	2026-05-25 18:24:07.827117+00	SPECIALTY_SUBCONTRACTOR	Roofing subcontract	222560.00	\N	\N	\N	2026-07-24 18:24:10.612846+00	2026-07-24 18:24:10.612847+00
201967f7-32cf-4ef9-a2f7-5f295e68531d	e1111e67-0fa0-488c-90df-bef48b2f5e16	249e5252-b737-446a-be25-f5e910a7380d	\N	\N	2026-05-05 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Disposal	15040.00	\N	\N	\N	2026-07-24 18:24:10.620176+00	2026-07-24 18:24:10.620176+00
f7b8e9cb-5721-4148-911a-b92bea76dca8	e1111e67-0fa0-488c-90df-bef48b2f5e16	249e5252-b737-446a-be25-f5e910a7380d	\N	\N	2026-04-30 18:24:07.827117+00	EQUIPMENT_RENTAL_AND_FUEL	Equipment & scrubbers	24440.00	\N	\N	\N	2026-07-24 18:24:10.618875+00	2026-07-24 18:24:10.618875+00
d9de4e74-b873-4b08-80d4-509c6166a132	e1111e67-0fa0-488c-90df-bef48b2f5e16	249e5252-b737-446a-be25-f5e910a7380d	\N	\N	2026-04-25 18:24:07.827117+00	INTERNAL_LABOR	Smoke remediation labor	48880.00	\N	\N	\N	2026-07-24 18:24:10.61734+00	2026-07-24 18:24:10.61734+00
29b58b4f-f9e4-4255-ae2e-7ef229826f57	7999ab34-a3c0-4894-a153-332cf7d0e7a3	3d320ab8-7e02-4557-ab26-c65abc774688	\N	\N	2026-05-27 18:24:07.827117+00	SPECIALTY_SUBCONTRACTOR	Clearance testing	8475.00	\N	\N	\N	2026-07-24 18:24:10.62414+00	2026-07-24 18:24:10.62414+00
79aba02d-9253-44fb-b533-efc80ea3a0f1	7999ab34-a3c0-4894-a153-332cf7d0e7a3	3d320ab8-7e02-4557-ab26-c65abc774688	\N	\N	2026-05-20 18:24:07.827117+00	EQUIPMENT_RENTAL_AND_FUEL	Air scrubbers & PPE	13560.00	\N	\N	\N	2026-07-24 18:24:10.622785+00	2026-07-24 18:24:10.622786+00
154596f6-1353-45a1-bdb5-c2382c0c1079	7999ab34-a3c0-4894-a153-332cf7d0e7a3	3d320ab8-7e02-4557-ab26-c65abc774688	\N	\N	2026-05-15 18:24:07.827117+00	INTERNAL_LABOR	Containment & remediation labor	28250.00	\N	\N	\N	2026-07-24 18:24:10.621467+00	2026-07-24 18:24:10.621468+00
ac22e265-8c37-4195-97fc-f1f21ec2ecec	dad8243c-a8ef-4a24-acf9-1aaf72f3ca42	906bdaec-dfde-4248-bae6-57191ccf3277	\N	\N	2026-05-25 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Materials	43780.00	\N	\N	\N	2026-07-24 18:24:10.628401+00	2026-07-24 18:24:10.628401+00
b19462ae-a243-4a5d-a745-94fa64cfc0f5	dad8243c-a8ef-4a24-acf9-1aaf72f3ca42	906bdaec-dfde-4248-bae6-57191ccf3277	\N	\N	2026-05-20 18:24:07.827117+00	INTERNAL_LABOR	Interior finish labor	59700.00	\N	\N	\N	2026-07-24 18:24:10.627015+00	2026-07-24 18:24:10.627016+00
f879827d-a826-4899-8e2d-807e39377f7f	dad8243c-a8ef-4a24-acf9-1aaf72f3ca42	906bdaec-dfde-4248-bae6-57191ccf3277	\N	\N	2026-05-05 18:24:07.827117+00	SPECIALTY_SUBCONTRACTOR	Roof monitor subcontract	79600.00	\N	\N	\N	2026-07-24 18:24:10.62553+00	2026-07-24 18:24:10.62553+00
24159dce-6e31-4fa6-b081-df244f518e48	0943c294-950e-47ad-9c6f-b407b6b82045	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	\N	\N	2026-06-30 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Consumables & disposal	17640.00	\N	\N	\N	2026-07-24 18:24:10.632459+00	2026-07-24 18:24:10.632459+00
b33914e2-7f08-44a0-8873-08557d5b30a4	0943c294-950e-47ad-9c6f-b407b6b82045	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	\N	\N	2026-06-28 18:24:07.827117+00	EQUIPMENT_RENTAL_AND_FUEL	Drying equipment	41160.00	\N	\N	\N	2026-07-24 18:24:10.630968+00	2026-07-24 18:24:10.630968+00
8c93ef21-9779-4138-bb80-62dbf8258547	0943c294-950e-47ad-9c6f-b407b6b82045	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	\N	\N	2026-06-24 18:24:07.827117+00	INTERNAL_LABOR	Emergency response labor	80850.00	\N	\N	\N	2026-07-24 18:24:10.629683+00	2026-07-24 18:24:10.629683+00
7fef0651-0bf6-4c4e-9905-cb7cf6a8a5f2	983e3328-f010-448d-aad0-a98da3b989b3	2cb81f29-032f-4247-8259-d7d4d3ffa28f	\N	\N	2026-06-06 18:24:07.827117+00	INTERNAL_LABOR	Install labor	31730.00	\N	\N	\N	2026-07-24 18:24:10.6352+00	2026-07-24 18:24:10.6352+00
f9177c8b-09cb-4114-8a97-c6be6f30b359	983e3328-f010-448d-aad0-a98da3b989b3	2cb81f29-032f-4247-8259-d7d4d3ffa28f	\N	\N	2026-05-30 18:24:07.827117+00	MATERIALS_AND_SUPPLIES	Skylight units & curbs	36740.00	\N	\N	\N	2026-07-24 18:24:10.633875+00	2026-07-24 18:24:10.633875+00
\.


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.addresses (id, street_address, unit, city, state, zip_code, country, normalized_address, latitude, longitude, created_at, updated_at) FROM stdin;
4ac6fe80-4792-4ed6-9c7f-ee6efe324eeb	Unknown Address	\N	Unknown City	Unknown State	00000	USA	UNKNOWN ADDRESS UNKNOWN CITY UNKNOWN STATE 00000	\N	\N	2026-07-24 18:24:01.902934+00	2026-07-24 18:24:01.902934+00
ba-corp-0000-0000-0000-000000000000	2100 Commerce St	\N	Dallas	TX	75201-5021	USA	2100 COMMERCE ST DALLAS TX 75201-5021	\N	\N	2026-07-24 18:24:04.485466+00	2026-07-24 18:24:04.485466+00
ba-test-0000-0000-0000-000000000000	2100 Commerce St	\N	Dallas	TX	75201-5021	USA	2100 COMMERCE ST DALLAS TX 75201-5021	\N	\N	2026-07-24 18:24:07.930624+00	2026-07-24 18:24:07.930628+00
cda0ec08-d16e-41bc-8e6c-ce01f2395df6	2010 Ross Avenue, Suite 1200	Suite 101	Dallas	TX	75201	USA	2010 ROSS AVENUE, SUITE 1200 SUITE 101 DALLAS TX 75201	\N	\N	2026-07-24 18:24:08.206443+00	2026-07-24 18:24:08.206444+00
7109f5f2-b7b8-4c09-af09-a02c7c52b54b	9800 Hargrove Drive	Suite 102	Dallas	TX	75220	USA	9800 HARGROVE DRIVE SUITE 102 DALLAS TX 75220	\N	\N	2026-07-24 18:24:08.261966+00	2026-07-24 18:24:08.261967+00
f0b7b065-dc31-4114-8c2b-9f5f1e979e9b	501 Congress Avenue, Suite 900	Suite 103	Austin	TX	78701	USA	501 CONGRESS AVENUE, SUITE 900 SUITE 103 AUSTIN TX 78701	\N	\N	2026-07-24 18:24:08.278805+00	2026-07-24 18:24:08.278806+00
29021e89-4fd1-4d32-b4eb-d58488cee5e6	7979 Walnut Hill Lane	Suite 104	Dallas	TX	75231	USA	7979 WALNUT HILL LANE SUITE 104 DALLAS TX 75231	\N	\N	2026-07-24 18:24:08.308718+00	2026-07-24 18:24:08.308719+00
24f88819-fbfc-4a04-b665-a1af9ff7b60f	1400 Northgate Boulevard	Suite 105	Houston	TX	77067	USA	1400 NORTHGATE BOULEVARD SUITE 105 HOUSTON TX 77067	\N	\N	2026-07-24 18:24:08.325663+00	2026-07-24 18:24:08.325664+00
fef95522-14d9-445f-b59a-b12f1d048ffb	4550 East McDowell Road	Suite 106	Phoenix	AZ	85008	USA	4550 EAST MCDOWELL ROAD SUITE 106 PHOENIX AZ 85008	\N	\N	2026-07-24 18:24:08.343928+00	2026-07-24 18:24:08.343929+00
8399781a-6dc5-4f19-a253-8673ab652128	12600 Memorial Drive	Suite 107	Houston	TX	77024	USA	12600 MEMORIAL DRIVE SUITE 107 HOUSTON TX 77024	\N	\N	2026-07-24 18:24:08.360207+00	2026-07-24 18:24:08.360207+00
7272be66-07a1-47ab-ae21-5fbd023e617f	3900 Singleton Boulevard	Suite 108	Dallas	TX	75212	USA	3900 SINGLETON BOULEVARD SUITE 108 DALLAS TX 75212	\N	\N	2026-07-24 18:24:08.375817+00	2026-07-24 18:24:08.375818+00
3f9312e5-e6e9-49c2-92a0-6629b57eaacc	7801 North Lamar Boulevard	Suite 109	Austin	TX	78752	USA	7801 NORTH LAMAR BOULEVARD SUITE 109 AUSTIN TX 78752	\N	\N	2026-07-24 18:24:08.391248+00	2026-07-24 18:24:08.391249+00
3432c722-74d6-4046-8d02-e175bf4e4c7e	1100 Louisiana Street, Suite 2500	Suite 110	Houston	TX	77002	USA	1100 LOUISIANA STREET, SUITE 2500 SUITE 110 HOUSTON TX 77002	\N	\N	2026-07-24 18:24:08.409892+00	2026-07-24 18:24:08.409893+00
6a5d402a-5623-4032-8508-b3de1c7c0a51	8800 East Hampden Avenue	Suite 111	Denver	CO	80231	USA	8800 EAST HAMPDEN AVENUE SUITE 111 DENVER CO 80231	\N	\N	2026-07-24 18:24:08.427291+00	2026-07-24 18:24:08.427291+00
3d535e89-acf7-4b11-aeda-715827f7fc38	6200 West Buckeye Road	Suite 112	Phoenix	AZ	85043	USA	6200 WEST BUCKEYE ROAD SUITE 112 PHOENIX AZ 85043	\N	\N	2026-07-24 18:24:08.445415+00	2026-07-24 18:24:08.445416+00
7b59b165-21c3-4f9a-a3fe-4a2a3e225605	2500 Harborside Drive	Suite 113	Galveston	TX	77550	USA	2500 HARBORSIDE DRIVE SUITE 113 GALVESTON TX 77550	\N	\N	2026-07-24 18:24:08.46259+00	2026-07-24 18:24:08.462591+00
a8d0721b-1181-429f-adcf-035f3d91f69d	215 East Houston Street	Suite 114	San Antonio	TX	78205	USA	215 EAST HOUSTON STREET SUITE 114 SAN ANTONIO TX 78205	\N	\N	2026-07-24 18:24:08.478436+00	2026-07-24 18:24:08.478436+00
12ffc34f-1670-4dd6-a798-c0979a855bb5	4400 Irving Boulevard	Suite 115	Dallas	TX	75247	USA	4400 IRVING BOULEVARD SUITE 115 DALLAS TX 75247	\N	\N	2026-07-24 18:24:08.493651+00	2026-07-24 18:24:08.493651+00
6d476b3c-abcf-45ce-bfef-626dfbd1f3bb	3160 East Spring Creek Parkway	Suite 116	Plano	TX	75074	USA	3160 EAST SPRING CREEK PARKWAY SUITE 116 PLANO TX 75074	\N	\N	2026-07-24 18:24:08.510957+00	2026-07-24 18:24:08.510958+00
37fb5fe6-f3fc-4e66-b8e2-2246d25a42df	11200 Stemmons Freeway	Suite 117	Dallas	TX	75229	USA	11200 STEMMONS FREEWAY SUITE 117 DALLAS TX 75229	\N	\N	2026-07-24 18:24:08.529438+00	2026-07-24 18:24:08.529438+00
99949bbd-e2c8-4d18-b325-b42c57df4ff5	2801 South Interstate 35E	Suite 118	Lancaster	TX	75134	USA	2801 SOUTH INTERSTATE 35E SUITE 118 LANCASTER TX 75134	\N	\N	2026-07-24 18:24:08.540429+00	2026-07-24 18:24:08.54043+00
dcbaa3f8-0f44-418c-bc7e-085ef35978fc	5150 Sharp Street	Suite 119	Dallas	TX	75247	USA	5150 SHARP STREET SUITE 119 DALLAS TX 75247	\N	\N	2026-07-24 18:24:08.551686+00	2026-07-24 18:24:08.551686+00
18dfed5d-a26a-4ab1-84fb-78e296d2dcae	8830 North Sam Houston Parkway	Suite 120	Houston	TX	77064	USA	8830 NORTH SAM HOUSTON PARKWAY SUITE 120 HOUSTON TX 77064	\N	\N	2026-07-24 18:24:08.563676+00	2026-07-24 18:24:08.563678+00
5ba48054-2453-4b85-a69d-20ff3fac7864	1901 East Riverside Drive	Suite 121	Austin	TX	78741	USA	1901 EAST RIVERSIDE DRIVE SUITE 121 AUSTIN TX 78741	\N	\N	2026-07-24 18:24:08.572112+00	2026-07-24 18:24:08.572113+00
30927971-96bd-4538-b452-874e9aa45df2	7434 Harwin Drive	Suite 122	Houston	TX	77036	USA	7434 HARWIN DRIVE SUITE 122 HOUSTON TX 77036	\N	\N	2026-07-24 18:24:08.579943+00	2026-07-24 18:24:08.579943+00
eba58e5d-550e-4c2e-95f3-1e56dc137e9a	3300 Century Circle	Suite 123	Irving	TX	75062	USA	3300 CENTURY CIRCLE SUITE 123 IRVING TX 75062	\N	\N	2026-07-24 18:24:08.587337+00	2026-07-24 18:24:08.587338+00
870388ea-d464-4798-a96d-7e3ac0590fff	4915 South Congress Avenue	Suite 124	Austin	TX	78745	USA	4915 SOUTH CONGRESS AVENUE SUITE 124 AUSTIN TX 78745	\N	\N	2026-07-24 18:24:08.595256+00	2026-07-24 18:24:08.595257+00
39113064-3712-4599-9999-a6720d10bc16	2222 West Peoria Avenue	Suite 125	Phoenix	AZ	85029	USA	2222 WEST PEORIA AVENUE SUITE 125 PHOENIX AZ 85029	\N	\N	2026-07-24 18:24:08.60381+00	2026-07-24 18:24:08.60381+00
70f5c45d-395e-4db3-b8d9-bbbf02d07adc	10550 Richmond Avenue	Suite 126	Houston	TX	77042	USA	10550 RICHMOND AVENUE SUITE 126 HOUSTON TX 77042	\N	\N	2026-07-24 18:24:08.612655+00	2026-07-24 18:24:08.612655+00
5ec12e07-ee46-438c-876f-b3ea14d6cf50	1100 Louisiana Street	\N	Houston	TX	77002	USA	1100 LOUISIANA STREET HOUSTON TX 77002	\N	\N	2026-07-24 18:24:08.637637+00	2026-07-24 18:24:08.637638+00
10575e96-95bf-486c-ae4e-3a9d8a10f50d	12600 Memorial Drive	\N	Houston	TX	77024	USA	12600 MEMORIAL DRIVE HOUSTON TX 77024	\N	\N	2026-07-24 18:24:08.733941+00	2026-07-24 18:24:08.733942+00
e7c25fc3-14d7-4015-a3fd-495947de0091	4550 East McDowell Road	\N	Phoenix	AZ	85008	USA	4550 EAST MCDOWELL ROAD PHOENIX AZ 85008	\N	\N	2026-07-24 18:24:08.766008+00	2026-07-24 18:24:08.766009+00
63d0b371-b67d-40e0-a8ed-8d8bf2411383	3160 East Spring Creek Parkway	\N	Plano	TX	75074	USA	3160 EAST SPRING CREEK PARKWAY PLANO TX 75074	\N	\N	2026-07-24 18:24:08.797264+00	2026-07-24 18:24:08.797265+00
af5a0069-696c-4247-bebc-b4aa2fba90b7	1400 Northgate Boulevard	\N	Houston	TX	77067	USA	1400 NORTHGATE BOULEVARD HOUSTON TX 77067	\N	\N	2026-07-24 18:24:08.827388+00	2026-07-24 18:24:08.827389+00
50577a8c-aaf3-43f5-bce1-c0b8d514acdd	6200 West Buckeye Road	\N	Phoenix	AZ	85043	USA	6200 WEST BUCKEYE ROAD PHOENIX AZ 85043	\N	\N	2026-07-24 18:24:08.863606+00	2026-07-24 18:24:08.863607+00
aa3c9138-8afd-44be-8504-959f59bccd1e	4400 Irving Boulevard	\N	Dallas	TX	75247	USA	4400 IRVING BOULEVARD DALLAS TX 75247	\N	\N	2026-07-24 18:24:08.899709+00	2026-07-24 18:24:08.89971+00
2a12bf11-ba9a-4765-8ef9-2263e249a7a9	501 Congress Avenue	\N	Austin	TX	78701	USA	501 CONGRESS AVENUE AUSTIN TX 78701	\N	\N	2026-07-24 18:24:08.931656+00	2026-07-24 18:24:08.931657+00
508f3772-d59f-4039-a516-893110ff4a46	3900 Singleton Boulevard	\N	Dallas	TX	75212	USA	3900 SINGLETON BOULEVARD DALLAS TX 75212	\N	\N	2026-07-24 18:24:08.962244+00	2026-07-24 18:24:08.962245+00
07ddc0d7-0347-4ae4-a9e7-7caffad7fe32	8800 East Hampden Avenue	\N	Denver	CO	80231	USA	8800 EAST HAMPDEN AVENUE DENVER CO 80231	\N	\N	2026-07-24 18:24:08.996642+00	2026-07-24 18:24:08.996643+00
f9d38b53-7a66-4837-8b40-e9df2a697d30	215 East Houston Street	\N	San Antonio	TX	78205	USA	215 EAST HOUSTON STREET SAN ANTONIO TX 78205	\N	\N	2026-07-24 18:24:09.03026+00	2026-07-24 18:24:09.030261+00
44b4fb75-da35-4e2f-b8e9-f004552b6942	7801 North Lamar Boulevard	\N	Austin	TX	78752	USA	7801 NORTH LAMAR BOULEVARD AUSTIN TX 78752	\N	\N	2026-07-24 18:24:09.065292+00	2026-07-24 18:24:09.065292+00
13f4b072-7d7c-4c7e-819e-4d547d15eb65	3110 Carlisle Street	\N	Dallas	TX	75204	USA	3110 CARLISLE STREET DALLAS TX 75204	\N	\N	2026-07-24 18:24:09.209993+00	2026-07-24 18:24:09.209995+00
e07ff3db-f6ed-4641-b985-7f61ae8226e6	7979 Walnut Hill Lane	\N	Dallas	TX	75231	USA	7979 WALNUT HILL LANE DALLAS TX 75231	\N	\N	2026-07-24 18:24:09.440455+00	2026-07-24 18:24:09.440458+00
a1e40a72-215e-4538-8f29-1001e0a43f4a	2500 Harborside Drive	\N	Galveston	TX	77550	USA	2500 HARBORSIDE DRIVE GALVESTON TX 77550	\N	\N	2026-07-24 18:24:09.510012+00	2026-07-24 18:24:09.510013+00
878e1693-f2c3-489d-97ad-a7c3d4d9035a	9800 Hargrove Drive	\N	Dallas	TX	75220	USA	9800 HARGROVE DRIVE DALLAS TX 75220	\N	\N	2026-07-24 18:24:09.562357+00	2026-07-24 18:24:09.562357+00
afd674c0-cdf0-40bf-9f38-b17b9ee7c215	2800 Commerce Street	\N	Dallas	TX	75226	USA	2800 COMMERCE STREET DALLAS TX 75226	\N	\N	2026-07-24 18:24:09.61543+00	2026-07-24 18:24:09.61543+00
d8525ce4-4c80-474f-a949-437cddae0813	1705 West Elliot Road	\N	Tempe	AZ	85284	USA	1705 WEST ELLIOT ROAD TEMPE AZ 85284	\N	\N	2026-07-24 18:24:09.709325+00	2026-07-24 18:24:09.709326+00
169490aa-bcdc-43aa-bb6c-f3ac80a4365b	2728 McKinney Avenue	\N	Dallas	TX	75204	USA	2728 MCKINNEY AVENUE DALLAS TX 75204	\N	\N	2026-07-24 18:24:10.071816+00	2026-07-24 18:24:10.071817+00
43f64236-da3c-4b76-a256-dcd16def11ab	8222 Douglas Avenue	\N	Dallas	TX	75225	USA	8222 DOUGLAS AVENUE DALLAS TX 75225	\N	\N	2026-07-24 18:24:10.25227+00	2026-07-24 18:24:10.252271+00
\.


--
-- Data for Name: ap_invoice_lines; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.ap_invoice_lines (id, invoice_id, description, quantity, unit_price, amount, created_at, updated_at) FROM stdin;
e4f186b2-60d4-4830-8fb1-f043c60f6436	7db3a24d-d6d4-41aa-8e3e-4ba1d69f4b4d	Air mover rental x40 — 2 weeks	1.000	2920.00	2920.00	2026-07-24 18:24:11.226949+00	2026-07-24 18:24:11.22695+00
2dbdaa90-664b-45a2-aa17-e0671f8ab92d	7db3a24d-d6d4-41aa-8e3e-4ba1d69f4b4d	LGR dehumidifier rental x12 — 2 weeks	1.000	6720.00	6720.00	2026-07-24 18:24:11.226948+00	2026-07-24 18:24:11.226949+00
44eee787-1803-4b66-83c3-16d68052df13	f13681b4-23bf-42da-80f3-6b623414de8f	Sealant & trim	1.000	1800.00	1800.00	2026-07-24 18:24:11.494999+00	2026-07-24 18:24:11.494999+00
8c662252-14ba-4b27-993c-3289e71d032e	f13681b4-23bf-42da-80f3-6b623414de8f	Skylight glazing units x18	1.000	13950.00	13950.00	2026-07-24 18:24:11.494998+00	2026-07-24 18:24:11.494999+00
377995ca-ca01-4212-bb94-e9d9b4bc3232	2036c5ee-daf7-45a7-bd1a-dc3a9c996a0f	Panel upgrades	1.000	8000.00	8000.00	2026-07-24 18:24:11.455511+00	2026-07-24 18:24:11.455511+00
60170083-718c-4bd7-8375-046e0e5a38e4	2036c5ee-daf7-45a7-bd1a-dc3a9c996a0f	Ballroom lighting rough-in	1.000	19400.00	19400.00	2026-07-24 18:24:11.45551+00	2026-07-24 18:24:11.455511+00
79a7330b-2404-4892-819f-ee26d4f652b9	81970914-67c8-49a1-8332-349ad177947c	Fasteners & adhesive	1.000	4000.00	4000.00	2026-07-24 18:24:11.186059+00	2026-07-24 18:24:11.186059+00
8b235d89-26c5-474e-b9f0-eff8148f42c9	81970914-67c8-49a1-8332-349ad177947c	Polyiso insulation R-25	1.000	13150.00	13150.00	2026-07-24 18:24:11.186058+00	2026-07-24 18:24:11.186058+00
404a5667-2a7e-4bac-b68f-a138a5865a0f	81970914-67c8-49a1-8332-349ad177947c	Modified bitumen membrane — 240 squares	1.000	31200.00	31200.00	2026-07-24 18:24:11.186057+00	2026-07-24 18:24:11.186058+00
50c80c2a-39d8-4774-ac3b-82f03a7768d1	42c4ace8-f0b2-4c20-bfbf-16e5019506c8	Dowel & joint sealing	1.000	11400.00	11400.00	2026-07-24 18:24:11.307072+00	2026-07-24 18:24:11.307072+00
4461df68-0483-415e-9436-3e10ea4d36d8	42c4ace8-f0b2-4c20-bfbf-16e5019506c8	Dock apron concrete replacement	1.000	52800.00	52800.00	2026-07-24 18:24:11.30707+00	2026-07-24 18:24:11.307071+00
5703d101-5969-43d4-9ee3-e34e73a50ec1	e134d780-492e-4519-bb3a-2e4170d357d2	Delivery & pickup	1.000	1600.00	1600.00	2026-07-24 18:24:10.876342+00	2026-07-24 18:24:10.876343+00
63ba25bc-ad07-4dac-a051-e2d8b0b7a9e7	e134d780-492e-4519-bb3a-2e4170d357d2	Scissor lift rental — 4 weeks	1.000	3600.00	3600.00	2026-07-24 18:24:10.876342+00	2026-07-24 18:24:10.876342+00
1326f0b6-a5f4-4122-a949-1fb3d3553b8d	e134d780-492e-4519-bb3a-2e4170d357d2	Telehandler rental — 4 weeks	1.000	7280.00	7280.00	2026-07-24 18:24:10.876341+00	2026-07-24 18:24:10.876342+00
a8d5ccff-437f-4ce8-b50b-da30bbfd8946	7aeec62d-7163-4e79-b430-bbca2ac488b8	Monthly rental	1.000	2200.00	2200.00	2026-07-24 18:24:11.5309+00	2026-07-24 18:24:11.530901+00
5c1391cb-b3bc-47e5-aa7c-b49dc848f16b	7aeec62d-7163-4e79-b430-bbca2ac488b8	Corridor scaffold erection	1.000	6220.00	6220.00	2026-07-24 18:24:11.530898+00	2026-07-24 18:24:11.5309+00
7333f08e-97cc-42ca-8cbb-b65e2e3a5512	9e3dcaf5-c365-466e-888e-9b3324d06a9a	Duct cleaning — memory care wing	1.000	13400.00	13400.00	2026-07-24 18:24:11.26433+00	2026-07-24 18:24:11.26433+00
c760e478-be8f-4b03-89a0-7d83097617ac	9e3dcaf5-c365-466e-888e-9b3324d06a9a	HEPA air scrubber deployment	1.000	8470.00	8470.00	2026-07-24 18:24:11.264329+00	2026-07-24 18:24:11.26433+00
c88fc838-e777-4a51-8fb8-f0f05b6d6676	e89ff38f-1934-46d4-8280-27630e753c1a	Fuel service	1.000	6000.00	6000.00	2026-07-24 18:24:11.342385+00	2026-07-24 18:24:11.342385+00
28cb65d6-59f5-4b1b-a6aa-e66812746989	e89ff38f-1934-46d4-8280-27630e753c1a	Generator 150kVA rental — 3 weeks	1.000	12930.00	12930.00	2026-07-24 18:24:11.342384+00	2026-07-24 18:24:11.342384+00
38445c17-d064-4b06-80a3-a7cd03fb955f	83c6c005-afb4-4574-b401-9e8b7f146977	Cover board & plates	1.000	24600.00	24600.00	2026-07-24 18:24:11.632598+00	2026-07-24 18:24:11.632598+00
3712e3e1-aad6-48b6-b2c4-bb545afdfb69	83c6c005-afb4-4574-b401-9e8b7f146977	TPO membrane 60-mil — full order	1.000	71800.00	71800.00	2026-07-24 18:24:11.632597+00	2026-07-24 18:24:11.632598+00
33eb9916-54b3-48cd-99bf-ea8a2339b17e	d06daf80-be4f-461d-8aff-4b419ce1cd06	Air scrubber rental	1.000	3800.00	3800.00	2026-07-24 18:24:11.667107+00	2026-07-24 18:24:11.667107+00
98f48922-36de-408e-8264-053f4eed58c1	d06daf80-be4f-461d-8aff-4b419ce1cd06	Hydroxyl generator rental	1.000	7460.00	7460.00	2026-07-24 18:24:11.667106+00	2026-07-24 18:24:11.667106+00
025a37d9-2a41-4587-9634-0ed31ef4f2f3	a66fde12-abdd-4869-b74c-1d0d0682561f	Mold clearance sampling & lab	1.000	3450.00	3450.00	2026-07-24 18:24:11.707472+00	2026-07-24 18:24:11.707472+00
167f0079-149a-402a-afd3-8f4db9d5885e	c0957e81-8404-4e1d-9f10-d64a860cc502	Exterior scaffold — conference center	1.000	19800.00	19800.00	2026-07-24 18:24:11.741019+00	2026-07-24 18:24:11.741019+00
217487b4-a925-4fcc-abe5-7a99899aeae9	d89b739e-c35d-48e7-af51-af89d864904d	Air mover rental x60	1.000	4400.00	4400.00	2026-07-24 18:24:11.565846+00	2026-07-24 18:24:11.565846+00
5bafa05f-7731-409f-868f-459f732d26e9	d89b739e-c35d-48e7-af51-af89d864904d	Desiccant dehumidifier rental	1.000	9980.00	9980.00	2026-07-24 18:24:11.565845+00	2026-07-24 18:24:11.565845+00
798229c3-9dc4-4ba4-9d90-f0fe745d709f	b31f181e-cc60-4ea0-a647-ff826cd420e6	Freight	1.000	3600.00	3600.00	2026-07-24 18:24:11.774298+00	2026-07-24 18:24:11.774298+00
6b724c0c-f3f7-4f3f-b8a7-3c2ef20515cf	b31f181e-cc60-4ea0-a647-ff826cd420e6	Skylight units & curbs x22	1.000	38300.00	38300.00	2026-07-24 18:24:11.774297+00	2026-07-24 18:24:11.774298+00
f3a1819f-a4f1-4a42-b3f5-68394ff478e7	1e0e801a-4682-4279-b769-a3429c0e51aa	Quarterly IAQ testing — branch offices	1.000	2850.00	2850.00	2026-07-24 18:24:11.422225+00	2026-07-24 18:24:11.422226+00
afa6a333-3f74-4e5b-9d8b-aa415ec88c07	b4de8a93-f7d0-4fe3-8aa1-2ae53bc7a365	30yd roll-off service — corporate yard	1.000	4160.00	4160.00	2026-07-24 18:24:11.385775+00	2026-07-24 18:24:11.385776+00
fbf68085-095f-4b94-94e5-d9cf2ed9c5e2	f46449c5-ae6c-4f41-8e34-bf1f6cedb8c7	Moisture mapping — Bayou City Tower	1.000	1975.00	1975.00	2026-07-24 18:24:11.599845+00	2026-07-24 18:24:11.599846+00
\.


--
-- Data for Name: ap_invoices; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.ap_invoices (id, invoice_number, vendor_id, vendor_contact_id, vendor_name, opportunity_id, legal_entity_id, branch_id, invoice_date, due_date, posting_date, amount, currency, description, cost_code, document_type, source, status, paid_status, total_paid_amount, overpaid_amount, discount_type, discount_value, discount_deadline, legacy_accounting_bill_id, legacy_unified_invoice_id, legacy_document_number, legacy_gl_account_id, created_at, updated_at) FROM stdin;
7db3a24d-d6d4-41aa-8e3e-4ba1d69f4b4d	PD-33218	118f20d6-bbd4-475f-b410-fd251afa5a8d	\N	ProDry Restoration Equipment	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	ki-105-0000-0000-0000-000000000000	\N	2026-07-21 18:24:07.827117+00	2026-08-20 18:24:07.827117+00	\N	9640.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	PENDING_PROJECT_APPROVAL	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.224642+00	2026-07-24 18:24:11.260845+00
f13681b4-23bf-42da-80f3-6b623414de8f	CVG-6633	c3dd60f3-4063-4fc0-9289-1d2a4669302a	\N	ClearView Glass & Glazing	509e5e53-df5e-42c4-bd79-3ea5b49497d8	ki-110-0000-0000-0000-000000000000	\N	2026-07-11 18:24:07.827117+00	2026-08-10 18:24:07.827117+00	\N	15750.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	NEEDS_REVIEW	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.492686+00	2026-07-24 18:24:11.527551+00
2036c5ee-daf7-45a7-bd1a-dc3a9c996a0f	HCE-30281	1a516cb5-d88a-49f5-945b-d62be1b14e13	\N	Hill Country Electric	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	ki-105-0000-0000-0000-000000000000	\N	2026-07-09 18:24:07.827117+00	2026-08-08 18:24:07.827117+00	\N	27400.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	NEEDS_REVIEW	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.453247+00	2026-07-24 18:24:11.49183+00
81970914-67c8-49a1-8332-349ad177947c	ARS-20447	56d4ab7e-ac1a-401d-a7da-9c8bcdb220cf	\N	Alliance Roofing Supply	71cf10e3-2ca6-4256-8e3c-6b10ee266997	ki-110-0000-0000-0000-000000000000	\N	2026-07-20 18:24:07.827117+00	2026-08-19 18:24:07.827117+00	\N	48350.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	PENDING_PROJECT_APPROVAL	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.182588+00	2026-07-24 18:24:11.812805+00
42c4ace8-f0b2-4c20-bfbf-16e5019506c8	RBC-1156	f18c7235-fc0e-4f20-a863-b3cf9e77e1a7	\N	Rios Brothers Concrete	f2717f36-697a-430f-a485-bcafc9482a32	ki-105-0000-0000-0000-000000000000	\N	2026-07-13 18:24:07.827117+00	2026-08-12 18:24:07.827117+00	\N	64200.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	PENDING_FINANCE_APPROVAL	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.304723+00	2026-07-24 18:24:11.339105+00
e134d780-492e-4519-bb3a-2e4170d357d2	LSR-88412	6cd8ab85-7fd7-4b8c-9e6c-079b3d7a2e31	\N	Lone Star Equipment Rental	f2717f36-697a-430f-a485-bcafc9482a32	ki-105-0000-0000-0000-000000000000	\N	2026-07-18 18:24:07.827117+00	2026-08-17 18:24:07.827117+00	\N	12480.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	PENDING_PROJECT_APPROVAL	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:10.869852+00	2026-07-24 18:24:11.180872+00
7aeec62d-7163-4e79-b430-bbca2ac488b8	APX-40912	549043d7-7df3-4405-ba26-132773b531af	\N	Apex Scaffolding	d80d6bca-688a-4dad-9204-89366f709b4f	ki-105-0000-0000-0000-000000000000	\N	2026-07-22 18:24:07.827117+00	2026-08-21 18:24:07.827117+00	\N	8420.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	DRAFT	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.528456+00	2026-07-24 18:24:11.562616+00
9e3dcaf5-c365-466e-888e-9b3324d06a9a	BBE-7702	6810ec97-1447-40b5-a039-f19e1dac57a1	\N	Bluebonnet Environmental	d80d6bca-688a-4dad-9204-89366f709b4f	ki-105-0000-0000-0000-000000000000	\N	2026-07-15 18:24:07.827117+00	2026-08-14 18:24:07.827117+00	\N	21870.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	PENDING_FINANCE_APPROVAL	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.26193+00	2026-07-24 18:24:11.30354+00
e89ff38f-1934-46d4-8280-27630e753c1a	LSR-88467	6cd8ab85-7fd7-4b8c-9e6c-079b3d7a2e31	\N	Lone Star Equipment Rental	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	ki-105-0000-0000-0000-000000000000	\N	2026-07-17 18:24:07.827117+00	2026-08-16 18:24:07.827117+00	\N	18930.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	PENDING_FINANCE_APPROVAL	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.340198+00	2026-07-24 18:24:11.814038+00
83c6c005-afb4-4574-b401-9e8b7f146977	ARS-20390	56d4ab7e-ac1a-401d-a7da-9c8bcdb220cf	\N	Alliance Roofing Supply	d32da9f2-4215-48f9-a1ec-71e967453305	ki-110-0000-0000-0000-000000000000	\N	2026-05-30 18:24:07.827117+00	2026-06-29 18:24:07.827117+00	\N	96400.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	POSTED	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.630356+00	2026-07-24 18:24:11.663917+00
d06daf80-be4f-461d-8aff-4b419ce1cd06	PD-33107	118f20d6-bbd4-475f-b410-fd251afa5a8d	\N	ProDry Restoration Equipment	249e5252-b737-446a-be25-f5e910a7380d	ki-105-0000-0000-0000-000000000000	\N	2026-05-15 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	\N	11260.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	POSTED	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.664874+00	2026-07-24 18:24:11.704636+00
a66fde12-abdd-4869-b74c-1d0d0682561f	DTL-9871	5a0f3fa1-b6f2-4bb0-be40-6712b6472e7f	\N	Delta Testing Labs	3d320ab8-7e02-4557-ab26-c65abc774688	ki-105-0000-0000-0000-000000000000	\N	2026-05-27 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	\N	3450.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	POSTED	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.70551+00	2026-07-24 18:24:11.738269+00
c0957e81-8404-4e1d-9f10-d64a860cc502	APX-40766	549043d7-7df3-4405-ba26-132773b531af	\N	Apex Scaffolding	906bdaec-dfde-4248-bae6-57191ccf3277	ki-105-0000-0000-0000-000000000000	\N	2026-06-19 18:24:07.827117+00	2026-07-19 18:24:07.827117+00	\N	19800.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	POSTING_FAILED	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.739107+00	2026-07-24 18:24:11.771471+00
d89b739e-c35d-48e7-af51-af89d864904d	PD-33305	118f20d6-bbd4-475f-b410-fd251afa5a8d	\N	ProDry Restoration Equipment	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	ki-105-0000-0000-0000-000000000000	\N	2026-07-23 18:24:07.827117+00	2026-08-22 18:24:07.827117+00	\N	14380.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	DRAFT	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.563606+00	2026-07-24 18:24:11.814945+00
b31f181e-cc60-4ea0-a647-ff826cd420e6	CVG-6540	c3dd60f3-4063-4fc0-9289-1d2a4669302a	\N	ClearView Glass & Glazing	2cb81f29-032f-4247-8259-d7d4d3ffa28f	ki-110-0000-0000-0000-000000000000	\N	2026-06-06 18:24:07.827117+00	2026-07-06 18:24:07.827117+00	\N	41900.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	POSTED	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.772341+00	2026-07-24 18:24:12.04179+00
1e0e801a-4682-4279-b769-a3429c0e51aa	DTL-9954	5a0f3fa1-b6f2-4bb0-be40-6712b6472e7f	\N	Delta Testing Labs	\N	\N	\N	2026-07-19 18:24:07.827117+00	2026-08-18 18:24:07.827117+00	\N	2850.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	PENDING_CORPORATE_REVIEW	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.419968+00	2026-07-24 18:24:11.816663+00
b4de8a93-f7d0-4fe3-8aa1-2ae53bc7a365	MDC-55201	608abef9-f1ac-487d-8419-7d6cbd7b8e9e	\N	Metroplex Dumpster Co	\N	\N	\N	2026-07-16 18:24:07.827117+00	2026-08-15 18:24:07.827117+00	\N	4160.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	PENDING_CORPORATE_REVIEW	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.38363+00	2026-07-24 18:24:11.815834+00
f46449c5-ae6c-4f41-8e34-bf1f6cedb8c7	DTL-10012	5a0f3fa1-b6f2-4bb0-be40-6712b6472e7f	\N	Delta Testing Labs	\N	\N	\N	2026-07-23 18:24:07.827117+00	2026-08-22 18:24:07.827117+00	\N	1975.00	USD	\N	materials-and-supplies	INVOICE	MANUAL	DRAFT	UNPAID	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-24 18:24:11.597585+00	2026-07-24 18:24:11.629532+00
\.


--
-- Data for Name: ar_invoice_documents; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.ar_invoice_documents (id, invoice_id, document_id, document_type, document_date, created_at, updated_at) FROM stdin;
6fdddd40-8669-4d55-9b25-d3287a53abd2	e2af2d59-7fcc-42d0-83b9-9b9d4715b61b	6c575d05-0ff5-577b-a028-fb63e5d9117d	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.721622+00	2026-07-24 18:24:10.721623+00
2c65c6e1-914f-47f4-a9c9-e1f57118ed6f	b64e14f5-e4e1-4ef3-b23f-091708fc052d	8b7fae9d-6946-5834-b3a7-20529ffef68b	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.744873+00	2026-07-24 18:24:10.744875+00
4ed699b3-497d-484c-a2be-b83513b4237c	79481da0-7fc8-425b-9d13-e1e447d87a23	3d5551a0-f174-53e0-9e4b-2e4bfb41ede7	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.753738+00	2026-07-24 18:24:10.753738+00
d614383d-4df9-40af-8f9b-938f39e1674b	fb7c4709-c8c2-4d0d-833d-fd63a527b518	f41b7651-8e61-5fa3-bad4-98302f863afc	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.760013+00	2026-07-24 18:24:10.760014+00
8c3a58e4-ef30-4619-a03a-e978d4cea5fb	e9a45535-4810-43f5-92cf-b1f18a46f727	142604bc-e70b-5850-85bf-230736868cd4	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.765577+00	2026-07-24 18:24:10.765577+00
92c52935-c390-4e73-983d-96e47af66229	628307df-5a4f-459b-aeaf-e6c0cc18cb2b	25e14978-d69b-5437-9302-40a3d1676811	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.771026+00	2026-07-24 18:24:10.771026+00
b6ba1a49-a3cb-4569-96b8-976196540092	9184de73-639f-43f4-b5a0-e7265fa148ea	9b3b5294-8605-592d-9b24-4d34d44b3a6d	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.776534+00	2026-07-24 18:24:10.776535+00
b9ba1371-0d0f-4fc7-8f7c-ef61b518ec6d	e968a647-6e24-4191-920e-437b5f547517	cf9566be-eb16-560d-a00e-274392bbba21	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.781341+00	2026-07-24 18:24:10.781342+00
19d3fbec-defc-44d9-a32a-af00ca968ce2	e6c2125a-1097-41a0-af38-856b0a26ac0e	64edabd2-935f-57ab-98a8-584be9753a17	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.786435+00	2026-07-24 18:24:10.786435+00
30be4118-ffb0-4703-acb6-1f76f0c563a7	854bd25c-a9c6-4e96-9e43-6100fd0058ce	fff84210-b7e6-5189-8842-1f35005ffaf6	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.791622+00	2026-07-24 18:24:10.791622+00
80f336e9-936c-4033-98be-a9c7bf642322	7d726f8b-fc94-4a23-b59d-61e35c7d4122	833b5b2b-c170-5b52-959f-c2e4edc330ee	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.796737+00	2026-07-24 18:24:10.796737+00
9e2de47d-0d5d-4389-96ce-6cadc7cc5417	e3574d48-b0c3-442f-b8ff-23826edfc02e	e7cb2a42-370e-57a7-acd6-8d58ade69b19	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.80164+00	2026-07-24 18:24:10.80164+00
b9049737-6972-4e13-b736-6174e2a6adbe	d227c689-7787-4ffc-972a-d02fdfa95d7b	ffff6075-b3fe-5cc1-96a4-45ac48a8e516	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.806589+00	2026-07-24 18:24:10.80659+00
ec05e26b-092d-4327-8f70-3b0e6fe226d7	5cea8e54-9a3d-4c94-b049-1a3f154cc7a7	7e7b431a-762c-56db-afc8-5dc67bd815ab	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.811152+00	2026-07-24 18:24:10.811152+00
a628a780-932d-4d80-95d4-351587ebcc19	7c2ada9d-33b0-4c0b-b166-a02e2de16bea	2643a10a-2220-5703-9bdb-e7d8c97b7ef4	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.818875+00	2026-07-24 18:24:10.818876+00
c70878ed-be38-407f-b36c-e26feadb4356	8f3ce396-16df-44a7-ad52-ab674d2a334f	961436eb-b99a-5d65-bdc2-c55310b25347	INVOICE	2026-07-24 18:24:10.532967+00	2026-07-24 18:24:10.823506+00	2026-07-24 18:24:10.823506+00
\.


--
-- Data for Name: ar_invoice_lines; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.ar_invoice_lines (id, invoice_id, legacy_contract_line_id, description, amount, billing_percentage, created_at, updated_at) FROM stdin;
d4fd1591-662f-4296-8026-1929a2156ff0	7c2ada9d-33b0-4c0b-b166-a02e2de16bea	\N	Scenario AR line item	55900.00	\N	2026-07-24 18:24:10.814231+00	2026-07-24 18:24:10.814232+00
f5b8e599-0641-47d3-9e37-a761a1d5ba85	c37f27fe-1cc6-4402-859f-86ba54987315	\N	Scenario AR line item	34500.00	\N	2026-07-24 18:24:10.824851+00	2026-07-24 18:24:10.824851+00
d67703cc-15f3-4143-b894-dcfc79285846	8f3ce396-16df-44a7-ad52-ab674d2a334f	\N	Scenario AR line item	80600.00	\N	2026-07-24 18:24:10.820429+00	2026-07-24 18:24:10.82043+00
d01f58e8-9eb6-498f-b52b-f98ecb3540fb	7d726f8b-fc94-4a23-b59d-61e35c7d4122	\N	Scenario AR line item	178100.00	\N	2026-07-24 18:24:10.793543+00	2026-07-24 18:24:10.793544+00
7544c9fc-d197-4cc9-a43f-d21db0f08bf4	e3574d48-b0c3-442f-b8ff-23826edfc02e	\N	Scenario AR line item	246300.00	\N	2026-07-24 18:24:10.798324+00	2026-07-24 18:24:10.798324+00
c8231bb7-4078-4885-97ee-a3ccb2f7df28	57246781-4958-41ef-b76c-16b9c1f59266	\N	Scenario AR line item	108300.00	\N	2026-07-24 18:24:10.828223+00	2026-07-24 18:24:10.828224+00
90da0ec5-6a4b-4432-82c2-3d7ea38c186c	e968a647-6e24-4191-920e-437b5f547517	\N	Scenario AR line item	216500.00	\N	2026-07-24 18:24:10.77827+00	2026-07-24 18:24:10.77827+00
3fd24bbc-b850-4c2a-b0f9-55960a11dc82	d227c689-7787-4ffc-972a-d02fdfa95d7b	\N	Scenario AR line item	173500.00	\N	2026-07-24 18:24:10.803104+00	2026-07-24 18:24:10.803105+00
f6d2ba99-10c8-446a-ad73-c9307f49ec34	5cea8e54-9a3d-4c94-b049-1a3f154cc7a7	\N	Scenario AR line item	185400.00	\N	2026-07-24 18:24:10.807949+00	2026-07-24 18:24:10.80795+00
bd4527f4-6c04-4bd1-809d-8d67441e47e9	a933e3de-7216-4245-9989-d676594b44af	\N	Scenario AR line item	52300.00	\N	2026-07-24 18:24:10.831643+00	2026-07-24 18:24:10.831644+00
065761ff-b011-423d-a890-ee7cf44cb72a	48bb6591-3dc4-4b04-9951-2e5acdb797ef	\N	Scenario AR line item	116700.00	\N	2026-07-24 18:24:10.835409+00	2026-07-24 18:24:10.835409+00
6ce135b7-0218-4650-9d3b-b7f8da69b285	e6c2125a-1097-41a0-af38-856b0a26ac0e	\N	Scenario AR line item	90800.00	\N	2026-07-24 18:24:10.783117+00	2026-07-24 18:24:10.783118+00
cc3b9cc1-27ce-469e-a1b8-664f06097185	1faff089-7d78-4f39-86ad-a43c213b4941	\N	Scenario AR line item	57300.00	\N	2026-07-24 18:24:10.838772+00	2026-07-24 18:24:10.838773+00
0819e9a0-0e67-459a-a36e-e8f19b31b53b	854bd25c-a9c6-4e96-9e43-6100fd0058ce	\N	Scenario AR line item	112600.00	\N	2026-07-24 18:24:10.788175+00	2026-07-24 18:24:10.788176+00
881b32af-551d-4bf0-bac8-31fd710c3bf9	b64e14f5-e4e1-4ef3-b23f-091708fc052d	\N	Scenario AR line item	304200.00	\N	2026-07-24 18:24:10.734186+00	2026-07-24 18:24:10.734188+00
618705b5-583f-4c48-963e-4b5075c9c044	e2af2d59-7fcc-42d0-83b9-9b9d4715b61b	\N	Scenario AR line item	304200.00	\N	2026-07-24 18:24:10.706984+00	2026-07-24 18:24:10.706984+00
9b91a9fa-78fa-4c03-ba9f-4d2fa8cb8603	79481da0-7fc8-425b-9d13-e1e447d87a23	\N	Scenario AR line item	146200.00	\N	2026-07-24 18:24:10.7496+00	2026-07-24 18:24:10.7496+00
d82f3ea1-4855-4d18-a1f1-9a1941821e17	fb7c4709-c8c2-4d0d-833d-fd63a527b518	\N	Scenario AR line item	84900.00	\N	2026-07-24 18:24:10.75581+00	2026-07-24 18:24:10.755811+00
7925454b-b332-4a2a-a339-63c2e0aed509	e9a45535-4810-43f5-92cf-b1f18a46f727	\N	Scenario AR line item	273500.00	\N	2026-07-24 18:24:10.761918+00	2026-07-24 18:24:10.761918+00
071103a9-aec5-4486-91cd-8fe9f090e85f	628307df-5a4f-459b-aeaf-e6c0cc18cb2b	\N	Scenario AR line item	229700.00	\N	2026-07-24 18:24:10.767572+00	2026-07-24 18:24:10.767572+00
7c831c4b-42a9-4e3a-ba15-11f109f7322b	9184de73-639f-43f4-b5a0-e7265fa148ea	\N	Scenario AR line item	122600.00	\N	2026-07-24 18:24:10.772985+00	2026-07-24 18:24:10.772986+00
\.


--
-- Data for Name: ar_invoice_notes; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.ar_invoice_notes (id, invoice_id, content, created_by_email, created_at, updated_at) FROM stdin;
f503a7df-6730-495d-a80d-ffec0cfa7380	e968a647-6e24-4191-920e-437b5f547517	Billing contact confirmed receipt; payment scheduled on their next check run. Follow up Friday if remittance hasn't landed.	jenna.okafor@ciridae.com	2026-07-24 18:24:12.073917+00	2026-07-24 18:24:12.073917+00
ce1e19d0-e9c1-498a-a4f6-270c7b329b36	9184de73-639f-43f4-b5a0-e7265fa148ea	Left voicemail with AP desk about the overdue balance and re-sent the invoice PDF. Escalate to the property manager next week.	tasha.green@ciridae.com	2026-07-24 18:24:12.075479+00	2026-07-24 18:24:12.07548+00
\.


--
-- Data for Name: ar_invoices; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.ar_invoices (id, invoice_number, invoice_type, company_id, contact_id, opportunity_id, legal_entity_id, invoice_date, due_date, posting_date, sent_date, approval_date, subtotal, tax_amount, total, status, tax_treatment, tax_exemption_reason, notes, document_id, legacy_accounting_invoice_id, legacy_accounting_invoice_number, created_at, updated_at) FROM stdin;
7c2ada9d-33b0-4c0b-b166-a02e2de16bea	INV-2026-0585	FIXED_AMOUNT	0678bf63-4382-4eec-aeaf-24604bd5675f	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	ki-105-0000-0000-0000-000000000000	2026-07-15 18:24:07.827117+00	2026-08-14 18:24:07.827117+00	2026-07-15 18:24:07.827117+00	2026-07-16 18:24:07.827117+00	2026-07-15 18:24:07.827117+00	55900.00	0.00	55900.00	SENT	TAXABLE	\N	\N	2643a10a-2220-5703-9bdb-e7d8c97b7ef4	\N	\N	2026-07-24 18:24:10.813645+00	2026-07-24 18:24:10.818678+00
c37f27fe-1cc6-4402-859f-86ba54987315	INV-2026-0590	FIXED_AMOUNT	6db6a137-e384-4224-b6ff-3f82415bf62e	a560e00c-9e03-4009-b3e3-e74b4d0f391b	f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	ki-105-0000-0000-0000-000000000000	2026-07-21 18:24:07.827117+00	2026-08-20 18:24:07.827117+00	2026-07-21 18:24:07.827117+00	\N	2026-07-21 18:24:07.827117+00	34500.00	0.00	34500.00	APPROVED	TAXABLE	\N	\N	\N	\N	\N	2026-07-24 18:24:10.824606+00	2026-07-24 18:24:10.826591+00
8f3ce396-16df-44a7-ad52-ab674d2a334f	INV-2026-0582	FIXED_AMOUNT	e1c8d1f1-71bb-46b3-9bb4-1f09a3f2978c	cc17cfa3-fe7e-4625-9440-ea5ce76b0fc4	509e5e53-df5e-42c4-bd79-3ea5b49497d8	ki-110-0000-0000-0000-000000000000	2026-07-12 18:24:07.827117+00	2026-08-11 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	2026-07-13 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	80600.00	0.00	80600.00	SENT	TAXABLE	\N	\N	961436eb-b99a-5d65-bdc2-c55310b25347	\N	\N	2026-07-24 18:24:10.820153+00	2026-07-24 18:24:10.823324+00
7d726f8b-fc94-4a23-b59d-61e35c7d4122	INV-2026-0515	FIXED_AMOUNT	3b29cc0f-b47f-4a9b-9fda-d7e03bfb57d6	0b74a58e-4abb-4c85-8a1d-ae6f4516aaf4	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	ki-105-0000-0000-0000-000000000000	2026-06-02 18:24:07.827117+00	2026-07-02 18:24:07.827117+00	2026-06-02 18:24:07.827117+00	2026-06-03 18:24:07.827117+00	2026-06-02 18:24:07.827117+00	178100.00	0.00	178100.00	SENT	TAXABLE	\N	\N	833b5b2b-c170-5b52-959f-c2e4edc330ee	\N	\N	2026-07-24 18:24:10.793256+00	2026-07-24 18:24:12.040394+00
e3574d48-b0c3-442f-b8ff-23826edfc02e	INV-2026-0538	FIXED_AMOUNT	d67feba9-410d-4bad-ae80-ca85bd5d7b23	8f139cf8-0b17-4254-95de-efad830a72ad	71cf10e3-2ca6-4256-8e3c-6b10ee266997	ki-110-0000-0000-0000-000000000000	2026-06-14 18:24:07.827117+00	2026-07-14 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	2026-06-15 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	246300.00	0.00	246300.00	SENT	TAXABLE	\N	\N	e7cb2a42-370e-57a7-acd6-8d58ade69b19	\N	\N	2026-07-24 18:24:10.798043+00	2026-07-24 18:24:12.040394+00
57246781-4958-41ef-b76c-16b9c1f59266	INV-2026-0592	FIXED_AMOUNT	f3ac4f4d-a06f-4f07-8bd4-85fe268cb8de	cc0e932c-43fe-4ec6-b3e1-df298af9a5c1	f2717f36-697a-430f-a485-bcafc9482a32	ki-105-0000-0000-0000-000000000000	2026-07-22 18:24:07.827117+00	2026-08-21 18:24:07.827117+00	2026-07-22 18:24:07.827117+00	\N	2026-07-22 18:24:07.827117+00	108300.00	0.00	108300.00	APPROVED	TAXABLE	\N	\N	\N	\N	\N	2026-07-24 18:24:10.827962+00	2026-07-24 18:24:10.829688+00
e968a647-6e24-4191-920e-437b5f547517	INV-2026-0502	FIXED_AMOUNT	f3ac4f4d-a06f-4f07-8bd4-85fe268cb8de	cc0e932c-43fe-4ec6-b3e1-df298af9a5c1	f2717f36-697a-430f-a485-bcafc9482a32	ki-105-0000-0000-0000-000000000000	2026-06-09 18:24:07.827117+00	2026-07-09 18:24:07.827117+00	2026-06-09 18:24:07.827117+00	2026-06-10 18:24:07.827117+00	2026-06-09 18:24:07.827117+00	216500.00	0.00	216500.00	SENT	TAXABLE	\N	\N	cf9566be-eb16-560d-a00e-274392bbba21	\N	\N	2026-07-24 18:24:10.77803+00	2026-07-24 18:24:12.040394+00
d227c689-7787-4ffc-972a-d02fdfa95d7b	INV-2026-0526	FIXED_AMOUNT	4f8ec95d-d766-4a82-9d53-0a8621da9dd9	3a19c280-1c94-41f4-93c6-17bf8f5a53b3	d80d6bca-688a-4dad-9204-89366f709b4f	ki-105-0000-0000-0000-000000000000	2026-06-10 18:24:07.827117+00	2026-07-10 18:24:07.827117+00	2026-06-10 18:24:07.827117+00	2026-06-11 18:24:07.827117+00	2026-06-10 18:24:07.827117+00	173500.00	0.00	173500.00	SENT	TAXABLE	\N	\N	ffff6075-b3fe-5cc1-96a4-45ac48a8e516	\N	\N	2026-07-24 18:24:10.802843+00	2026-07-24 18:24:12.040394+00
5cea8e54-9a3d-4c94-b049-1a3f154cc7a7	INV-2026-0578	FIXED_AMOUNT	5db42652-f672-466c-b4c9-6fa0875f9536	72db787e-b8e4-440f-b26e-8b08d680f5c7	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	ki-105-0000-0000-0000-000000000000	2026-07-08 18:24:07.827117+00	2026-08-07 18:24:07.827117+00	2026-07-08 18:24:07.827117+00	2026-07-09 18:24:07.827117+00	2026-07-08 18:24:07.827117+00	185400.00	0.00	185400.00	SENT	TAXABLE	\N	\N	7e7b431a-762c-56db-afc8-5dc67bd815ab	\N	\N	2026-07-24 18:24:10.807698+00	2026-07-24 18:24:10.810972+00
a933e3de-7216-4245-9989-d676594b44af	INV-2026-0594	FIXED_AMOUNT	6f5ad4fb-962c-48d7-9d59-451595b23853	3f57307f-01c0-4c82-b420-c99853296a30	36fd7907-a7d3-4f4b-a838-0810a2a81669	ki-105-0000-0000-0000-000000000000	2026-07-23 18:24:07.827117+00	2026-08-22 18:24:07.827117+00	2026-07-23 18:24:07.827117+00	\N	\N	52300.00	0.00	52300.00	DRAFT	TAXABLE	\N	\N	\N	\N	\N	2026-07-24 18:24:10.831311+00	2026-07-24 18:24:10.833475+00
48bb6591-3dc4-4b04-9951-2e5acdb797ef	INV-2026-0596	FIXED_AMOUNT	0678bf63-4382-4eec-aeaf-24604bd5675f	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	ki-105-0000-0000-0000-000000000000	2026-07-23 18:24:07.827117+00	2026-08-22 18:24:07.827117+00	2026-07-23 18:24:07.827117+00	\N	\N	116700.00	0.00	116700.00	DRAFT	TAXABLE	\N	\N	\N	\N	\N	2026-07-24 18:24:10.835116+00	2026-07-24 18:24:10.836931+00
e6c2125a-1097-41a0-af38-856b0a26ac0e	INV-2026-0549	FIXED_AMOUNT	056f3141-1976-473b-806e-a5d6e1b01060	773a30df-0dec-4469-8b3c-e6c0ac31a9e7	774de069-49ca-4cd5-a20e-9bb97382cdd2	ki-105-0000-0000-0000-000000000000	2026-06-26 18:24:07.827117+00	2026-07-26 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	2026-06-27 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	90800.00	0.00	90800.00	SENT	TAXABLE	\N	\N	64edabd2-935f-57ab-98a8-584be9753a17	\N	\N	2026-07-24 18:24:10.7829+00	2026-07-24 18:24:12.040394+00
1faff089-7d78-4f39-86ad-a43c213b4941	INV-2026-0553	FIXED_AMOUNT	4aa00703-066c-44df-aada-c5c5d912f6ec	531e85e7-06e4-4a7a-ac5d-5ce5d55a0ef9	4539b766-a4f6-4871-a6dc-0b1820f0f627	ki-105-0000-0000-0000-000000000000	2026-06-29 18:24:07.827117+00	2026-07-29 18:24:07.827117+00	2026-06-29 18:24:07.827117+00	2026-06-30 18:24:07.827117+00	2026-06-29 18:24:07.827117+00	57300.00	0.00	57300.00	SYNC_FAILED	TAXABLE	\N	\N	\N	\N	\N	2026-07-24 18:24:10.838459+00	2026-07-24 18:24:12.040394+00
854bd25c-a9c6-4e96-9e43-6100fd0058ce	INV-2026-0571	FIXED_AMOUNT	c579feae-c58d-4520-ad5e-f3921b3f9bbf	6a5475e2-8a5f-442d-a154-9b12a51b82eb	08ed21da-c5f3-40d0-b44c-15897cfdd3b1	ki-105-0000-0000-0000-000000000000	2026-07-06 18:24:07.827117+00	2026-08-05 18:24:07.827117+00	2026-07-06 18:24:07.827117+00	2026-07-07 18:24:07.827117+00	2026-07-06 18:24:07.827117+00	112600.00	0.00	112600.00	SENT	TAXABLE	\N	\N	fff84210-b7e6-5189-8842-1f35005ffaf6	\N	\N	2026-07-24 18:24:10.787915+00	2026-07-24 18:24:10.791447+00
b64e14f5-e4e1-4ef3-b23f-091708fc052d	INV-2026-0533	FIXED_AMOUNT	0678bf63-4382-4eec-aeaf-24604bd5675f	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	d32da9f2-4215-48f9-a1ec-71e967453305	ki-110-0000-0000-0000-000000000000	2026-06-12 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	2026-06-12 18:24:07.827117+00	2026-06-13 18:24:07.827117+00	2026-06-12 18:24:07.827117+00	304200.00	0.00	304200.00	SENT	TAXABLE	\N	\N	8b7fae9d-6946-5834-b3a7-20529ffef68b	\N	\N	2026-07-24 18:24:10.732962+00	2026-07-24 18:24:12.040394+00
e2af2d59-7fcc-42d0-83b9-9b9d4715b61b	INV-2026-0491	FIXED_AMOUNT	0678bf63-4382-4eec-aeaf-24604bd5675f	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	d32da9f2-4215-48f9-a1ec-71e967453305	ki-110-0000-0000-0000-000000000000	2026-05-15 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	2026-05-15 18:24:07.827117+00	2026-05-16 18:24:07.827117+00	2026-05-15 18:24:07.827117+00	304200.00	0.00	304200.00	SENT	TAXABLE	\N	\N	6c575d05-0ff5-577b-a028-fb63e5d9117d	\N	\N	2026-07-24 18:24:10.705761+00	2026-07-24 18:24:10.720895+00
79481da0-7fc8-425b-9d13-e1e447d87a23	INV-2026-0448	FIXED_AMOUNT	056f3141-1976-473b-806e-a5d6e1b01060	773a30df-0dec-4469-8b3c-e6c0ac31a9e7	249e5252-b737-446a-be25-f5e910a7380d	ki-105-0000-0000-0000-000000000000	2026-05-07 18:24:07.827117+00	2026-06-06 18:24:07.827117+00	2026-05-07 18:24:07.827117+00	2026-05-08 18:24:07.827117+00	2026-05-07 18:24:07.827117+00	146200.00	0.00	146200.00	SENT	TAXABLE	\N	\N	3d5551a0-f174-53e0-9e4b-2e4bfb41ede7	\N	\N	2026-07-24 18:24:10.749208+00	2026-07-24 18:24:10.753565+00
fb7c4709-c8c2-4d0d-833d-fd63a527b518	INV-2026-0462	FIXED_AMOUNT	d616639c-a60a-4a5a-8c8f-8527a8c772a7	175b4c6b-13b9-4ecb-a7e3-6d0fb451ae4d	3d320ab8-7e02-4557-ab26-c65abc774688	ki-105-0000-0000-0000-000000000000	2026-05-23 18:24:07.827117+00	2026-06-22 18:24:07.827117+00	2026-05-23 18:24:07.827117+00	2026-05-24 18:24:07.827117+00	2026-05-23 18:24:07.827117+00	84900.00	0.00	84900.00	SENT	TAXABLE	\N	\N	f41b7651-8e61-5fa3-bad4-98302f863afc	\N	\N	2026-07-24 18:24:10.755507+00	2026-07-24 18:24:10.759837+00
e9a45535-4810-43f5-92cf-b1f18a46f727	INV-2026-0479	FIXED_AMOUNT	3b29cc0f-b47f-4a9b-9fda-d7e03bfb57d6	158fe954-6327-472f-980e-f3aa622d3bef	906bdaec-dfde-4248-bae6-57191ccf3277	ki-105-0000-0000-0000-000000000000	2026-05-30 18:24:07.827117+00	2026-06-29 18:24:07.827117+00	2026-05-30 18:24:07.827117+00	2026-05-31 18:24:07.827117+00	2026-05-30 18:24:07.827117+00	273500.00	0.00	273500.00	SENT	TAXABLE	\N	\N	142604bc-e70b-5850-85bf-230736868cd4	\N	\N	2026-07-24 18:24:10.761653+00	2026-07-24 18:24:10.76536+00
628307df-5a4f-459b-aeaf-e6c0cc18cb2b	INV-2026-0561	FIXED_AMOUNT	d67feba9-410d-4bad-ae80-ca85bd5d7b23	8f139cf8-0b17-4254-95de-efad830a72ad	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	ki-105-0000-0000-0000-000000000000	2026-07-04 18:24:07.827117+00	2026-08-03 18:24:07.827117+00	2026-07-04 18:24:07.827117+00	2026-07-05 18:24:07.827117+00	2026-07-04 18:24:07.827117+00	229700.00	0.00	229700.00	SENT	TAXABLE	\N	\N	25e14978-d69b-5437-9302-40a3d1676811	\N	\N	2026-07-24 18:24:10.76729+00	2026-07-24 18:24:10.770837+00
9184de73-639f-43f4-b5a0-e7265fa148ea	INV-2026-0455	FIXED_AMOUNT	f3ac4f4d-a06f-4f07-8bd4-85fe268cb8de	cc0e932c-43fe-4ec6-b3e1-df298af9a5c1	2cb81f29-032f-4247-8259-d7d4d3ffa28f	ki-110-0000-0000-0000-000000000000	2026-05-27 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	2026-05-27 18:24:07.827117+00	2026-05-28 18:24:07.827117+00	2026-05-27 18:24:07.827117+00	122600.00	0.00	122600.00	SENT	TAXABLE	\N	\N	9b3b5294-8605-592d-9b24-4d34d44b3a6d	\N	\N	2026-07-24 18:24:10.77264+00	2026-07-24 18:24:10.776384+00
\.


--
-- Data for Name: ar_payments; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.ar_payments (id, invoice_id, payment_date, amount, payment_method, reference_number, notes, created_at, updated_at) FROM stdin;
df30822a-60a1-43c6-bc5a-99d85458325f	e968a647-6e24-4191-920e-437b5f547517	2026-06-29 18:24:07.827117+00	129900.00	ACH	PMT-008	Scenario partial payment	2026-07-24 18:24:10.780275+00	2026-07-24 18:24:10.780568+00
388d1a95-6ebe-4941-aa47-ae45cd671c10	e6c2125a-1097-41a0-af38-856b0a26ac0e	2026-07-16 18:24:07.827117+00	56296.00	ACH	PMT-009	Scenario partial payment	2026-07-24 18:24:10.785189+00	2026-07-24 18:24:10.78551+00
c5880dd4-2a0f-4036-a128-5ffd3d615fe0	854bd25c-a9c6-4e96-9e43-6100fd0058ce	2026-07-23 18:24:07.827117+00	45040.00	ACH	PMT-010	Scenario partial payment	2026-07-24 18:24:10.790437+00	2026-07-24 18:24:10.790744+00
52a2361a-f01c-492a-878d-4efe9f96c4cf	b64e14f5-e4e1-4ef3-b23f-091708fc052d	2026-07-02 18:24:07.827117+00	304200.00	ACH	PMT-002	Scenario partial payment	2026-07-24 18:24:10.740125+00	2026-07-24 18:24:10.741126+00
02be4ade-aa13-4cfb-ab1f-5476f650c9d8	e2af2d59-7fcc-42d0-83b9-9b9d4715b61b	2026-06-04 18:24:07.827117+00	304200.00	ACH	PMT-001	Scenario partial payment	2026-07-24 18:24:10.718334+00	2026-07-24 18:24:10.71947+00
e6942708-a258-4c4a-831d-73ff6e14bfeb	79481da0-7fc8-425b-9d13-e1e447d87a23	2026-05-27 18:24:07.827117+00	146200.00	ACH	PMT-003	Scenario partial payment	2026-07-24 18:24:10.752441+00	2026-07-24 18:24:10.752809+00
057fe76c-a30f-402e-823c-c3948fa7589f	fb7c4709-c8c2-4d0d-833d-fd63a527b518	2026-06-12 18:24:07.827117+00	84900.00	ACH	PMT-004	Scenario partial payment	2026-07-24 18:24:10.758646+00	2026-07-24 18:24:10.759066+00
de59314e-aac3-44ad-b39b-7d74d7dd0c4c	e9a45535-4810-43f5-92cf-b1f18a46f727	2026-06-19 18:24:07.827117+00	273500.00	ACH	PMT-005	Scenario partial payment	2026-07-24 18:24:10.76411+00	2026-07-24 18:24:10.764407+00
f7b88b7f-f07d-46a9-8aef-654563f4e27b	628307df-5a4f-459b-aeaf-e6c0cc18cb2b	2026-07-23 18:24:07.827117+00	229700.00	ACH	PMT-006	Scenario partial payment	2026-07-24 18:24:10.769893+00	2026-07-24 18:24:10.770195+00
d75331a2-606c-4584-83e1-527c7f2755be	9184de73-639f-43f4-b5a0-e7265fa148ea	2026-06-16 18:24:07.827117+00	122600.00	ACH	PMT-007	Scenario partial payment	2026-07-24 18:24:10.7754+00	2026-07-24 18:24:10.775714+00
\.


--
-- Data for Name: bids; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.bids (id, opportunity_id, bid_owner_id, proposal_recipient_id, bid_type, status, estimate_due_date, loss_event_date, damage_description, areas_of_damage, contract_value, margin, opportunity_notes, date_approved, approved_by, approved_at, submitted_at, created_at, updated_at) FROM stdin;
29ad5182-5e83-440f-b572-5f41fb5e0adf	248c64f8-fefc-4bb0-94b9-71064fa7a1ae	3095e4d0-236d-4c2b-8a88-2aaa54b4d547	\N	INSURANCE	APPROVED	2026-07-26 18:24:07.827117+00	2026-04-18 18:24:07.827117+00	Full tear-off and 60-mil TPO replacement on 210,000 sq ft distribution roof after hail damage.	null	780000.00	30.00	Direct award opportunity under portfolio MSA.	2026-07-23 18:24:07.827117+00	\N	\N	\N	2026-07-24 18:24:09.161011+00	2026-07-24 18:24:09.168844+00
0bd2912a-82c4-4ad5-bcdf-ccfa6526f332	f7838ae5-0ee0-444b-8898-8e4ffe6b5549	dfd04378-3b99-4219-bf0d-5f419097767f	\N	INSURANCE	SUBMITTED	2026-07-18 18:24:07.827117+00	2026-05-25 18:24:07.827117+00	Reconstruction of twelve units and shared corridor after an electrical fire in Building 4.	null	540000.00	27.00	Competing against two regional GCs.	2026-07-20 18:24:07.827117+00	\N	\N	2026-07-21 18:24:07.827117+00	2026-07-24 18:24:09.177849+00	2026-07-24 18:24:09.186985+00
822df432-b6ff-4342-92b3-ecd46ad82a0f	fac6f5a9-9168-4977-bf3c-44d7b41bc7f7	3095e4d0-236d-4c2b-8a88-2aaa54b4d547	\N	CAPEX	LOST	2026-06-24 18:24:07.827117+00	\N	Lobby and porte-cochere refresh ahead of brand inspection.	null	310000.00	22.00	Competing against two regional GCs.	2026-06-26 18:24:07.827117+00	\N	\N	2026-06-27 18:24:07.827117+00	2026-07-24 18:24:09.196049+00	2026-07-24 18:24:09.207767+00
24dabdfb-d16c-4ca2-b21d-39b0c3c9b30d	9bc53410-e648-43ff-b935-20a686b3e0cc	dfd04378-3b99-4219-bf0d-5f419097767f	\N	INSURANCE	REQUEST	2026-07-29 18:24:07.827117+00	2026-06-19 18:24:07.827117+00	Roof drain failure during June flooding; gym floor cupped and wall assemblies saturated.	null	320000.00	32.00	Direct award opportunity under portfolio MSA.	\N	\N	\N	\N	2026-07-24 18:24:09.108889+00	2026-07-24 18:24:09.108891+00
2878fceb-dbf9-4a1b-9b25-acecf76eb2d4	47de910d-8951-4f56-9741-939410de0d19	\N	\N	CAPEX	PENDING_ASSIGNMENT	2026-08-02 18:24:07.827117+00	2026-07-06 18:24:07.827117+00	Semi-trailer strike damaged dock doors 7-9, canopy steel, and adjacent tilt-wall panel.	null	152000.00	28.00	Direct award opportunity under portfolio MSA.	\N	\N	\N	\N	2026-07-24 18:24:09.123815+00	2026-07-24 18:24:09.125525+00
b1bfdc76-98a4-4140-9f6f-81a945648cbe	592c30c3-3b33-4956-95c0-e0ae286b5b3d	3095e4d0-236d-4c2b-8a88-2aaa54b4d547	\N	INSURANCE	READY_FOR_APPROVAL	2026-07-27 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	Ammonia release in the cold storage annex; decontamination and insulation replacement required.	null	264000.00	35.00	Direct award opportunity under portfolio MSA.	\N	\N	\N	\N	2026-07-24 18:24:09.131674+00	2026-07-24 18:24:09.139336+00
47f138bf-29c5-4a5b-88b5-22f1d97143ba	4b4ad37b-3798-4089-8e9a-a8d910f2cc2b	3095e4d0-236d-4c2b-8a88-2aaa54b4d547	\N	CAPEX	SUBMITTED	2026-07-12 18:24:07.827117+00	\N	Phased renovation of 180 guest rooms across eight floors, including corridor finishes.	null	1150000.00	24.00	Competing against two regional GCs.	2026-07-14 18:24:07.827117+00	\N	\N	2026-07-15 18:24:07.827117+00	2026-07-24 18:24:09.146982+00	2026-07-24 18:24:09.152867+00
\.


--
-- Data for Name: branches; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.branches (id, name, address, city, state, zip_code, phone, email, is_active, latitude, longitude, legacy_accounting_id, legacy_accounting_name, created_at, updated_at) FROM stdin;
25211ead-cdbb-53e1-a3da-77540988682d	Atlanta	1180 Peachtree St NE	Atlanta	GA	30092	\N	\N	t	33.9556741	-84.2235982	Atlanta	Atlanta	2026-07-24 18:24:07.942918+00	2026-07-24 18:24:07.942919+00
ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	Austin	600 Congress Ave	Austin	TX	78744	\N	\N	t	30.1755904	-97.6922228	Austin	Austin	2026-07-24 18:24:07.946392+00	2026-07-24 18:24:07.946393+00
3c44bd92-c401-5c84-95f6-c018ca808cca	Chicago	233 S Wacker Dr	Chicago	IL	60446	\N	\N	t	41.6566296	-88.0687755	Chicago	Chicago	2026-07-24 18:24:07.947508+00	2026-07-24 18:24:07.947508+00
77c36dd1-ea64-5ece-9c72-c30fa9f1448a	Dallas	2100 Commerce St	Dallas	TX	75201	\N	\N	t	32.9829602	-96.8383665	Dallas	Dallas	2026-07-24 18:24:07.948739+00	2026-07-24 18:24:07.94874+00
85add3ff-056b-59b7-b3a0-a10a4fe339cb	Denver	1801 California St	Denver	CO	80031	\N	\N	t	39.8608603	-105.0653379	Denver	Denver	2026-07-24 18:24:07.949744+00	2026-07-24 18:24:07.949745+00
8c3a37db-86aa-5ada-974f-407012c21d70	Houston	1000 Louisiana St	Houston	TX	77090	\N	\N	t	30.0014379	-95.4318848	Houston	Houston	2026-07-24 18:24:07.950751+00	2026-07-24 18:24:07.950752+00
94a1815e-335a-59cc-9143-407a0ec50231	Los Angeles	1200 Wilshire Blvd	Los Angeles	CA	90017	\N	\N	t	34.0060137	-117.8488728	Los Angeles	Los Angeles	2026-07-24 18:24:07.95172+00	2026-07-24 18:24:07.951721+00
36eb8d4a-d64d-5c3f-bcc3-d85c9f808c05	National	\N	\N	\N	\N	\N	\N	t	\N	\N	National	National	2026-07-24 18:24:07.952617+00	2026-07-24 18:24:07.952618+00
129f0cdc-ff89-5e79-a1ac-8af25881bd2d	Orlando	1424 North Ronald Reagan Boulevard	Longwood	FL	32750	\N	\N	t	28.7147117	-81.3428255	Orlando	Orlando	2026-07-24 18:24:07.953532+00	2026-07-24 18:24:07.953532+00
a2f068c0-97cc-537d-a395-a3d84500d912	Phoenix	22601 North 17th Avenue	Phoenix	AZ	85027	\N	\N	t	33.6916773	-112.0945431	Phoenix	Phoenix	2026-07-24 18:24:07.954599+00	2026-07-24 18:24:07.954601+00
633ed29c-3cc1-5163-a2fc-60de0742550d	Remote	\N	\N	\N	\N	\N	\N	t	\N	\N	Remote City	Remote	2026-07-24 18:24:07.955734+00	2026-07-24 18:24:07.955735+00
31ecce56-99e2-5e5d-9c2f-6c62f4d5e5b2	San Diego	8295 Aero Place	San Diego	CA	92123	\N	\N	t	32.8074673	-117.1460323	San Diego	San Diego	2026-07-24 18:24:07.956722+00	2026-07-24 18:24:07.956723+00
7cd92222-cd4e-5811-894f-a6d1ddaaa9cb	Tampa	8415 Sunstate Street	Tampa	FL	33634	\N	\N	t	28.0269040	-82.5283618	Tampa	Tampa	2026-07-24 18:24:07.957689+00	2026-07-24 18:24:07.957689+00
02c5cf80-f598-5dfd-87ea-c1719176e3c9	California	\N	\N	\N	\N	\N	\N	f	\N	\N	California	California	2026-07-24 18:24:07.958652+00	2026-07-24 18:24:07.958653+00
4db84b45-4160-552e-a105-8953918472af	Corporate	\N	\N	\N	\N	\N	\N	f	\N	\N	Corporate	Corporate	2026-07-24 18:24:07.959571+00	2026-07-24 18:24:07.959572+00
e4535dd3-d59b-50ee-acc0-5bf4c88699ea	Jackson	\N	\N	\N	\N	\N	\N	f	\N	\N	Jackson	Jackson	2026-07-24 18:24:07.960458+00	2026-07-24 18:24:07.960459+00
5c2476aa-562f-5298-abcf-b635674c7fa0	Memphis	\N	\N	\N	\N	\N	\N	f	\N	\N	Memphis	Memphis	2026-07-24 18:24:07.961624+00	2026-07-24 18:24:07.961625+00
f5ce4910-e8f3-52f1-9c21-02e59e73143d	New Jersey	\N	\N	\N	\N	\N	\N	f	\N	\N	New Jersey	New Jersey	2026-07-24 18:24:07.962536+00	2026-07-24 18:24:07.962537+00
\.


--
-- Data for Name: budget_lines; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.budget_lines (id, budget_id, cost_code, allocation_value, created_at, updated_at) FROM stdin;
01aceef0-8e92-4db8-8b79-452e6c4d4168	3060abdf-5062-49d3-b121-1ec0aa6d9662	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:08.657679+00	2026-07-24 18:24:08.657681+00
56aafd91-4f16-4743-ba7c-3fce7db17460	3060abdf-5062-49d3-b121-1ec0aa6d9662	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:08.657681+00	2026-07-24 18:24:08.657681+00
178d764e-419e-4106-80eb-893b73472d9d	3060abdf-5062-49d3-b121-1ec0aa6d9662	INTERNAL_LABOR	0.00	2026-07-24 18:24:08.657682+00	2026-07-24 18:24:08.657682+00
a982ab00-b995-40f2-9c95-c7114a47cc5f	3060abdf-5062-49d3-b121-1ec0aa6d9662	EXTERNAL_LABOR	0.00	2026-07-24 18:24:08.657682+00	2026-07-24 18:24:08.657682+00
d96f071c-0b72-498d-9385-8f89a3980217	3060abdf-5062-49d3-b121-1ec0aa6d9662	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:08.657682+00	2026-07-24 18:24:08.657682+00
11dac732-4f19-4221-b16e-55c1783886a5	3060abdf-5062-49d3-b121-1ec0aa6d9662	DUMPSTERS	0.00	2026-07-24 18:24:08.657682+00	2026-07-24 18:24:08.657683+00
a4d1dc28-4f19-4716-b472-61b3b9ce7e0f	3060abdf-5062-49d3-b121-1ec0aa6d9662	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:08.657683+00	2026-07-24 18:24:08.657683+00
8c0e26b3-7264-488e-9855-08673093bfa1	3060abdf-5062-49d3-b121-1ec0aa6d9662	UNALLOCATED	0.00	2026-07-24 18:24:08.657683+00	2026-07-24 18:24:08.657683+00
68db6a3f-c3b9-479b-8734-4ff7c6841ac4	6fdb76ec-b07f-435c-93bb-507cce462f4a	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:08.743602+00	2026-07-24 18:24:08.743603+00
9788d319-fa01-4be4-9fe5-5a9a596b55ed	6fdb76ec-b07f-435c-93bb-507cce462f4a	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:08.743603+00	2026-07-24 18:24:08.743603+00
752a41ad-fc7d-427b-bc63-dd11edebd606	6fdb76ec-b07f-435c-93bb-507cce462f4a	INTERNAL_LABOR	0.00	2026-07-24 18:24:08.743603+00	2026-07-24 18:24:08.743603+00
09ea963c-237a-45bf-a1b7-b08250e91c44	6fdb76ec-b07f-435c-93bb-507cce462f4a	EXTERNAL_LABOR	0.00	2026-07-24 18:24:08.743604+00	2026-07-24 18:24:08.743604+00
cc20cc2c-3bdd-41e8-a660-9d400e0df8a7	6fdb76ec-b07f-435c-93bb-507cce462f4a	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:08.743604+00	2026-07-24 18:24:08.743604+00
36d3ecaa-6aa0-4191-ba0a-91a97eb3f738	6fdb76ec-b07f-435c-93bb-507cce462f4a	DUMPSTERS	0.00	2026-07-24 18:24:08.743604+00	2026-07-24 18:24:08.743604+00
ff645fe2-3722-4e72-a345-ec41b81949bc	6fdb76ec-b07f-435c-93bb-507cce462f4a	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:08.743605+00	2026-07-24 18:24:08.743605+00
67e9d285-439b-4474-b997-b1084b9f7eec	6fdb76ec-b07f-435c-93bb-507cce462f4a	UNALLOCATED	0.00	2026-07-24 18:24:08.743605+00	2026-07-24 18:24:08.743605+00
e817c56e-5c20-49f7-aad4-b3c9c10c34be	23d0bdfd-77d2-41d6-9c76-271acaf0d133	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:08.77553+00	2026-07-24 18:24:08.77553+00
a6acfc80-4bf1-4a21-872f-2bb588b54cd4	23d0bdfd-77d2-41d6-9c76-271acaf0d133	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:08.775531+00	2026-07-24 18:24:08.775531+00
5fae21d1-c3fe-454d-b12c-7f4a9005a965	23d0bdfd-77d2-41d6-9c76-271acaf0d133	INTERNAL_LABOR	0.00	2026-07-24 18:24:08.775531+00	2026-07-24 18:24:08.775531+00
7c716091-e287-4135-82b2-853fc1e33a67	23d0bdfd-77d2-41d6-9c76-271acaf0d133	EXTERNAL_LABOR	0.00	2026-07-24 18:24:08.775531+00	2026-07-24 18:24:08.775531+00
9cf15450-186c-493e-838c-b501623d2266	23d0bdfd-77d2-41d6-9c76-271acaf0d133	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:08.775532+00	2026-07-24 18:24:08.775532+00
f81a8f8e-4ad4-4c62-a256-2a39760b8e5e	23d0bdfd-77d2-41d6-9c76-271acaf0d133	DUMPSTERS	0.00	2026-07-24 18:24:08.775532+00	2026-07-24 18:24:08.775532+00
b2687bfa-f50f-457e-aa7c-4a2618d41c45	23d0bdfd-77d2-41d6-9c76-271acaf0d133	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:08.775532+00	2026-07-24 18:24:08.775532+00
343f39a0-040d-43ce-ba06-69fb003e58c2	23d0bdfd-77d2-41d6-9c76-271acaf0d133	UNALLOCATED	0.00	2026-07-24 18:24:08.775533+00	2026-07-24 18:24:08.775533+00
4311a392-e207-4bdf-9dfe-9ea035097eaa	0eebf55f-2323-49ab-bead-ffa410fa6185	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:08.805681+00	2026-07-24 18:24:08.805681+00
a30c54b8-773b-4fb2-9c79-caaf118ea02d	0eebf55f-2323-49ab-bead-ffa410fa6185	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:08.805682+00	2026-07-24 18:24:08.805682+00
808500a6-0a5c-4292-80f1-1ddae8db89a3	0eebf55f-2323-49ab-bead-ffa410fa6185	INTERNAL_LABOR	0.00	2026-07-24 18:24:08.805682+00	2026-07-24 18:24:08.805682+00
c0e30e93-8820-45b3-a3ec-94c3259db3f7	0eebf55f-2323-49ab-bead-ffa410fa6185	EXTERNAL_LABOR	0.00	2026-07-24 18:24:08.805682+00	2026-07-24 18:24:08.805683+00
4e346305-8d94-4fb3-8227-2b8a60eed346	0eebf55f-2323-49ab-bead-ffa410fa6185	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:08.805683+00	2026-07-24 18:24:08.805683+00
b6d7947e-b9ba-44fd-9a93-0643a465c24c	0eebf55f-2323-49ab-bead-ffa410fa6185	DUMPSTERS	0.00	2026-07-24 18:24:08.805683+00	2026-07-24 18:24:08.805683+00
b972e2d8-eaee-4c27-a34c-96d4c52cf3bf	0eebf55f-2323-49ab-bead-ffa410fa6185	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:08.805683+00	2026-07-24 18:24:08.805684+00
eefe02bd-35a2-4738-8c0e-c799fddc4615	0eebf55f-2323-49ab-bead-ffa410fa6185	UNALLOCATED	0.00	2026-07-24 18:24:08.805684+00	2026-07-24 18:24:08.805684+00
94ccf894-e376-40e0-997a-4a77f320f18d	a6bf38ed-47d1-47e4-bf50-13f04a1b18de	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:08.83869+00	2026-07-24 18:24:08.838691+00
e0c42a06-50e0-46bb-8a0f-c1e8a4068283	a6bf38ed-47d1-47e4-bf50-13f04a1b18de	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:08.838691+00	2026-07-24 18:24:08.838691+00
288c3529-91f1-41df-a8f4-a9b19caf28d7	a6bf38ed-47d1-47e4-bf50-13f04a1b18de	INTERNAL_LABOR	0.00	2026-07-24 18:24:08.838692+00	2026-07-24 18:24:08.838692+00
47d4a6b5-3cb2-4b80-b238-1d9ca511d9ef	a6bf38ed-47d1-47e4-bf50-13f04a1b18de	EXTERNAL_LABOR	0.00	2026-07-24 18:24:08.838692+00	2026-07-24 18:24:08.838692+00
6071149d-4bf8-4f75-9849-39ae5ad6e72c	a6bf38ed-47d1-47e4-bf50-13f04a1b18de	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:08.838692+00	2026-07-24 18:24:08.838693+00
4a97c8bf-b65e-4200-8cd2-098b37684af5	a6bf38ed-47d1-47e4-bf50-13f04a1b18de	DUMPSTERS	0.00	2026-07-24 18:24:08.838693+00	2026-07-24 18:24:08.838693+00
7c04f013-8b65-480a-8975-c049000d1c78	a6bf38ed-47d1-47e4-bf50-13f04a1b18de	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:08.838693+00	2026-07-24 18:24:08.838693+00
4e0474d2-bffc-4449-a24d-9bffdcfc44fb	a6bf38ed-47d1-47e4-bf50-13f04a1b18de	UNALLOCATED	0.00	2026-07-24 18:24:08.838693+00	2026-07-24 18:24:08.838694+00
16d3d090-41ba-4af0-89fc-c418bb3804fa	8ce8784c-2611-44d6-affa-035e5840dd02	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:08.874449+00	2026-07-24 18:24:08.87445+00
95d8efb6-fe23-4661-9c81-d8571f46eb74	8ce8784c-2611-44d6-affa-035e5840dd02	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:08.87445+00	2026-07-24 18:24:08.874451+00
51d48ac6-2865-43a9-af0f-2bb1d61b1664	8ce8784c-2611-44d6-affa-035e5840dd02	INTERNAL_LABOR	0.00	2026-07-24 18:24:08.874451+00	2026-07-24 18:24:08.874451+00
6dcc5b9e-ded6-4fee-acd3-a29877a75a8b	8ce8784c-2611-44d6-affa-035e5840dd02	EXTERNAL_LABOR	0.00	2026-07-24 18:24:08.874451+00	2026-07-24 18:24:08.874451+00
ab9b070b-d17b-4f60-baaa-cb5a08cbc124	8ce8784c-2611-44d6-affa-035e5840dd02	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:08.874452+00	2026-07-24 18:24:08.874452+00
eb1ba71f-5d5a-4b42-b589-20303b72022f	8ce8784c-2611-44d6-affa-035e5840dd02	DUMPSTERS	0.00	2026-07-24 18:24:08.874452+00	2026-07-24 18:24:08.874452+00
f58f11b8-1194-4074-a234-b622d21c7e3a	8ce8784c-2611-44d6-affa-035e5840dd02	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:08.874452+00	2026-07-24 18:24:08.874453+00
d69c38c1-aef9-4206-a8e6-5fc8bfb6f6c7	8ce8784c-2611-44d6-affa-035e5840dd02	UNALLOCATED	0.00	2026-07-24 18:24:08.874453+00	2026-07-24 18:24:08.874453+00
cf28e400-8467-4f2b-b1c4-48982ecbc036	ac1e0cf7-dab2-42ce-8b8e-f0185c176323	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:08.90948+00	2026-07-24 18:24:08.909481+00
6bf1fdbc-8086-4493-995a-56a632a8ef4f	ac1e0cf7-dab2-42ce-8b8e-f0185c176323	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:08.909481+00	2026-07-24 18:24:08.909481+00
155e62ed-8978-4df2-979c-ec370fdcb825	ac1e0cf7-dab2-42ce-8b8e-f0185c176323	INTERNAL_LABOR	0.00	2026-07-24 18:24:08.909481+00	2026-07-24 18:24:08.909482+00
62e31e01-b149-429c-b007-128668b2b8d8	ac1e0cf7-dab2-42ce-8b8e-f0185c176323	EXTERNAL_LABOR	0.00	2026-07-24 18:24:08.909482+00	2026-07-24 18:24:08.909482+00
f5f92b4a-60e7-475e-9998-60f81c81d9f9	ac1e0cf7-dab2-42ce-8b8e-f0185c176323	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:08.909482+00	2026-07-24 18:24:08.909482+00
9865376a-6e5c-422f-a78a-3e83d693fbac	ac1e0cf7-dab2-42ce-8b8e-f0185c176323	DUMPSTERS	0.00	2026-07-24 18:24:08.909483+00	2026-07-24 18:24:08.909483+00
11a79bc4-ba07-4864-99a1-42e07c66a328	ac1e0cf7-dab2-42ce-8b8e-f0185c176323	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:08.909483+00	2026-07-24 18:24:08.909483+00
ceb5dfa6-b6be-4a92-9ac7-0f9b5cfdd5be	ac1e0cf7-dab2-42ce-8b8e-f0185c176323	UNALLOCATED	0.00	2026-07-24 18:24:08.909484+00	2026-07-24 18:24:08.909484+00
d8664eb4-05eb-4e37-96cf-2f89ee59ecd9	0ab15237-fd81-4da0-b8f0-cfae86382510	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:08.941327+00	2026-07-24 18:24:08.941327+00
943a825b-4897-466f-89f0-8f03c9b0c73a	0ab15237-fd81-4da0-b8f0-cfae86382510	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:08.941328+00	2026-07-24 18:24:08.941328+00
b992a901-ee64-4e89-a2ce-4ea44c91ec94	0ab15237-fd81-4da0-b8f0-cfae86382510	INTERNAL_LABOR	0.00	2026-07-24 18:24:08.941328+00	2026-07-24 18:24:08.941328+00
8b09d304-3892-48af-9742-fce39ffddaec	0ab15237-fd81-4da0-b8f0-cfae86382510	EXTERNAL_LABOR	0.00	2026-07-24 18:24:08.941328+00	2026-07-24 18:24:08.941329+00
0deb3e3f-efd9-4652-8c29-f8d5b2f60a30	0ab15237-fd81-4da0-b8f0-cfae86382510	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:08.941329+00	2026-07-24 18:24:08.941329+00
0a045309-b067-4ac0-bcab-dec19cb10e75	0ab15237-fd81-4da0-b8f0-cfae86382510	DUMPSTERS	0.00	2026-07-24 18:24:08.941329+00	2026-07-24 18:24:08.941329+00
2303d6c8-21cc-4b05-b146-ef91c405a21c	0ab15237-fd81-4da0-b8f0-cfae86382510	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:08.941329+00	2026-07-24 18:24:08.941329+00
35be8c86-7efb-4325-9504-b696dc6d4129	0ab15237-fd81-4da0-b8f0-cfae86382510	UNALLOCATED	0.00	2026-07-24 18:24:08.94133+00	2026-07-24 18:24:08.94133+00
f85b13cd-fbe6-4bf6-b2be-1b61486e5277	0568f037-7321-474a-b1d0-09a2629b8687	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:08.972222+00	2026-07-24 18:24:08.972223+00
b721729b-7341-43ab-98c0-870216cb2bf9	0568f037-7321-474a-b1d0-09a2629b8687	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:08.972223+00	2026-07-24 18:24:08.972223+00
a44e8bed-eb50-48bb-9255-3fb44c3b47ed	0568f037-7321-474a-b1d0-09a2629b8687	INTERNAL_LABOR	0.00	2026-07-24 18:24:08.972224+00	2026-07-24 18:24:08.972224+00
7b071147-c28b-4fe3-81b9-4f99a19be958	0568f037-7321-474a-b1d0-09a2629b8687	EXTERNAL_LABOR	0.00	2026-07-24 18:24:08.972224+00	2026-07-24 18:24:08.972224+00
56d3947a-4897-4e82-a90f-3a804c560dd1	0568f037-7321-474a-b1d0-09a2629b8687	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:08.972224+00	2026-07-24 18:24:08.972224+00
06878d6b-a66f-4298-85a6-bd63186e42a3	0568f037-7321-474a-b1d0-09a2629b8687	DUMPSTERS	0.00	2026-07-24 18:24:08.972225+00	2026-07-24 18:24:08.972225+00
a370b92b-9383-4c41-9c8e-64093cad5db6	0568f037-7321-474a-b1d0-09a2629b8687	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:08.972225+00	2026-07-24 18:24:08.972225+00
6bf060e5-34a9-4b41-8cad-ae617f21cce1	0568f037-7321-474a-b1d0-09a2629b8687	UNALLOCATED	0.00	2026-07-24 18:24:08.972225+00	2026-07-24 18:24:08.972225+00
244fcb80-7418-42e9-8b52-aa64431b117d	7b3ee32c-313a-42c8-a2e5-227882442942	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.007014+00	2026-07-24 18:24:09.007015+00
3ce7e010-8eae-4458-8af0-77ced0b7e824	7b3ee32c-313a-42c8-a2e5-227882442942	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.007016+00	2026-07-24 18:24:09.007016+00
62872993-2681-44d6-9b4a-2f968f5c39aa	7b3ee32c-313a-42c8-a2e5-227882442942	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.007016+00	2026-07-24 18:24:09.007016+00
fcfd57ec-29d5-484d-a789-c327e8ce4b4f	7b3ee32c-313a-42c8-a2e5-227882442942	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.007016+00	2026-07-24 18:24:09.007017+00
28098798-b279-48bb-8649-5a997cd667e1	7b3ee32c-313a-42c8-a2e5-227882442942	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.007017+00	2026-07-24 18:24:09.007017+00
7a4be623-8ae5-4fad-8967-67728dd1abff	7b3ee32c-313a-42c8-a2e5-227882442942	DUMPSTERS	0.00	2026-07-24 18:24:09.007017+00	2026-07-24 18:24:09.007017+00
7b1bbc68-a54f-4ae6-9788-e7757f7c5fe6	7b3ee32c-313a-42c8-a2e5-227882442942	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.007017+00	2026-07-24 18:24:09.007017+00
0d2e5c63-702a-4da0-bbd6-5ec1f0fe4990	7b3ee32c-313a-42c8-a2e5-227882442942	UNALLOCATED	0.00	2026-07-24 18:24:09.007018+00	2026-07-24 18:24:09.007018+00
7c94e3cc-8a87-45af-9e15-fa3ced88f48c	a92cae36-b38e-4bd4-950e-8ae4734cfc9d	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.039412+00	2026-07-24 18:24:09.039412+00
f37b9942-04e5-4903-8f48-f3005dbaa739	a92cae36-b38e-4bd4-950e-8ae4734cfc9d	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.039413+00	2026-07-24 18:24:09.039413+00
9ba7fd62-62d3-4d26-af6c-d23f6b6d3604	a92cae36-b38e-4bd4-950e-8ae4734cfc9d	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.039413+00	2026-07-24 18:24:09.039413+00
1e018bea-5cbf-4ff8-8995-3130a6d81248	a92cae36-b38e-4bd4-950e-8ae4734cfc9d	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.039413+00	2026-07-24 18:24:09.039414+00
2e0dc994-7082-4f5e-a839-609f18566e13	a92cae36-b38e-4bd4-950e-8ae4734cfc9d	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.039414+00	2026-07-24 18:24:09.039414+00
2af17cb9-e90f-42a5-beb0-45f9ae58daa4	a92cae36-b38e-4bd4-950e-8ae4734cfc9d	DUMPSTERS	0.00	2026-07-24 18:24:09.039414+00	2026-07-24 18:24:09.039414+00
268929de-fc40-4566-a77c-a4ca441e8409	a92cae36-b38e-4bd4-950e-8ae4734cfc9d	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.039414+00	2026-07-24 18:24:09.039415+00
cb618196-7aca-4a41-b180-82d9642ee77a	a92cae36-b38e-4bd4-950e-8ae4734cfc9d	UNALLOCATED	0.00	2026-07-24 18:24:09.039415+00	2026-07-24 18:24:09.039415+00
49e1fa28-0beb-48a6-8ce5-a4037ec52d15	a3a06788-1eaa-484e-95ef-cd0d5a1d2097	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.074681+00	2026-07-24 18:24:09.074682+00
277a3f1e-b69e-46eb-9eba-6c3588559b3d	a3a06788-1eaa-484e-95ef-cd0d5a1d2097	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.074683+00	2026-07-24 18:24:09.074683+00
5da693cb-e8bd-48e8-a2a9-816882feef63	a3a06788-1eaa-484e-95ef-cd0d5a1d2097	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.074683+00	2026-07-24 18:24:09.074683+00
f42d8a38-ce3c-4f49-a539-fa3967e763a1	a3a06788-1eaa-484e-95ef-cd0d5a1d2097	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.074683+00	2026-07-24 18:24:09.074684+00
4b702aba-97e9-4065-9bbd-57550c976d62	a3a06788-1eaa-484e-95ef-cd0d5a1d2097	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.074684+00	2026-07-24 18:24:09.074684+00
559d0f85-b68a-44ec-ba4f-a33f88eab63a	a3a06788-1eaa-484e-95ef-cd0d5a1d2097	DUMPSTERS	0.00	2026-07-24 18:24:09.074684+00	2026-07-24 18:24:09.074684+00
8e222d6f-a5d6-4806-a5e8-8b655f72a56c	a3a06788-1eaa-484e-95ef-cd0d5a1d2097	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.074684+00	2026-07-24 18:24:09.074685+00
2b88b8dc-e851-4074-b7ae-f926a9dfbef3	a3a06788-1eaa-484e-95ef-cd0d5a1d2097	UNALLOCATED	0.00	2026-07-24 18:24:09.074685+00	2026-07-24 18:24:09.074685+00
d39ff2a1-e8d0-4954-a8ac-874873e519fd	c92e1fed-90b3-4535-9a7a-273bc07cdea2	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.432391+00	2026-07-24 18:24:09.432393+00
35d309f7-13ef-4d08-a06e-926b681ac3e0	c92e1fed-90b3-4535-9a7a-273bc07cdea2	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.432396+00	2026-07-24 18:24:09.432397+00
b85e97bb-8d01-41c5-a416-8ddc0611923a	c92e1fed-90b3-4535-9a7a-273bc07cdea2	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.432398+00	2026-07-24 18:24:09.432399+00
fc56b7f1-b1ef-4c22-bd2e-4d990d1f6efe	c92e1fed-90b3-4535-9a7a-273bc07cdea2	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.4324+00	2026-07-24 18:24:09.432401+00
4fbab3f7-c85d-4881-b7a9-de153185790e	c92e1fed-90b3-4535-9a7a-273bc07cdea2	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.432402+00	2026-07-24 18:24:09.432403+00
6790bb60-ba78-48e3-b244-5802e0ad2f9e	c92e1fed-90b3-4535-9a7a-273bc07cdea2	DUMPSTERS	0.00	2026-07-24 18:24:09.432404+00	2026-07-24 18:24:09.432404+00
057a194b-98f1-49f1-a1be-c4c93394367a	c92e1fed-90b3-4535-9a7a-273bc07cdea2	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.432406+00	2026-07-24 18:24:09.432406+00
5f08114b-a8a6-431f-be7f-78a64eb0a736	c92e1fed-90b3-4535-9a7a-273bc07cdea2	UNALLOCATED	172000.00	2026-07-24 18:24:09.432408+00	2026-07-24 18:24:09.432408+00
d09dac4a-5882-420e-9773-c3b3a5d6f194	3cfb5915-512b-4547-b15c-cd8a3accb54b	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.122371+00	2026-07-24 18:24:10.122371+00
b38000a2-27b5-43f0-8889-9dd0a0d5c05e	3cfb5915-512b-4547-b15c-cd8a3accb54b	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.122374+00	2026-07-24 18:24:10.122374+00
938fcc5a-ff63-495f-9c62-d8a7be8d9493	c9b49b14-d72c-4b14-b60c-dd0abb6c45b2	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.506672+00	2026-07-24 18:24:09.506674+00
6eb6d466-e902-4a1b-8310-5b9dc4816900	c9b49b14-d72c-4b14-b60c-dd0abb6c45b2	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.506676+00	2026-07-24 18:24:09.506677+00
d6a792e6-75ac-4330-8210-d6f1488f4c76	c9b49b14-d72c-4b14-b60c-dd0abb6c45b2	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.506678+00	2026-07-24 18:24:09.506678+00
9dd285f5-45ee-48d4-8139-174d437dd353	c9b49b14-d72c-4b14-b60c-dd0abb6c45b2	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.50668+00	2026-07-24 18:24:09.50668+00
446ccf87-9ba3-4d7e-8e9a-411ed7ad2a99	c9b49b14-d72c-4b14-b60c-dd0abb6c45b2	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.506681+00	2026-07-24 18:24:09.506682+00
89eff229-2e65-40a3-9867-e6ed36b645e4	c9b49b14-d72c-4b14-b60c-dd0abb6c45b2	DUMPSTERS	0.00	2026-07-24 18:24:09.506683+00	2026-07-24 18:24:09.506683+00
2e8ce5b2-6060-44b9-923a-5fb493aaf9a0	c9b49b14-d72c-4b14-b60c-dd0abb6c45b2	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.506684+00	2026-07-24 18:24:09.506685+00
e61b7656-567f-4aa7-a917-1338ccebf9d2	c9b49b14-d72c-4b14-b60c-dd0abb6c45b2	UNALLOCATED	118000.00	2026-07-24 18:24:09.506686+00	2026-07-24 18:24:09.506686+00
cb3aed38-472e-4fc5-9a9f-eecb9e9d9415	3cfb5915-512b-4547-b15c-cd8a3accb54b	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.122376+00	2026-07-24 18:24:10.122376+00
851a18a6-5b56-4e43-bf54-32e06492a186	3cfb5915-512b-4547-b15c-cd8a3accb54b	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.122378+00	2026-07-24 18:24:10.122378+00
fae3ff96-2ddc-49a0-ba0e-9a2400492bce	3cfb5915-512b-4547-b15c-cd8a3accb54b	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.122379+00	2026-07-24 18:24:10.12238+00
e3082e93-c869-47c3-9342-3b8d52e3f667	3cfb5915-512b-4547-b15c-cd8a3accb54b	DUMPSTERS	0.00	2026-07-24 18:24:10.122381+00	2026-07-24 18:24:10.122381+00
6e820835-641c-42b0-b2ee-6fe85508422f	3cfb5915-512b-4547-b15c-cd8a3accb54b	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.122383+00	2026-07-24 18:24:10.122383+00
3ebae094-b58a-4ed5-988a-1556af348bc2	3cfb5915-512b-4547-b15c-cd8a3accb54b	UNALLOCATED	82000.00	2026-07-24 18:24:10.122384+00	2026-07-24 18:24:10.122385+00
c78e71f8-89db-4a0e-8aed-cce48cf576f1	724ea7da-b09f-4897-a060-012fc43bb2e2	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.559249+00	2026-07-24 18:24:09.55925+00
1631a699-bed0-472a-979b-6e61767a4319	724ea7da-b09f-4897-a060-012fc43bb2e2	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.559252+00	2026-07-24 18:24:09.559252+00
38c78642-485c-40c8-afd1-c1799faaeb8a	724ea7da-b09f-4897-a060-012fc43bb2e2	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.559254+00	2026-07-24 18:24:09.559254+00
fdc6e471-0535-4978-a3f0-b2c16bc9b808	724ea7da-b09f-4897-a060-012fc43bb2e2	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.559256+00	2026-07-24 18:24:09.559256+00
6d2c12ef-7243-490f-8480-bc21dd8ce16e	724ea7da-b09f-4897-a060-012fc43bb2e2	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.559258+00	2026-07-24 18:24:09.559258+00
e169bf74-23e2-4a80-bd8d-c625412b3716	724ea7da-b09f-4897-a060-012fc43bb2e2	DUMPSTERS	0.00	2026-07-24 18:24:09.559259+00	2026-07-24 18:24:09.559259+00
8fb929e2-9c06-4c76-b68d-91149f77efb5	724ea7da-b09f-4897-a060-012fc43bb2e2	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.559261+00	2026-07-24 18:24:09.559261+00
3cdf1a74-7470-4a1d-b8b4-a0de2ea67719	724ea7da-b09f-4897-a060-012fc43bb2e2	UNALLOCATED	71000.00	2026-07-24 18:24:09.559262+00	2026-07-24 18:24:09.559262+00
08ca4dca-1960-4b4b-9e8a-fe53160e216f	529e3163-4768-4047-9be7-9dddc8580a47	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.612263+00	2026-07-24 18:24:09.612264+00
5d80e03c-5eed-4722-af35-1655aede9cd2	529e3163-4768-4047-9be7-9dddc8580a47	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.612266+00	2026-07-24 18:24:09.612266+00
dc0163a1-5294-49ab-99a3-d371c55207cc	529e3163-4768-4047-9be7-9dddc8580a47	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.612268+00	2026-07-24 18:24:09.612268+00
4f0f47ab-1417-40ed-972d-719c193d7b9e	529e3163-4768-4047-9be7-9dddc8580a47	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.61227+00	2026-07-24 18:24:09.61227+00
3f7da9a3-d78f-48a1-a111-9af1f36430d2	529e3163-4768-4047-9be7-9dddc8580a47	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.612272+00	2026-07-24 18:24:09.612272+00
19aab545-bfb1-4507-acf7-9f2ea2c8987b	529e3163-4768-4047-9be7-9dddc8580a47	DUMPSTERS	0.00	2026-07-24 18:24:09.612273+00	2026-07-24 18:24:09.612273+00
376db33d-5623-4691-9545-8988258e0dec	529e3163-4768-4047-9be7-9dddc8580a47	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.612275+00	2026-07-24 18:24:09.612275+00
3d1aea0c-c495-479f-bf92-22c2610e9efe	529e3163-4768-4047-9be7-9dddc8580a47	UNALLOCATED	39500.00	2026-07-24 18:24:09.612277+00	2026-07-24 18:24:09.612277+00
ab84e6e1-40b5-42c7-9ae5-81f93eadbb61	a933dbdd-3357-42d7-b5e7-bf91d75392d1	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.662069+00	2026-07-24 18:24:09.66207+00
b3b4ef98-00a2-4eca-a8f7-faf669ad9cc5	a933dbdd-3357-42d7-b5e7-bf91d75392d1	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.662072+00	2026-07-24 18:24:09.662072+00
cd63e288-7e34-4710-b3c6-974b358fb657	a933dbdd-3357-42d7-b5e7-bf91d75392d1	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.662074+00	2026-07-24 18:24:09.662074+00
4370964f-4ea4-424d-803a-dfd4c20b0775	a933dbdd-3357-42d7-b5e7-bf91d75392d1	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.662075+00	2026-07-24 18:24:09.662076+00
b2aaf46a-ffab-48b5-a775-12b88116ec9b	a933dbdd-3357-42d7-b5e7-bf91d75392d1	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.662077+00	2026-07-24 18:24:09.662077+00
f436c9fc-5a31-4edb-8c7f-cdb14eb46ac4	a933dbdd-3357-42d7-b5e7-bf91d75392d1	DUMPSTERS	0.00	2026-07-24 18:24:09.662079+00	2026-07-24 18:24:09.662079+00
91777f5f-7c33-4e12-a47f-09d204515799	a933dbdd-3357-42d7-b5e7-bf91d75392d1	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.662081+00	2026-07-24 18:24:09.662081+00
bcde6dd8-c94c-44c6-a293-09d05580c338	a933dbdd-3357-42d7-b5e7-bf91d75392d1	UNALLOCATED	96000.00	2026-07-24 18:24:09.662083+00	2026-07-24 18:24:09.662083+00
291be8a5-2a70-4ab5-9547-263a0ed57e52	083c0384-ea66-44c8-afaa-0aa166559328	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.70601+00	2026-07-24 18:24:09.706011+00
f66454a2-ce48-4203-937a-5343e59ebd2d	083c0384-ea66-44c8-afaa-0aa166559328	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.706013+00	2026-07-24 18:24:09.706013+00
86c2eb84-3a2a-455b-aa05-921a6f39e7f1	083c0384-ea66-44c8-afaa-0aa166559328	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.706015+00	2026-07-24 18:24:09.706015+00
d9ffd81b-8420-4736-b110-7888c23a575e	083c0384-ea66-44c8-afaa-0aa166559328	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.706016+00	2026-07-24 18:24:09.706016+00
2254de91-cd54-4bbc-ad03-9381a57153ed	083c0384-ea66-44c8-afaa-0aa166559328	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.706018+00	2026-07-24 18:24:09.706018+00
b6d5d8f8-b0af-4ebc-b545-c262dd0fc1b8	083c0384-ea66-44c8-afaa-0aa166559328	DUMPSTERS	0.00	2026-07-24 18:24:09.706019+00	2026-07-24 18:24:09.706019+00
8514f810-5d39-4fb4-8bca-b87c644dbcb3	083c0384-ea66-44c8-afaa-0aa166559328	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.706021+00	2026-07-24 18:24:09.706021+00
31fb02b1-7496-4215-b44d-329067e69f30	083c0384-ea66-44c8-afaa-0aa166559328	UNALLOCATED	58000.00	2026-07-24 18:24:09.706022+00	2026-07-24 18:24:09.706022+00
8b08ffd0-8de4-4eff-802e-98bd2b6c04d4	b54a0bb4-25da-4f89-a4bf-074e4d5443ad	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.752808+00	2026-07-24 18:24:09.752808+00
b31f88d2-033f-4be8-94a3-6c0ef8dc4917	b54a0bb4-25da-4f89-a4bf-074e4d5443ad	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.752811+00	2026-07-24 18:24:09.752811+00
e017d58f-a7a1-436a-a8a4-dc61dd27d893	b54a0bb4-25da-4f89-a4bf-074e4d5443ad	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.752812+00	2026-07-24 18:24:09.752812+00
0e305c41-178d-4eb7-b93b-d3c796fa440f	b54a0bb4-25da-4f89-a4bf-074e4d5443ad	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.752814+00	2026-07-24 18:24:09.752814+00
e336042d-faff-477a-ab50-1946e701494b	b54a0bb4-25da-4f89-a4bf-074e4d5443ad	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.752816+00	2026-07-24 18:24:09.752816+00
a3510f21-d17e-4683-96bc-23349a023f46	b54a0bb4-25da-4f89-a4bf-074e4d5443ad	DUMPSTERS	0.00	2026-07-24 18:24:09.752817+00	2026-07-24 18:24:09.752817+00
9c76e8fc-7809-49de-b9cf-a710bae43821	b54a0bb4-25da-4f89-a4bf-074e4d5443ad	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.752819+00	2026-07-24 18:24:09.752819+00
c5cbcc13-5c3a-4fcf-96b8-1a9d417baf33	b54a0bb4-25da-4f89-a4bf-074e4d5443ad	UNALLOCATED	142000.00	2026-07-24 18:24:09.75282+00	2026-07-24 18:24:09.75282+00
a2ed14ba-4532-476d-9abd-e083eff0caa4	3ec45ca8-1671-4246-9d1d-fa244ee3ee13	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.795209+00	2026-07-24 18:24:09.79521+00
205f707f-aca9-4538-afe7-454fc8791717	3ec45ca8-1671-4246-9d1d-fa244ee3ee13	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.795212+00	2026-07-24 18:24:09.795212+00
ab12fbdd-c50c-47c8-b81e-bee652e18794	3ec45ca8-1671-4246-9d1d-fa244ee3ee13	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.795214+00	2026-07-24 18:24:09.795215+00
a8674258-e931-451f-81f0-25892dee3c96	3ec45ca8-1671-4246-9d1d-fa244ee3ee13	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.795216+00	2026-07-24 18:24:09.795217+00
d6ac2af6-7e52-4663-acbf-b3e9e1674100	3ec45ca8-1671-4246-9d1d-fa244ee3ee13	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.795218+00	2026-07-24 18:24:09.795219+00
e8c7e038-c91d-4e9e-b9e2-43fd07d62db2	3ec45ca8-1671-4246-9d1d-fa244ee3ee13	DUMPSTERS	0.00	2026-07-24 18:24:09.795221+00	2026-07-24 18:24:09.795221+00
0273ee45-049f-462b-9ea4-75e57b2f6068	3ec45ca8-1671-4246-9d1d-fa244ee3ee13	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.795223+00	2026-07-24 18:24:09.795223+00
7e595253-40d2-4383-ac34-bb484e88a7fd	3ec45ca8-1671-4246-9d1d-fa244ee3ee13	UNALLOCATED	228000.00	2026-07-24 18:24:09.795225+00	2026-07-24 18:24:09.795225+00
9042ee16-cd05-41f1-9290-e36673e407e4	690e89e9-95ec-4209-950c-f0f6a05efc76	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.166126+00	2026-07-24 18:24:10.166127+00
3eead718-f01e-4b16-8a56-3e0c8a230f92	690e89e9-95ec-4209-950c-f0f6a05efc76	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.166129+00	2026-07-24 18:24:10.166129+00
0a379b7e-8839-4058-bb79-fcd7d09ab313	abb76735-d7c4-41d3-bcb8-c4b2d5eb037d	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.838207+00	2026-07-24 18:24:09.838208+00
a7444b1a-1dc9-4ffc-b230-e1a732931641	abb76735-d7c4-41d3-bcb8-c4b2d5eb037d	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.83821+00	2026-07-24 18:24:09.83821+00
c0ce68f1-b835-49b9-b7c8-1a32fa5a722c	abb76735-d7c4-41d3-bcb8-c4b2d5eb037d	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.838212+00	2026-07-24 18:24:09.838213+00
a7062762-f556-48d8-8225-3435dd48fc7d	abb76735-d7c4-41d3-bcb8-c4b2d5eb037d	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.838214+00	2026-07-24 18:24:09.838214+00
c04a8eef-8ed7-46e4-b48c-e575f8b1351c	abb76735-d7c4-41d3-bcb8-c4b2d5eb037d	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.838216+00	2026-07-24 18:24:09.838216+00
ee2ce1c1-db51-4934-9b28-714fef2b400a	abb76735-d7c4-41d3-bcb8-c4b2d5eb037d	DUMPSTERS	0.00	2026-07-24 18:24:09.838218+00	2026-07-24 18:24:09.838218+00
28bc5e61-12db-43c1-a1cd-5b259b03430a	abb76735-d7c4-41d3-bcb8-c4b2d5eb037d	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.838219+00	2026-07-24 18:24:09.838219+00
e9913202-db4c-422d-9aae-941720952f78	abb76735-d7c4-41d3-bcb8-c4b2d5eb037d	UNALLOCATED	332000.00	2026-07-24 18:24:09.838221+00	2026-07-24 18:24:09.838221+00
0dec85de-0c68-4bc4-b000-a4371c417cef	690e89e9-95ec-4209-950c-f0f6a05efc76	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.166131+00	2026-07-24 18:24:10.166131+00
a6db1e16-e3f7-40bc-b063-c18fc6aef277	690e89e9-95ec-4209-950c-f0f6a05efc76	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.166133+00	2026-07-24 18:24:10.166133+00
c09dcfdc-2fe7-442d-9afe-be00d3d8848a	690e89e9-95ec-4209-950c-f0f6a05efc76	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.166135+00	2026-07-24 18:24:10.166135+00
0d2a3d31-84ef-42a0-9375-8165604ca5e5	690e89e9-95ec-4209-950c-f0f6a05efc76	DUMPSTERS	0.00	2026-07-24 18:24:10.166137+00	2026-07-24 18:24:10.166137+00
2266601e-763b-4aeb-9adb-31bfa9418886	690e89e9-95ec-4209-950c-f0f6a05efc76	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.166138+00	2026-07-24 18:24:10.166138+00
0c0a12cb-8d39-4245-b2cb-a039fad3244b	690e89e9-95ec-4209-950c-f0f6a05efc76	UNALLOCATED	66000.00	2026-07-24 18:24:10.16614+00	2026-07-24 18:24:10.16614+00
3ba0a55c-256e-4823-b521-b762900b577c	f8d906ba-4068-4ef0-a3d5-283fb6029105	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.882686+00	2026-07-24 18:24:09.882688+00
59e10f5a-7e29-4740-b26d-0dca71980d72	f8d906ba-4068-4ef0-a3d5-283fb6029105	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.88269+00	2026-07-24 18:24:09.88269+00
33e4d123-ed5b-4852-8a22-23b5e630cec5	f8d906ba-4068-4ef0-a3d5-283fb6029105	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.882693+00	2026-07-24 18:24:09.882693+00
c78bebc0-3b4a-467d-9f0f-ea3614edf884	f8d906ba-4068-4ef0-a3d5-283fb6029105	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.882695+00	2026-07-24 18:24:09.882696+00
0c8225a7-2bdc-47a3-b0dd-3de5af535193	f8d906ba-4068-4ef0-a3d5-283fb6029105	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.882698+00	2026-07-24 18:24:09.882698+00
6afec961-3a9f-422d-94ad-5e3bebf94ec3	f8d906ba-4068-4ef0-a3d5-283fb6029105	DUMPSTERS	0.00	2026-07-24 18:24:09.8827+00	2026-07-24 18:24:09.8827+00
9c147a85-71e4-4812-a287-9ad4d1d2f2e7	f8d906ba-4068-4ef0-a3d5-283fb6029105	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.882702+00	2026-07-24 18:24:09.882702+00
65ec181d-899c-4ba8-b064-2fbf1cfc1464	f8d906ba-4068-4ef0-a3d5-283fb6029105	UNALLOCATED	455000.00	2026-07-24 18:24:09.882703+00	2026-07-24 18:24:09.882704+00
87fe3bc9-bf8b-473d-a155-e8a9741454b9	f62f0e7d-5ce7-4765-96e0-3cff028b000b	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.925863+00	2026-07-24 18:24:09.925864+00
5ea9c477-3b73-4379-ad25-6f468c650afc	f62f0e7d-5ce7-4765-96e0-3cff028b000b	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.925866+00	2026-07-24 18:24:09.925867+00
381ee227-1570-48fe-81e5-0be7b67e6312	f62f0e7d-5ce7-4765-96e0-3cff028b000b	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.925868+00	2026-07-24 18:24:09.925868+00
1c5e5c8b-a60b-482e-a663-843db84872fb	f62f0e7d-5ce7-4765-96e0-3cff028b000b	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.92587+00	2026-07-24 18:24:09.92587+00
060e8849-42e0-4d42-836f-320f0306c172	f62f0e7d-5ce7-4765-96e0-3cff028b000b	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.925872+00	2026-07-24 18:24:09.925872+00
0270937b-3422-4b7c-9fc2-791a9eb7b2c9	f62f0e7d-5ce7-4765-96e0-3cff028b000b	DUMPSTERS	0.00	2026-07-24 18:24:09.925873+00	2026-07-24 18:24:09.925874+00
c9733e6b-8e86-4f2c-b10d-c6f76bc9b513	f62f0e7d-5ce7-4765-96e0-3cff028b000b	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.925875+00	2026-07-24 18:24:09.925875+00
c94e604f-4598-4ab6-afe8-07a7dbd3a580	f62f0e7d-5ce7-4765-96e0-3cff028b000b	UNALLOCATED	289000.00	2026-07-24 18:24:09.925877+00	2026-07-24 18:24:09.925877+00
d572a150-250e-4faf-ac19-232832c4975b	c437b9bd-2dea-4be3-ae90-d59b17928a30	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:09.970673+00	2026-07-24 18:24:09.970674+00
24e3ca7b-cef8-4ad8-bdab-660a79302133	c437b9bd-2dea-4be3-ae90-d59b17928a30	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:09.970676+00	2026-07-24 18:24:09.970676+00
fba8b0e0-9210-4772-ab14-e567c4e80533	c437b9bd-2dea-4be3-ae90-d59b17928a30	INTERNAL_LABOR	0.00	2026-07-24 18:24:09.970678+00	2026-07-24 18:24:09.970678+00
e4b44f3a-d06f-42a6-b306-304d0f02cbaf	c437b9bd-2dea-4be3-ae90-d59b17928a30	EXTERNAL_LABOR	0.00	2026-07-24 18:24:09.97068+00	2026-07-24 18:24:09.97068+00
6a636d18-9688-4962-b345-05544bdbba16	c437b9bd-2dea-4be3-ae90-d59b17928a30	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:09.970681+00	2026-07-24 18:24:09.970681+00
7897f653-db07-4bb2-8eb6-cc36d8562d24	c437b9bd-2dea-4be3-ae90-d59b17928a30	DUMPSTERS	0.00	2026-07-24 18:24:09.970683+00	2026-07-24 18:24:09.970683+00
1d98fd7f-2235-444a-859c-166af43ba89a	c437b9bd-2dea-4be3-ae90-d59b17928a30	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:09.970685+00	2026-07-24 18:24:09.970685+00
a12aabff-6378-46ad-86cf-24d4ce811a90	c437b9bd-2dea-4be3-ae90-d59b17928a30	UNALLOCATED	178000.00	2026-07-24 18:24:09.970687+00	2026-07-24 18:24:09.970687+00
fad97bf3-2250-4bf7-b7e5-c360cb958fa3	9e3a6080-5814-4d19-94c7-61c3bfa59039	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.018964+00	2026-07-24 18:24:10.018965+00
e0e0b943-6685-4719-b012-4a9c92b6410a	9e3a6080-5814-4d19-94c7-61c3bfa59039	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.018968+00	2026-07-24 18:24:10.018968+00
d5e5e5c1-5835-4fc1-be0c-1d9446c90e47	9e3a6080-5814-4d19-94c7-61c3bfa59039	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.01897+00	2026-07-24 18:24:10.01897+00
6004dc5a-8fb0-4359-9200-1665fe971412	9e3a6080-5814-4d19-94c7-61c3bfa59039	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.018971+00	2026-07-24 18:24:10.018971+00
a391a356-d883-47fa-829b-49c6370213bc	9e3a6080-5814-4d19-94c7-61c3bfa59039	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.018973+00	2026-07-24 18:24:10.018973+00
b30c7fba-d1a3-49bc-8a7d-034639d5e5ee	9e3a6080-5814-4d19-94c7-61c3bfa59039	DUMPSTERS	0.00	2026-07-24 18:24:10.018974+00	2026-07-24 18:24:10.018975+00
8b8087e4-4f79-4cfa-89c6-5a62102664e3	9e3a6080-5814-4d19-94c7-61c3bfa59039	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.018976+00	2026-07-24 18:24:10.018976+00
7f5a661e-bc22-4fe0-9e0c-7ec2c92756f4	9e3a6080-5814-4d19-94c7-61c3bfa59039	UNALLOCATED	181000.00	2026-07-24 18:24:10.018977+00	2026-07-24 18:24:10.018978+00
0b5fcb1f-5cb7-494d-9d9c-49443e1d7d67	f1dbebe5-e960-46d4-82b5-95a56bc4c6c0	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.068474+00	2026-07-24 18:24:10.068476+00
2af8d5f2-c8f2-45e8-99d9-07b82e8e0e77	f1dbebe5-e960-46d4-82b5-95a56bc4c6c0	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.068479+00	2026-07-24 18:24:10.068479+00
7a2c21aa-5392-4fc5-bc66-56a40eaae7d6	f1dbebe5-e960-46d4-82b5-95a56bc4c6c0	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.068481+00	2026-07-24 18:24:10.068481+00
b93fabe1-ade1-4c9f-8ba4-3d819c701368	f1dbebe5-e960-46d4-82b5-95a56bc4c6c0	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.068483+00	2026-07-24 18:24:10.068483+00
41bb51c3-8c8e-4e48-97fc-7169611db18d	f1dbebe5-e960-46d4-82b5-95a56bc4c6c0	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.068485+00	2026-07-24 18:24:10.068485+00
608fedf9-0d7a-4273-9986-d8a0dc3c568b	f1dbebe5-e960-46d4-82b5-95a56bc4c6c0	DUMPSTERS	0.00	2026-07-24 18:24:10.068486+00	2026-07-24 18:24:10.068486+00
a4ce1c00-5142-4249-bece-63b1e7459c6f	f1dbebe5-e960-46d4-82b5-95a56bc4c6c0	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.068488+00	2026-07-24 18:24:10.068488+00
4eb9d7bd-0322-4a55-9b59-e25a7e4ca23f	f1dbebe5-e960-46d4-82b5-95a56bc4c6c0	UNALLOCATED	44500.00	2026-07-24 18:24:10.068489+00	2026-07-24 18:24:10.068489+00
9bc310ff-569c-4a47-b581-5d83f4a36a0b	1f85489c-24cc-4dfa-9b96-b4b10f9998f8	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.208138+00	2026-07-24 18:24:10.208139+00
429c2a0a-de21-4f3d-97a2-46a49173112f	1f85489c-24cc-4dfa-9b96-b4b10f9998f8	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.208141+00	2026-07-24 18:24:10.208141+00
c429f4ef-1997-4615-9890-2b47fa31e3d5	1f85489c-24cc-4dfa-9b96-b4b10f9998f8	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.208143+00	2026-07-24 18:24:10.208143+00
a4b4fc4b-ac8a-4eb7-b509-0b1ea78494b6	1f85489c-24cc-4dfa-9b96-b4b10f9998f8	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.208145+00	2026-07-24 18:24:10.208145+00
fd7bdfcb-60e2-49d5-8662-2a6291efdf56	1f85489c-24cc-4dfa-9b96-b4b10f9998f8	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.208146+00	2026-07-24 18:24:10.208146+00
df2bc40c-0dea-4749-8715-ccf3b05f1a6e	1f85489c-24cc-4dfa-9b96-b4b10f9998f8	DUMPSTERS	0.00	2026-07-24 18:24:10.208147+00	2026-07-24 18:24:10.208148+00
f9558201-00ed-4ad5-bb04-0078b6afc6b5	1f85489c-24cc-4dfa-9b96-b4b10f9998f8	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.208149+00	2026-07-24 18:24:10.208149+00
fb066aee-6453-4acd-b597-8bd37a41063d	1f85489c-24cc-4dfa-9b96-b4b10f9998f8	UNALLOCATED	41500.00	2026-07-24 18:24:10.20815+00	2026-07-24 18:24:10.208151+00
409d2dd1-ff53-4c1f-9920-f873c577c692	d4f0ef96-7456-470f-83c7-38137be20653	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.249165+00	2026-07-24 18:24:10.249165+00
81720300-68d7-4fd7-8c92-0e0f05014b24	d4f0ef96-7456-470f-83c7-38137be20653	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.249167+00	2026-07-24 18:24:10.249168+00
787231a7-7440-49d1-89e7-7030c5eb5be2	d4f0ef96-7456-470f-83c7-38137be20653	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.249169+00	2026-07-24 18:24:10.24917+00
f509963f-e76f-4911-8320-61e860437d2a	d4f0ef96-7456-470f-83c7-38137be20653	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.249171+00	2026-07-24 18:24:10.249171+00
d1197093-38ed-415c-a1ca-342fa1863d73	d4f0ef96-7456-470f-83c7-38137be20653	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.249172+00	2026-07-24 18:24:10.249173+00
d2d0192a-1988-4961-a0d6-e48146674e1e	d4f0ef96-7456-470f-83c7-38137be20653	DUMPSTERS	0.00	2026-07-24 18:24:10.249174+00	2026-07-24 18:24:10.249174+00
85c12c2e-b0cb-48c5-84da-83ddf3a98978	d4f0ef96-7456-470f-83c7-38137be20653	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.249176+00	2026-07-24 18:24:10.249176+00
99aae9fc-4e39-4372-96d6-f72f811eed3d	d4f0ef96-7456-470f-83c7-38137be20653	UNALLOCATED	95500.00	2026-07-24 18:24:10.249177+00	2026-07-24 18:24:10.249177+00
656ceb29-4d09-458f-9bbc-fdb480e3d0a7	86c8ea96-f125-4925-8fef-38f245ec9f8a	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.295712+00	2026-07-24 18:24:10.295713+00
41343dde-0607-4c28-b63c-f0238585c530	86c8ea96-f125-4925-8fef-38f245ec9f8a	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.295716+00	2026-07-24 18:24:10.295716+00
e8e96cd1-df72-47dc-9784-95a0a904c711	86c8ea96-f125-4925-8fef-38f245ec9f8a	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.295718+00	2026-07-24 18:24:10.295718+00
5b9a3805-fc82-4be8-b7c1-43f051991a1f	86c8ea96-f125-4925-8fef-38f245ec9f8a	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.295719+00	2026-07-24 18:24:10.29572+00
17415484-a267-40b1-9592-0aea3802f253	86c8ea96-f125-4925-8fef-38f245ec9f8a	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.295721+00	2026-07-24 18:24:10.295721+00
b740d5d9-f5d2-49cc-9596-4cb93b556f58	86c8ea96-f125-4925-8fef-38f245ec9f8a	DUMPSTERS	0.00	2026-07-24 18:24:10.295723+00	2026-07-24 18:24:10.295723+00
06fd49dc-44c5-44da-a915-c4ba1e487deb	86c8ea96-f125-4925-8fef-38f245ec9f8a	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.295724+00	2026-07-24 18:24:10.295725+00
c2b4fedb-7bf7-4daf-87fd-4d11e27acd18	86c8ea96-f125-4925-8fef-38f245ec9f8a	UNALLOCATED	428000.00	2026-07-24 18:24:10.295726+00	2026-07-24 18:24:10.295727+00
33ce398f-7686-4cf7-990c-6216b6a3fc63	e1111e67-0fa0-488c-90df-bef48b2f5e16	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.338317+00	2026-07-24 18:24:10.338317+00
f08b9b5a-d39c-41b0-a99a-f6fe82c9b900	e1111e67-0fa0-488c-90df-bef48b2f5e16	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.338319+00	2026-07-24 18:24:10.33832+00
e1babc4c-4883-4d34-afed-7be7775c43e4	e1111e67-0fa0-488c-90df-bef48b2f5e16	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.338321+00	2026-07-24 18:24:10.338321+00
90443d70-bc61-419b-84e1-adb04a0479ab	e1111e67-0fa0-488c-90df-bef48b2f5e16	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.338323+00	2026-07-24 18:24:10.338323+00
170d4b94-cf01-40be-b12b-94c332aa6e82	e1111e67-0fa0-488c-90df-bef48b2f5e16	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.338324+00	2026-07-24 18:24:10.338325+00
0b58e5fa-1509-402e-b94e-49821ea24aab	e1111e67-0fa0-488c-90df-bef48b2f5e16	DUMPSTERS	0.00	2026-07-24 18:24:10.338326+00	2026-07-24 18:24:10.338327+00
0409b786-654c-48e6-9740-7ca8a9f24333	e1111e67-0fa0-488c-90df-bef48b2f5e16	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.338328+00	2026-07-24 18:24:10.338328+00
471e3cb4-1c98-4aff-b90a-88129b192e91	e1111e67-0fa0-488c-90df-bef48b2f5e16	UNALLOCATED	94000.00	2026-07-24 18:24:10.338329+00	2026-07-24 18:24:10.33833+00
41c7becc-ec8b-4fe3-b663-e22595f143e5	7999ab34-a3c0-4894-a153-332cf7d0e7a3	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.379467+00	2026-07-24 18:24:10.379468+00
ab17cf5a-b386-463d-a706-74dcd7369414	7999ab34-a3c0-4894-a153-332cf7d0e7a3	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.37947+00	2026-07-24 18:24:10.37947+00
fed0de62-8454-40c2-9eec-0d5c39553b5b	7999ab34-a3c0-4894-a153-332cf7d0e7a3	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.379472+00	2026-07-24 18:24:10.379472+00
2e688874-a90c-4cae-9465-1c8e4776d850	7999ab34-a3c0-4894-a153-332cf7d0e7a3	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.379473+00	2026-07-24 18:24:10.379474+00
98acf9c7-5f02-4798-b208-56701e1c0abb	7999ab34-a3c0-4894-a153-332cf7d0e7a3	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.379475+00	2026-07-24 18:24:10.379475+00
bb4d1d91-752f-4f7c-b173-5af452af824f	7999ab34-a3c0-4894-a153-332cf7d0e7a3	DUMPSTERS	0.00	2026-07-24 18:24:10.379477+00	2026-07-24 18:24:10.379477+00
d0af61bc-ebc8-4a9e-8d0a-916e15d558b7	7999ab34-a3c0-4894-a153-332cf7d0e7a3	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.379479+00	2026-07-24 18:24:10.379479+00
7cfef392-0bf0-4b83-9416-d11dfbc0735a	7999ab34-a3c0-4894-a153-332cf7d0e7a3	UNALLOCATED	56500.00	2026-07-24 18:24:10.37948+00	2026-07-24 18:24:10.37948+00
3853b593-c981-4109-9be4-f9ff34c70c28	dad8243c-a8ef-4a24-acf9-1aaf72f3ca42	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.427498+00	2026-07-24 18:24:10.427499+00
0c858aa8-44d9-4ca7-a1a2-e3de7e6eace8	dad8243c-a8ef-4a24-acf9-1aaf72f3ca42	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.427501+00	2026-07-24 18:24:10.427501+00
271a9f30-f981-43b8-a74d-5ba0dadd1174	dad8243c-a8ef-4a24-acf9-1aaf72f3ca42	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.427503+00	2026-07-24 18:24:10.427503+00
44b121ca-415e-454a-84ea-6cb924a8b352	dad8243c-a8ef-4a24-acf9-1aaf72f3ca42	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.427505+00	2026-07-24 18:24:10.427505+00
2f04f62c-966a-4e2f-9633-6f7791d4a9a3	dad8243c-a8ef-4a24-acf9-1aaf72f3ca42	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.427506+00	2026-07-24 18:24:10.427506+00
49e396a8-0b05-481c-98f1-75f4426285ab	dad8243c-a8ef-4a24-acf9-1aaf72f3ca42	DUMPSTERS	0.00	2026-07-24 18:24:10.427508+00	2026-07-24 18:24:10.427508+00
37e454a0-d695-49b1-b9f9-0727e5ad6208	dad8243c-a8ef-4a24-acf9-1aaf72f3ca42	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.427509+00	2026-07-24 18:24:10.42751+00
5eff5bb3-c701-4a6e-90de-d62b8ef6170b	dad8243c-a8ef-4a24-acf9-1aaf72f3ca42	UNALLOCATED	199000.00	2026-07-24 18:24:10.427511+00	2026-07-24 18:24:10.427511+00
85ddd69a-2725-4f15-a066-aaa1b039cd5d	0943c294-950e-47ad-9c6f-b407b6b82045	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.469222+00	2026-07-24 18:24:10.469222+00
0fbd7f8d-01b5-4fd7-aa1c-6e6b64dccf2e	0943c294-950e-47ad-9c6f-b407b6b82045	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.469225+00	2026-07-24 18:24:10.469225+00
b77975df-9652-468d-a144-6e6090b60a1b	0943c294-950e-47ad-9c6f-b407b6b82045	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.469227+00	2026-07-24 18:24:10.469227+00
a1c3d862-0583-4366-ac45-3fc2990deb74	0943c294-950e-47ad-9c6f-b407b6b82045	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.469228+00	2026-07-24 18:24:10.469229+00
6dcd23dd-e293-4c5a-bbca-258eb6f59d37	0943c294-950e-47ad-9c6f-b407b6b82045	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.46923+00	2026-07-24 18:24:10.46923+00
a3ef5508-599c-41f5-9350-52f30163cc90	0943c294-950e-47ad-9c6f-b407b6b82045	DUMPSTERS	0.00	2026-07-24 18:24:10.469232+00	2026-07-24 18:24:10.469232+00
3dcbdbb1-e415-4544-a1b6-f87cae4ccdba	0943c294-950e-47ad-9c6f-b407b6b82045	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.469233+00	2026-07-24 18:24:10.469233+00
d903f203-a131-44aa-9cb7-d67bc274244b	0943c294-950e-47ad-9c6f-b407b6b82045	UNALLOCATED	147000.00	2026-07-24 18:24:10.469235+00	2026-07-24 18:24:10.469235+00
8dd234d3-3608-46b2-9bbe-22a74459f4d1	983e3328-f010-448d-aad0-a98da3b989b3	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.511933+00	2026-07-24 18:24:10.511933+00
525487bd-f487-4b82-8b0c-7c882d65bb06	983e3328-f010-448d-aad0-a98da3b989b3	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.511935+00	2026-07-24 18:24:10.511935+00
0b6f768a-a1e4-48d8-b68e-6dbcce8f4965	983e3328-f010-448d-aad0-a98da3b989b3	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.511937+00	2026-07-24 18:24:10.511938+00
a6768a00-5e0b-4975-98af-bb2927ce390b	983e3328-f010-448d-aad0-a98da3b989b3	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.511939+00	2026-07-24 18:24:10.511939+00
ea3ef70a-b2ca-440f-9ca7-23f786bf7dbe	983e3328-f010-448d-aad0-a98da3b989b3	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.511941+00	2026-07-24 18:24:10.511941+00
65f2693c-83be-4466-a126-81ad46ffec9f	983e3328-f010-448d-aad0-a98da3b989b3	DUMPSTERS	0.00	2026-07-24 18:24:10.511942+00	2026-07-24 18:24:10.511942+00
948009b2-f518-4f08-a805-cb4c24e5a010	983e3328-f010-448d-aad0-a98da3b989b3	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.511944+00	2026-07-24 18:24:10.511944+00
b7eb6503-1dfa-4360-984c-c9908e405c15	983e3328-f010-448d-aad0-a98da3b989b3	UNALLOCATED	83500.00	2026-07-24 18:24:10.511945+00	2026-07-24 18:24:10.511946+00
2a022b37-8a70-4dfd-8ee2-fb6f3550a9c7	365287a5-958f-4f45-bcfd-c1c1d96740dc	TRAVEL_AND_LODGING	0.00	2026-07-24 18:24:10.554939+00	2026-07-24 18:24:10.55494+00
4f66fa02-5f5c-4d74-86cb-8c4175692c0e	365287a5-958f-4f45-bcfd-c1c1d96740dc	PROFESSIONAL_FEES	0.00	2026-07-24 18:24:10.554942+00	2026-07-24 18:24:10.554943+00
5353236a-50dd-41f3-8f3c-9c2bc8621b1f	365287a5-958f-4f45-bcfd-c1c1d96740dc	INTERNAL_LABOR	0.00	2026-07-24 18:24:10.554945+00	2026-07-24 18:24:10.554945+00
6581c685-289e-4e03-ad5a-a3210f90e9c0	365287a5-958f-4f45-bcfd-c1c1d96740dc	EXTERNAL_LABOR	0.00	2026-07-24 18:24:10.554947+00	2026-07-24 18:24:10.554947+00
f4573733-e2fb-4850-b9cb-4c17714dd736	365287a5-958f-4f45-bcfd-c1c1d96740dc	MATERIALS_AND_SUPPLIES	0.00	2026-07-24 18:24:10.55495+00	2026-07-24 18:24:10.55495+00
7e57f57c-2824-4698-a831-4ecc7595693e	365287a5-958f-4f45-bcfd-c1c1d96740dc	DUMPSTERS	0.00	2026-07-24 18:24:10.554952+00	2026-07-24 18:24:10.554952+00
c587c71b-5cf5-4e4d-b4c1-e85dd300383a	365287a5-958f-4f45-bcfd-c1c1d96740dc	EQUIPMENT_RENTAL_AND_FUEL	0.00	2026-07-24 18:24:10.554954+00	2026-07-24 18:24:10.554955+00
b9465048-836d-48cb-84eb-fbefdacfe309	365287a5-958f-4f45-bcfd-c1c1d96740dc	UNALLOCATED	104000.00	2026-07-24 18:24:10.554957+00	2026-07-24 18:24:10.554957+00
\.


--
-- Data for Name: budgets; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.budgets (id, opportunity_id, total_budget_amount, original_total_budget_amount, original_margin, status, activated_at, notes, created_at, updated_at) FROM stdin;
3060abdf-5062-49d3-b121-1ec0aa6d9662	c6aaacf2-4a0f-4857-8167-2fe2ac00dab0	0.00	\N	\N	draft	\N	Auto-created engagement budget	2026-07-24 18:24:08.653575+00	2026-07-24 18:24:08.653576+00
6fdb76ec-b07f-435c-93bb-507cce462f4a	35db6eab-e764-4ee2-98ae-d781494517f3	0.00	\N	\N	draft	\N	Auto-created engagement budget	2026-07-24 18:24:08.742115+00	2026-07-24 18:24:08.742115+00
23d0bdfd-77d2-41d6-9c76-271acaf0d133	a52c9644-5971-4955-9b59-df66f25c8f2d	0.00	\N	\N	draft	\N	Auto-created engagement budget	2026-07-24 18:24:08.774107+00	2026-07-24 18:24:08.774108+00
0eebf55f-2323-49ab-bead-ffa410fa6185	b182f06c-cde2-4278-bc04-4b11daac1a29	0.00	\N	\N	draft	\N	Auto-created engagement budget	2026-07-24 18:24:08.804333+00	2026-07-24 18:24:08.804334+00
0568f037-7321-474a-b1d0-09a2629b8687	248c64f8-fefc-4bb0-94b9-71064fa7a1ae	0.00	\N	\N	draft	\N	Auto-created engagement budget	2026-07-24 18:24:08.970767+00	2026-07-24 18:24:08.970768+00
7b3ee32c-313a-42c8-a2e5-227882442942	f7838ae5-0ee0-444b-8898-8e4ffe6b5549	0.00	\N	\N	draft	\N	Auto-created engagement budget	2026-07-24 18:24:09.005108+00	2026-07-24 18:24:09.005109+00
a92cae36-b38e-4bd4-950e-8ae4734cfc9d	fac6f5a9-9168-4977-bf3c-44d7b41bc7f7	0.00	\N	\N	draft	\N	Auto-created engagement budget	2026-07-24 18:24:09.037982+00	2026-07-24 18:24:09.037983+00
a3a06788-1eaa-484e-95ef-cd0d5a1d2097	8f0b3181-97c0-429c-97ad-03282eae6a07	0.00	\N	\N	draft	\N	Auto-created engagement budget	2026-07-24 18:24:09.073229+00	2026-07-24 18:24:09.07323+00
a6bf38ed-47d1-47e4-bf50-13f04a1b18de	9bc53410-e648-43ff-b935-20a686b3e0cc	0.00	\N	\N	draft	\N	Auto-created engagement budget	2026-07-24 18:24:08.837066+00	2026-07-24 18:24:08.837067+00
8ce8784c-2611-44d6-affa-035e5840dd02	47de910d-8951-4f56-9741-939410de0d19	0.00	\N	\N	draft	\N	Auto-created engagement budget	2026-07-24 18:24:08.872943+00	2026-07-24 18:24:08.872943+00
ac1e0cf7-dab2-42ce-8b8e-f0185c176323	592c30c3-3b33-4956-95c0-e0ae286b5b3d	0.00	\N	\N	draft	\N	Auto-created engagement budget	2026-07-24 18:24:08.908075+00	2026-07-24 18:24:08.908076+00
0ab15237-fd81-4da0-b8f0-cfae86382510	4b4ad37b-3798-4089-8e9a-a8d910f2cc2b	0.00	\N	\N	draft	\N	Auto-created engagement budget	2026-07-24 18:24:08.939963+00	2026-07-24 18:24:08.939964+00
c92e1fed-90b3-4535-9a7a-273bc07cdea2	55077d1f-d983-4252-b79a-64084ea21b97	172000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.233237+00	2026-07-24 18:24:09.429134+00
c9b49b14-d72c-4b14-b60c-dd0abb6c45b2	b4e2d5c8-e9f6-484a-89ba-8bba4705c4e1	118000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.458646+00	2026-07-24 18:24:09.505578+00
724ea7da-b09f-4897-a060-012fc43bb2e2	b0b134ff-548e-4de7-950f-5ae1af431706	71000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.517048+00	2026-07-24 18:24:09.55843+00
529e3163-4768-4047-9be7-9dddc8580a47	f3409f77-6734-49c8-929f-60954fbc9034	39500.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.569467+00	2026-07-24 18:24:09.611413+00
a933dbdd-3357-42d7-b5e7-bf91d75392d1	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	96000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.623094+00	2026-07-24 18:24:09.661208+00
083c0384-ea66-44c8-afaa-0aa166559328	f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	58000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.668808+00	2026-07-24 18:24:09.705121+00
b54a0bb4-25da-4f89-a4bf-074e4d5443ad	509e5e53-df5e-42c4-bd79-3ea5b49497d8	142000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.717637+00	2026-07-24 18:24:09.751965+00
3ec45ca8-1671-4246-9d1d-fa244ee3ee13	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	228000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.759253+00	2026-07-24 18:24:09.794309+00
abb76735-d7c4-41d3-bcb8-c4b2d5eb037d	71cf10e3-2ca6-4256-8e3c-6b10ee266997	332000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.802359+00	2026-07-24 18:24:09.837319+00
f8d906ba-4068-4ef0-a3d5-283fb6029105	f2717f36-697a-430f-a485-bcafc9482a32	455000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.845456+00	2026-07-24 18:24:09.881668+00
f62f0e7d-5ce7-4765-96e0-3cff028b000b	d80d6bca-688a-4dad-9204-89366f709b4f	289000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.890019+00	2026-07-24 18:24:09.924976+00
c437b9bd-2dea-4be3-ae90-d59b17928a30	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	178000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.932666+00	2026-07-24 18:24:09.96977+00
9e3a6080-5814-4d19-94c7-61c3bfa59039	36fd7907-a7d3-4f4b-a838-0810a2a81669	181000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:09.97831+00	2026-07-24 18:24:10.017782+00
f1dbebe5-e960-46d4-82b5-95a56bc4c6c0	328b7c55-274d-421b-aee2-163df067ffd1	44500.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:10.027863+00	2026-07-24 18:24:10.067502+00
3cfb5915-512b-4547-b15c-cd8a3accb54b	9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	82000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:10.080951+00	2026-07-24 18:24:10.121398+00
690e89e9-95ec-4209-950c-f0f6a05efc76	774de069-49ca-4cd5-a20e-9bb97382cdd2	66000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:10.129936+00	2026-07-24 18:24:10.165278+00
1f85489c-24cc-4dfa-9b96-b4b10f9998f8	4539b766-a4f6-4871-a6dc-0b1820f0f627	41500.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:10.17241+00	2026-07-24 18:24:10.207299+00
d4f0ef96-7456-470f-83c7-38137be20653	08ed21da-c5f3-40d0-b44c-15897cfdd3b1	95500.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:10.214639+00	2026-07-24 18:24:10.248352+00
86c8ea96-f125-4925-8fef-38f245ec9f8a	d32da9f2-4215-48f9-a1ec-71e967453305	428000.00	\N	\N	closed	\N	Factory budget	2026-07-24 18:24:10.259959+00	2026-07-24 18:24:10.298691+00
e1111e67-0fa0-488c-90df-bef48b2f5e16	249e5252-b737-446a-be25-f5e910a7380d	94000.00	\N	\N	closed	\N	Factory budget	2026-07-24 18:24:10.303765+00	2026-07-24 18:24:10.340556+00
7999ab34-a3c0-4894-a153-332cf7d0e7a3	3d320ab8-7e02-4557-ab26-c65abc774688	56500.00	\N	\N	closed	\N	Factory budget	2026-07-24 18:24:10.345386+00	2026-07-24 18:24:10.381835+00
dad8243c-a8ef-4a24-acf9-1aaf72f3ca42	906bdaec-dfde-4248-bae6-57191ccf3277	199000.00	\N	\N	closed	\N	Factory budget	2026-07-24 18:24:10.389249+00	2026-07-24 18:24:10.429719+00
0943c294-950e-47ad-9c6f-b407b6b82045	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	147000.00	\N	\N	closed	\N	Factory budget	2026-07-24 18:24:10.434845+00	2026-07-24 18:24:10.471511+00
983e3328-f010-448d-aad0-a98da3b989b3	2cb81f29-032f-4247-8259-d7d4d3ffa28f	83500.00	\N	\N	closed	\N	Factory budget	2026-07-24 18:24:10.476466+00	2026-07-24 18:24:10.514187+00
365287a5-958f-4f45-bcfd-c1c1d96740dc	74c20bea-1f9c-404f-b056-23ee26f01017	104000.00	\N	\N	active	\N	Factory budget	2026-07-24 18:24:10.519598+00	2026-07-24 18:24:10.554113+00
\.


--
-- Data for Name: catastrophe_events; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.catastrophe_events (id, name, description, created_at, updated_at) FROM stdin;
514ccb9b-7f79-4117-93ae-94115882edb2	North Texas Hail Event	Severe hailstorm impacting the Dallas-Fort Worth metro; widespread roof and skylight damage across commercial portfolios.	2026-07-24 18:24:08.634022+00	2026-07-24 18:24:08.634023+00
80ce3408-5dc3-475f-b239-0ab3b2085718	Gulf Coast Flooding	Slow-moving tropical system dropping 14+ inches of rain across the Houston and Galveston areas.	2026-07-24 18:24:08.634503+00	2026-07-24 18:24:08.634504+00
\.


--
-- Data for Name: change_orders; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.change_orders (id, project_id, change_order_number, display_name, original_contract_value, new_contract_value, original_margin, new_margin, original_completion_date, new_completion_date, signed_document_id, notes, created_at, updated_at) FROM stdin;
9b71ad89-b598-4094-9d2d-370ab1ab16b7	f2717f36-697a-430f-a485-bcafc9482a32	1	\N	618700.00	664300.00	26.00	27.10	\N	\N	eab8dacf-a7ba-53d7-94ba-0ef3d947f656	\N	2026-07-24 18:24:11.820379+00	2026-07-24 18:24:11.82038+00
\.


--
-- Data for Name: commission_policies; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.commission_policies (id, family, version_label, document_id, original_filename, content_type, policy_text, is_active, activated_at, created_at, updated_at) FROM stdin;
e0ce7c0b-badb-4c73-9df3-a0a7437e02c6	CURRENT	2026 Commission Plan	51f9f590-8d2a-5a87-b469-08a99d69e95d	2026 Commission Plan.pdf	application/pdf	2026 Commission Plan — Account Executives and Project Directors\n\nEligibility: AEs and PDs in good standing, on projects reaching CLOSED status\nwith completed financial reconciliation during the plan year.\n\nCommission basis: realized project gross profit (contract revenue less direct\ncosts) at close. Schedule: below 20 percent realized margin pays 4.0 percent of\ngross profit; 20 to 35 percent pays 6.0 percent; above 35 percent pays 8.0\npercent. Splits: Primary AE 70 percent, Project Director 30 percent unless a\nwritten split agreement is on file. Payment on the second payroll following\nfinance approval of the monthly run. Clawbacks apply to write-offs within 180\ndays of close. Administered by the Finance Manager; disputes within 30 days.\n	t	2026-05-25 18:24:07.827117+00	2026-07-24 18:24:11.824763+00	2026-07-24 18:24:11.824764+00
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.companies (id, name, industry_id, billing_contact_id, address_id, customer_number, is_customer, is_vendor, is_active, notes, created_at, updated_at) FROM stdin;
0678bf63-4382-4eec-aeaf-24604bd5675f	Brookline Property Group	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	cda0ec08-d16e-41bc-8e6c-ce01f2395df6	1	t	f	t	Portfolio property manager; 40+ commercial sites across DFW.	2026-07-24 18:24:08.210153+00	2026-07-24 18:24:08.241258+00
056f3141-1976-473b-806e-a5d6e1b01060	Silverline Logistics	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	773a30df-0dec-4469-8b3c-e6c0ac31a9e7	7109f5f2-b7b8-4c09-af09-a02c7c52b54b	2	t	f	t	\N	2026-07-24 18:24:08.26388+00	2026-07-24 18:24:08.277998+00
3b29cc0f-b47f-4a9b-9fda-d7e03bfb57d6	TexStar Hospitality Partners	e62505b4-efca-5343-ade2-be566e4b45e0	0b74a58e-4abb-4c85-8a1d-ae6f4516aaf4	f0b7b065-dc31-4114-8c2b-9f5f1e979e9b	3	t	f	t	\N	2026-07-24 18:24:08.280893+00	2026-07-24 18:24:08.297528+00
d616639c-a60a-4a5a-8c8f-8527a8c772a7	Caprock Medical Real Estate	3fb93144-c45a-5506-817f-59adb03a773c	175b4c6b-13b9-4ecb-a7e3-6d0fb451ae4d	29021e89-4fd1-4d32-b4eb-d58488cee5e6	4	t	f	t	\N	2026-07-24 18:24:08.310711+00	2026-07-24 18:24:08.324879+00
d67feba9-410d-4bad-ae80-ca85bd5d7b23	Northgate Independent School District	3a8b2964-f5d4-55b5-aa62-fe3c868d6159	8f139cf8-0b17-4254-95de-efad830a72ad	24f88819-fbfc-4a04-b665-a1af9ff7b60f	5	t	f	t	\N	2026-07-24 18:24:08.327616+00	2026-07-24 18:24:08.343107+00
e1c8d1f1-71bb-46b3-9bb4-1f09a3f2978c	Pinnacle Storage Solutions	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	cc17cfa3-fe7e-4625-9440-ea5ce76b0fc4	fef95522-14d9-445f-b59a-b12f1d048ffb	6	t	f	t	\N	2026-07-24 18:24:08.345794+00	2026-07-24 18:24:08.359512+00
4f8ec95d-d766-4a82-9d53-0a8621da9dd9	Heritage Grove Senior Living	3fb93144-c45a-5506-817f-59adb03a773c	3a19c280-1c94-41f4-93c6-17bf8f5a53b3	8399781a-6dc5-4f19-a253-8673ab652128	7	t	f	t	\N	2026-07-24 18:24:08.362104+00	2026-07-24 18:24:08.375098+00
f3ac4f4d-a06f-4f07-8bd4-85fe268cb8de	Redbird Industrial Trust	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	cc0e932c-43fe-4ec6-b3e1-df298af9a5c1	7272be66-07a1-47ab-ae21-5fbd023e617f	8	t	f	t	\N	2026-07-24 18:24:08.378058+00	2026-07-24 18:24:08.390576+00
4aa00703-066c-44df-aada-c5c5d912f6ec	Lonestar Retail Partners	8ab3d589-9408-5ded-bf10-33124fb76af3	531e85e7-06e4-4a7a-ac5d-5ce5d55a0ef9	3f9312e5-e6e9-49c2-92a0-6629b57eaacc	9	t	f	t	\N	2026-07-24 18:24:08.392888+00	2026-07-24 18:24:08.409044+00
6db6a137-e384-4224-b6ff-3f82415bf62e	Bayou City Office Holdings	6d6d6a81-c1b1-51ad-a569-14345936fb79	a560e00c-9e03-4009-b3e3-e74b4d0f391b	3432c722-74d6-4046-8d02-e175bf4e4c7e	10	t	f	t	\N	2026-07-24 18:24:08.412097+00	2026-07-24 18:24:08.426474+00
0b91bc81-e895-415d-8ea7-321e13d1cf79	Summit Ridge Apartments	4d9dc580-f1f5-5dcd-bd7d-7b655602293a	3907f666-373b-4ef8-9c89-e4934b06463e	6a5d402a-5623-4032-8508-b3de1c7c0a51	11	t	f	t	\N	2026-07-24 18:24:08.429373+00	2026-07-24 18:24:08.444706+00
c1296776-b6e3-4738-97e7-c5523454741b	Cactus Flats Distribution	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	1fafe57a-8995-4352-83a1-11040555305b	3d535e89-acf7-4b11-aeda-715827f7fc38	12	t	f	t	\N	2026-07-24 18:24:08.447677+00	2026-07-24 18:24:08.461879+00
5db42652-f672-466c-b4c9-6fa0875f9536	Gulf Coast Marine Terminals	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	72db787e-b8e4-440f-b26e-8b08d680f5c7	7b59b165-21c3-4f9a-a3fe-4a2a3e225605	13	t	f	t	\N	2026-07-24 18:24:08.46469+00	2026-07-24 18:24:08.477738+00
c579feae-c58d-4520-ad5e-f3921b3f9bbf	Alamo Heights Hotel Group	e62505b4-efca-5343-ade2-be566e4b45e0	6a5475e2-8a5f-442d-a154-9b12a51b82eb	a8d0721b-1181-429f-adcf-035f3d91f69d	14	t	f	t	\N	2026-07-24 18:24:08.480308+00	2026-07-24 18:24:08.492928+00
6f5ad4fb-962c-48d7-9d59-451595b23853	Prairie Wind Foods	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	3f57307f-01c0-4c82-b420-c99853296a30	12ffc34f-1670-4dd6-a798-c0979a855bb5	15	t	f	t	\N	2026-07-24 18:24:08.495438+00	2026-07-24 18:24:08.510223+00
03a0c6eb-0e4e-448e-9ff5-ddee84a9b5b9	First Methodist Church of Plano	53f64999-2cb4-5800-941b-9b61bec0d45e	6c434fa2-99a4-4658-8d16-4dc096ff2544	6d476b3c-abcf-45ce-bfef-626dfbd1f3bb	16	t	f	t	\N	2026-07-24 18:24:08.51306+00	2026-07-24 18:24:08.528243+00
6cd8ab85-7fd7-4b8c-9e6c-079b3d7a2e31	Lone Star Equipment Rental	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	\N	37fb5fe6-f3fc-4e66-b8e2-2246d25a42df	17	f	t	t	\N	2026-07-24 18:24:08.532041+00	2026-07-24 18:24:08.537257+00
56d4ab7e-ac1a-401d-a7da-9c8bcdb220cf	Alliance Roofing Supply	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	\N	99949bbd-e2c8-4d18-b325-b42c57df4ff5	18	f	t	t	\N	2026-07-24 18:24:08.542876+00	2026-07-24 18:24:08.549269+00
608abef9-f1ac-487d-8419-7d6cbd7b8e9e	Metroplex Dumpster Co	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	\N	dcbaa3f8-0f44-418c-bc7e-085ef35978fc	19	f	t	t	\N	2026-07-24 18:24:08.555441+00	2026-07-24 18:24:08.561241+00
118f20d6-bbd4-475f-b410-fd251afa5a8d	ProDry Restoration Equipment	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	\N	18dfed5d-a26a-4ab1-84fb-78e296d2dcae	20	f	t	t	\N	2026-07-24 18:24:08.566054+00	2026-07-24 18:24:08.570467+00
1a516cb5-d88a-49f5-945b-d62be1b14e13	Hill Country Electric	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	\N	5ba48054-2453-4b85-a69d-20ff3fac7864	21	f	t	t	\N	2026-07-24 18:24:08.574414+00	2026-07-24 18:24:08.578336+00
549043d7-7df3-4405-ba26-132773b531af	Apex Scaffolding	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	\N	30927971-96bd-4538-b452-874e9aa45df2	22	f	t	t	\N	2026-07-24 18:24:08.582044+00	2026-07-24 18:24:08.58582+00
6810ec97-1447-40b5-a039-f19e1dac57a1	Bluebonnet Environmental	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	\N	eba58e5d-550e-4c2e-95f3-1e56dc137e9a	23	f	t	t	\N	2026-07-24 18:24:08.589482+00	2026-07-24 18:24:08.593504+00
f18c7235-fc0e-4f20-a863-b3cf9e77e1a7	Rios Brothers Concrete	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	\N	870388ea-d464-4798-a96d-7e3ac0590fff	24	f	t	t	\N	2026-07-24 18:24:08.596938+00	2026-07-24 18:24:08.60211+00
c3dd60f3-4063-4fc0-9289-1d2a4669302a	ClearView Glass & Glazing	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	\N	39113064-3712-4599-9999-a6720d10bc16	25	f	t	t	\N	2026-07-24 18:24:08.60656+00	2026-07-24 18:24:08.611069+00
5a0f3fa1-b6f2-4bb0-be40-6712b6472e7f	Delta Testing Labs	f5f90f23-7ff1-5d29-99fd-06ea24271e9e	\N	70f5c45d-395e-4db3-b8d9-bbbf02d07adc	26	f	t	t	\N	2026-07-24 18:24:08.614782+00	2026-07-24 18:24:08.619119+00
\.


--
-- Data for Name: company_documents; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.company_documents (id, company_id, document_id, notes, total_square_footage, expiration_date, is_exclusive, applies_to_all_addresses, created_at, updated_at) FROM stdin;
eb49fe84-3421-4db7-a5b2-0321c7089495	0678bf63-4382-4eec-aeaf-24604bd5675f	daacfc54-181e-51e1-8fdc-1795b0dfad10	Company-wide master services agreement	\N	2027-07-24	f	t	2026-07-24 18:24:08.630619+00	2026-07-24 18:24:08.630619+00
2e884bd3-c73f-4171-aecc-b48246a340a2	3b29cc0f-b47f-4a9b-9fda-d7e03bfb57d6	2e37d5d8-6c43-532b-9ed3-75de35dfde65	Company-wide master services agreement	\N	2027-07-24	f	t	2026-07-24 18:24:08.631611+00	2026-07-24 18:24:08.631611+00
b5eed28e-3b5c-420e-8af8-876b94354a3f	5db42652-f672-466c-b4c9-6fa0875f9536	ca8082a8-bbf7-5db2-9d93-81ab1466c3ff	Company-wide master services agreement	\N	2027-07-24	f	t	2026-07-24 18:24:08.63228+00	2026-07-24 18:24:08.63228+00
\.


--
-- Data for Name: contact_addresses; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.contact_addresses (id, contact_id, address_id, is_active, start_date, end_date, notes, created_at, updated_at) FROM stdin;
de63ab1b-892d-41b9-93e5-41ace79fae05	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	43f64236-da3c-4b76-a256-dcd16def11ab	t	2026-07-24 18:24:10.254823+00	\N	Added from opportunity creation	2026-07-24 18:24:10.254928+00	2026-07-24 18:24:10.254928+00
5ccc6bc1-22f1-41fb-af9e-c1e4cac6d01e	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	169490aa-bcdc-43aa-bb6c-f3ac80a4365b	t	2026-07-24 18:24:10.074339+00	\N	Added from opportunity creation	2026-07-24 18:24:10.074493+00	2026-07-24 18:24:10.074493+00
37b61bd7-0492-402a-b915-e77a13cb3b52	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	afd674c0-cdf0-40bf-9f38-b17b9ee7c215	t	2026-07-24 18:24:09.617855+00	\N	Added from opportunity creation	2026-07-24 18:24:09.617969+00	2026-07-24 18:24:09.617969+00
1ef11745-02c0-4428-9587-8ac18a23530e	c7f692b6-73e6-4280-aa3b-777909ee8dcd	13f4b072-7d7c-4c7e-819e-4d547d15eb65	t	2026-07-24 18:24:09.222308+00	\N	Added from opportunity creation	2026-07-24 18:24:09.222482+00	2026-07-24 18:24:09.222482+00
44cc52c8-fa53-45e6-a8d4-32e14aa59efb	773a30df-0dec-4469-8b3c-e6c0ac31a9e7	878e1693-f2c3-489d-97ad-a7c3d4d9035a	t	2026-07-24 18:24:09.564471+00	\N	Added from opportunity creation	2026-07-24 18:24:09.564602+00	2026-07-24 18:24:09.564603+00
f342089c-f741-4083-a676-5c938963e7e5	0b74a58e-4abb-4c85-8a1d-ae6f4516aaf4	2a12bf11-ba9a-4765-8ef9-2263e249a7a9	t	2026-07-24 18:24:08.934359+00	\N	Added from opportunity creation	2026-07-24 18:24:08.934499+00	2026-07-24 18:24:08.9345+00
7e5f3cff-72e8-43eb-9e6d-f94ea0803c58	158fe954-6327-472f-980e-f3aa622d3bef	2a12bf11-ba9a-4765-8ef9-2263e249a7a9	t	2026-07-24 18:24:10.383526+00	\N	Added from opportunity creation	2026-07-24 18:24:10.383668+00	2026-07-24 18:24:10.383668+00
83b515c0-34d5-4b6b-a80d-b0a5f656d1a4	175b4c6b-13b9-4ecb-a7e3-6d0fb451ae4d	e07ff3db-f6ed-4641-b985-7f61ae8226e6	t	2026-07-24 18:24:09.451623+00	\N	Added from opportunity creation	2026-07-24 18:24:09.451843+00	2026-07-24 18:24:09.451844+00
a0edd4f5-0376-46d3-91de-a39690ae75b2	8f139cf8-0b17-4254-95de-efad830a72ad	af5a0069-696c-4247-bebc-b4aa2fba90b7	t	2026-07-24 18:24:08.830034+00	\N	Added from opportunity creation	2026-07-24 18:24:08.830174+00	2026-07-24 18:24:08.830174+00
310a9361-4c6b-4eb0-84e7-cc2dbd8f0918	cc17cfa3-fe7e-4625-9440-ea5ce76b0fc4	d8525ce4-4c80-474f-a949-437cddae0813	t	2026-07-24 18:24:09.712295+00	\N	Added from opportunity creation	2026-07-24 18:24:09.712418+00	2026-07-24 18:24:09.712418+00
021c20a4-e85d-425d-bc35-51a1155c7fa0	cc17cfa3-fe7e-4625-9440-ea5ce76b0fc4	e7c25fc3-14d7-4015-a3fd-495947de0091	t	2026-07-24 18:24:08.768145+00	\N	Added from opportunity creation	2026-07-24 18:24:08.768252+00	2026-07-24 18:24:08.768252+00
e06e4344-fd39-4843-9d04-ec2ae0c06355	3a19c280-1c94-41f4-93c6-17bf8f5a53b3	10575e96-95bf-486c-ae4e-3a9d8a10f50d	t	2026-07-24 18:24:08.736231+00	\N	Added from opportunity creation	2026-07-24 18:24:08.736339+00	2026-07-24 18:24:08.736339+00
a2c6b96e-8059-4f8f-8e02-58fc5fff4530	cc0e932c-43fe-4ec6-b3e1-df298af9a5c1	508f3772-d59f-4039-a516-893110ff4a46	t	2026-07-24 18:24:08.964688+00	\N	Added from opportunity creation	2026-07-24 18:24:08.964871+00	2026-07-24 18:24:08.964872+00
b088c00b-8572-4241-b398-15e2a2ad4395	531e85e7-06e4-4a7a-ac5d-5ce5d55a0ef9	44b4fb75-da35-4e2f-b8e9-f004552b6942	t	2026-07-24 18:24:09.067928+00	\N	Added from opportunity creation	2026-07-24 18:24:09.068053+00	2026-07-24 18:24:09.068054+00
832ca9be-5e25-4de6-92be-b1cbab3204e1	a560e00c-9e03-4009-b3e3-e74b4d0f391b	5ec12e07-ee46-438c-876f-b3ea14d6cf50	t	2026-07-24 18:24:08.641571+00	\N	Added from opportunity creation	2026-07-24 18:24:08.641904+00	2026-07-24 18:24:08.641905+00
2d8f9230-76a4-4a7b-ac0b-a857b93a784e	3907f666-373b-4ef8-9c89-e4934b06463e	07ddc0d7-0347-4ae4-a9e7-7caffad7fe32	t	2026-07-24 18:24:08.999598+00	\N	Added from opportunity creation	2026-07-24 18:24:08.999717+00	2026-07-24 18:24:08.999717+00
b07e6bfa-4269-4e17-9c63-56c88ab7bc17	1fafe57a-8995-4352-83a1-11040555305b	50577a8c-aaf3-43f5-bce1-c0b8d514acdd	t	2026-07-24 18:24:08.866404+00	\N	Added from opportunity creation	2026-07-24 18:24:08.866523+00	2026-07-24 18:24:08.866524+00
25757c06-a398-4e0f-9218-214246292834	72db787e-b8e4-440f-b26e-8b08d680f5c7	a1e40a72-215e-4538-8f29-1001e0a43f4a	t	2026-07-24 18:24:09.512137+00	\N	Added from opportunity creation	2026-07-24 18:24:09.512257+00	2026-07-24 18:24:09.512257+00
e1d24888-02b3-41d1-9eb4-f2c693170ab2	6a5475e2-8a5f-442d-a154-9b12a51b82eb	f9d38b53-7a66-4837-8b40-e9df2a697d30	t	2026-07-24 18:24:09.032348+00	\N	Added from opportunity creation	2026-07-24 18:24:09.032465+00	2026-07-24 18:24:09.032465+00
5a9e825f-6a79-4e3a-a0e1-9ca9a8098686	3f57307f-01c0-4c82-b420-c99853296a30	aa3c9138-8afd-44be-8504-959f59bccd1e	t	2026-07-24 18:24:08.90244+00	\N	Added from opportunity creation	2026-07-24 18:24:08.902562+00	2026-07-24 18:24:08.902562+00
0f31ccc5-350c-4c12-abf8-0ef6908c266c	6c434fa2-99a4-4658-8d16-4dc096ff2544	63d0b371-b67d-40e0-a8ed-8d8bf2411383	t	2026-07-24 18:24:08.799493+00	\N	Added from opportunity creation	2026-07-24 18:24:08.799613+00	2026-07-24 18:24:08.799613+00
\.


--
-- Data for Name: contact_interactions; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.contact_interactions (id, contact_id, interaction_date, action, note, created_by, created_at, updated_at) FROM stdin;
531621d3-fa8e-4114-b7b3-eec7e83e9e7e	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	2026-07-21 18:24:07.827117+00	PHONE_CALL	Walked Alicia through the Deep Ellum warehouse drying logs; she asked for a demobilization estimate by Friday.	marcus.webb@ciridae.com	2026-07-24 18:24:08.622659+00	2026-07-24 18:24:08.62266+00
a06e5ca3-6b40-43ef-a767-66eb3355ad95	c7f692b6-73e6-4280-aa3b-777909ee8dcd	2026-07-12 18:24:07.827117+00	IN_PERSON_MEETING	Quarterly portfolio review at Brookline's office. Two capex roof projects likely in Q4.	marcus.webb@ciridae.com	2026-07-24 18:24:08.623286+00	2026-07-24 18:24:08.623286+00
a84bee98-e97d-49c2-99b2-26fa324e0abf	0b74a58e-4abb-4c85-8a1d-ae6f4516aaf4	2026-07-19 18:24:07.827117+00	VIRTUAL_MEETING	Reviewed the guest tower renovation phasing plan with Miguel's team; awaiting board sign-off.	danny.alvarez@ciridae.com	2026-07-24 18:24:08.623606+00	2026-07-24 18:24:08.623606+00
97869b14-352a-427f-b751-43549d19e645	8f139cf8-0b17-4254-95de-efad830a72ad	2026-07-16 18:24:07.827117+00	PHONE_CALL	Carl confirmed summer break access for the gymnasium remediation; keys via facilities office.	priya.raman@ciridae.com	2026-07-24 18:24:08.623899+00	2026-07-24 18:24:08.6239+00
f0c37a45-c28e-4828-823b-c05735bda2c4	3a19c280-1c94-41f4-93c6-17bf8f5a53b3	2026-07-05 18:24:07.827117+00	IN_PERSON_MEETING	Toured the memory-care wing with Patricia to scope the kitchen fire repairs.	priya.raman@ciridae.com	2026-07-24 18:24:08.6242+00	2026-07-24 18:24:08.6242+00
f2d03642-67ac-45e5-a24e-e4fd4fa875f6	a560e00c-9e03-4009-b3e3-e74b4d0f391b	2026-07-22 18:24:07.827117+00	PHONE_CALL	Terrence reported elevated moisture readings on floor 14; monitoring visit scheduled.	priya.raman@ciridae.com	2026-07-24 18:24:08.624498+00	2026-07-24 18:24:08.624498+00
a0948c1d-5d2d-4449-9a0f-a9d81241106e	72db787e-b8e4-440f-b26e-8b08d680f5c7	2026-06-28 18:24:07.827117+00	EVENT	Hosted Gulf Coast Marine ops team at the Houston safety expo.	priya.raman@ciridae.com	2026-07-24 18:24:08.624776+00	2026-07-24 18:24:08.624776+00
2ed4473e-94a7-4335-aace-bac4a75ba1a9	6a5475e2-8a5f-442d-a154-9b12a51b82eb	2026-07-20 18:24:07.827117+00	VIRTUAL_MEETING	Sofia asked for references on hotel guest-floor turn work before signing the proposal.	danny.alvarez@ciridae.com	2026-07-24 18:24:08.625052+00	2026-07-24 18:24:08.625053+00
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.contacts (id, company_id, industry_id, first_name, last_name, email, phone, mobile, title, status, category, notes, created_at, updated_at) FROM stdin;
7ca4882b-bcbc-48e2-b472-b22c96dbc61b	0678bf63-4382-4eec-aeaf-24604bd5675f	\N	Alicia	Fontaine	alicia.fontaine@brooklinepg.com	2145550137	\N	VP of Facilities	client	PROPERTY_MANAGER	\N	2026-07-24 18:24:08.229677+00	2026-07-24 18:24:08.229679+00
c7f692b6-73e6-4280-aa3b-777909ee8dcd	0678bf63-4382-4eec-aeaf-24604bd5675f	\N	Gregory	Nash	greg.nash@brooklinepg.com	2145550164	\N	Regional Property Manager	client	PROPERTY_MANAGER	\N	2026-07-24 18:24:08.252542+00	2026-07-24 18:24:08.252544+00
773a30df-0dec-4469-8b3c-e6c0ac31a9e7	056f3141-1976-473b-806e-a5d6e1b01060	\N	Dana	Kowalski	dkowalski@silverlinelogistics.com	9725550118	\N	Director of Operations	client	PROPERTY_OWNER	\N	2026-07-24 18:24:08.270903+00	2026-07-24 18:24:08.270905+00
0b74a58e-4abb-4c85-8a1d-ae6f4516aaf4	3b29cc0f-b47f-4a9b-9fda-d7e03bfb57d6	\N	Miguel	Herrera	mherrera@texstarhospitality.com	5125550142	\N	Director of Engineering	client	PROPERTY_MANAGER	\N	2026-07-24 18:24:08.287569+00	2026-07-24 18:24:08.287571+00
158fe954-6327-472f-980e-f3aa622d3bef	3b29cc0f-b47f-4a9b-9fda-d7e03bfb57d6	\N	Joanne	Pruitt	jpruitt@texstarhospitality.com	5125550177	\N	Asset Manager	client	PROPERTY_OWNER	\N	2026-07-24 18:24:08.301015+00	2026-07-24 18:24:08.301016+00
175b4c6b-13b9-4ecb-a7e3-6d0fb451ae4d	d616639c-a60a-4a5a-8c8f-8527a8c772a7	\N	Sandra	Ellison	sellison@caprockmre.com	2145550189	\N	Facilities Director	client	PROPERTY_MANAGER	\N	2026-07-24 18:24:08.317503+00	2026-07-24 18:24:08.317505+00
8f139cf8-0b17-4254-95de-efad830a72ad	d67feba9-410d-4bad-ae80-ca85bd5d7b23	\N	Carl	Jefferson	cjefferson@northgateisd.org	2815550125	\N	Director of Maintenance & Operations	client	PROPERTY_OWNER	\N	2026-07-24 18:24:08.335649+00	2026-07-24 18:24:08.335651+00
cc17cfa3-fe7e-4625-9440-ea5ce76b0fc4	e1c8d1f1-71bb-46b3-9bb4-1f09a3f2978c	\N	Renee	Calloway	rcalloway@pinnaclestorage.com	6025550151	\N	Regional Facilities Manager	prospect	PROPERTY_MANAGER	\N	2026-07-24 18:24:08.352617+00	2026-07-24 18:24:08.352618+00
3a19c280-1c94-41f4-93c6-17bf8f5a53b3	4f8ec95d-d766-4a82-9d53-0a8621da9dd9	\N	Patricia	Osei	posei@heritagegrove.com	7135550139	\N	Executive Director	client	PROPERTY_OWNER	\N	2026-07-24 18:24:08.368218+00	2026-07-24 18:24:08.368219+00
cc0e932c-43fe-4ec6-b3e1-df298af9a5c1	f3ac4f4d-a06f-4f07-8bd4-85fe268cb8de	\N	Victor	Aldana	valdana@redbirdtrust.com	2145550171	\N	Portfolio Manager	client	PROPERTY_OWNER	\N	2026-07-24 18:24:08.384255+00	2026-07-24 18:24:08.384256+00
531e85e7-06e4-4a7a-ac5d-5ce5d55a0ef9	4aa00703-066c-44df-aada-c5c5d912f6ec	\N	Hannah	Brock	hbrock@lonestarretail.com	5125550113	\N	Property Manager	prospect	PROPERTY_MANAGER	\N	2026-07-24 18:24:08.400407+00	2026-07-24 18:24:08.400411+00
a560e00c-9e03-4009-b3e3-e74b4d0f391b	6db6a137-e384-4224-b6ff-3f82415bf62e	\N	Terrence	Vaughn	tvaughn@bayoucityoffice.com	7135550166	\N	Chief Engineer	client	PROPERTY_MANAGER	\N	2026-07-24 18:24:08.419171+00	2026-07-24 18:24:08.419173+00
3907f666-373b-4ef8-9c89-e4934b06463e	0b91bc81-e895-415d-8ea7-321e13d1cf79	\N	Lauren	McAvoy	lmcavoy@summitridgeliving.com	3035550147	\N	Community Director	client	PROPERTY_MANAGER	\N	2026-07-24 18:24:08.436824+00	2026-07-24 18:24:08.436826+00
1fafe57a-8995-4352-83a1-11040555305b	c1296776-b6e3-4738-97e7-c5523454741b	\N	Omar	Reyes	oreyes@cactusflats.com	6025550128	\N	Site Operations Lead	prospect	PROPERTY_OWNER	\N	2026-07-24 18:24:08.454059+00	2026-07-24 18:24:08.45406+00
72db787e-b8e4-440f-b26e-8b08d680f5c7	5db42652-f672-466c-b4c9-6fa0875f9536	\N	Bill	Standish	bstandish@gcmterminals.com	4095550152	\N	Terminal Manager	client	PROPERTY_OWNER	\N	2026-07-24 18:24:08.471126+00	2026-07-24 18:24:08.471127+00
6a5475e2-8a5f-442d-a154-9b12a51b82eb	c579feae-c58d-4520-ad5e-f3921b3f9bbf	\N	Sofia	Marchetti	smarchetti@alamoheightshotels.com	2105550119	\N	General Manager	prospect	PROPERTY_MANAGER	\N	2026-07-24 18:24:08.486493+00	2026-07-24 18:24:08.486494+00
3f57307f-01c0-4c82-b420-c99853296a30	6f5ad4fb-962c-48d7-9d59-451595b23853	\N	Ken	Yamada	kyamada@prairiewindfoods.com	2145550183	\N	Plant Engineering Manager	client	PROPERTY_OWNER	\N	2026-07-24 18:24:08.502553+00	2026-07-24 18:24:08.502555+00
6c434fa2-99a4-4658-8d16-4dc096ff2544	03a0c6eb-0e4e-448e-9ff5-ddee84a9b5b9	\N	Deborah	Whitlock	dwhitlock@fmcplano.org	9725550134	\N	Business Administrator	prospect	PROPERTY_OWNER	\N	2026-07-24 18:24:08.519638+00	2026-07-24 18:24:08.519639+00
\.


--
-- Data for Name: cost_codes; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.cost_codes (id, code, name, legacy_account_id, legacy_account_name, legacy_cost_type_id, created_at, updated_at) FROM stdin;
07329fbc-730e-4d46-9a82-eefd794a4fda	travel-and-lodging	Travel and Lodging	5040	COGS - Travel - COGS	1	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.130448+00
b7bbddac-9f20-43f5-bbe6-37492ae6ee7c	professional-fees	Professional Fees	5080	COGS - Permits, Bonds and Fees - COGS	2	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.130868+00
35a2fa33-fddf-4d0d-905f-ccc63a729948	internal-labor	Internal Labor	5015	COGS - General Labor - COGS	3	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.131129+00
1071491c-879b-4a66-b003-1db0d31e4a21	external-labor	External Labor	5010	COGS - Contract Labor - COGS	4	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.13139+00
893feb0b-0e69-4597-8747-877c472710ab	concrete-subcontractor	Concrete Subcontractor	5010	COGS - Contract Labor - COGS	4b	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.131634+00
c4cb590a-56a4-4d92-9e24-f6613faad6c2	metals-subcontractor	Metals Subcontractor	5010	COGS - Contract Labor - COGS	4c	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.131869+00
9c2821d0-cdd1-42aa-817f-a685ac452def	electrical-subcontractor	Electrical Subcontractor	5010	COGS - Contract Labor - COGS	4d	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.132096+00
fe0fe8c1-4f86-4681-a405-be5d5945f044	doors-docks-windows-subcontractor	Doors, Docks and Windows Subcontractor	5010	COGS - Contract Labor - COGS	4e	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.132331+00
bd69c776-5765-461a-87a6-e412e0e5bd8a	finishes-subcontractor	Finishes Subcontractor	5010	COGS - Contract Labor - COGS	4f	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.132547+00
f71eb4fc-11f0-4640-b48a-eff21cb50e19	fire-suppression-subcontractor	Fire Suppression Subcontractor	5010	COGS - Contract Labor - COGS	4g	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.132758+00
673e8b40-5f1a-446e-ab7e-6be5a0971200	plumbing-subcontractor	Plumbing Subcontractor	5010	COGS - Contract Labor - COGS	4h	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.132967+00
aa0c2f6a-21c9-44f1-bd6e-bfb3ebee32a6	hvac-subcontractor	HVAC Subcontractor	5010	COGS - Contract Labor - COGS	4i	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.133176+00
2e836804-80cb-4259-a962-1f6603f4e10b	roofing-subcontractor	Roofing Subcontractor	5010	COGS - Contract Labor - COGS	4j	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.133391+00
4fb91976-c87d-41a1-9885-841690b776f2	landscaping-subcontractor	Landscaping Subcontractor	5010	COGS - Contract Labor - COGS	4k	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.133599+00
cd82303d-61ab-4091-aa61-33f8a9327baa	specialty-subcontractor	Specialty Subcontractor	5010	COGS - Contract Labor - COGS	4l	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.133804+00
9b2fc5a2-7235-499c-9a9f-f2a7660a5348	materials-and-supplies	Materials & Supplies	5020	COGS:Materials/Supplies - COGS	5	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.134018+00
d77589e6-fd5d-425e-bfb2-e7995aaac0f0	dumpsters	Dumpsters	5090	COGS - Dumpsters	6	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.134222+00
dc19e4f6-9660-4d86-8339-e51adf5a00e3	equipment-rental-and-fuel	Equipment Rental & Fuel	5000	COGS - Equipment Rental - COGS	7	2026-07-24 18:24:03.154592+00	2026-07-24 18:24:08.134457+00
\.


--
-- Data for Name: dataset_metadata; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.dataset_metadata (key, value) FROM stdin;
dataset_name	Synthetic restoration contractor source data
dataset_version	1
dataset_as_of	2026-07-28
generated_at	2026-07-28 18:43:10.313609+00
synthetic	true
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.documents (id, original_filename, file_size, content_type, document_type, created_at, updated_at) FROM stdin;
daacfc54-181e-51e1-8fdc-1795b0dfad10	MSA - Brookline Property Group.pdf	14056	application/pdf	SIGNED_MSA	2026-07-24 18:24:08.629149+00	2026-07-24 18:24:08.629151+00
2e37d5d8-6c43-532b-9ed3-75de35dfde65	MSA - TexStar Hospitality Partners.pdf	13895	application/pdf	SIGNED_MSA	2026-07-24 18:24:08.631301+00	2026-07-24 18:24:08.631301+00
ca8082a8-bbf7-5db2-9d93-81ab1466c3ff	MSA - Gulf Coast Marine Terminals.pdf	13652	application/pdf	SIGNED_MSA	2026-07-24 18:24:08.631998+00	2026-07-24 18:24:08.631999+00
d2fb4af9-47d0-50cd-a4dd-4e83b77a9ab1	Estimate - Prairie Wind Foods — Cold Storage Annex.pdf	13882	application/pdf	BID_ESTIMATE	2026-07-24 18:24:09.140122+00	2026-07-24 18:24:09.140122+00
0269806d-0e59-562b-b7fd-929ee986a559	Estimate - TexStar — Guest Tower Renovation.pdf	13835	application/pdf	BID_ESTIMATE	2026-07-24 18:24:09.153636+00	2026-07-24 18:24:09.153636+00
9841e8b3-b1e5-5fac-9c5c-0ccb96ac4b6c	Estimate - Redbird — Building C Roof Replacement.pdf	14070	application/pdf	BID_ESTIMATE	2026-07-24 18:24:09.170368+00	2026-07-24 18:24:09.170369+00
5383dea6-a166-5206-bc24-d507d41e98df	Signed Contract - RTX00010004.pdf	14513	application/pdf	SIGNED_CONTRACT	2026-07-24 18:24:10.638639+00	2026-07-24 18:24:10.63864+00
9ed458a4-64ba-5d74-995f-9c93155bb581	Signed Contract - CTX00080002.pdf	14680	application/pdf	SIGNED_CONTRACT	2026-07-24 18:24:10.640097+00	2026-07-24 18:24:10.640097+00
295699aa-c41d-56c8-9831-34098c2fd232	Signed Contract - BTX00030002.pdf	14691	application/pdf	SIGNED_CONTRACT	2026-07-24 18:24:10.641006+00	2026-07-24 18:24:10.641007+00
37472eaa-689b-5e62-82ea-e5b043ecb104	Signed Contract - RTX00050002.pdf	14693	application/pdf	SIGNED_CONTRACT	2026-07-24 18:24:10.641644+00	2026-07-24 18:24:10.641645+00
9f8c1c25-200c-5da1-adcd-4f6aec2cc60e	Signed Contract - BTX00070002.pdf	15104	application/pdf	SIGNED_CONTRACT	2026-07-24 18:24:10.64227+00	2026-07-24 18:24:10.642271+00
13a7e0f6-c26a-50f1-a775-e77d5c58f6a0	Signed Contract - CTX00020002.pdf	14742	application/pdf	SIGNED_CONTRACT	2026-07-24 18:24:10.643092+00	2026-07-24 18:24:10.643093+00
4b51e8b3-1f81-5951-b493-5f2844ac0597	Signed Work Authorization - WA-2026-0142.pdf	13774	application/pdf	SIGNED_WORK_AUTHORIZATION	2026-07-24 18:24:10.645103+00	2026-07-24 18:24:10.645103+00
b5169264-19f0-571d-8268-0a5f5c0433b1	Signed Work Authorization - WA-2026-0151.pdf	13855	application/pdf	SIGNED_WORK_AUTHORIZATION	2026-07-24 18:24:10.646099+00	2026-07-24 18:24:10.646099+00
32115c1b-685c-514b-965a-587ccaac49c6	Signed Work Authorization - WA-2026-0146.pdf	13845	application/pdf	SIGNED_WORK_AUTHORIZATION	2026-07-24 18:24:10.646993+00	2026-07-24 18:24:10.646994+00
a8148008-08b4-5a14-992d-27c81004ea6a	Signed Work Authorization - WA-2026-0144.pdf	13585	application/pdf	SIGNED_WORK_AUTHORIZATION	2026-07-24 18:24:10.647888+00	2026-07-24 18:24:10.647889+00
6c575d05-0ff5-577b-a028-fb63e5d9117d	invoice_INV-2026-0491.pdf	13943	application/pdf	INVOICE	2026-07-24 18:24:10.720449+00	2026-07-24 18:24:10.72045+00
8b7fae9d-6946-5834-b3a7-20529ffef68b	invoice_INV-2026-0533.pdf	13703	application/pdf	INVOICE	2026-07-24 18:24:10.742733+00	2026-07-24 18:24:10.742735+00
3d5551a0-f174-53e0-9e4b-2e4bfb41ede7	invoice_INV-2026-0448.pdf	13822	application/pdf	INVOICE	2026-07-24 18:24:10.753342+00	2026-07-24 18:24:10.753343+00
f41b7651-8e61-5fa3-bad4-98302f863afc	invoice_INV-2026-0462.pdf	13977	application/pdf	INVOICE	2026-07-24 18:24:10.759612+00	2026-07-24 18:24:10.759613+00
142604bc-e70b-5850-85bf-230736868cd4	invoice_INV-2026-0479.pdf	13961	application/pdf	INVOICE	2026-07-24 18:24:10.765114+00	2026-07-24 18:24:10.765115+00
25e14978-d69b-5437-9302-40a3d1676811	invoice_INV-2026-0561.pdf	13797	application/pdf	INVOICE	2026-07-24 18:24:10.770623+00	2026-07-24 18:24:10.770624+00
9b3b5294-8605-592d-9b24-4d34d44b3a6d	invoice_INV-2026-0455.pdf	13630	application/pdf	INVOICE	2026-07-24 18:24:10.776167+00	2026-07-24 18:24:10.776167+00
cf9566be-eb16-560d-a00e-274392bbba21	invoice_INV-2026-0502.pdf	13708	application/pdf	INVOICE	2026-07-24 18:24:10.780981+00	2026-07-24 18:24:10.780982+00
64edabd2-935f-57ab-98a8-584be9753a17	invoice_INV-2026-0549.pdf	13736	application/pdf	INVOICE	2026-07-24 18:24:10.785942+00	2026-07-24 18:24:10.785942+00
fff84210-b7e6-5189-8842-1f35005ffaf6	invoice_INV-2026-0571.pdf	13830	application/pdf	INVOICE	2026-07-24 18:24:10.7912+00	2026-07-24 18:24:10.791201+00
833b5b2b-c170-5b52-959f-c2e4edc330ee	invoice_INV-2026-0515.pdf	13860	application/pdf	INVOICE	2026-07-24 18:24:10.796299+00	2026-07-24 18:24:10.7963+00
e7cb2a42-370e-57a7-acd6-8d58ade69b19	invoice_INV-2026-0538.pdf	13711	application/pdf	INVOICE	2026-07-24 18:24:10.801218+00	2026-07-24 18:24:10.801218+00
ffff6075-b3fe-5cc1-96a4-45ac48a8e516	invoice_INV-2026-0526.pdf	14006	application/pdf	INVOICE	2026-07-24 18:24:10.806144+00	2026-07-24 18:24:10.806144+00
7e7b431a-762c-56db-afc8-5dc67bd815ab	invoice_INV-2026-0578.pdf	14098	application/pdf	INVOICE	2026-07-24 18:24:10.81073+00	2026-07-24 18:24:10.810731+00
2643a10a-2220-5703-9bdb-e7d8c97b7ef4	invoice_INV-2026-0585.pdf	14058	application/pdf	INVOICE	2026-07-24 18:24:10.818403+00	2026-07-24 18:24:10.818404+00
961436eb-b99a-5d65-bdc2-c55310b25347	invoice_INV-2026-0582.pdf	13696	application/pdf	INVOICE	2026-07-24 18:24:10.823103+00	2026-07-24 18:24:10.823104+00
eab8dacf-a7ba-53d7-94ba-0ef3d947f656	Change Order 1 - CTX00080002.pdf	13063	application/pdf	CHANGE_ORDER	2026-07-24 18:24:11.818027+00	2026-07-24 18:24:11.818029+00
51f9f590-8d2a-5a87-b469-08a99d69e95d	2026 Commission Plan.pdf	14593	application/pdf	OTHER	2026-07-24 18:24:11.821446+00	2026-07-24 18:24:11.821447+00
e75e6dc7-8320-4aff-ae8d-837ae670a9b0	FINAL_MONTHLY_CLOSE_JUNE_2026.xlsx	35482	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet	OTHER	2026-07-24 18:24:12.034797+00	2026-07-24 18:24:12.035242+00
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.employees (id, legacy_worker_id, legacy_associate_id, legacy_reports_to_worker_id, email, first_name, last_name, display_name, phone, mobile, branch_id, hire_date, termination_date, employment_status, business_unit, business_unit_name, department, location, job_title, payroll_group_code, notes, created_at, updated_at) FROM stdin;
1b20d122-5294-4c80-b16f-f678d1040e88	\N	\N	\N	marcus.webb@ciridae.com	Marcus	Webb	Marcus Webb	\N	\N	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	\N	Active	\N	\N	Operations	Dallas	Senior Account Executive	\N	\N	2026-07-24 18:24:08.198798+00	2026-07-24 18:24:08.198799+00
d397a68c-35e3-4c5e-ade1-a2a772bb5f4f	\N	\N	\N	priya.raman@ciridae.com	Priya	Raman	Priya Raman	\N	\N	8c3a37db-86aa-5ada-974f-407012c21d70	\N	\N	Active	\N	\N	Operations	Houston	Account Executive	\N	\N	2026-07-24 18:24:08.199336+00	2026-07-24 18:24:08.199336+00
3eff8b0d-b0de-4ae8-a0e2-883f4b42a010	\N	\N	\N	danny.alvarez@ciridae.com	Danny	Alvarez	Danny Alvarez	\N	\N	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	\N	\N	Active	\N	\N	Operations	Austin	Account Executive	\N	\N	2026-07-24 18:24:08.199815+00	2026-07-24 18:24:08.199815+00
d8dbfeb9-9cab-4e84-be4c-75d9406cfe27	\N	\N	\N	elena.sokolov@ciridae.com	Elena	Sokolov	Elena Sokolov	\N	\N	a2f068c0-97cc-537d-a395-a3d84500d912	\N	\N	Active	\N	\N	Operations	Phoenix	Account Executive	\N	\N	2026-07-24 18:24:08.200261+00	2026-07-24 18:24:08.200262+00
af77d93d-6ca1-465e-bed7-253fc794e109	\N	\N	\N	ray.delgado@ciridae.com	Ray	Delgado	Ray Delgado	\N	\N	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	\N	Active	\N	\N	Operations	Dallas	Operations Manager	\N	\N	2026-07-24 18:24:08.20074+00	2026-07-24 18:24:08.200741+00
1cd587a7-4a78-4375-9030-7379324efd6e	\N	\N	\N	tasha.green@ciridae.com	Tasha	Green	Tasha Green	\N	\N	8c3a37db-86aa-5ada-974f-407012c21d70	\N	\N	Active	\N	\N	Operations	Houston	Operations Manager	\N	\N	2026-07-24 18:24:08.201164+00	2026-07-24 18:24:08.201165+00
643ca164-0fb4-401a-a861-64172242e2c4	\N	\N	\N	sam.whitfield@ciridae.com	Sam	Whitfield	Sam Whitfield	\N	\N	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	\N	Active	\N	\N	Operations	Dallas	Project Director	\N	\N	2026-07-24 18:24:08.201596+00	2026-07-24 18:24:08.201596+00
2901a9f0-d4cd-4f9f-9cef-c73aa5d285e1	\N	\N	\N	jenna.okafor@ciridae.com	Jenna	Okafor	Jenna Okafor	\N	\N	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	\N	Active	\N	\N	Operations	Dallas	Project Coordinator	\N	\N	2026-07-24 18:24:08.202015+00	2026-07-24 18:24:08.202015+00
3095e4d0-236d-4c2b-8a88-2aaa54b4d547	\N	\N	\N	cole.bennett@ciridae.com	Cole	Bennett	Cole Bennett	\N	\N	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	\N	Active	\N	\N	Operations	Dallas	Estimator	\N	\N	2026-07-24 18:24:08.202437+00	2026-07-24 18:24:08.202437+00
dfd04378-3b99-4219-bf0d-5f419097767f	\N	\N	\N	mia.torres@ciridae.com	Mia	Torres	Mia Torres	\N	\N	8c3a37db-86aa-5ada-974f-407012c21d70	\N	\N	Active	\N	\N	Operations	Houston	Estimator	\N	\N	2026-07-24 18:24:08.202878+00	2026-07-24 18:24:08.202879+00
\.


--
-- Data for Name: engagement_assignments; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.engagement_assignments (id, opportunity_id, employee_id, capacity, created_at, updated_at) FROM stdin;
2d647d02-1ba5-487d-8e65-5784540e720c	c6aaacf2-4a0f-4857-8167-2fe2ac00dab0	d397a68c-35e3-4c5e-ade1-a2a772bb5f4f	Primary AE	2026-07-24 18:24:08.659983+00	2026-07-24 18:24:08.732114+00
2dd3bfaf-ddb1-45bc-93ae-40cdcea81f40	35db6eab-e764-4ee2-98ae-d781494517f3	d397a68c-35e3-4c5e-ade1-a2a772bb5f4f	Primary AE	2026-07-24 18:24:08.74455+00	2026-07-24 18:24:08.764553+00
f7e91f51-26fc-4b6c-a60d-561b34c0e1f7	a52c9644-5971-4955-9b59-df66f25c8f2d	d8dbfeb9-9cab-4e84-be4c-75d9406cfe27	Primary AE	2026-07-24 18:24:08.776394+00	2026-07-24 18:24:08.79511+00
c87edb44-6508-4bd5-b0bc-2cefa7126f16	b182f06c-cde2-4278-bc04-4b11daac1a29	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:08.80656+00	2026-07-24 18:24:08.825406+00
c404f372-abd3-44f5-81d2-359f68fb2a06	9bc53410-e648-43ff-b935-20a686b3e0cc	d397a68c-35e3-4c5e-ade1-a2a772bb5f4f	Primary AE	2026-07-24 18:24:08.83974+00	2026-07-24 18:24:08.861575+00
2e4bf42a-a32d-4f20-af1e-6a9a8b430764	9bc53410-e648-43ff-b935-20a686b3e0cc	1cd587a7-4a78-4375-9030-7379324efd6e	Primary Ops Manager	2026-07-24 18:24:08.862026+00	2026-07-24 18:24:08.862027+00
f4649e5a-326f-4796-9f23-4c06d66ece31	47de910d-8951-4f56-9741-939410de0d19	d8dbfeb9-9cab-4e84-be4c-75d9406cfe27	Primary AE	2026-07-24 18:24:08.875489+00	2026-07-24 18:24:08.898104+00
c654c98a-6587-4549-8dc5-9ff74f419d8f	592c30c3-3b33-4956-95c0-e0ae286b5b3d	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:08.91028+00	2026-07-24 18:24:08.929866+00
567e2f92-0a0d-4529-b386-b3e4bfcbe254	592c30c3-3b33-4956-95c0-e0ae286b5b3d	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:08.930241+00	2026-07-24 18:24:08.930241+00
30b61e0c-bf24-4343-b72d-fcc0e4d8b34e	4b4ad37b-3798-4089-8e9a-a8d910f2cc2b	3eff8b0d-b0de-4ae8-a0e2-883f4b42a010	Primary AE	2026-07-24 18:24:08.942321+00	2026-07-24 18:24:08.960756+00
e899fa55-28df-461a-8909-fbbd675228da	248c64f8-fefc-4bb0-94b9-71064fa7a1ae	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:08.973208+00	2026-07-24 18:24:08.995181+00
bdbd15dc-9378-42d4-bdcc-8f6df4f247b0	f7838ae5-0ee0-444b-8898-8e4ffe6b5549	3eff8b0d-b0de-4ae8-a0e2-883f4b42a010	Primary AE	2026-07-24 18:24:09.007997+00	2026-07-24 18:24:09.028713+00
7e62c245-d64d-4d8a-a8b6-95137c135054	fac6f5a9-9168-4977-bf3c-44d7b41bc7f7	3eff8b0d-b0de-4ae8-a0e2-883f4b42a010	Primary AE	2026-07-24 18:24:09.040466+00	2026-07-24 18:24:09.063905+00
1a71b53f-b387-4ed1-a99d-56e8e60e000b	8f0b3181-97c0-429c-97ad-03282eae6a07	3eff8b0d-b0de-4ae8-a0e2-883f4b42a010	Primary AE	2026-07-24 18:24:09.075638+00	2026-07-24 18:24:09.097755+00
c0e4c3e9-9775-4e0c-b936-5519e43a43a7	55077d1f-d983-4252-b79a-64084ea21b97	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:09.236181+00	2026-07-24 18:24:09.28456+00
b35d4dbc-2f8d-47c1-a5da-841f9788f448	55077d1f-d983-4252-b79a-64084ea21b97	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:09.285095+00	2026-07-24 18:24:09.285096+00
5ed996b2-da10-4470-b440-1a7ad2d46cde	b4e2d5c8-e9f6-484a-89ba-8bba4705c4e1	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:09.462527+00	2026-07-24 18:24:09.483399+00
8ef10758-78a0-4f7c-888e-3b8d91a51c41	b4e2d5c8-e9f6-484a-89ba-8bba4705c4e1	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:09.483811+00	2026-07-24 18:24:09.483812+00
284dac0e-5dd2-4903-a92e-5aae0fbe776a	b0b134ff-548e-4de7-950f-5ae1af431706	d397a68c-35e3-4c5e-ade1-a2a772bb5f4f	Primary AE	2026-07-24 18:24:09.519345+00	2026-07-24 18:24:09.537888+00
c365959b-3e6d-4e5a-ba0c-a539dff413ba	b0b134ff-548e-4de7-950f-5ae1af431706	1cd587a7-4a78-4375-9030-7379324efd6e	Primary Ops Manager	2026-07-24 18:24:09.538285+00	2026-07-24 18:24:09.538285+00
f7d9048d-930c-417a-9e32-1974ced4ecb1	f3409f77-6734-49c8-929f-60954fbc9034	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:09.5716+00	2026-07-24 18:24:09.590434+00
e040c346-9828-4f14-89fa-3e2baef4979f	f3409f77-6734-49c8-929f-60954fbc9034	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:09.590798+00	2026-07-24 18:24:09.590799+00
13915a15-2cfd-4897-b293-bbf2e75477ba	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:09.625456+00	2026-07-24 18:24:09.640106+00
c0662099-e1ae-4f50-a3e4-42c0483fed52	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:09.640484+00	2026-07-24 18:24:09.640485+00
e6811188-110f-4c02-8e12-2a46be4b0e6c	f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	d397a68c-35e3-4c5e-ade1-a2a772bb5f4f	Primary AE	2026-07-24 18:24:09.671163+00	2026-07-24 18:24:09.684575+00
9d0c3f83-0d53-4911-a9c2-212409df05e2	f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	1cd587a7-4a78-4375-9030-7379324efd6e	Primary Ops Manager	2026-07-24 18:24:09.685004+00	2026-07-24 18:24:09.685005+00
c6e6a6e3-af57-4f1c-a616-d7a34511f916	509e5e53-df5e-42c4-bd79-3ea5b49497d8	d8dbfeb9-9cab-4e84-be4c-75d9406cfe27	Primary AE	2026-07-24 18:24:09.719913+00	2026-07-24 18:24:09.731549+00
762a4e9d-3326-4c3b-8124-7095f039fffa	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	3eff8b0d-b0de-4ae8-a0e2-883f4b42a010	Primary AE	2026-07-24 18:24:09.761474+00	2026-07-24 18:24:09.773509+00
3a9f5804-f8dc-4547-ac43-0eb50d7acec9	71cf10e3-2ca6-4256-8e3c-6b10ee266997	d397a68c-35e3-4c5e-ade1-a2a772bb5f4f	Primary AE	2026-07-24 18:24:09.804738+00	2026-07-24 18:24:09.816551+00
dca6cd80-98dd-4ef2-a794-ab746fa98b25	71cf10e3-2ca6-4256-8e3c-6b10ee266997	1cd587a7-4a78-4375-9030-7379324efd6e	Primary Ops Manager	2026-07-24 18:24:09.816969+00	2026-07-24 18:24:09.81697+00
4dbe27d5-6f35-4a47-98e1-487678976783	f2717f36-697a-430f-a485-bcafc9482a32	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:09.847873+00	2026-07-24 18:24:09.86093+00
d5fbcf6b-7efd-43ba-8e03-161dc8525637	f2717f36-697a-430f-a485-bcafc9482a32	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:09.861315+00	2026-07-24 18:24:09.861315+00
6c2674b9-91f7-4b57-9be3-ed96a9bd49d2	d80d6bca-688a-4dad-9204-89366f709b4f	d397a68c-35e3-4c5e-ade1-a2a772bb5f4f	Primary AE	2026-07-24 18:24:09.892409+00	2026-07-24 18:24:09.904731+00
598de134-137c-4d89-a73d-63eee10efc37	d80d6bca-688a-4dad-9204-89366f709b4f	1cd587a7-4a78-4375-9030-7379324efd6e	Primary Ops Manager	2026-07-24 18:24:09.905071+00	2026-07-24 18:24:09.905072+00
7683d5d0-211e-4f14-8fe5-46aff1fd78ea	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	d397a68c-35e3-4c5e-ade1-a2a772bb5f4f	Primary AE	2026-07-24 18:24:09.93489+00	2026-07-24 18:24:09.948171+00
4c5ca7a2-9269-4049-b476-55a25856d4b6	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	1cd587a7-4a78-4375-9030-7379324efd6e	Primary Ops Manager	2026-07-24 18:24:09.948561+00	2026-07-24 18:24:09.948561+00
bedaf20e-fa5c-4d19-8983-d1b090227b17	36fd7907-a7d3-4f4b-a838-0810a2a81669	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:09.980753+00	2026-07-24 18:24:09.99383+00
09ea184d-ee82-4bc8-822b-eefb136e043e	36fd7907-a7d3-4f4b-a838-0810a2a81669	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:09.994271+00	2026-07-24 18:24:09.994272+00
51184af2-f381-4620-a3ba-4850d5586872	328b7c55-274d-421b-aee2-163df067ffd1	d8dbfeb9-9cab-4e84-be4c-75d9406cfe27	Primary AE	2026-07-24 18:24:10.031246+00	2026-07-24 18:24:10.046463+00
e365a9cc-eec8-4593-ba91-5f7dcab1414d	9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:10.083876+00	2026-07-24 18:24:10.098617+00
63cc5be0-a990-47ee-8fc8-24f6d0f83c05	9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:10.098999+00	2026-07-24 18:24:10.098999+00
b0149e42-b8b3-4c61-8759-c8aa5c232827	774de069-49ca-4cd5-a20e-9bb97382cdd2	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:10.132189+00	2026-07-24 18:24:10.14521+00
5102b96f-257e-4f6f-a3d7-e33a6d7e6340	774de069-49ca-4cd5-a20e-9bb97382cdd2	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:10.145608+00	2026-07-24 18:24:10.145608+00
49207ec4-c19e-4394-8597-7af569d63dfc	4539b766-a4f6-4871-a6dc-0b1820f0f627	3eff8b0d-b0de-4ae8-a0e2-883f4b42a010	Primary AE	2026-07-24 18:24:10.174965+00	2026-07-24 18:24:10.187153+00
769c21e4-f53c-4dff-81e0-6a72cbdbc74e	08ed21da-c5f3-40d0-b44c-15897cfdd3b1	3eff8b0d-b0de-4ae8-a0e2-883f4b42a010	Primary AE	2026-07-24 18:24:10.217219+00	2026-07-24 18:24:10.228898+00
17dc80a1-c9d4-4135-87c3-8d76561f5ab7	d32da9f2-4215-48f9-a1ec-71e967453305	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:10.262162+00	2026-07-24 18:24:10.273147+00
ebbf1fcd-8ea6-41a5-9f6c-85bb8795a4bc	d32da9f2-4215-48f9-a1ec-71e967453305	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:10.273579+00	2026-07-24 18:24:10.273579+00
870de66c-3e5f-4d11-b118-7da84227942b	249e5252-b737-446a-be25-f5e910a7380d	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:10.305883+00	2026-07-24 18:24:10.317674+00
55f8655a-32ec-4347-9e44-501f692f741c	249e5252-b737-446a-be25-f5e910a7380d	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:10.318039+00	2026-07-24 18:24:10.31804+00
7bb4738a-83bb-4701-acbc-87775577e6b9	3d320ab8-7e02-4557-ab26-c65abc774688	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:10.347996+00	2026-07-24 18:24:10.359505+00
671a87be-d780-4b33-ac37-7b550fde8cc7	3d320ab8-7e02-4557-ab26-c65abc774688	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:10.359842+00	2026-07-24 18:24:10.359842+00
c8be0834-1e48-4c64-b150-bc4791780c1a	906bdaec-dfde-4248-bae6-57191ccf3277	3eff8b0d-b0de-4ae8-a0e2-883f4b42a010	Primary AE	2026-07-24 18:24:10.391687+00	2026-07-24 18:24:10.406577+00
717f685d-7155-46af-97ba-9973bd0e07b9	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	d397a68c-35e3-4c5e-ade1-a2a772bb5f4f	Primary AE	2026-07-24 18:24:10.437104+00	2026-07-24 18:24:10.447845+00
be65038a-6c4c-48ce-8434-d6bd0de96a85	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	1cd587a7-4a78-4375-9030-7379324efd6e	Primary Ops Manager	2026-07-24 18:24:10.448178+00	2026-07-24 18:24:10.448178+00
53ec7aba-84b5-457d-8e4d-26ef31f98838	2cb81f29-032f-4247-8259-d7d4d3ffa28f	1b20d122-5294-4c80-b16f-f678d1040e88	Primary AE	2026-07-24 18:24:10.478751+00	2026-07-24 18:24:10.48998+00
a2c194e7-5220-4a72-bb19-205fc9b0dfb6	2cb81f29-032f-4247-8259-d7d4d3ffa28f	af77d93d-6ca1-465e-bed7-253fc794e109	Primary Ops Manager	2026-07-24 18:24:10.490347+00	2026-07-24 18:24:10.490348+00
72296e7b-6571-47c3-a37b-682e712b958e	74c20bea-1f9c-404f-b056-23ee26f01017	3eff8b0d-b0de-4ae8-a0e2-883f4b42a010	Primary AE	2026-07-24 18:24:10.521975+00	2026-07-24 18:24:10.534201+00
\.


--
-- Data for Name: gl_accounts; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.gl_accounts (id, cost_type, service_line, legacy_account_id, account_name, created_at, updated_at) FROM stdin;
16ab3058-527a-4848-b58f-84d5290bdb48	DUMPSTERS	BB	5061	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.13547+00
92639529-da4b-4c71-897b-69869cd7826a	DUMPSTERS	CONST	5062	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.135824+00
9544d54b-56d4-4d8b-9786-bb58175cb675	DUMPSTERS	MISC	5064	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.136071+00
e71cff39-fe72-4ad2-a2d0-abefb537344a	DUMPSTERS	MIT	5060	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.136313+00
195379ad-2ae0-4080-b996-749ade528184	DUMPSTERS	ROOF	5063	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.136619+00
338484dc-b94c-4333-8795-37f536bee72e	EQUIPMENT_RENTAL	BB	5001	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.136864+00
6ccc57f0-87db-4fed-9c21-9e053eb5aa7e	EQUIPMENT_RENTAL	CONST	5002	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.137093+00
b06df215-f7d6-4d11-9e3a-bcfbd26535d7	EQUIPMENT_RENTAL	MISC	5004	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.137308+00
7e0df05c-dd2b-47cb-a4e8-8be2fa8efe71	EQUIPMENT_RENTAL	MIT	5000	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.137537+00
1ab1c198-6504-40eb-9351-5394a7ac774e	EQUIPMENT_RENTAL	ROOF	5003	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.13777+00
c0752960-4272-4fe6-b345-9a431a7ee8c4	EXTERNAL_LABOR	BB	5011	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.137986+00
6e2100f4-1be2-4949-8f1c-3870a2a0495a	EXTERNAL_LABOR	CONST	5012	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.1382+00
1a53b193-c741-4eb6-ab56-1406518f9411	EXTERNAL_LABOR	MISC	5014	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.138424+00
8aa8cc85-8c5a-4501-a717-3f527b733bd2	EXTERNAL_LABOR	MIT	5010	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.138645+00
dd4a6739-62ce-4556-ac0c-06a57f3e240c	EXTERNAL_LABOR	ROOF	5013	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.139036+00
1537fa37-aa46-430d-b0b8-afbd1ca2cf22	INTERNAL_LABOR	BB	5021	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.139439+00
e0948837-af9a-42ef-b90d-594c6546a205	INTERNAL_LABOR	CONST	5022	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.139822+00
29c8a9e5-0d12-44e6-bc08-a4535ad88527	INTERNAL_LABOR	MISC	5024	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.140041+00
a39bca01-3749-4c3e-b6dc-be7d2006476b	INTERNAL_LABOR	MIT	5020	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.140258+00
be0e308d-96ed-4ea7-8fb9-302145d0fa80	INTERNAL_LABOR	ROOF	5023	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.140481+00
6fb32d20-d220-4424-86be-5f8e28582c82	MATERIALS_AND_SUPPLIES	BB	5031	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.140709+00
8763218b-5bff-4f47-8e30-de3b4248e312	MATERIALS_AND_SUPPLIES	CONST	5032	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.140927+00
a10914a5-df29-4a72-8463-089bc028f202	MATERIALS_AND_SUPPLIES	MISC	5034	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.141143+00
a37e0632-f66d-444b-9738-5787950639df	MATERIALS_AND_SUPPLIES	MIT	5030	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.141358+00
81b5f7b2-cc01-4654-9455-fef74790897f	MATERIALS_AND_SUPPLIES	ROOF	5033	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.141585+00
6fc142fd-0ecc-4dec-a68b-09e52c053199	PROFESSIONAL_FEES	BB	5051	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.141803+00
3ad222d8-4e83-4f57-91d4-5d5e88113d00	PROFESSIONAL_FEES	CONST	5052	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.142018+00
bc7aa34b-a601-4089-ab98-50015ab163ca	PROFESSIONAL_FEES	MISC	5054	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.142234+00
0d7161ad-9faa-4a9b-863d-6b696258ff5e	PROFESSIONAL_FEES	MIT	5050	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.14246+00
4641650b-81ec-4946-9814-a8af1be95db8	PROFESSIONAL_FEES	ROOF	5053	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.142677+00
69ccbf24-92aa-4ae9-a3a3-679a1972fbb2	TRAVEL	BB	5041	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.142892+00
1f1bfd80-6480-4193-a2a1-8d7adbbe6bc3	TRAVEL	CONST	5042	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.143107+00
cd2125a6-99dc-4ad8-86fc-2ca88da30863	TRAVEL	MISC	5044	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.143325+00
dd47d2b3-fa64-4a9a-aa01-f86acaf07ccc	TRAVEL	MIT	5040	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.143549+00
ac5ed1af-5422-4b35-8379-9ee8424706b7	TRAVEL	ROOF	5043	\N	2026-07-24 18:24:04.716246+00	2026-07-24 18:24:08.143742+00
\.


--
-- Data for Name: gl_entries; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.gl_entries (id, source_object, legacy_record_id, legacy_line_id, entry_type, opportunity_id, project_number, account_no, cost_code, amount, debit_amount, credit_amount, transaction_amount, currency, posting_date, document_date, due_date, payment_date, document_number, counterparty_id, counterparty_name, source_status, created_at, updated_at) FROM stdin;
740c2ded-b0d3-4a2c-8654-4796fb6b89f8	GLDETAIL	JE-RTX00010004-R0		GL_DETAIL	d32da9f2-4215-48f9-a1ec-71e967453305	RTX00010004	4010	\N	182500.00	\N	\N	\N	\N	2026-05-10 18:24:07.827117+00	2026-05-10 18:24:07.827117+00	2026-06-09 18:24:07.827117+00	\N	JE-RTX00010004-R0	\N	\N	\N	2026-07-24 18:24:10.650887+00	2026-07-24 18:24:10.650887+00
a7a6c268-235f-4933-936d-fd703610e7ba	GLDETAIL	JE-RTX00010004-C0		GL_DETAIL	d32da9f2-4215-48f9-a1ec-71e967453305	RTX00010004	5020	\N	128300.00	\N	\N	\N	\N	2026-05-10 18:24:07.827117+00	2026-05-10 18:24:07.827117+00	2026-06-09 18:24:07.827117+00	\N	JE-RTX00010004-C0	\N	\N	\N	2026-07-24 18:24:10.651859+00	2026-07-24 18:24:10.65186+00
9d32aa01-e1ec-453f-8009-2a96b83b2afb	GLDETAIL	JE-RTX00010004-R1		GL_DETAIL	d32da9f2-4215-48f9-a1ec-71e967453305	RTX00010004	4010	\N	243400.00	\N	\N	\N	\N	2026-06-06 18:24:07.827117+00	2026-06-06 18:24:07.827117+00	2026-07-06 18:24:07.827117+00	\N	JE-RTX00010004-R1	\N	\N	\N	2026-07-24 18:24:10.652428+00	2026-07-24 18:24:10.652429+00
1425b4af-83a1-4b30-a4aa-f87144f7de8f	GLDETAIL	JE-RTX00010004-C1		GL_DETAIL	d32da9f2-4215-48f9-a1ec-71e967453305	RTX00010004	5020	\N	171200.00	\N	\N	\N	\N	2026-06-06 18:24:07.827117+00	2026-06-06 18:24:07.827117+00	2026-07-06 18:24:07.827117+00	\N	JE-RTX00010004-C1	\N	\N	\N	2026-07-24 18:24:10.652967+00	2026-07-24 18:24:10.652967+00
2163e112-5df3-485e-9331-ccea8c670c3a	GLDETAIL	JE-RTX00010004-R2		GL_DETAIL	d32da9f2-4215-48f9-a1ec-71e967453305	RTX00010004	4010	\N	182500.00	\N	\N	\N	\N	2026-06-24 18:24:07.827117+00	2026-06-24 18:24:07.827117+00	2026-07-24 18:24:07.827117+00	\N	JE-RTX00010004-R2	\N	\N	\N	2026-07-24 18:24:10.653505+00	2026-07-24 18:24:10.653505+00
6b4498b7-f6e3-49b4-b1c9-bb4f17aed5da	GLDETAIL	JE-RTX00010004-C2		GL_DETAIL	d32da9f2-4215-48f9-a1ec-71e967453305	RTX00010004	5020	\N	126100.00	\N	\N	\N	\N	2026-06-24 18:24:07.827117+00	2026-06-24 18:24:07.827117+00	2026-07-24 18:24:07.827117+00	\N	JE-RTX00010004-C2	\N	\N	\N	2026-07-24 18:24:10.653999+00	2026-07-24 18:24:10.653999+00
6e06ba32-8c2c-407b-b397-b78fda41189a	GLDETAIL	JE-MTX00020003-R0		GL_DETAIL	249e5252-b737-446a-be25-f5e910a7380d	MTX00020003	4010	\N	87700.00	\N	\N	\N	\N	2026-05-05 18:24:07.827117+00	2026-05-05 18:24:07.827117+00	2026-06-04 18:24:07.827117+00	\N	JE-MTX00020003-R0	\N	\N	\N	2026-07-24 18:24:10.654481+00	2026-07-24 18:24:10.654481+00
ae8095e8-af66-48d8-864b-c430eb413c27	GLDETAIL	JE-MTX00020003-C0		GL_DETAIL	249e5252-b737-446a-be25-f5e910a7380d	MTX00020003	5020	\N	56200.00	\N	\N	\N	\N	2026-05-05 18:24:07.827117+00	2026-05-05 18:24:07.827117+00	2026-06-04 18:24:07.827117+00	\N	JE-MTX00020003-C0	\N	\N	\N	2026-07-24 18:24:10.654993+00	2026-07-24 18:24:10.654994+00
1634f71e-8146-4ff1-9ee9-3a5b37abe246	GLDETAIL	JE-MTX00020003-R1		GL_DETAIL	249e5252-b737-446a-be25-f5e910a7380d	MTX00020003	4010	\N	58500.00	\N	\N	\N	\N	2026-05-27 18:24:07.827117+00	2026-05-27 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	\N	JE-MTX00020003-R1	\N	\N	\N	2026-07-24 18:24:10.655553+00	2026-07-24 18:24:10.655553+00
92092da8-4ba9-4d45-b012-34bea8dab48c	GLDETAIL	JE-MTX00020003-C1		GL_DETAIL	249e5252-b737-446a-be25-f5e910a7380d	MTX00020003	5020	\N	37500.00	\N	\N	\N	\N	2026-05-27 18:24:07.827117+00	2026-05-27 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	\N	JE-MTX00020003-C1	\N	\N	\N	2026-07-24 18:24:10.656048+00	2026-07-24 18:24:10.656049+00
62adb311-e845-44ba-aca8-838d3dbc8c49	GLDETAIL	JE-MTX00040002-R0		GL_DETAIL	3d320ab8-7e02-4557-ab26-c65abc774688	MTX00040002	4010	\N	50900.00	\N	\N	\N	\N	2026-05-19 18:24:07.827117+00	2026-05-19 18:24:07.827117+00	2026-06-18 18:24:07.827117+00	\N	JE-MTX00040002-R0	\N	\N	\N	2026-07-24 18:24:10.656547+00	2026-07-24 18:24:10.656548+00
04665b3a-d10e-4b51-a222-042a9d1c013f	GLDETAIL	JE-MTX00040002-C0		GL_DETAIL	3d320ab8-7e02-4557-ab26-c65abc774688	MTX00040002	5020	\N	33800.00	\N	\N	\N	\N	2026-05-19 18:24:07.827117+00	2026-05-19 18:24:07.827117+00	2026-06-18 18:24:07.827117+00	\N	JE-MTX00040002-C0	\N	\N	\N	2026-07-24 18:24:10.65703+00	2026-07-24 18:24:10.657031+00
1c6870df-2551-4d3e-9814-d221ffb06e7d	GLDETAIL	JE-MTX00040002-R1		GL_DETAIL	3d320ab8-7e02-4557-ab26-c65abc774688	MTX00040002	4010	\N	34000.00	\N	\N	\N	\N	2026-06-09 18:24:07.827117+00	2026-06-09 18:24:07.827117+00	2026-07-09 18:24:07.827117+00	\N	JE-MTX00040002-R1	\N	\N	\N	2026-07-24 18:24:10.657499+00	2026-07-24 18:24:10.657499+00
b3fbe890-9504-4b73-9748-89ca1d8cc0f2	GLDETAIL	JE-MTX00040002-C1		GL_DETAIL	3d320ab8-7e02-4557-ab26-c65abc774688	MTX00040002	5020	\N	22500.00	\N	\N	\N	\N	2026-06-09 18:24:07.827117+00	2026-06-09 18:24:07.827117+00	2026-07-09 18:24:07.827117+00	\N	JE-MTX00040002-C1	\N	\N	\N	2026-07-24 18:24:10.657997+00	2026-07-24 18:24:10.657997+00
3ad5531d-0005-4e1e-906f-3a191c686ae5	GLDETAIL	JE-CTX00030003-R0		GL_DETAIL	906bdaec-dfde-4248-bae6-57191ccf3277	CTX00030003	4010	\N	136700.00	\N	\N	\N	\N	2026-05-15 18:24:07.827117+00	2026-05-15 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	\N	JE-CTX00030003-R0	\N	\N	\N	2026-07-24 18:24:10.658457+00	2026-07-24 18:24:10.658457+00
ec323428-2c79-4fa1-90f1-cf5440af2c23	GLDETAIL	JE-CTX00030003-C0		GL_DETAIL	906bdaec-dfde-4248-bae6-57191ccf3277	CTX00030003	5020	\N	99400.00	\N	\N	\N	\N	2026-05-15 18:24:07.827117+00	2026-05-15 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	\N	JE-CTX00030003-C0	\N	\N	\N	2026-07-24 18:24:10.658926+00	2026-07-24 18:24:10.658926+00
903c6280-55cc-45d5-9b06-efab75bcd52c	GLDETAIL	JE-CTX00030003-R1		GL_DETAIL	906bdaec-dfde-4248-bae6-57191ccf3277	CTX00030003	4010	\N	136800.00	\N	\N	\N	\N	2026-06-14 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	2026-07-14 18:24:07.827117+00	\N	JE-CTX00030003-R1	\N	\N	\N	2026-07-24 18:24:10.65938+00	2026-07-24 18:24:10.65938+00
52443684-d69a-40ec-bc8e-c74cce736742	GLDETAIL	JE-CTX00030003-C1		GL_DETAIL	906bdaec-dfde-4248-bae6-57191ccf3277	CTX00030003	5020	\N	99300.00	\N	\N	\N	\N	2026-06-14 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	2026-07-14 18:24:07.827117+00	\N	JE-CTX00030003-C1	\N	\N	\N	2026-07-24 18:24:10.659857+00	2026-07-24 18:24:10.659858+00
bbfd688c-11c8-40aa-b2bf-46f0fd45d209	GLDETAIL	JE-MTX00050003-R0		GL_DETAIL	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	MTX00050003	4010	\N	137800.00	\N	\N	\N	\N	2026-06-26 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	2026-07-26 18:24:07.827117+00	\N	JE-MTX00050003-R0	\N	\N	\N	2026-07-24 18:24:10.660317+00	2026-07-24 18:24:10.660317+00
36b3d7d2-7ca7-4e2f-96a7-428bf790d08f	GLDETAIL	JE-MTX00050003-C0		GL_DETAIL	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	MTX00050003	5020	\N	88100.00	\N	\N	\N	\N	2026-06-26 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	2026-07-26 18:24:07.827117+00	\N	JE-MTX00050003-C0	\N	\N	\N	2026-07-24 18:24:10.660787+00	2026-07-24 18:24:10.660788+00
fd3c19d3-cf86-456b-98dd-719decfe7420	GLDETAIL	JE-MTX00050003-R1		GL_DETAIL	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	MTX00050003	4010	\N	91900.00	\N	\N	\N	\N	2026-07-12 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	2026-08-11 18:24:07.827117+00	\N	JE-MTX00050003-R1	\N	\N	\N	2026-07-24 18:24:10.66124+00	2026-07-24 18:24:10.66124+00
d45e0356-dceb-4d29-804c-c0edf8f462eb	GLDETAIL	JE-MTX00050003-C1		GL_DETAIL	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	MTX00050003	5020	\N	58600.00	\N	\N	\N	\N	2026-07-12 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	2026-08-11 18:24:07.827117+00	\N	JE-MTX00050003-C1	\N	\N	\N	2026-07-24 18:24:10.661703+00	2026-07-24 18:24:10.661704+00
e99accad-ea5e-44fd-9264-d83f0e50e4eb	GLDETAIL	JE-RTX00080003-R0		GL_DETAIL	2cb81f29-032f-4247-8259-d7d4d3ffa28f	RTX00080003	4010	\N	73500.00	\N	\N	\N	\N	2026-05-30 18:24:07.827117+00	2026-05-30 18:24:07.827117+00	2026-06-29 18:24:07.827117+00	\N	JE-RTX00080003-R0	\N	\N	\N	2026-07-24 18:24:10.66215+00	2026-07-24 18:24:10.662151+00
8c0fa8de-f428-4a40-8d57-bbd69a9ea107	GLDETAIL	JE-RTX00080003-C0		GL_DETAIL	2cb81f29-032f-4247-8259-d7d4d3ffa28f	RTX00080003	5020	\N	50000.00	\N	\N	\N	\N	2026-05-30 18:24:07.827117+00	2026-05-30 18:24:07.827117+00	2026-06-29 18:24:07.827117+00	\N	JE-RTX00080003-C0	\N	\N	\N	2026-07-24 18:24:10.662621+00	2026-07-24 18:24:10.662622+00
ac3d7c1f-867d-443e-9b8e-38c9ac12628a	GLDETAIL	JE-RTX00080003-R1		GL_DETAIL	2cb81f29-032f-4247-8259-d7d4d3ffa28f	RTX00080003	4010	\N	49100.00	\N	\N	\N	\N	2026-06-18 18:24:07.827117+00	2026-06-18 18:24:07.827117+00	2026-07-18 18:24:07.827117+00	\N	JE-RTX00080003-R1	\N	\N	\N	2026-07-24 18:24:10.663077+00	2026-07-24 18:24:10.663078+00
bed81a7e-baa4-4f8e-9629-3faea0c8d41f	GLDETAIL	JE-RTX00080003-C1		GL_DETAIL	2cb81f29-032f-4247-8259-d7d4d3ffa28f	RTX00080003	5020	\N	33400.00	\N	\N	\N	\N	2026-06-18 18:24:07.827117+00	2026-06-18 18:24:07.827117+00	2026-07-18 18:24:07.827117+00	\N	JE-RTX00080003-C1	\N	\N	\N	2026-07-24 18:24:10.663667+00	2026-07-24 18:24:10.663668+00
2dce765b-6afb-4326-b126-172aa2a377c6	GLDETAIL	JE-CTX00080002-R0		GL_DETAIL	f2717f36-697a-430f-a485-bcafc9482a32	CTX00080002	4010	\N	148500.00	\N	\N	\N	\N	2026-05-15 18:24:07.827117+00	2026-05-15 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	\N	JE-CTX00080002-R0	\N	\N	\N	2026-07-24 18:24:10.664124+00	2026-07-24 18:24:10.664124+00
1b9158d7-c8b5-46c7-9541-50046f28ee9c	GLDETAIL	JE-CTX00080002-C0		GL_DETAIL	f2717f36-697a-430f-a485-bcafc9482a32	CTX00080002	5020	\N	109300.00	\N	\N	\N	\N	2026-05-15 18:24:07.827117+00	2026-05-15 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	\N	JE-CTX00080002-C0	\N	\N	\N	2026-07-24 18:24:10.664599+00	2026-07-24 18:24:10.6646+00
02d5d286-9f1c-4943-ba25-a05b6c840599	GLDETAIL	JE-CTX00080002-R1		GL_DETAIL	f2717f36-697a-430f-a485-bcafc9482a32	CTX00080002	4010	\N	160300.00	\N	\N	\N	\N	2026-06-12 18:24:07.827117+00	2026-06-12 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	\N	JE-CTX00080002-R1	\N	\N	\N	2026-07-24 18:24:10.667466+00	2026-07-24 18:24:10.667468+00
44de8da1-d8b5-4d84-ad16-1837b6960e2f	GLDETAIL	JE-CTX00080002-C1		GL_DETAIL	f2717f36-697a-430f-a485-bcafc9482a32	CTX00080002	5020	\N	118000.00	\N	\N	\N	\N	2026-06-12 18:24:07.827117+00	2026-06-12 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	\N	JE-CTX00080002-C1	\N	\N	\N	2026-07-24 18:24:10.669346+00	2026-07-24 18:24:10.669347+00
8d5205f4-d9e0-4b4e-b1a5-068f8b0e7dde	GLDETAIL	JE-CTX00080002-R2		GL_DETAIL	f2717f36-697a-430f-a485-bcafc9482a32	CTX00080002	4010	\N	123700.00	\N	\N	\N	\N	2026-07-10 18:24:07.827117+00	2026-07-10 18:24:07.827117+00	2026-08-09 18:24:07.827117+00	\N	JE-CTX00080002-R2	\N	\N	\N	2026-07-24 18:24:10.671576+00	2026-07-24 18:24:10.671577+00
82bb3e43-74cb-48c2-ade9-58c0c78b2ad6	GLDETAIL	JE-CTX00080002-C2		GL_DETAIL	f2717f36-697a-430f-a485-bcafc9482a32	CTX00080002	5020	\N	91200.00	\N	\N	\N	\N	2026-07-10 18:24:07.827117+00	2026-07-10 18:24:07.827117+00	2026-08-09 18:24:07.827117+00	\N	JE-CTX00080002-C2	\N	\N	\N	2026-07-24 18:24:10.673119+00	2026-07-24 18:24:10.673122+00
3261c057-f860-461e-bf45-d2a11f662733	GLDETAIL	JE-BTX00030002-R0		GL_DETAIL	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	BTX00030002	4010	\N	93700.00	\N	\N	\N	\N	2026-06-16 18:24:07.827117+00	2026-06-16 18:24:07.827117+00	2026-07-16 18:24:07.827117+00	\N	JE-BTX00030002-R0	\N	\N	\N	2026-07-24 18:24:10.675703+00	2026-07-24 18:24:10.675705+00
353378a9-696e-4ea9-8a1c-670ebaa121d7	GLDETAIL	JE-BTX00030002-C0		GL_DETAIL	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	BTX00030002	5020	\N	68500.00	\N	\N	\N	\N	2026-06-16 18:24:07.827117+00	2026-06-16 18:24:07.827117+00	2026-07-16 18:24:07.827117+00	\N	JE-BTX00030002-C0	\N	\N	\N	2026-07-24 18:24:10.677716+00	2026-07-24 18:24:10.677717+00
48216108-89b4-44c5-8d36-a4f474e65048	GLDETAIL	JE-BTX00030002-R1		GL_DETAIL	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	BTX00030002	4010	\N	84400.00	\N	\N	\N	\N	2026-07-14 18:24:07.827117+00	2026-07-14 18:24:07.827117+00	2026-08-13 18:24:07.827117+00	\N	JE-BTX00030002-R1	\N	\N	\N	2026-07-24 18:24:10.679889+00	2026-07-24 18:24:10.679891+00
a2206b36-c9e4-4a9e-8557-9d9b1a9bdec1	GLDETAIL	JE-BTX00030002-C1		GL_DETAIL	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	BTX00030002	5020	\N	61200.00	\N	\N	\N	\N	2026-07-14 18:24:07.827117+00	2026-07-14 18:24:07.827117+00	2026-08-13 18:24:07.827117+00	\N	JE-BTX00030002-C1	\N	\N	\N	2026-07-24 18:24:10.681858+00	2026-07-24 18:24:10.68186+00
eb569a79-b253-4a43-9b4b-d6fdb2077424	GLDETAIL	JE-RTX00050002-R0		GL_DETAIL	71cf10e3-2ca6-4256-8e3c-6b10ee266997	RTX00050002	4010	\N	134300.00	\N	\N	\N	\N	2026-06-29 18:24:07.827117+00	2026-06-29 18:24:07.827117+00	2026-07-29 18:24:07.827117+00	\N	JE-RTX00050002-R0	\N	\N	\N	2026-07-24 18:24:10.683628+00	2026-07-24 18:24:10.68363+00
4936c276-cbbe-45bd-ab16-b1c05f8cab8b	GLDETAIL	JE-RTX00050002-C0		GL_DETAIL	71cf10e3-2ca6-4256-8e3c-6b10ee266997	RTX00050002	5020	\N	99600.00	\N	\N	\N	\N	2026-06-29 18:24:07.827117+00	2026-06-29 18:24:07.827117+00	2026-07-29 18:24:07.827117+00	\N	JE-RTX00050002-C0	\N	\N	\N	2026-07-24 18:24:10.685024+00	2026-07-24 18:24:10.685026+00
80cd6a11-66f8-4717-8d45-d43a24c214ed	GLDETAIL	JE-RTX00050002-R1		GL_DETAIL	71cf10e3-2ca6-4256-8e3c-6b10ee266997	RTX00050002	4010	\N	111900.00	\N	\N	\N	\N	2026-07-18 18:24:07.827117+00	2026-07-18 18:24:07.827117+00	2026-08-17 18:24:07.827117+00	\N	JE-RTX00050002-R1	\N	\N	\N	2026-07-24 18:24:10.686208+00	2026-07-24 18:24:10.686209+00
3ec37e78-7f6a-4d50-8ee8-dcd43edf55af	GLDETAIL	JE-RTX00050002-C1		GL_DETAIL	71cf10e3-2ca6-4256-8e3c-6b10ee266997	RTX00050002	5020	\N	83100.00	\N	\N	\N	\N	2026-07-18 18:24:07.827117+00	2026-07-18 18:24:07.827117+00	2026-08-17 18:24:07.827117+00	\N	JE-RTX00050002-C1	\N	\N	\N	2026-07-24 18:24:10.688494+00	2026-07-24 18:24:10.688496+00
fdb109ca-f1aa-487c-b4bd-ece3a54a6b6c	GLDETAIL	JE-BTX00070002-R0		GL_DETAIL	d80d6bca-688a-4dad-9204-89366f709b4f	BTX00070002	4010	\N	96400.00	\N	\N	\N	\N	2026-06-09 18:24:07.827117+00	2026-06-09 18:24:07.827117+00	2026-07-09 18:24:07.827117+00	\N	JE-BTX00070002-R0	\N	\N	\N	2026-07-24 18:24:10.689328+00	2026-07-24 18:24:10.689329+00
46a8977e-a126-43db-9f24-97ed7a8fe817	GLDETAIL	JE-BTX00070002-C0		GL_DETAIL	d80d6bca-688a-4dad-9204-89366f709b4f	BTX00070002	5020	\N	72300.00	\N	\N	\N	\N	2026-06-09 18:24:07.827117+00	2026-06-09 18:24:07.827117+00	2026-07-09 18:24:07.827117+00	\N	JE-BTX00070002-C0	\N	\N	\N	2026-07-24 18:24:10.69005+00	2026-07-24 18:24:10.690051+00
b9370dd0-e129-408b-a388-85ec04b45556	GLDETAIL	JE-BTX00070002-R1		GL_DETAIL	d80d6bca-688a-4dad-9204-89366f709b4f	BTX00070002	4010	\N	77100.00	\N	\N	\N	\N	2026-07-08 18:24:07.827117+00	2026-07-08 18:24:07.827117+00	2026-08-07 18:24:07.827117+00	\N	JE-BTX00070002-R1	\N	\N	\N	2026-07-24 18:24:10.690638+00	2026-07-24 18:24:10.690638+00
9d592205-42b2-4ca5-8050-5ea6abbf5297	GLDETAIL	JE-BTX00070002-C1		GL_DETAIL	d80d6bca-688a-4dad-9204-89366f709b4f	BTX00070002	5020	\N	57900.00	\N	\N	\N	\N	2026-07-08 18:24:07.827117+00	2026-07-08 18:24:07.827117+00	2026-08-07 18:24:07.827117+00	\N	JE-BTX00070002-C1	\N	\N	\N	2026-07-24 18:24:10.691191+00	2026-07-24 18:24:10.691192+00
fe2c142e-50ea-47ea-9284-e07d9b3ce1e6	GLDETAIL	JE-MTX00130002-R0		GL_DETAIL	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	MTX00130002	4010	\N	105900.00	\N	\N	\N	\N	2026-06-30 18:24:07.827117+00	2026-06-30 18:24:07.827117+00	2026-07-30 18:24:07.827117+00	\N	JE-MTX00130002-R0	\N	\N	\N	2026-07-24 18:24:10.691724+00	2026-07-24 18:24:10.691725+00
9eacd056-3597-49f3-816d-77336a016134	GLDETAIL	JE-MTX00130002-C0		GL_DETAIL	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	MTX00130002	5020	\N	71200.00	\N	\N	\N	\N	2026-06-30 18:24:07.827117+00	2026-06-30 18:24:07.827117+00	2026-07-30 18:24:07.827117+00	\N	JE-MTX00130002-C0	\N	\N	\N	2026-07-24 18:24:10.692229+00	2026-07-24 18:24:10.692229+00
c837f145-617e-4b95-b591-1abd35fb94f3	GLDETAIL	JE-MTX00130002-R1		GL_DETAIL	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	MTX00130002	4010	\N	79400.00	\N	\N	\N	\N	2026-07-16 18:24:07.827117+00	2026-07-16 18:24:07.827117+00	2026-08-15 18:24:07.827117+00	\N	JE-MTX00130002-R1	\N	\N	\N	2026-07-24 18:24:10.692736+00	2026-07-24 18:24:10.692737+00
842532a7-aed7-483b-a1eb-bdaea9456b58	GLDETAIL	JE-MTX00130002-C1		GL_DETAIL	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	MTX00130002	5020	\N	53400.00	\N	\N	\N	\N	2026-07-16 18:24:07.827117+00	2026-07-16 18:24:07.827117+00	2026-08-15 18:24:07.827117+00	\N	JE-MTX00130002-C1	\N	\N	\N	2026-07-24 18:24:10.693251+00	2026-07-24 18:24:10.693251+00
7a4cabef-2020-4b9c-abcf-1ccb67586c9d	GLDETAIL	JE-MTX00010002-R0		GL_DETAIL	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	MTX00010002	4010	\N	55900.00	\N	\N	\N	\N	2026-07-17 18:24:07.827117+00	2026-07-17 18:24:07.827117+00	2026-08-16 18:24:07.827117+00	\N	JE-MTX00010002-R0	\N	\N	\N	2026-07-24 18:24:10.69379+00	2026-07-24 18:24:10.69379+00
e73993e8-fee0-41d5-b9e9-713432043e4a	GLDETAIL	JE-MTX00010002-C0		GL_DETAIL	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	MTX00010002	5020	\N	38400.00	\N	\N	\N	\N	2026-07-17 18:24:07.827117+00	2026-07-17 18:24:07.827117+00	2026-08-16 18:24:07.827117+00	\N	JE-MTX00010002-C0	\N	\N	\N	2026-07-24 18:24:10.694342+00	2026-07-24 18:24:10.694342+00
653a7f5d-a636-45ab-97c2-6f99f5b14b40	GLDETAIL	JE-MTX00100002-R0		GL_DETAIL	f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	MTX00100002	4010	\N	34500.00	\N	\N	\N	\N	2026-07-20 18:24:07.827117+00	2026-07-20 18:24:07.827117+00	2026-08-19 18:24:07.827117+00	\N	JE-MTX00100002-R0	\N	\N	\N	2026-07-24 18:24:10.694855+00	2026-07-24 18:24:10.694856+00
d16125bc-b28c-4a01-97cb-0ab4c13114f0	GLDETAIL	JE-MTX00100002-C0		GL_DETAIL	f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	MTX00100002	5020	\N	23300.00	\N	\N	\N	\N	2026-07-20 18:24:07.827117+00	2026-07-20 18:24:07.827117+00	2026-08-19 18:24:07.827117+00	\N	JE-MTX00100002-C0	\N	\N	\N	2026-07-24 18:24:10.695366+00	2026-07-24 18:24:10.695366+00
71ca1d23-bfcb-4159-b919-6678af7854c2	GLDETAIL	JE-RAZ00060002-R0		GL_DETAIL	509e5e53-df5e-42c4-bd79-3ea5b49497d8	RAZ00060002	4010	\N	80600.00	\N	\N	\N	\N	2026-07-10 18:24:07.827117+00	2026-07-10 18:24:07.827117+00	2026-08-09 18:24:07.827117+00	\N	JE-RAZ00060002-R0	\N	\N	\N	2026-07-24 18:24:10.695858+00	2026-07-24 18:24:10.695859+00
a57a4454-9a4f-4aac-9ef7-0c1c56931f17	GLDETAIL	JE-RAZ00060002-C0		GL_DETAIL	509e5e53-df5e-42c4-bd79-3ea5b49497d8	RAZ00060002	5020	\N	56800.00	\N	\N	\N	\N	2026-07-10 18:24:07.827117+00	2026-07-10 18:24:07.827117+00	2026-08-09 18:24:07.827117+00	\N	JE-RAZ00060002-C0	\N	\N	\N	2026-07-24 18:24:10.696386+00	2026-07-24 18:24:10.696386+00
e4e9d954-0911-4312-bfa5-03655d7cfcbb	GLDETAIL	JE-BTX00010003-R0		GL_DETAIL	9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	BTX00010003	4010	\N	58300.00	\N	\N	\N	\N	2026-06-19 18:24:07.827117+00	2026-06-19 18:24:07.827117+00	2026-07-19 18:24:07.827117+00	\N	JE-BTX00010003-R0	\N	\N	\N	2026-07-24 18:24:10.696868+00	2026-07-24 18:24:10.696868+00
b82e12a3-bbd4-4c94-ba21-d635abb725b5	GLDETAIL	JE-BTX00010003-C0		GL_DETAIL	9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	BTX00010003	5020	\N	41000.00	\N	\N	\N	\N	2026-06-19 18:24:07.827117+00	2026-06-19 18:24:07.827117+00	2026-07-19 18:24:07.827117+00	\N	JE-BTX00010003-C0	\N	\N	\N	2026-07-24 18:24:10.69741+00	2026-07-24 18:24:10.69741+00
b216c77a-7b89-471e-b655-74d248489f87	GLDETAIL	JE-BTX00010003-R1		GL_DETAIL	9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	BTX00010003	4010	\N	58400.00	\N	\N	\N	\N	2026-07-08 18:24:07.827117+00	2026-07-08 18:24:07.827117+00	2026-08-07 18:24:07.827117+00	\N	JE-BTX00010003-R1	\N	\N	\N	2026-07-24 18:24:10.697974+00	2026-07-24 18:24:10.697975+00
f5e4fd0d-4b7e-42c8-aab4-af09c70744c3	GLDETAIL	JE-BTX00010003-C1		GL_DETAIL	9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	BTX00010003	5020	\N	41200.00	\N	\N	\N	\N	2026-07-08 18:24:07.827117+00	2026-07-08 18:24:07.827117+00	2026-08-07 18:24:07.827117+00	\N	JE-BTX00010003-C1	\N	\N	\N	2026-07-24 18:24:10.698482+00	2026-07-24 18:24:10.698482+00
aeb505f5-f070-4406-bf38-58ea3136ce13	GLDETAIL	JE-CTX00020002-R0		GL_DETAIL	774de069-49ca-4cd5-a20e-9bb97382cdd2	CTX00020002	4010	\N	45400.00	\N	\N	\N	\N	2026-06-24 18:24:07.827117+00	2026-06-24 18:24:07.827117+00	2026-07-24 18:24:07.827117+00	\N	JE-CTX00020002-R0	\N	\N	\N	2026-07-24 18:24:10.698979+00	2026-07-24 18:24:10.698979+00
b9946e11-a6ac-49b2-9e55-9e91ecd8292e	GLDETAIL	JE-CTX00020002-C0		GL_DETAIL	774de069-49ca-4cd5-a20e-9bb97382cdd2	CTX00020002	5020	\N	33000.00	\N	\N	\N	\N	2026-06-24 18:24:07.827117+00	2026-06-24 18:24:07.827117+00	2026-07-24 18:24:07.827117+00	\N	JE-CTX00020002-C0	\N	\N	\N	2026-07-24 18:24:10.699497+00	2026-07-24 18:24:10.699497+00
b8881f43-e680-4e03-af60-9c5bec7b146b	GLDETAIL	JE-CTX00020002-R1		GL_DETAIL	774de069-49ca-4cd5-a20e-9bb97382cdd2	CTX00020002	4010	\N	45400.00	\N	\N	\N	\N	2026-07-11 18:24:07.827117+00	2026-07-11 18:24:07.827117+00	2026-08-10 18:24:07.827117+00	\N	JE-CTX00020002-R1	\N	\N	\N	2026-07-24 18:24:10.699987+00	2026-07-24 18:24:10.699988+00
d20a8427-8a41-43d0-9454-bca283f82f4f	GLDETAIL	JE-CTX00020002-C1		GL_DETAIL	774de069-49ca-4cd5-a20e-9bb97382cdd2	CTX00020002	5020	\N	33100.00	\N	\N	\N	\N	2026-07-11 18:24:07.827117+00	2026-07-11 18:24:07.827117+00	2026-08-10 18:24:07.827117+00	\N	JE-CTX00020002-C1	\N	\N	\N	2026-07-24 18:24:10.700481+00	2026-07-24 18:24:10.700482+00
b26d9587-1466-4a49-9162-991b098aebeb	GLDETAIL	JE-BTX00140002-R0		GL_DETAIL	08ed21da-c5f3-40d0-b44c-15897cfdd3b1	BTX00140002	4010	\N	66200.00	\N	\N	\N	\N	2026-07-02 18:24:07.827117+00	2026-07-02 18:24:07.827117+00	2026-08-01 18:24:07.827117+00	\N	JE-BTX00140002-R0	\N	\N	\N	2026-07-24 18:24:10.700974+00	2026-07-24 18:24:10.700975+00
fb139297-bd5e-4a29-8b74-0832604b1a09	GLDETAIL	JE-BTX00140002-C0		GL_DETAIL	08ed21da-c5f3-40d0-b44c-15897cfdd3b1	BTX00140002	5020	\N	47700.00	\N	\N	\N	\N	2026-07-02 18:24:07.827117+00	2026-07-02 18:24:07.827117+00	2026-08-01 18:24:07.827117+00	\N	JE-BTX00140002-C0	\N	\N	\N	2026-07-24 18:24:10.701472+00	2026-07-24 18:24:10.701473+00
a527d022-a878-4a49-b1c0-35c362533650	GLDETAIL	JE-BTX00140002-R1		GL_DETAIL	08ed21da-c5f3-40d0-b44c-15897cfdd3b1	BTX00140002	4010	\N	66300.00	\N	\N	\N	\N	2026-07-18 18:24:07.827117+00	2026-07-18 18:24:07.827117+00	2026-08-17 18:24:07.827117+00	\N	JE-BTX00140002-R1	\N	\N	\N	2026-07-24 18:24:10.701949+00	2026-07-24 18:24:10.701949+00
d3585c28-54b7-4872-b5a5-e986f5cd4d25	GLDETAIL	JE-BTX00140002-C1		GL_DETAIL	08ed21da-c5f3-40d0-b44c-15897cfdd3b1	BTX00140002	5020	\N	47800.00	\N	\N	\N	\N	2026-07-18 18:24:07.827117+00	2026-07-18 18:24:07.827117+00	2026-08-17 18:24:07.827117+00	\N	JE-BTX00140002-C1	\N	\N	\N	2026-07-24 18:24:10.702425+00	2026-07-24 18:24:10.702425+00
625abd60-bcba-4f22-8735-bf83eaabf7a2	GLDETAIL	JE-XTX00090002-R0		GL_DETAIL	4539b766-a4f6-4871-a6dc-0b1820f0f627	XTX00090002	4010	\N	57300.00	\N	\N	\N	\N	2026-07-06 18:24:07.827117+00	2026-07-06 18:24:07.827117+00	2026-08-05 18:24:07.827117+00	\N	JE-XTX00090002-R0	\N	\N	\N	2026-07-24 18:24:10.702902+00	2026-07-24 18:24:10.702902+00
e64e2cd2-ea34-43e9-9204-66693ed51cc3	GLDETAIL	JE-XTX00090002-C0		GL_DETAIL	4539b766-a4f6-4871-a6dc-0b1820f0f627	XTX00090002	5020	\N	41400.00	\N	\N	\N	\N	2026-07-06 18:24:07.827117+00	2026-07-06 18:24:07.827117+00	2026-08-05 18:24:07.827117+00	\N	JE-XTX00090002-C0	\N	\N	\N	2026-07-24 18:24:10.703434+00	2026-07-24 18:24:10.703434+00
7d083f7c-5681-426b-b66f-21c5c2e18bb5	ARINVOICE	INV-2026-0491		AR_BILLING	d32da9f2-4215-48f9-a1ec-71e967453305	RTX00010004	4010	\N	304200.00	\N	\N	\N	\N	2026-05-15 18:24:07.827117+00	2026-05-15 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	\N	INV-2026-0491	\N	\N	\N	2026-07-24 18:24:10.727848+00	2026-07-24 18:24:10.727851+00
d773585e-54ad-4380-a0c4-f20289af3c9f	ARINVOICE	INV-2026-0491		AR_COLLECTION	d32da9f2-4215-48f9-a1ec-71e967453305	RTX00010004	1200	\N	304200.00	\N	\N	\N	\N	2026-06-04 18:24:07.827117+00	2026-06-04 18:24:07.827117+00	2026-07-04 18:24:07.827117+00	2026-06-04 18:24:07.827117+00	INV-2026-0491	\N	\N	\N	2026-07-24 18:24:10.730889+00	2026-07-24 18:24:10.730891+00
5fd4139d-11a9-4f99-9d36-d50bd2efc191	ARINVOICE	INV-2026-0533		AR_BILLING	d32da9f2-4215-48f9-a1ec-71e967453305	RTX00010004	4010	\N	304200.00	\N	\N	\N	\N	2026-06-12 18:24:07.827117+00	2026-06-12 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	\N	INV-2026-0533	\N	\N	\N	2026-07-24 18:24:10.746869+00	2026-07-24 18:24:10.746871+00
e5cc6508-c5d3-4d25-862b-7a822e816206	ARINVOICE	INV-2026-0533		AR_COLLECTION	d32da9f2-4215-48f9-a1ec-71e967453305	RTX00010004	1200	\N	304200.00	\N	\N	\N	\N	2026-07-02 18:24:07.827117+00	2026-07-02 18:24:07.827117+00	2026-08-01 18:24:07.827117+00	2026-07-02 18:24:07.827117+00	INV-2026-0533	\N	\N	\N	2026-07-24 18:24:10.748204+00	2026-07-24 18:24:10.748205+00
866ec9c6-e8f8-46c7-be28-cf2f6a4ef7fb	ARINVOICE	INV-2026-0448		AR_BILLING	249e5252-b737-446a-be25-f5e910a7380d	MTX00020003	4010	\N	146200.00	\N	\N	\N	\N	2026-05-07 18:24:07.827117+00	2026-05-07 18:24:07.827117+00	2026-06-06 18:24:07.827117+00	\N	INV-2026-0448	\N	\N	\N	2026-07-24 18:24:10.754262+00	2026-07-24 18:24:10.754263+00
8f4ca06a-84b1-4144-8d6d-55a905eaad17	ARINVOICE	INV-2026-0448		AR_COLLECTION	249e5252-b737-446a-be25-f5e910a7380d	MTX00020003	1200	\N	146200.00	\N	\N	\N	\N	2026-05-27 18:24:07.827117+00	2026-05-27 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	2026-05-27 18:24:07.827117+00	INV-2026-0448	\N	\N	\N	2026-07-24 18:24:10.754748+00	2026-07-24 18:24:10.754749+00
d9e382fa-c8d1-4309-ad30-1d8acc8c8839	ARINVOICE	INV-2026-0462		AR_BILLING	3d320ab8-7e02-4557-ab26-c65abc774688	MTX00040002	4010	\N	84900.00	\N	\N	\N	\N	2026-05-23 18:24:07.827117+00	2026-05-23 18:24:07.827117+00	2026-06-22 18:24:07.827117+00	\N	INV-2026-0462	\N	\N	\N	2026-07-24 18:24:10.760567+00	2026-07-24 18:24:10.760567+00
19f12512-f297-41a7-8ba7-6c7328855c39	ARINVOICE	INV-2026-0462		AR_COLLECTION	3d320ab8-7e02-4557-ab26-c65abc774688	MTX00040002	1200	\N	84900.00	\N	\N	\N	\N	2026-06-12 18:24:07.827117+00	2026-06-12 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	2026-06-12 18:24:07.827117+00	INV-2026-0462	\N	\N	\N	2026-07-24 18:24:10.761064+00	2026-07-24 18:24:10.761064+00
626e0fe2-037a-4e9c-aa24-e1f1ffcf56ff	ARINVOICE	INV-2026-0479		AR_BILLING	906bdaec-dfde-4248-bae6-57191ccf3277	CTX00030003	4010	\N	273500.00	\N	\N	\N	\N	2026-05-30 18:24:07.827117+00	2026-05-30 18:24:07.827117+00	2026-06-29 18:24:07.827117+00	\N	INV-2026-0479	\N	\N	\N	2026-07-24 18:24:10.766165+00	2026-07-24 18:24:10.766166+00
d387d9ba-f6a8-414b-9067-35ed53e98e1f	ARINVOICE	INV-2026-0479		AR_COLLECTION	906bdaec-dfde-4248-bae6-57191ccf3277	CTX00030003	1200	\N	273500.00	\N	\N	\N	\N	2026-06-19 18:24:07.827117+00	2026-06-19 18:24:07.827117+00	2026-07-19 18:24:07.827117+00	2026-06-19 18:24:07.827117+00	INV-2026-0479	\N	\N	\N	2026-07-24 18:24:10.766688+00	2026-07-24 18:24:10.766689+00
fd694ad1-63db-49ef-856c-a30e47a41595	ARINVOICE	INV-2026-0561		AR_BILLING	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	MTX00050003	4010	\N	229700.00	\N	\N	\N	\N	2026-07-04 18:24:07.827117+00	2026-07-04 18:24:07.827117+00	2026-08-03 18:24:07.827117+00	\N	INV-2026-0561	\N	\N	\N	2026-07-24 18:24:10.771575+00	2026-07-24 18:24:10.771575+00
af9a10d2-f9f5-43e0-bba7-1ba373afb3c8	ARINVOICE	INV-2026-0561		AR_COLLECTION	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	MTX00050003	1200	\N	229700.00	\N	\N	\N	\N	2026-07-23 18:24:07.827117+00	2026-07-23 18:24:07.827117+00	2026-08-22 18:24:07.827117+00	2026-07-23 18:24:07.827117+00	INV-2026-0561	\N	\N	\N	2026-07-24 18:24:10.772081+00	2026-07-24 18:24:10.772082+00
51e24f1d-06be-4875-99fd-5fdda83163b3	ARINVOICE	INV-2026-0455		AR_BILLING	2cb81f29-032f-4247-8259-d7d4d3ffa28f	RTX00080003	4010	\N	122600.00	\N	\N	\N	\N	2026-05-27 18:24:07.827117+00	2026-05-27 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	\N	INV-2026-0455	\N	\N	\N	2026-07-24 18:24:10.777016+00	2026-07-24 18:24:10.777017+00
b25cb780-4189-40a9-808f-534420472461	ARINVOICE	INV-2026-0455		AR_COLLECTION	2cb81f29-032f-4247-8259-d7d4d3ffa28f	RTX00080003	1200	\N	122600.00	\N	\N	\N	\N	2026-06-16 18:24:07.827117+00	2026-06-16 18:24:07.827117+00	2026-07-16 18:24:07.827117+00	2026-06-16 18:24:07.827117+00	INV-2026-0455	\N	\N	\N	2026-07-24 18:24:10.777501+00	2026-07-24 18:24:10.777502+00
6e63080c-14d6-4eb4-b220-dcbbbf065676	ARINVOICE	INV-2026-0502		AR_BILLING	f2717f36-697a-430f-a485-bcafc9482a32	CTX00080002	4010	\N	216500.00	\N	\N	\N	\N	2026-06-09 18:24:07.827117+00	2026-06-09 18:24:07.827117+00	2026-07-09 18:24:07.827117+00	\N	INV-2026-0502	\N	\N	\N	2026-07-24 18:24:10.781847+00	2026-07-24 18:24:10.781847+00
75585d8a-b15c-4b61-8f80-d78fd4243639	ARINVOICE	INV-2026-0502		AR_COLLECTION	f2717f36-697a-430f-a485-bcafc9482a32	CTX00080002	1200	\N	129900.00	\N	\N	\N	\N	2026-06-29 18:24:07.827117+00	2026-06-29 18:24:07.827117+00	2026-07-29 18:24:07.827117+00	2026-06-29 18:24:07.827117+00	INV-2026-0502	\N	\N	\N	2026-07-24 18:24:10.782358+00	2026-07-24 18:24:10.782358+00
05e8294c-9629-4992-a665-1cfd932400bd	ARINVOICE	INV-2026-0549		AR_BILLING	774de069-49ca-4cd5-a20e-9bb97382cdd2	CTX00020002	4010	\N	90800.00	\N	\N	\N	\N	2026-06-26 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	2026-07-26 18:24:07.827117+00	\N	INV-2026-0549	\N	\N	\N	2026-07-24 18:24:10.786912+00	2026-07-24 18:24:10.786912+00
e6e2994e-97ed-4dd5-aa92-db951ed12922	ARINVOICE	INV-2026-0549		AR_COLLECTION	774de069-49ca-4cd5-a20e-9bb97382cdd2	CTX00020002	1200	\N	56296.00	\N	\N	\N	\N	2026-07-16 18:24:07.827117+00	2026-07-16 18:24:07.827117+00	2026-08-15 18:24:07.827117+00	2026-07-16 18:24:07.827117+00	INV-2026-0549	\N	\N	\N	2026-07-24 18:24:10.787401+00	2026-07-24 18:24:10.787402+00
da6d2bb2-5f85-47ae-b18d-669b8eca5255	ARINVOICE	INV-2026-0571		AR_BILLING	08ed21da-c5f3-40d0-b44c-15897cfdd3b1	BTX00140002	4010	\N	112600.00	\N	\N	\N	\N	2026-07-06 18:24:07.827117+00	2026-07-06 18:24:07.827117+00	2026-08-05 18:24:07.827117+00	\N	INV-2026-0571	\N	\N	\N	2026-07-24 18:24:10.79213+00	2026-07-24 18:24:10.79213+00
f4c1bbca-9823-4e9c-a811-1babcd5192c5	ARINVOICE	INV-2026-0571		AR_COLLECTION	08ed21da-c5f3-40d0-b44c-15897cfdd3b1	BTX00140002	1200	\N	45040.00	\N	\N	\N	\N	2026-07-23 18:24:07.827117+00	2026-07-23 18:24:07.827117+00	2026-08-22 18:24:07.827117+00	2026-07-23 18:24:07.827117+00	INV-2026-0571	\N	\N	\N	2026-07-24 18:24:10.79264+00	2026-07-24 18:24:10.792641+00
ccff7255-dee4-4576-a511-8318978dae53	ARINVOICE	INV-2026-0515		AR_BILLING	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	BTX00030002	4010	\N	178100.00	\N	\N	\N	\N	2026-06-02 18:24:07.827117+00	2026-06-02 18:24:07.827117+00	2026-07-02 18:24:07.827117+00	\N	INV-2026-0515	\N	\N	\N	2026-07-24 18:24:10.797314+00	2026-07-24 18:24:10.797315+00
8f1fb3f7-b5df-49a2-a6de-f003e49597c9	ARINVOICE	INV-2026-0538		AR_BILLING	71cf10e3-2ca6-4256-8e3c-6b10ee266997	RTX00050002	4010	\N	246300.00	\N	\N	\N	\N	2026-06-14 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	2026-07-14 18:24:07.827117+00	\N	INV-2026-0538	\N	\N	\N	2026-07-24 18:24:10.802216+00	2026-07-24 18:24:10.802216+00
807b66ea-4dd1-4b32-8881-9011271ca0b0	ARINVOICE	INV-2026-0526		AR_BILLING	d80d6bca-688a-4dad-9204-89366f709b4f	BTX00070002	4010	\N	173500.00	\N	\N	\N	\N	2026-06-10 18:24:07.827117+00	2026-06-10 18:24:07.827117+00	2026-07-10 18:24:07.827117+00	\N	INV-2026-0526	\N	\N	\N	2026-07-24 18:24:10.8071+00	2026-07-24 18:24:10.8071+00
5694ce07-afcd-400d-bba8-0a3d26f979ea	ARINVOICE	INV-2026-0578		AR_BILLING	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	MTX00130002	4010	\N	185400.00	\N	\N	\N	\N	2026-07-08 18:24:07.827117+00	2026-07-08 18:24:07.827117+00	2026-08-07 18:24:07.827117+00	\N	INV-2026-0578	\N	\N	\N	2026-07-24 18:24:10.811723+00	2026-07-24 18:24:10.811724+00
60be2e24-57f5-4ccd-b57d-d31cd0789864	ARINVOICE	INV-2026-0585		AR_BILLING	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	MTX00010002	4010	\N	55900.00	\N	\N	\N	\N	2026-07-15 18:24:07.827117+00	2026-07-15 18:24:07.827117+00	2026-08-14 18:24:07.827117+00	\N	INV-2026-0585	\N	\N	\N	2026-07-24 18:24:10.819487+00	2026-07-24 18:24:10.819487+00
0288f61d-9c4a-4de4-9191-7f8671af9c9f	ARINVOICE	INV-2026-0582		AR_BILLING	509e5e53-df5e-42c4-bd79-3ea5b49497d8	RAZ00060002	4010	\N	80600.00	\N	\N	\N	\N	2026-07-12 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	2026-08-11 18:24:07.827117+00	\N	INV-2026-0582	\N	\N	\N	2026-07-24 18:24:10.824019+00	2026-07-24 18:24:10.824019+00
\.


--
-- Data for Name: inbound_email_attachments; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.inbound_email_attachments (id, inbound_email_id, filename, content_type, size_bytes, created_at, updated_at) FROM stdin;
71988648-d5ff-4e92-be15-0352c9bc2025	01546d53-6ce4-4a43-af1d-67f99dc9018d	ARS-20447.pdf	application/pdf	48000	2026-07-24 18:24:11.812016+00	2026-07-24 18:24:11.812016+00
d53d1470-7540-4c49-abae-ce3f16562853	95371927-2e32-4667-b7b0-08ead709333f	LSR-88467.pdf	application/pdf	48000	2026-07-24 18:24:11.813789+00	2026-07-24 18:24:11.81379+00
8c020516-e924-4105-9cff-2f348b0442e7	f6c6008d-6ff9-45e3-9fca-1e976badd9ba	PD-33305.pdf	application/pdf	48000	2026-07-24 18:24:11.814728+00	2026-07-24 18:24:11.814728+00
58a595bb-0aef-492f-b12b-fd97d69859f2	a541886a-6fda-498d-b53c-1bd933cc8bbf	MDC-55201.pdf	application/pdf	48000	2026-07-24 18:24:11.815624+00	2026-07-24 18:24:11.815624+00
c70122c3-e0d7-47ea-9440-1b738813bf2c	78462b83-1e8b-420f-acbe-1511ba368523	DTL-9954.pdf	application/pdf	48000	2026-07-24 18:24:11.81644+00	2026-07-24 18:24:11.816441+00
\.


--
-- Data for Name: inbound_emails; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.inbound_emails (id, legacy_message_id, from_email, to_emails, subject, received_at, attachment_count, created_at, updated_at) FROM stdin;
01546d53-6ce4-4a43-af1d-67f99dc9018d	\N	ar@allianceroofingsupply.com	["ap@ciridae.com"]	Invoice ARS-20447 — Northgate ISD Admin Reroof	2026-07-20 15:24:07.827117+00	1	2026-07-24 18:24:11.811304+00	2026-07-24 18:24:11.811305+00
95371927-2e32-4667-b7b0-08ead709333f	\N	billing@lonestarequipment.com	["ap@ciridae.com"]	Invoice LSR-88467 — Pier 12 generator rental	2026-07-17 15:24:07.827117+00	1	2026-07-24 18:24:11.813554+00	2026-07-24 18:24:11.813554+00
f6c6008d-6ff9-45e3-9fca-1e976badd9ba	\N	accounts@prodryequipment.com	["ap@ciridae.com"]	Invoice PD-33305 — Northgate drying equipment	2026-07-23 15:24:07.827117+00	1	2026-07-24 18:24:11.814518+00	2026-07-24 18:24:11.814518+00
a541886a-6fda-498d-b53c-1bd933cc8bbf	\N	invoices@metroplexdumpster.com	["ap@ciridae.com"]	June roll-off service statement	2026-07-16 15:24:07.827117+00	1	2026-07-24 18:24:11.81541+00	2026-07-24 18:24:11.81541+00
78462b83-1e8b-420f-acbe-1511ba368523	\N	billing@deltatestinglabs.com	["ap@ciridae.com"]	Statement — quarterly IAQ program	2026-07-19 15:24:07.827117+00	1	2026-07-24 18:24:11.816243+00	2026-07-24 18:24:11.816243+00
872f489c-3529-48fb-a4f7-5333afe39849	\N	ar@apexscaffolding.com	["ap@ciridae.com"]	Past due reminder — APX-40766	2026-07-12 15:24:07.827117+00	0	2026-07-24 18:24:11.817086+00	2026-07-24 18:24:11.817087+00
\.


--
-- Data for Name: industries; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.industries (id, name, description, created_at, updated_at) FROM stdin;
d55463b7-5802-57c0-8530-2da78fef4990	Data Centers	Data centers	2026-07-24 18:24:07.966704+00	2026-07-24 18:24:07.966705+00
3a8b2964-f5d4-55b5-aa62-fe3c868d6159	Education	Schools, universities, student housing	2026-07-24 18:24:07.967683+00	2026-07-24 18:24:07.967684+00
ed316e45-e347-5e9f-bf05-0b7919591f85	Entertainment	Sports stadiums, arenas, music venues, movie theaters	2026-07-24 18:24:07.96826+00	2026-07-24 18:24:07.96826+00
5f797499-5a8a-5ea8-ad01-f90a267d6391	Governement	Court houses, police departments, public works	2026-07-24 18:24:07.968903+00	2026-07-24 18:24:07.968903+00
3fb93144-c45a-5506-817f-59adb03a773c	Healthcare	Hospitals, medical office buildings	2026-07-24 18:24:07.96984+00	2026-07-24 18:24:07.969841+00
e62505b4-efca-5343-ade2-be566e4b45e0	Hospitality	Hotels and resorts	2026-07-24 18:24:07.970514+00	2026-07-24 18:24:07.970516+00
f5f90f23-7ff1-5d29-99fd-06ea24271e9e	Industrial	Warehouse, distribution, manufacturing, logistics	2026-07-24 18:24:07.971302+00	2026-07-24 18:24:07.971303+00
922285ac-739c-58c4-893f-2b1977a0e100	Insurance	Carriers, brokers, adjusters, building consultants	2026-07-24 18:24:07.971948+00	2026-07-24 18:24:07.971948+00
4d9dc580-f1f5-5dcd-bd7d-7b655602293a	Multi Family	Apartments, condos, time shares	2026-07-24 18:24:07.972549+00	2026-07-24 18:24:07.972549+00
6d6d6a81-c1b1-51ad-a569-14345936fb79	Office	Commercial, flex	2026-07-24 18:24:07.973119+00	2026-07-24 18:24:07.97312+00
53f64999-2cb4-5800-941b-9b61bec0d45e	Religious Facility	Church buildings, synagogues, temples	2026-07-24 18:24:07.973697+00	2026-07-24 18:24:07.973698+00
fc0540e9-c120-5f10-873f-db42275e72be	Residential	Friend of Ciridae OS	2026-07-24 18:24:07.974255+00	2026-07-24 18:24:07.974256+00
8ab3d589-9408-5ded-bf10-33124fb76af3	Retail	Shopping, restaurants, grocery stores, big box	2026-07-24 18:24:07.974821+00	2026-07-24 18:24:07.974821+00
\.


--
-- Data for Name: legal_entities; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.legal_entities (id, legacy_accounting_id, name, legal_name, is_california, is_roofing, is_project_entity, is_active, billing_address_id, created_at, updated_at) FROM stdin;
ki-100-0000-0000-0000-000000000000	100	Corporate	Ciridae OS Services	\N	\N	f	t	ba-test-0000-0000-0000-000000000000	2026-07-24 18:24:04.487737+00	2026-07-24 18:24:07.933675+00
ki-105-0000-0000-0000-000000000000	105	Non-CA Non-Roofing	Ciridae OS Restoration, LLC	f	f	t	t	ba-test-0000-0000-0000-000000000000	2026-07-24 18:24:01.902934+00	2026-07-24 18:24:07.934396+00
ki-110-0000-0000-0000-000000000000	110	Non-CA Roofing	Ciridae OS Roofing, LLC	f	t	t	t	ba-test-0000-0000-0000-000000000000	2026-07-24 18:24:01.902934+00	2026-07-24 18:24:07.934812+00
ki-115-0000-0000-0000-000000000000	115	California Non-Roofing	Ciridae OS Services - California	t	f	t	t	ba-test-0000-0000-0000-000000000000	2026-07-24 18:24:01.902934+00	2026-07-24 18:24:07.93523+00
ki-120-0000-0000-0000-000000000000	120	California Roofing	Ciridae OS Roofing - California	t	t	t	t	ba-test-0000-0000-0000-000000000000	2026-07-24 18:24:01.902934+00	2026-07-24 18:24:07.935595+00
\.


--
-- Data for Name: opportunities; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.opportunities (id, legacy_opportunity_number, site_name, contact_id, site_contact_id, referral_contact_id, address_id, reporting_branch_id, operating_branch_id, catastrophe_event_id, status, project_type, miscellaneous_type, source, contact_date, contact_method, urgency, qualified_at, disqualified_at, disqualification_reason, incident_date, reported_date, loss_type, severity, incident_description, incident_cause, affected_areas, damage_description, special_requirements, estimated_value, square_footage_potential, likelihood_conversion, bid_required, won_date, lost_date, lost_reason, cancelled_date, cancelled_reason, notes, created_at, updated_at) FROM stdin;
c6aaacf2-4a0f-4857-8167-2fe2ac00dab0	MTX00100001	Bayou City Tower — Floors 12-14	a560e00c-9e03-4009-b3e3-e74b4d0f391b	\N	\N	5ec12e07-ee46-438c-876f-b3ea14d6cf50	8c3a37db-86aa-5ada-974f-407012c21d70	8c3a37db-86aa-5ada-974f-407012c21d70	\N	PROSPECT	MITIGATION	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-20 18:24:07.827117+00	2026-07-21 00:24:07.827117+00	WATER	MODERATE	\N	\N	\N	Domestic water riser failure saturated three office floors; tenant suites impacted.	\N	185000.00	12500	70	t	\N	\N	\N	\N	\N	\N	2026-07-20 18:24:07.827117+00	2026-07-24 18:24:08.730099+00
35db6eab-e764-4ee2-98ae-d781494517f3	BTX00070001	Heritage Grove — Commercial Kitchen	3a19c280-1c94-41f4-93c6-17bf8f5a53b3	\N	\N	10575e96-95bf-486c-ae4e-3a9d8a10f50d	8c3a37db-86aa-5ada-974f-407012c21d70	8c3a37db-86aa-5ada-974f-407012c21d70	\N	PROSPECT	BUILD_BACK	\N	\N	\N	\N	\N	\N	\N	\N	2026-07-15 18:24:07.827117+00	2026-07-16 00:24:07.827117+00	FIRE	MINOR	\N	\N	\N	Grease fire above the service line; hood system and adjacent drywall require replacement.	\N	78500.00	12500	55	t	\N	\N	\N	\N	\N	\N	2026-07-16 18:24:07.827117+00	2026-07-24 18:24:08.764039+00
a52c9644-5971-4955-9b59-df66f25c8f2d	RAZ00060001	Pinnacle Storage — Mesa Facility Roof	cc17cfa3-fe7e-4625-9440-ea5ce76b0fc4	\N	\N	e7c25fc3-14d7-4015-a3fd-495947de0091	a2f068c0-97cc-537d-a395-a3d84500d912	a2f068c0-97cc-537d-a395-a3d84500d912	\N	PROSPECT	ROOFING	\N	\N	\N	\N	\N	\N	\N	\N	2026-06-14 18:24:07.827117+00	2026-06-15 00:24:07.827117+00	WIND	MINOR	\N	\N	\N	Monsoon microburst lifted TPO membrane sections on two storage buildings.	\N	96000.00	12500	40	t	\N	\N	\N	\N	\N	\N	2026-06-16 18:24:07.827117+00	2026-06-30 18:24:07.827117+00
b182f06c-cde2-4278-bc04-4b11daac1a29	RTX00160001	First Methodist Plano — Sanctuary Roof	6c434fa2-99a4-4658-8d16-4dc096ff2544	\N	\N	63d0b371-b67d-40e0-a8ed-8d8bf2411383	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	514ccb9b-7f79-4117-93ae-94115882edb2	PROSPECT	ROOFING	\N	\N	\N	\N	\N	\N	\N	\N	2026-04-18 18:24:07.827117+00	2026-04-19 00:24:07.827117+00	NAMED_CAT	MODERATE	\N	\N	\N	Hail-bruised shingle and standing-seam sections across the sanctuary and education wing.	\N	415000.00	12500	50	t	\N	\N	\N	\N	\N	\N	2026-04-25 18:24:07.827117+00	2026-07-05 18:24:07.827117+00
248c64f8-fefc-4bb0-94b9-71064fa7a1ae	RTX00080001	Redbird — Building C Roof Replacement	cc0e932c-43fe-4ec6-b3e1-df298af9a5c1	\N	\N	508f3772-d59f-4039-a516-893110ff4a46	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	514ccb9b-7f79-4117-93ae-94115882edb2	PROPOSAL	ROOFING	\N	\N	\N	\N	\N	2026-05-07 18:24:07.827117+00	\N	\N	2026-04-18 18:24:07.827117+00	2026-04-19 00:24:07.827117+00	NAMED_CAT	MAJOR	\N	\N	\N	Full tear-off and 60-mil TPO replacement on 210,000 sq ft distribution roof after hail damage.	\N	780000.00	12500	85	t	\N	\N	\N	\N	\N	\N	2026-05-05 18:24:07.827117+00	2026-07-24 18:24:09.161281+00
f7838ae5-0ee0-444b-8898-8e4ffe6b5549	BCO00110001	Summit Ridge — Building 4 Fire Build-Back	3907f666-373b-4ef8-9c89-e4934b06463e	\N	\N	07ddc0d7-0347-4ae4-a9e7-7caffad7fe32	85add3ff-056b-59b7-b3a0-a10a4fe339cb	85add3ff-056b-59b7-b3a0-a10a4fe339cb	\N	PROPOSAL	BUILD_BACK	\N	\N	\N	\N	\N	2026-06-06 18:24:07.827117+00	\N	\N	2026-05-25 18:24:07.827117+00	2026-05-26 00:24:07.827117+00	FIRE	MAJOR	\N	\N	\N	Reconstruction of twelve units and shared corridor after an electrical fire in Building 4.	\N	540000.00	12500	60	t	\N	\N	\N	\N	\N	\N	2026-06-04 18:24:07.827117+00	2026-07-24 18:24:09.178124+00
fac6f5a9-9168-4977-bf3c-44d7b41bc7f7	CTX00140001	Alamo Heights — Lobby Refresh	6a5475e2-8a5f-442d-a154-9b12a51b82eb	\N	\N	f9d38b53-7a66-4837-8b40-e9df2a697d30	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	\N	LOST	CONSTRUCTION	\N	\N	\N	\N	\N	2026-05-17 18:24:07.827117+00	\N	\N	\N	\N	CAPEX	\N	\N	\N	\N	Lobby and porte-cochere refresh ahead of brand inspection.	\N	310000.00	12500	45	t	\N	2026-06-29 18:24:07.827117+00	Owner selected incumbent GC on price	\N	\N	\N	2026-05-15 18:24:07.827117+00	2026-07-24 18:24:09.19656+00
8f0b3181-97c0-429c-97ad-03282eae6a07	CTX00090001	Lonestar Retail — Suite 240 White Box	531e85e7-06e4-4a7a-ac5d-5ce5d55a0ef9	\N	\N	44b4fb75-da35-4e2f-b8e9-f004552b6942	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	\N	LOST	CONSTRUCTION	\N	\N	\N	\N	\N	2026-06-11 18:24:07.827117+00	\N	\N	\N	\N	CAPEX	\N	\N	\N	\N	White-box conversion of former anchor suite for a national tenant.	\N	125000.00	12500	35	t	\N	2026-07-12 18:24:07.827117+00	Project shelved pending anchor lease	\N	\N	\N	2026-06-09 18:24:07.827117+00	2026-07-24 18:24:09.097228+00
9bc53410-e648-43ff-b935-20a686b3e0cc	MTX00050001	Northgate ISD — Westfield Gymnasium	8f139cf8-0b17-4254-95de-efad830a72ad	\N	\N	af5a0069-696c-4247-bebc-b4aa2fba90b7	8c3a37db-86aa-5ada-974f-407012c21d70	8c3a37db-86aa-5ada-974f-407012c21d70	80ce3408-5dc3-475f-b239-0ab3b2085718	ESTIMATE	MITIGATION	\N	\N	\N	\N	\N	2026-06-26 18:24:07.827117+00	\N	\N	2026-06-19 18:24:07.827117+00	2026-06-20 00:24:07.827117+00	NAMED_CAT	MAJOR	\N	\N	\N	Roof drain failure during June flooding; gym floor cupped and wall assemblies saturated.	\N	320000.00	12500	80	t	\N	\N	\N	\N	\N	\N	2026-06-24 18:24:07.827117+00	2026-07-24 18:24:09.109433+00
47de910d-8951-4f56-9741-939410de0d19	CAZ00120001	Cactus Flats — Dock 7 Impact Damage	1fafe57a-8995-4352-83a1-11040555305b	\N	\N	50577a8c-aaf3-43f5-bce1-c0b8d514acdd	a2f068c0-97cc-537d-a395-a3d84500d912	a2f068c0-97cc-537d-a395-a3d84500d912	\N	ESTIMATE	CONSTRUCTION	\N	\N	\N	\N	\N	2026-07-12 18:24:07.827117+00	\N	\N	2026-07-06 18:24:07.827117+00	2026-07-07 00:24:07.827117+00	CAPEX	MODERATE	\N	\N	\N	Semi-trailer strike damaged dock doors 7-9, canopy steel, and adjacent tilt-wall panel.	\N	152000.00	12500	65	t	\N	\N	\N	\N	\N	\N	2026-07-10 18:24:07.827117+00	2026-07-24 18:24:09.124078+00
592c30c3-3b33-4956-95c0-e0ae286b5b3d	XTX00150001	Prairie Wind Foods — Cold Storage Annex	3f57307f-01c0-4c82-b420-c99853296a30	\N	\N	aa3c9138-8afd-44be-8504-959f59bccd1e	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	ESTIMATE	MISCELLANEOUS	TEMPORARY_FACILITY_SERVICES	\N	\N	\N	\N	2026-07-16 18:24:07.827117+00	\N	\N	2026-07-12 18:24:07.827117+00	2026-07-13 00:24:07.827117+00	BIOHAZARD	MAJOR	\N	\N	\N	Ammonia release in the cold storage annex; decontamination and insulation replacement required.	\N	264000.00	12500	70	t	\N	\N	\N	\N	\N	\N	2026-07-14 18:24:07.827117+00	2026-07-24 18:24:09.131896+00
4b4ad37b-3798-4089-8e9a-a8d910f2cc2b	CTX00030001	TexStar — Guest Tower Renovation	0b74a58e-4abb-4c85-8a1d-ae6f4516aaf4	\N	\N	2a12bf11-ba9a-4765-8ef9-2263e249a7a9	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	\N	PROPOSAL	CONSTRUCTION	\N	\N	\N	\N	\N	2026-06-01 18:24:07.827117+00	\N	\N	\N	\N	CAPEX	\N	\N	\N	\N	Phased renovation of 180 guest rooms across eight floors, including corridor finishes.	\N	1150000.00	12500	75	t	\N	\N	\N	\N	\N	\N	2026-05-30 18:24:07.827117+00	2026-07-24 18:24:09.147174+00
55077d1f-d983-4252-b79a-64084ea21b97	CTX00010001	Brookline — Katy Trail Lofts Garage	c7f692b6-73e6-4280-aa3b-777909ee8dcd	\N	\N	13f4b072-7d7c-4c7e-819e-4d547d15eb65	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	WON	CONSTRUCTION	\N	\N	\N	\N	\N	2026-06-16 18:24:07.827117+00	\N	\N	\N	\N	CAPEX	\N	\N	\N	\N	Parking garage post-tension repairs and deck coating, levels P1-P2.	\N	240000.00	12500	60	t	2026-07-23 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-06-14 18:24:07.827117+00	2026-07-24 18:24:09.283697+00
b4e2d5c8-e9f6-484a-89ba-8bba4705c4e1	BTX00040001	Caprock — Walnut Hill MOB Suite 300	175b4c6b-13b9-4ecb-a7e3-6d0fb451ae4d	\N	\N	e07ff3db-f6ed-4641-b985-7f61ae8226e6	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	WON	BUILD_BACK	\N	\N	\N	\N	\N	2026-06-30 18:24:07.827117+00	\N	\N	2026-06-24 18:24:07.827117+00	2026-06-25 00:24:07.827117+00	WATER	MODERATE	\N	\N	\N	Sprinkler line freeze break above imaging suite; finish-out restoration.	\N	165000.00	12500	60	t	2026-07-23 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-06-28 18:24:07.827117+00	2026-07-24 18:24:09.482702+00
b0b134ff-548e-4de7-950f-5ae1af431706	CTX00130001	Gulf Coast — Terminal 2 Warehouse Doors	72db787e-b8e4-440f-b26e-8b08d680f5c7	\N	\N	a1e40a72-215e-4538-8f29-1001e0a43f4a	8c3a37db-86aa-5ada-974f-407012c21d70	8c3a37db-86aa-5ada-974f-407012c21d70	\N	WON	CONSTRUCTION	\N	\N	\N	\N	\N	2026-06-21 18:24:07.827117+00	\N	\N	2026-06-12 18:24:07.827117+00	2026-06-13 00:24:07.827117+00	WIND	MINOR	\N	\N	\N	Replacement of six storm-damaged rolling steel doors at Terminal 2.	\N	98000.00	12500	60	t	2026-07-23 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-06-19 18:24:07.827117+00	2026-07-24 18:24:09.537382+00
f3409f77-6734-49c8-929f-60954fbc9034	XTX00020001	Silverline — Hargrove Fire Lane Repaving	773a30df-0dec-4469-8b3c-e6c0ac31a9e7	\N	\N	878e1693-f2c3-489d-97ad-a7c3d4d9035a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	WON	MISCELLANEOUS	TEMPORARY_FACILITY_SERVICES	\N	\N	\N	\N	2026-07-05 18:24:07.827117+00	\N	\N	\N	\N	CAPEX	\N	\N	\N	\N	Fire-lane concrete replacement flagged by the city fire marshal.	\N	54000.00	12500	60	t	2026-07-23 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-07-03 18:24:07.827117+00	2026-07-24 18:24:09.589833+00
51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	MTX00010002	Brookline — Deep Ellum Warehouse Drying	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	\N	\N	afd674c0-cdf0-40bf-9f38-b17b9ee7c215	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	WON	MITIGATION	\N	\N	\N	\N	\N	2026-07-14 18:24:07.827117+00	\N	\N	2026-07-11 18:24:07.827117+00	2026-07-12 00:24:07.827117+00	WATER	MAJOR	\N	\N	\N	Roof drain backup during July thunderstorms saturated 30,000 sq ft of warehouse.	\N	142000.00	12500	60	t	2026-07-13 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-07-12 18:24:07.827117+00	2026-07-24 18:24:09.639642+00
f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	MTX00100002	Bayou City — Floor 14 Moisture Remediation	a560e00c-9e03-4009-b3e3-e74b4d0f391b	\N	\N	5ec12e07-ee46-438c-876f-b3ea14d6cf50	8c3a37db-86aa-5ada-974f-407012c21d70	8c3a37db-86aa-5ada-974f-407012c21d70	\N	WON	MITIGATION	\N	\N	\N	\N	\N	2026-07-18 18:24:07.827117+00	\N	\N	2026-07-15 18:24:07.827117+00	2026-07-16 00:24:07.827117+00	WATER	MODERATE	\N	\N	\N	HVAC condensate line failure above executive floor; targeted demolition and drying.	\N	88000.00	12500	60	t	2026-07-17 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-07-16 18:24:07.827117+00	2026-07-24 18:24:09.683715+00
509e5e53-df5e-42c4-bd79-3ea5b49497d8	RAZ00060002	Pinnacle — Tempe Facility Hail Repairs	cc17cfa3-fe7e-4625-9440-ea5ce76b0fc4	\N	\N	d8525ce4-4c80-474f-a949-437cddae0813	a2f068c0-97cc-537d-a395-a3d84500d912	a2f068c0-97cc-537d-a395-a3d84500d912	\N	WON	ROOFING	\N	\N	\N	\N	\N	2026-06-11 18:24:07.827117+00	\N	\N	2026-06-04 18:24:07.827117+00	2026-06-05 00:24:07.827117+00	WIND	MODERATE	\N	\N	\N	Hail-damaged metal roof panel and skylight replacement across four buildings.	\N	204000.00	12500	60	t	2026-07-06 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-06-09 18:24:07.827117+00	2026-07-24 18:24:09.73111+00
ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	BTX00030002	TexStar — Ballroom Water Intrusion	0b74a58e-4abb-4c85-8a1d-ae6f4516aaf4	\N	\N	2a12bf11-ba9a-4765-8ef9-2263e249a7a9	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	\N	WON	BUILD_BACK	\N	\N	\N	\N	\N	2026-05-17 18:24:07.827117+00	\N	\N	2026-05-10 18:24:07.827117+00	2026-05-11 00:24:07.827117+00	WATER	MAJOR	\N	\N	\N	Curtain-wall leak damaged ballroom finishes; millwork and acoustic ceiling replacement.	\N	315000.00	12500	60	t	2026-06-12 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-05-15 18:24:07.827117+00	2026-07-24 18:24:09.773049+00
71cf10e3-2ca6-4256-8e3c-6b10ee266997	RTX00050002	Northgate ISD — Admin Building Reroof	8f139cf8-0b17-4254-95de-efad830a72ad	\N	\N	af5a0069-696c-4247-bebc-b4aa2fba90b7	8c3a37db-86aa-5ada-974f-407012c21d70	8c3a37db-86aa-5ada-974f-407012c21d70	\N	WON	ROOFING	\N	\N	\N	\N	\N	2026-04-22 18:24:07.827117+00	\N	\N	\N	\N	CAPEX	\N	\N	\N	\N	Modified bitumen reroof of the district administration building over summer break.	\N	452000.00	12500	60	t	2026-06-21 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-04-20 18:24:07.827117+00	2026-07-24 18:24:09.816026+00
f2717f36-697a-430f-a485-bcafc9482a32	CTX00080002	Redbird — Building A Dock Rebuild	cc0e932c-43fe-4ec6-b3e1-df298af9a5c1	\N	\N	508f3772-d59f-4039-a516-893110ff4a46	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	WON	CONSTRUCTION	\N	\N	\N	\N	\N	2026-03-28 18:24:07.827117+00	\N	\N	2026-03-16 18:24:07.827117+00	2026-03-17 00:24:07.827117+00	FIRE	MAJOR	\N	\N	\N	Structural rebuild of fire-damaged shipping dock, offices, and sprinkler main.	\N	623000.00	12500	60	t	2026-04-27 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-03-26 18:24:07.827117+00	2026-07-24 18:24:09.860413+00
d80d6bca-688a-4dad-9204-89366f709b4f	BTX00070002	Heritage Grove — Memory Care Wing	3a19c280-1c94-41f4-93c6-17bf8f5a53b3	\N	\N	10575e96-95bf-486c-ae4e-3a9d8a10f50d	8c3a37db-86aa-5ada-974f-407012c21d70	8c3a37db-86aa-5ada-974f-407012c21d70	\N	WON	BUILD_BACK	\N	\N	\N	\N	\N	2026-04-29 18:24:07.827117+00	\N	\N	2026-04-20 18:24:07.827117+00	2026-04-21 00:24:07.827117+00	FIRE	MAJOR	\N	\N	\N	Kitchen fire smoke damage across the memory-care wing; finishes and HVAC duct cleaning.	\N	389000.00	12500	60	t	2026-05-30 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-04-27 18:24:07.827117+00	2026-07-24 18:24:09.904328+00
3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	MTX00130002	Gulf Coast — Pier 12 Flood Mitigation	72db787e-b8e4-440f-b26e-8b08d680f5c7	\N	\N	a1e40a72-215e-4538-8f29-1001e0a43f4a	8c3a37db-86aa-5ada-974f-407012c21d70	8c3a37db-86aa-5ada-974f-407012c21d70	80ce3408-5dc3-475f-b239-0ab3b2085718	WON	MITIGATION	\N	\N	\N	\N	\N	2026-06-22 18:24:07.827117+00	\N	\N	2026-06-19 18:24:07.827117+00	2026-06-20 00:24:07.827117+00	NAMED_CAT	CATASTROPHIC	\N	\N	\N	June flood event inundated pier-side offices; extraction, drying, and controlled demolition.	\N	267000.00	12500	60	t	2026-06-22 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-06-20 18:24:07.827117+00	2026-07-24 18:24:09.947527+00
36fd7907-a7d3-4f4b-a838-0810a2a81669	CTX00150002	Prairie Wind — Packaging Line 2 Rebuild	3f57307f-01c0-4c82-b420-c99853296a30	\N	\N	aa3c9138-8afd-44be-8504-959f59bccd1e	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	WON	CONSTRUCTION	\N	\N	\N	\N	\N	2026-06-06 18:24:07.827117+00	\N	\N	2026-05-30 18:24:07.827117+00	2026-05-31 00:24:07.827117+00	WATER	MODERATE	\N	\N	\N	Roof leak damaged packaging line electrical room; structural deck and switchgear room rebuild.	\N	176000.00	12500	60	t	2026-07-16 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-06-04 18:24:07.827117+00	2026-07-24 18:24:09.99322+00
328b7c55-274d-421b-aee2-163df067ffd1	XAZ00120002	Cactus Flats — Yard Lighting Retrofit	1fafe57a-8995-4352-83a1-11040555305b	\N	\N	50577a8c-aaf3-43f5-bce1-c0b8d514acdd	a2f068c0-97cc-537d-a395-a3d84500d912	a2f068c0-97cc-537d-a395-a3d84500d912	\N	WON	MISCELLANEOUS	TEMPORARY_FACILITY_SERVICES	\N	\N	\N	\N	2026-06-26 18:24:07.827117+00	\N	\N	\N	\N	CAPEX	\N	\N	\N	\N	LED retrofit of trailer-yard lighting with new poles at the truck court.	\N	64000.00	12500	60	t	2026-07-20 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-06-24 18:24:07.827117+00	2026-07-24 18:24:10.045747+00
9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	BTX00010003	Brookline — Uptown Tower Suite 900	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	\N	\N	169490aa-bcdc-43aa-bb6c-f3ac80a4365b	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	WON	BUILD_BACK	\N	\N	\N	\N	\N	2026-05-07 18:24:07.827117+00	\N	\N	2026-04-30 18:24:07.827117+00	2026-05-01 00:24:07.827117+00	WATER	MODERATE	\N	\N	\N	Tenant suite restoration after supply-line leak; flooring, drywall, and paint.	\N	118000.00	12500	60	t	2026-05-25 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-05-05 18:24:07.827117+00	2026-07-24 18:24:10.098042+00
774de069-49ca-4cd5-a20e-9bb97382cdd2	CTX00020002	Silverline — Sprinkler Riser Replacement	773a30df-0dec-4469-8b3c-e6c0ac31a9e7	\N	\N	878e1693-f2c3-489d-97ad-a7c3d4d9035a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	WON	CONSTRUCTION	\N	\N	\N	\N	\N	2026-05-12 18:24:07.827117+00	\N	\N	\N	\N	CAPEX	\N	\N	\N	\N	Replacement of corroded sprinkler riser and impaired zone piping.	\N	92000.00	12500	60	t	2026-06-04 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-05-10 18:24:07.827117+00	2026-07-24 18:24:10.144604+00
4539b766-a4f6-4871-a6dc-0b1820f0f627	XTX00090002	Lonestar Retail — Storm Drain Repairs	531e85e7-06e4-4a7a-ac5d-5ce5d55a0ef9	\N	\N	44b4fb75-da35-4e2f-b8e9-f004552b6942	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	\N	WON	MISCELLANEOUS	TEMPORARY_FACILITY_SERVICES	\N	\N	\N	\N	2026-05-22 18:24:07.827117+00	\N	\N	\N	\N	CAPEX	\N	\N	\N	\N	Collapsed storm drain line under the north parking field; excavation and replacement.	\N	58000.00	12500	60	t	2026-06-14 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-05-20 18:24:07.827117+00	2026-07-24 18:24:10.186631+00
08ed21da-c5f3-40d0-b44c-15897cfdd3b1	BTX00140002	Alamo Heights — Guest Floor 6 Turn	6a5475e2-8a5f-442d-a154-9b12a51b82eb	\N	\N	f9d38b53-7a66-4837-8b40-e9df2a697d30	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	\N	WON	BUILD_BACK	\N	\N	\N	\N	\N	2026-05-21 18:24:07.827117+00	\N	\N	2026-05-15 18:24:07.827117+00	2026-05-16 00:24:07.827117+00	WATER	MODERATE	\N	\N	\N	Water heater failure damaged eight guest rooms on floor 6; full finish restoration.	\N	134000.00	12500	60	t	2026-06-09 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-05-19 18:24:07.827117+00	2026-07-24 18:24:10.228504+00
d32da9f2-4215-48f9-a1ec-71e967453305	RTX00010004	Brookline — Preston Center Hail Reroof	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	\N	\N	43f64236-da3c-4b76-a256-dcd16def11ab	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	514ccb9b-7f79-4117-93ae-94115882edb2	WON	ROOFING	\N	\N	\N	\N	\N	2026-04-25 18:24:07.827117+00	\N	\N	2026-04-18 18:24:07.827117+00	2026-04-19 00:24:07.827117+00	NAMED_CAT	MAJOR	\N	\N	\N	Full TPO reroof of two office buildings after the April hail event.	\N	612000.00	12500	60	t	2026-05-05 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-04-23 18:24:07.827117+00	2026-07-24 18:24:10.272686+00
249e5252-b737-446a-be25-f5e910a7380d	MTX00020003	Silverline — Dock 12 Fire Mitigation	773a30df-0dec-4469-8b3c-e6c0ac31a9e7	\N	\N	878e1693-f2c3-489d-97ad-a7c3d4d9035a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	WON	MITIGATION	\N	\N	\N	\N	\N	2026-04-05 18:24:07.827117+00	\N	\N	2026-03-31 18:24:07.827117+00	2026-04-01 00:24:07.827117+00	FIRE	MAJOR	\N	\N	\N	Forklift charging station fire; smoke remediation across 60,000 sq ft.	\N	148000.00	12500	60	t	2026-04-05 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-04-03 18:24:07.827117+00	2026-07-24 18:24:10.317193+00
3d320ab8-7e02-4557-ab26-c65abc774688	MTX00040002	Caprock — Imaging Suite Mold Remediation	175b4c6b-13b9-4ecb-a7e3-6d0fb451ae4d	\N	\N	e07ff3db-f6ed-4641-b985-7f61ae8226e6	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	\N	WON	MITIGATION	\N	\N	\N	\N	\N	2026-04-22 18:24:07.827117+00	\N	\N	2026-04-15 18:24:07.827117+00	2026-04-16 00:24:07.827117+00	MOLD	MODERATE	\N	\N	\N	Concealed condensation drove mold growth behind imaging suite walls; containment remediation.	\N	86000.00	12500	60	t	2026-04-27 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-04-20 18:24:07.827117+00	2026-07-24 18:24:10.359103+00
906bdaec-dfde-4248-bae6-57191ccf3277	CTX00030003	TexStar — Conference Center Storm Repairs	158fe954-6327-472f-980e-f3aa622d3bef	\N	\N	2a12bf11-ba9a-4765-8ef9-2263e249a7a9	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	ef7cc824-e1b0-5e08-b4b3-21fa65ca4c32	\N	WON	CONSTRUCTION	\N	\N	\N	\N	\N	2026-04-02 18:24:07.827117+00	\N	\N	2026-03-26 18:24:07.827117+00	2026-03-27 00:24:07.827117+00	WIND	MAJOR	\N	\N	\N	Wind-driven rain damaged conference center roof monitors and interior finishes.	\N	276000.00	12500	60	t	2026-04-10 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-03-31 18:24:07.827117+00	2026-07-24 18:24:10.406128+00
eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	MTX00050003	Northgate ISD — Elementary Flood Response	8f139cf8-0b17-4254-95de-efad830a72ad	\N	\N	af5a0069-696c-4247-bebc-b4aa2fba90b7	8c3a37db-86aa-5ada-974f-407012c21d70	8c3a37db-86aa-5ada-974f-407012c21d70	80ce3408-5dc3-475f-b239-0ab3b2085718	WON	MITIGATION	\N	\N	\N	\N	\N	2026-06-22 18:24:07.827117+00	\N	\N	2026-06-19 18:24:07.827117+00	2026-06-20 00:24:07.827117+00	NAMED_CAT	MAJOR	\N	\N	\N	Emergency extraction and drying at two elementary campuses after June flooding.	\N	232000.00	12500	60	t	2026-06-21 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-06-20 18:24:07.827117+00	2026-07-24 18:24:10.447407+00
2cb81f29-032f-4247-8259-d7d4d3ffa28f	RTX00080003	Redbird — Building B Skylight Package	cc0e932c-43fe-4ec6-b3e1-df298af9a5c1	\N	\N	508f3772-d59f-4039-a516-893110ff4a46	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	77c36dd1-ea64-5ece-9c72-c30fa9f1448a	514ccb9b-7f79-4117-93ae-94115882edb2	WON	ROOFING	\N	\N	\N	\N	\N	2026-04-27 18:24:07.827117+00	\N	\N	2026-04-18 18:24:07.827117+00	2026-04-19 00:24:07.827117+00	NAMED_CAT	MODERATE	\N	\N	\N	Hail-shattered skylight replacement and curb flashing repairs, Building B.	\N	124000.00	12500	60	t	2026-05-10 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-04-25 18:24:07.827117+00	2026-07-24 18:24:10.489468+00
74c20bea-1f9c-404f-b056-23ee26f01017	CCO00110002	Summit Ridge — Clubhouse Remodel	3907f666-373b-4ef8-9c89-e4934b06463e	\N	\N	07ddc0d7-0347-4ae4-a9e7-7caffad7fe32	85add3ff-056b-59b7-b3a0-a10a4fe339cb	85add3ff-056b-59b7-b3a0-a10a4fe339cb	\N	WON	CONSTRUCTION	\N	\N	\N	\N	\N	2026-04-17 18:24:07.827117+00	\N	\N	\N	\N	CAPEX	\N	\N	\N	\N	Clubhouse and leasing office remodel.	\N	145000.00	12500	60	t	2026-05-15 18:24:07.827117+00	\N	\N	\N	\N	\N	2026-04-15 18:24:07.827117+00	2026-07-24 18:24:10.533795+00
\.


--
-- Data for Name: opportunity_documents; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.opportunity_documents (id, opportunity_id, document_id, notes, created_at, updated_at) FROM stdin;
627ac841-1c26-46f6-af74-6bc2ca02662f	592c30c3-3b33-4956-95c0-e0ae286b5b3d	d2fb4af9-47d0-50cd-a4dd-4e83b77a9ab1	Estimate package	2026-07-24 18:24:09.140854+00	2026-07-24 18:24:09.140855+00
c8183d7c-c271-45c2-896a-905ab1a28f36	4b4ad37b-3798-4089-8e9a-a8d910f2cc2b	0269806d-0e59-562b-b7fd-929ee986a559	Estimate package	2026-07-24 18:24:09.153948+00	2026-07-24 18:24:09.153949+00
d079e388-e318-44d1-8c37-967fd7cc8356	248c64f8-fefc-4bb0-94b9-71064fa7a1ae	9841e8b3-b1e5-5fac-9c5c-0ccb96ac4b6c	Estimate package	2026-07-24 18:24:09.170894+00	2026-07-24 18:24:09.170896+00
\.


--
-- Data for Name: project_documents; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.project_documents (id, project_id, document_id, created_at, updated_at) FROM stdin;
80373f0d-b569-4ee2-8f6f-88b91985f1ae	d32da9f2-4215-48f9-a1ec-71e967453305	5383dea6-a166-5206-bc24-d507d41e98df	2026-07-24 18:24:10.639424+00	2026-07-24 18:24:10.639425+00
60f9fea4-9dde-4918-83f9-da2d4dbc49c7	f2717f36-697a-430f-a485-bcafc9482a32	9ed458a4-64ba-5d74-995f-9c93155bb581	2026-07-24 18:24:10.640609+00	2026-07-24 18:24:10.64061+00
7c57b2cf-5ea0-49d2-aa17-52497acea304	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	295699aa-c41d-56c8-9831-34098c2fd232	2026-07-24 18:24:10.641267+00	2026-07-24 18:24:10.641268+00
8ae08f0b-aaed-4d4d-9157-2879db9e5fe0	71cf10e3-2ca6-4256-8e3c-6b10ee266997	37472eaa-689b-5e62-82ea-e5b043ecb104	2026-07-24 18:24:10.641914+00	2026-07-24 18:24:10.641914+00
fc9f893d-fac7-4fa9-9564-b03b0a793454	d80d6bca-688a-4dad-9204-89366f709b4f	9f8c1c25-200c-5da1-adcd-4f6aec2cc60e	2026-07-24 18:24:10.642527+00	2026-07-24 18:24:10.642528+00
989e2d58-fd6b-43e1-a131-9d320fb44399	774de069-49ca-4cd5-a20e-9bb97382cdd2	13a7e0f6-c26a-50f1-a775-e77d5c58f6a0	2026-07-24 18:24:10.643382+00	2026-07-24 18:24:10.643382+00
891bbe73-76ea-4a08-b09f-63528a2861c3	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	4b51e8b3-1f81-5951-b493-5f2844ac0597	2026-07-24 18:24:10.645375+00	2026-07-24 18:24:10.645375+00
fcc837e4-c029-43ed-ad4f-70e591bab9d8	f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	b5169264-19f0-571d-8268-0a5f5c0433b1	2026-07-24 18:24:10.646354+00	2026-07-24 18:24:10.646355+00
9de89712-dd3a-4ba2-9c83-86264afc75e3	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	32115c1b-685c-514b-965a-587ccaac49c6	2026-07-24 18:24:10.647243+00	2026-07-24 18:24:10.647244+00
2f96e50f-5dc1-4996-a24d-148afcb50f04	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	a8148008-08b4-5a14-992d-27c81004ea6a	2026-07-24 18:24:10.648129+00	2026-07-24 18:24:10.648129+00
\.


--
-- Data for Name: project_notes; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.project_notes (id, project_id, content, created_by_email, created_at, updated_at) FROM stdin;
dd0ab6da-500c-4ef0-a1ef-f73953aa95ac	f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	Moisture readings trending down on the north wall. One more week of drying, then we can schedule the rebuild estimate with the tenant.	priya.raman@ciridae.com	2026-07-24 18:24:12.072296+00	2026-07-24 18:24:12.072297+00
1966a234-fe73-4c9c-aedf-ec6b21fe3886	f2717f36-697a-430f-a485-bcafc9482a32	Dock leveler steel delivered and staged. Crane mobilization booked for Monday; customer asked for weekly photo updates going forward.	jenna.okafor@ciridae.com	2026-07-24 18:24:12.069467+00	2026-07-24 18:24:12.069467+00
3720345d-62cd-4593-9258-a081dc7b2075	d80d6bca-688a-4dad-9204-89366f709b4f	Kitchen hood rough-in passed inspection. Waiting on the health department walkthrough before closing out the fire-repair scope.	tasha.green@ciridae.com	2026-07-24 18:24:12.071235+00	2026-07-24 18:24:12.071235+00
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.projects (id, opportunity_id, project_number, site_name, contact_id, legal_entity_id, project_type, status, contract_value, default_profit_margin, first_day_on_site, estimated_completion_date, actual_completion_date, completed_at, closed_at, original_closed_at, cancelled_date, cancelled_reason, cancelled_from_status, roof_access, roof_access_notes, special_requirements, requires_authorization_for_invoicing, wip_start_contract_value, notes, cancelled_by_email, completed_by_email, closed_by_email, created_at, updated_at) FROM stdin;
55077d1f-d983-4252-b79a-64084ea21b97	55077d1f-d983-4252-b79a-64084ea21b97	CTX00010001	\N	c7f692b6-73e6-4280-aa3b-777909ee8dcd	ki-105-0000-0000-0000-000000000000	CONSTRUCTION	WORK_NOT_STARTED	238500.00	28.00	2026-08-05 18:24:07.827117+00	2026-10-19 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-07-23 18:24:07.827117+00	2026-07-24 18:24:09.420279+00
b4e2d5c8-e9f6-484a-89ba-8bba4705c4e1	b4e2d5c8-e9f6-484a-89ba-8bba4705c4e1	BTX00040001	\N	175b4c6b-13b9-4ecb-a7e3-6d0fb451ae4d	ki-105-0000-0000-0000-000000000000	BUILD_BACK	WORK_NOT_STARTED	161200.00	26.00	2026-07-30 18:24:07.827117+00	2026-09-28 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-07-20 18:24:07.827117+00	2026-07-24 18:24:09.502398+00
b0b134ff-548e-4de7-950f-5ae1af431706	b0b134ff-548e-4de7-950f-5ae1af431706	CTX00130001	\N	72db787e-b8e4-440f-b26e-8b08d680f5c7	ki-105-0000-0000-0000-000000000000	CONSTRUCTION	WORK_NOT_STARTED	96400.00	26.00	2026-08-13 18:24:07.827117+00	2026-09-12 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-07-23 18:24:07.827117+00	2026-07-24 18:24:09.555464+00
f3409f77-6734-49c8-929f-60954fbc9034	f3409f77-6734-49c8-929f-60954fbc9034	XTX00020001	\N	773a30df-0dec-4469-8b3c-e6c0ac31a9e7	ki-105-0000-0000-0000-000000000000	MISCELLANEOUS	WORK_NOT_STARTED	52750.00	25.00	2026-08-18 18:24:07.827117+00	2026-09-08 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-07-23 18:24:07.827117+00	2026-07-24 18:24:09.6086+00
51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	51bf4c8f-6597-4be5-9b4e-5ef98ef0d66d	MTX00010002	\N	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	ki-105-0000-0000-0000-000000000000	MITIGATION	IN_PROGRESS	139800.00	31.00	2026-07-13 18:24:07.827117+00	2026-08-17 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	139800.00	\N	\N	\N	\N	2026-07-03 18:24:07.827117+00	2026-07-24 18:24:09.657862+00
f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	f1a1cbba-c00f-44c1-9bbd-cc9154dfe946	MTX00100002	\N	a560e00c-9e03-4009-b3e3-e74b4d0f391b	ki-105-0000-0000-0000-000000000000	MITIGATION	IN_PROGRESS	86300.00	33.00	2026-07-17 18:24:07.827117+00	2026-08-07 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	86300.00	\N	\N	\N	\N	2026-07-07 18:24:07.827117+00	2026-07-24 18:24:09.701941+00
509e5e53-df5e-42c4-bd79-3ea5b49497d8	509e5e53-df5e-42c4-bd79-3ea5b49497d8	RAZ00060002	\N	cc17cfa3-fe7e-4625-9440-ea5ce76b0fc4	ki-110-0000-0000-0000-000000000000	ROOFING	IN_PROGRESS	201500.00	30.00	2026-07-06 18:24:07.827117+00	2026-08-20 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	201500.00	\N	\N	\N	\N	2026-06-26 18:24:07.827117+00	2026-07-24 18:24:09.748939+00
ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	ac81eb89-6ea7-48b4-8860-10a3ad8c7ffe	BTX00030002	\N	0b74a58e-4abb-4c85-8a1d-ae6f4516aaf4	ki-105-0000-0000-0000-000000000000	BUILD_BACK	IN_PROGRESS	312400.00	27.00	2026-06-12 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	312400.00	\N	\N	\N	\N	2026-06-02 18:24:07.827117+00	2026-07-24 18:24:09.791354+00
71cf10e3-2ca6-4256-8e3c-6b10ee266997	71cf10e3-2ca6-4256-8e3c-6b10ee266997	RTX00050002	\N	8f139cf8-0b17-4254-95de-efad830a72ad	ki-110-0000-0000-0000-000000000000	ROOFING	IN_PROGRESS	447900.00	26.00	2026-06-21 18:24:07.827117+00	2026-08-30 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	447900.00	\N	\N	\N	\N	2026-06-11 18:24:07.827117+00	2026-07-24 18:24:09.834181+00
f2717f36-697a-430f-a485-bcafc9482a32	f2717f36-697a-430f-a485-bcafc9482a32	CTX00080002	\N	cc0e932c-43fe-4ec6-b3e1-df298af9a5c1	ki-105-0000-0000-0000-000000000000	CONSTRUCTION	IN_PROGRESS	664300.00	26.00	2026-04-27 18:24:07.827117+00	2026-09-24 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	618700.00	\N	\N	\N	\N	2026-04-17 18:24:07.827117+00	2026-07-24 18:24:11.819592+00
d80d6bca-688a-4dad-9204-89366f709b4f	d80d6bca-688a-4dad-9204-89366f709b4f	BTX00070002	\N	3a19c280-1c94-41f4-93c6-17bf8f5a53b3	ki-105-0000-0000-0000-000000000000	BUILD_BACK	IN_PROGRESS	385600.00	25.00	2026-05-30 18:24:07.827117+00	2026-09-17 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	385600.00	\N	\N	\N	\N	2026-05-20 18:24:07.827117+00	2026-07-24 18:24:09.921773+00
3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	3be0abb2-2a1d-40c1-a2ab-d9e4c63effdd	MTX00130002	\N	72db787e-b8e4-440f-b26e-8b08d680f5c7	ki-105-0000-0000-0000-000000000000	MITIGATION	IN_PROGRESS	264800.00	33.00	2026-06-22 18:24:07.827117+00	2026-08-11 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	264800.00	\N	\N	\N	\N	2026-06-12 18:24:07.827117+00	2026-07-24 18:24:09.966807+00
36fd7907-a7d3-4f4b-a838-0810a2a81669	36fd7907-a7d3-4f4b-a838-0810a2a81669	CTX00150002	\N	3f57307f-01c0-4c82-b420-c99853296a30	ki-105-0000-0000-0000-000000000000	CONSTRUCTION	IN_PROGRESS	174200.00	22.00	2026-07-16 18:24:07.827117+00	2026-09-09 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	174200.00	\N	\N	\N	\N	2026-07-06 18:24:07.827117+00	2026-07-24 18:24:10.014097+00
328b7c55-274d-421b-aee2-163df067ffd1	328b7c55-274d-421b-aee2-163df067ffd1	XAZ00120002	\N	1fafe57a-8995-4352-83a1-11040555305b	ki-105-0000-0000-0000-000000000000	MISCELLANEOUS	IN_PROGRESS	63200.00	30.00	2026-07-20 18:24:07.827117+00	2026-08-09 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	63200.00	\N	\N	\N	\N	2026-07-10 18:24:07.827117+00	2026-07-24 18:24:10.064293+00
9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	9ca881a9-ddf9-4bb6-9045-1b1369b6dcb9	BTX00010003	\N	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	ki-105-0000-0000-0000-000000000000	BUILD_BACK	COMPLETED	116700.00	29.00	2026-05-25 18:24:07.827117+00	2026-07-04 18:24:07.827117+00	2026-07-09 18:24:07.827117+00	2026-07-09 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-05-15 18:24:07.827117+00	2026-07-24 18:24:10.118063+00
774de069-49ca-4cd5-a20e-9bb97382cdd2	774de069-49ca-4cd5-a20e-9bb97382cdd2	CTX00020002	\N	773a30df-0dec-4469-8b3c-e6c0ac31a9e7	ki-105-0000-0000-0000-000000000000	CONSTRUCTION	COMPLETED	90800.00	27.00	2026-06-04 18:24:07.827117+00	2026-07-04 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	2026-07-12 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-05-25 18:24:07.827117+00	2026-07-24 18:24:10.162349+00
4539b766-a4f6-4871-a6dc-0b1820f0f627	4539b766-a4f6-4871-a6dc-0b1820f0f627	XTX00090002	\N	531e85e7-06e4-4a7a-ac5d-5ce5d55a0ef9	ki-105-0000-0000-0000-000000000000	MISCELLANEOUS	COMPLETED	57300.00	27.00	2026-06-14 18:24:07.827117+00	2026-07-04 18:24:07.827117+00	2026-07-16 18:24:07.827117+00	2026-07-16 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-06-04 18:24:07.827117+00	2026-07-24 18:24:10.204409+00
08ed21da-c5f3-40d0-b44c-15897cfdd3b1	08ed21da-c5f3-40d0-b44c-15897cfdd3b1	BTX00140002	\N	6a5475e2-8a5f-442d-a154-9b12a51b82eb	ki-105-0000-0000-0000-000000000000	BUILD_BACK	COMPLETED	132500.00	28.00	2026-06-09 18:24:07.827117+00	2026-07-14 18:24:07.827117+00	2026-07-19 18:24:07.827117+00	2026-07-19 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-05-30 18:24:07.827117+00	2026-07-24 18:24:10.24543+00
d32da9f2-4215-48f9-a1ec-71e967453305	d32da9f2-4215-48f9-a1ec-71e967453305	RTX00010004	\N	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	ki-110-0000-0000-0000-000000000000	ROOFING	CLOSED	608400.00	30.00	2026-05-05 18:24:07.827117+00	2026-06-19 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	2026-06-14 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	2026-06-26 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-04-25 18:24:07.827117+00	2026-07-24 18:24:10.298292+00
249e5252-b737-446a-be25-f5e910a7380d	249e5252-b737-446a-be25-f5e910a7380d	MTX00020003	\N	773a30df-0dec-4469-8b3c-e6c0ac31a9e7	ki-105-0000-0000-0000-000000000000	MITIGATION	CLOSED	146200.00	36.00	2026-04-05 18:24:07.827117+00	2026-05-05 18:24:07.827117+00	2026-05-15 18:24:07.827117+00	2026-05-15 18:24:07.827117+00	2026-05-30 18:24:07.827117+00	2026-05-30 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-03-26 18:24:07.827117+00	2026-07-24 18:24:10.340388+00
3d320ab8-7e02-4557-ab26-c65abc774688	3d320ab8-7e02-4557-ab26-c65abc774688	MTX00040002	\N	175b4c6b-13b9-4ecb-a7e3-6d0fb451ae4d	ki-105-0000-0000-0000-000000000000	MITIGATION	CLOSED	84900.00	33.00	2026-04-27 18:24:07.827117+00	2026-05-22 18:24:07.827117+00	2026-05-30 18:24:07.827117+00	2026-05-30 18:24:07.827117+00	2026-06-12 18:24:07.827117+00	2026-06-12 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-04-17 18:24:07.827117+00	2026-07-24 18:24:10.381638+00
906bdaec-dfde-4248-bae6-57191ccf3277	906bdaec-dfde-4248-bae6-57191ccf3277	CTX00030003	\N	158fe954-6327-472f-980e-f3aa622d3bef	ki-105-0000-0000-0000-000000000000	CONSTRUCTION	CLOSED	273500.00	27.00	2026-04-10 18:24:07.827117+00	2026-05-30 18:24:07.827117+00	2026-06-04 18:24:07.827117+00	2026-06-04 18:24:07.827117+00	2026-06-19 18:24:07.827117+00	2026-06-19 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-03-31 18:24:07.827117+00	2026-07-24 18:24:10.429533+00
eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	eeeeb2a6-c460-47ab-bad8-1859f4ef5a27	MTX00050003	\N	8f139cf8-0b17-4254-95de-efad830a72ad	ki-105-0000-0000-0000-000000000000	MITIGATION	CLOSED	229700.00	36.00	2026-06-21 18:24:07.827117+00	2026-07-05 18:24:07.827117+00	2026-07-08 18:24:07.827117+00	2026-07-08 18:24:07.827117+00	2026-07-18 18:24:07.827117+00	2026-07-18 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-06-11 18:24:07.827117+00	2026-07-24 18:24:10.471319+00
2cb81f29-032f-4247-8259-d7d4d3ffa28f	2cb81f29-032f-4247-8259-d7d4d3ffa28f	RTX00080003	\N	cc0e932c-43fe-4ec6-b3e1-df298af9a5c1	ki-110-0000-0000-0000-000000000000	ROOFING	CLOSED	122600.00	32.00	2026-05-10 18:24:07.827117+00	2026-05-30 18:24:07.827117+00	2026-06-09 18:24:07.827117+00	2026-06-09 18:24:07.827117+00	2026-06-22 18:24:07.827117+00	2026-06-22 18:24:07.827117+00	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-04-30 18:24:07.827117+00	2026-07-24 18:24:10.513989+00
74c20bea-1f9c-404f-b056-23ee26f01017	74c20bea-1f9c-404f-b056-23ee26f01017	CCO00110002	\N	3907f666-373b-4ef8-9c89-e4934b06463e	ki-105-0000-0000-0000-000000000000	CONSTRUCTION	CANCELLED	143800.00	28.00	2026-05-15 18:24:07.827117+00	2026-06-29 18:24:07.827117+00	\N	\N	\N	\N	2026-06-06 18:24:07.827117+00	Ownership paused capital work pending refinance	WORK_NOT_STARTED	\N	\N	\N	f	\N	\N	\N	\N	\N	2026-05-05 18:24:07.827117+00	2026-07-24 18:24:10.557155+00
\.


--
-- Data for Name: standard_tasks; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.standard_tasks (id, code, name, legacy_task_id, created_at, updated_at) FROM stdin;
773f4af2-6424-4dc4-878e-84147d9333c8	travel-and-lodging	Travel and Lodging	1	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.1488+00
c1830425-2439-4dbb-9209-c692d83ff2b7	professional-fees	Professional Fees	2	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.149236+00
32fbdff0-95c5-4360-9140-7e450738a98c	internal-labor	Internal Labor	3	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.149511+00
022df8b0-90fd-4604-8a05-f2d9a29964d0	external-labor	External Labor	4	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.149757+00
55362133-f9a1-4b91-99bb-c08170937714	concrete-subcontractor	Concrete Subcontractor	4b	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.149988+00
54655a43-a27d-4847-9330-5c3abc9b980e	metals-subcontractor	Metals Subcontractor	4c	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.150222+00
c1383d1a-ad2c-4be8-8869-67dc37c47d41	electrical-subcontractor	Electrical Subcontractor	4d	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.150457+00
a79d903b-6777-4d05-919f-f2a48d992360	doors-docks-windows-subcontractor	Doors, Docks and Windows Subcontractor	4e	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.150664+00
61e73f8e-6bc7-4e2f-a7f4-479b55796cd2	finishes-subcontractor	Finishes Subcontractor	4f	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.150873+00
a59a09b2-9e54-4609-81ce-2a58d012576d	fire-suppression-subcontractor	Fire Suppression Subcontractor	4g	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.151077+00
64c48695-63d0-4d77-87a0-b45e3af70a1e	plumbing-subcontractor	Plumbing Subcontractor	4h	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.151288+00
b33ffb54-d831-474f-8200-311a3574e916	hvac-subcontractor	HVAC Subcontractor	4i	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.151499+00
de3e3cd1-b9a8-41d6-8bba-1dbd3b267981	roofing-subcontractor	Roofing Subcontractor	4j	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.151707+00
849aee2b-323f-4bbb-9210-58f92da921de	landscaping-subcontractor	Landscaping Subcontractor	4k	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.151908+00
092973fc-af08-46ba-b75a-25f70a8b354d	specialty-subcontractor	Specialty Subcontractor	4l	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.152116+00
ecc8ff97-7d7f-4073-8406-ff47aeda2ea9	materials-and-supplies	Materials & Supplies	5	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.152324+00
269f557c-2464-466a-bbfe-ef373c1a8eb0	dumpsters	Dumpsters	6	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.152531+00
884aa406-c354-4c85-a942-db016908001e	equipment-rental-and-fuel	Equipment Rental & Fuel	7	2026-07-24 18:24:03.172444+00	2026-07-24 18:24:08.152717+00
\.


--
-- Data for Name: vendor_accounts; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.vendor_accounts (id, company_id, legacy_vendor_id, legacy_vendor_name, created_at, updated_at) FROM stdin;
6d29579d-4920-4768-a82d-66cfc346b521	6cd8ab85-7fd7-4b8c-9e6c-079b3d7a2e31	V10241	Lone Star Equipment Rental	2026-07-24 18:24:08.539359+00	2026-07-24 18:24:08.539368+00
e832c1ff-9226-449a-a419-2397275eb9a8	56d4ab7e-ac1a-401d-a7da-9c8bcdb220cf	V10318	Alliance Roofing Supply	2026-07-24 18:24:08.55076+00	2026-07-24 18:24:08.550762+00
077d7748-b905-4efc-b3d9-698a691f5dde	608abef9-f1ac-487d-8419-7d6cbd7b8e9e	V10422	Metroplex Dumpster Co	2026-07-24 18:24:08.562759+00	2026-07-24 18:24:08.562761+00
ac2f4904-c73f-4d42-8ed6-6d6b3aed366f	118f20d6-bbd4-475f-b410-fd251afa5a8d	V10467	ProDry Restoration Equipment	2026-07-24 18:24:08.571441+00	2026-07-24 18:24:08.571441+00
c3e88ed4-403b-4397-b98a-7eb4ff29d6df	1a516cb5-d88a-49f5-945b-d62be1b14e13	V10503	Hill Country Electric	2026-07-24 18:24:08.579299+00	2026-07-24 18:24:08.579299+00
f304c278-d17d-44dc-a0bd-28be31f481c8	549043d7-7df3-4405-ba26-132773b531af	V10559	Apex Scaffolding	2026-07-24 18:24:08.586751+00	2026-07-24 18:24:08.586751+00
34110e9d-cefe-4347-be2a-8b6c2a628420	6810ec97-1447-40b5-a039-f19e1dac57a1	V10614	Bluebonnet Environmental	2026-07-24 18:24:08.59457+00	2026-07-24 18:24:08.594571+00
70e0b5c1-6593-4e3d-aba2-9747c00fba4c	f18c7235-fc0e-4f20-a863-b3cf9e77e1a7	V10688	Rios Brothers Concrete	2026-07-24 18:24:08.603143+00	2026-07-24 18:24:08.603144+00
96fa11cd-1afd-49f5-9227-8dd7b3445e21	c3dd60f3-4063-4fc0-9289-1d2a4669302a	V10725	ClearView Glass & Glazing	2026-07-24 18:24:08.612019+00	2026-07-24 18:24:08.61202+00
208e8300-6e7b-4ec7-bc16-e5073b86701a	5a0f3fa1-b6f2-4bb0-be40-6712b6472e7f	V10771	Delta Testing Labs	2026-07-24 18:24:08.619971+00	2026-07-24 18:24:08.619971+00
\.


--
-- Data for Name: vendor_discount_terms; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.vendor_discount_terms (id, company_id, discount_percentage, discount_days, created_at, updated_at) FROM stdin;
7728dad6-4133-4644-9c00-38880c58dfb3	56d4ab7e-ac1a-401d-a7da-9c8bcdb220cf	2.00	10	2026-07-24 18:24:11.808659+00	2026-07-24 18:24:11.808661+00
26119eb8-b151-48c5-b6e1-46e9dc4abe46	118f20d6-bbd4-475f-b410-fd251afa5a8d	1.50	15	2026-07-24 18:24:11.809666+00	2026-07-24 18:24:11.809668+00
\.


--
-- Data for Name: work_authorizations; Type: TABLE DATA; Schema: source_company; Owner: -
--

COPY source_company.work_authorizations (id, contact_id, authorization_number, title, description, authorized_amount, status, customer_signed, customer_signed_by, customer_signed_at, contractor_signed, contractor_signed_by, contractor_signed_at, effective_date, expires_at, is_emergency_authorization, notes, created_at, updated_at) FROM stdin;
ab5126f6-cb5f-4c1b-9f10-4bd7b5771570	7ca4882b-bcbc-48e2-b472-b22c96dbc61b	WA-2026-0142	Emergency services — Brookline — Deep Ellum Warehouse Drying	Roof drain backup during July thunderstorms saturated 30,000 sq ft of warehouse.	139800.00	APPROVED	t	Alicia Fontaine	2026-07-11 18:24:07.827117+00	t	Sam Whitfield	2026-07-11 18:24:07.827117+00	2026-07-11 18:24:07.827117+00	2027-07-11 18:24:07.827117+00	f	\N	2026-07-24 18:24:10.644265+00	2026-07-24 18:24:10.644266+00
30064126-5483-44bb-930f-03cca946d006	8f139cf8-0b17-4254-95de-efad830a72ad	WA-2026-0144	Emergency services — Northgate ISD — Elementary Flood Response	Emergency extraction and drying at two elementary campuses after June flooding.	229700.00	APPROVED	t	Carl Jefferson	2026-06-19 18:24:07.827117+00	t	Sam Whitfield	2026-06-19 18:24:07.827117+00	2026-06-19 18:24:07.827117+00	2027-06-19 18:24:07.827117+00	f	\N	2026-07-24 18:24:10.647532+00	2026-07-24 18:24:10.647532+00
97bde639-324b-49ed-96a0-9ae5c7eada25	a560e00c-9e03-4009-b3e3-e74b4d0f391b	WA-2026-0151	Emergency services — Bayou City — Floor 14 Moisture Remediation	HVAC condensate line failure above executive floor; targeted demolition and drying.	86300.00	APPROVED	t	Terrence Vaughn	2026-07-15 18:24:07.827117+00	t	Sam Whitfield	2026-07-15 18:24:07.827117+00	2026-07-15 18:24:07.827117+00	2027-07-15 18:24:07.827117+00	f	\N	2026-07-24 18:24:10.645675+00	2026-07-24 18:24:10.645675+00
8dcaa761-84b8-438f-b7f8-138a50659b20	72db787e-b8e4-440f-b26e-8b08d680f5c7	WA-2026-0146	Emergency services — Gulf Coast — Pier 12 Flood Mitigation	June flood event inundated pier-side offices; extraction, drying, and controlled demolition.	264800.00	APPROVED	t	Bill Standish	2026-06-20 18:24:07.827117+00	t	Sam Whitfield	2026-06-20 18:24:07.827117+00	2026-06-20 18:24:07.827117+00	2027-06-20 18:24:07.827117+00	f	\N	2026-07-24 18:24:10.64664+00	2026-07-24 18:24:10.64664+00
\.


--
-- Name: accounting_periods accounting_periods_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.accounting_periods
    ADD CONSTRAINT accounting_periods_pkey PRIMARY KEY (id);


--
-- Name: actual_costs actual_costs_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.actual_costs
    ADD CONSTRAINT actual_costs_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: ap_invoice_lines ap_invoice_lines_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ap_invoice_lines
    ADD CONSTRAINT ap_invoice_lines_pkey PRIMARY KEY (id);


--
-- Name: ap_invoices ap_invoices_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ap_invoices
    ADD CONSTRAINT ap_invoices_pkey PRIMARY KEY (id);


--
-- Name: ar_invoice_documents ar_invoice_documents_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoice_documents
    ADD CONSTRAINT ar_invoice_documents_pkey PRIMARY KEY (id);


--
-- Name: ar_invoice_lines ar_invoice_lines_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoice_lines
    ADD CONSTRAINT ar_invoice_lines_pkey PRIMARY KEY (id);


--
-- Name: ar_invoice_notes ar_invoice_notes_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoice_notes
    ADD CONSTRAINT ar_invoice_notes_pkey PRIMARY KEY (id);


--
-- Name: ar_invoices ar_invoices_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoices
    ADD CONSTRAINT ar_invoices_pkey PRIMARY KEY (id);


--
-- Name: ar_payments ar_payments_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_payments
    ADD CONSTRAINT ar_payments_pkey PRIMARY KEY (id);


--
-- Name: bids bids_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.bids
    ADD CONSTRAINT bids_pkey PRIMARY KEY (id);


--
-- Name: branches branches_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (id);


--
-- Name: budget_lines budget_lines_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.budget_lines
    ADD CONSTRAINT budget_lines_pkey PRIMARY KEY (id);


--
-- Name: budgets budgets_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.budgets
    ADD CONSTRAINT budgets_pkey PRIMARY KEY (id);


--
-- Name: catastrophe_events catastrophe_events_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.catastrophe_events
    ADD CONSTRAINT catastrophe_events_pkey PRIMARY KEY (id);


--
-- Name: change_orders change_orders_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.change_orders
    ADD CONSTRAINT change_orders_pkey PRIMARY KEY (id);


--
-- Name: commission_policies commission_policies_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.commission_policies
    ADD CONSTRAINT commission_policies_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: company_documents company_documents_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.company_documents
    ADD CONSTRAINT company_documents_pkey PRIMARY KEY (id);


--
-- Name: contact_addresses contact_addresses_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.contact_addresses
    ADD CONSTRAINT contact_addresses_pkey PRIMARY KEY (id);


--
-- Name: contact_interactions contact_interactions_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.contact_interactions
    ADD CONSTRAINT contact_interactions_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: cost_codes cost_codes_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.cost_codes
    ADD CONSTRAINT cost_codes_pkey PRIMARY KEY (id);


--
-- Name: dataset_metadata dataset_metadata_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.dataset_metadata
    ADD CONSTRAINT dataset_metadata_pkey PRIMARY KEY (key);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: engagement_assignments engagement_assignments_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.engagement_assignments
    ADD CONSTRAINT engagement_assignments_pkey PRIMARY KEY (id);


--
-- Name: gl_accounts gl_accounts_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.gl_accounts
    ADD CONSTRAINT gl_accounts_pkey PRIMARY KEY (id);


--
-- Name: gl_entries gl_entries_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.gl_entries
    ADD CONSTRAINT gl_entries_pkey PRIMARY KEY (id);


--
-- Name: inbound_email_attachments inbound_email_attachments_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.inbound_email_attachments
    ADD CONSTRAINT inbound_email_attachments_pkey PRIMARY KEY (id);


--
-- Name: inbound_emails inbound_emails_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.inbound_emails
    ADD CONSTRAINT inbound_emails_pkey PRIMARY KEY (id);


--
-- Name: industries industries_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.industries
    ADD CONSTRAINT industries_pkey PRIMARY KEY (id);


--
-- Name: legal_entities legal_entities_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.legal_entities
    ADD CONSTRAINT legal_entities_pkey PRIMARY KEY (id);


--
-- Name: opportunities opportunities_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.opportunities
    ADD CONSTRAINT opportunities_pkey PRIMARY KEY (id);


--
-- Name: opportunity_documents opportunity_documents_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.opportunity_documents
    ADD CONSTRAINT opportunity_documents_pkey PRIMARY KEY (id);


--
-- Name: project_documents project_documents_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.project_documents
    ADD CONSTRAINT project_documents_pkey PRIMARY KEY (id);


--
-- Name: project_notes project_notes_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.project_notes
    ADD CONSTRAINT project_notes_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: standard_tasks standard_tasks_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.standard_tasks
    ADD CONSTRAINT standard_tasks_pkey PRIMARY KEY (id);


--
-- Name: vendor_accounts vendor_accounts_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.vendor_accounts
    ADD CONSTRAINT vendor_accounts_pkey PRIMARY KEY (id);


--
-- Name: vendor_discount_terms vendor_discount_terms_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.vendor_discount_terms
    ADD CONSTRAINT vendor_discount_terms_pkey PRIMARY KEY (id);


--
-- Name: work_authorizations work_authorizations_pkey; Type: CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.work_authorizations
    ADD CONSTRAINT work_authorizations_pkey PRIMARY KEY (id);


--
-- Name: actual_costs_opportunity_idx; Type: INDEX; Schema: source_company; Owner: -
--

CREATE INDEX actual_costs_opportunity_idx ON source_company.actual_costs USING btree (opportunity_id);


--
-- Name: ap_invoices_number_idx; Type: INDEX; Schema: source_company; Owner: -
--

CREATE INDEX ap_invoices_number_idx ON source_company.ap_invoices USING btree (invoice_number);


--
-- Name: ar_invoices_number_idx; Type: INDEX; Schema: source_company; Owner: -
--

CREATE INDEX ar_invoices_number_idx ON source_company.ar_invoices USING btree (invoice_number);


--
-- Name: engagement_assignments_opportunity_idx; Type: INDEX; Schema: source_company; Owner: -
--

CREATE INDEX engagement_assignments_opportunity_idx ON source_company.engagement_assignments USING btree (opportunity_id);


--
-- Name: gl_entries_opportunity_idx; Type: INDEX; Schema: source_company; Owner: -
--

CREATE INDEX gl_entries_opportunity_idx ON source_company.gl_entries USING btree (opportunity_id);


--
-- Name: opportunities_legacy_number_idx; Type: INDEX; Schema: source_company; Owner: -
--

CREATE INDEX opportunities_legacy_number_idx ON source_company.opportunities USING btree (legacy_opportunity_number);


--
-- Name: projects_project_number_idx; Type: INDEX; Schema: source_company; Owner: -
--

CREATE INDEX projects_project_number_idx ON source_company.projects USING btree (project_number);


--
-- Name: actual_costs actual_costs_ap_invoice_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.actual_costs
    ADD CONSTRAINT actual_costs_ap_invoice_fkey FOREIGN KEY (source_ap_invoice_id) REFERENCES source_company.ap_invoices(id);


--
-- Name: actual_costs actual_costs_budget_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.actual_costs
    ADD CONSTRAINT actual_costs_budget_fkey FOREIGN KEY (budget_id) REFERENCES source_company.budgets(id);


--
-- Name: actual_costs actual_costs_opportunity_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.actual_costs
    ADD CONSTRAINT actual_costs_opportunity_fkey FOREIGN KEY (opportunity_id) REFERENCES source_company.opportunities(id);


--
-- Name: actual_costs actual_costs_vendor_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.actual_costs
    ADD CONSTRAINT actual_costs_vendor_fkey FOREIGN KEY (vendor_id) REFERENCES source_company.companies(id);


--
-- Name: ap_invoice_lines ap_invoice_lines_invoice_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ap_invoice_lines
    ADD CONSTRAINT ap_invoice_lines_invoice_fkey FOREIGN KEY (invoice_id) REFERENCES source_company.ap_invoices(id);


--
-- Name: ap_invoices ap_invoices_branch_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ap_invoices
    ADD CONSTRAINT ap_invoices_branch_fkey FOREIGN KEY (branch_id) REFERENCES source_company.branches(id);


--
-- Name: ap_invoices ap_invoices_legal_entity_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ap_invoices
    ADD CONSTRAINT ap_invoices_legal_entity_fkey FOREIGN KEY (legal_entity_id) REFERENCES source_company.legal_entities(id);


--
-- Name: ap_invoices ap_invoices_opportunity_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ap_invoices
    ADD CONSTRAINT ap_invoices_opportunity_fkey FOREIGN KEY (opportunity_id) REFERENCES source_company.opportunities(id);


--
-- Name: ap_invoices ap_invoices_vendor_contact_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ap_invoices
    ADD CONSTRAINT ap_invoices_vendor_contact_fkey FOREIGN KEY (vendor_contact_id) REFERENCES source_company.contacts(id);


--
-- Name: ap_invoices ap_invoices_vendor_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ap_invoices
    ADD CONSTRAINT ap_invoices_vendor_fkey FOREIGN KEY (vendor_id) REFERENCES source_company.companies(id);


--
-- Name: ar_invoice_documents ar_invoice_documents_document_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoice_documents
    ADD CONSTRAINT ar_invoice_documents_document_fkey FOREIGN KEY (document_id) REFERENCES source_company.documents(id);


--
-- Name: ar_invoice_documents ar_invoice_documents_invoice_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoice_documents
    ADD CONSTRAINT ar_invoice_documents_invoice_fkey FOREIGN KEY (invoice_id) REFERENCES source_company.ar_invoices(id);


--
-- Name: ar_invoice_lines ar_invoice_lines_invoice_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoice_lines
    ADD CONSTRAINT ar_invoice_lines_invoice_fkey FOREIGN KEY (invoice_id) REFERENCES source_company.ar_invoices(id);


--
-- Name: ar_invoice_notes ar_invoice_notes_invoice_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoice_notes
    ADD CONSTRAINT ar_invoice_notes_invoice_fkey FOREIGN KEY (invoice_id) REFERENCES source_company.ar_invoices(id);


--
-- Name: ar_invoices ar_invoices_company_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoices
    ADD CONSTRAINT ar_invoices_company_fkey FOREIGN KEY (company_id) REFERENCES source_company.companies(id);


--
-- Name: ar_invoices ar_invoices_contact_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoices
    ADD CONSTRAINT ar_invoices_contact_fkey FOREIGN KEY (contact_id) REFERENCES source_company.contacts(id);


--
-- Name: ar_invoices ar_invoices_document_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoices
    ADD CONSTRAINT ar_invoices_document_fkey FOREIGN KEY (document_id) REFERENCES source_company.documents(id);


--
-- Name: ar_invoices ar_invoices_legal_entity_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoices
    ADD CONSTRAINT ar_invoices_legal_entity_fkey FOREIGN KEY (legal_entity_id) REFERENCES source_company.legal_entities(id);


--
-- Name: ar_invoices ar_invoices_opportunity_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_invoices
    ADD CONSTRAINT ar_invoices_opportunity_fkey FOREIGN KEY (opportunity_id) REFERENCES source_company.opportunities(id);


--
-- Name: ar_payments ar_payments_invoice_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.ar_payments
    ADD CONSTRAINT ar_payments_invoice_fkey FOREIGN KEY (invoice_id) REFERENCES source_company.ar_invoices(id);


--
-- Name: bids bids_opportunity_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.bids
    ADD CONSTRAINT bids_opportunity_fkey FOREIGN KEY (opportunity_id) REFERENCES source_company.opportunities(id);


--
-- Name: budget_lines budget_lines_budget_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.budget_lines
    ADD CONSTRAINT budget_lines_budget_fkey FOREIGN KEY (budget_id) REFERENCES source_company.budgets(id);


--
-- Name: budgets budgets_opportunity_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.budgets
    ADD CONSTRAINT budgets_opportunity_fkey FOREIGN KEY (opportunity_id) REFERENCES source_company.opportunities(id);


--
-- Name: change_orders change_orders_document_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.change_orders
    ADD CONSTRAINT change_orders_document_fkey FOREIGN KEY (signed_document_id) REFERENCES source_company.documents(id);


--
-- Name: change_orders change_orders_project_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.change_orders
    ADD CONSTRAINT change_orders_project_fkey FOREIGN KEY (project_id) REFERENCES source_company.projects(id);


--
-- Name: commission_policies commission_policies_document_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.commission_policies
    ADD CONSTRAINT commission_policies_document_fkey FOREIGN KEY (document_id) REFERENCES source_company.documents(id);


--
-- Name: companies companies_address_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.companies
    ADD CONSTRAINT companies_address_fkey FOREIGN KEY (address_id) REFERENCES source_company.addresses(id);


--
-- Name: companies companies_billing_contact_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.companies
    ADD CONSTRAINT companies_billing_contact_fkey FOREIGN KEY (billing_contact_id) REFERENCES source_company.contacts(id);


--
-- Name: companies companies_industry_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.companies
    ADD CONSTRAINT companies_industry_fkey FOREIGN KEY (industry_id) REFERENCES source_company.industries(id);


--
-- Name: company_documents company_documents_company_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.company_documents
    ADD CONSTRAINT company_documents_company_fkey FOREIGN KEY (company_id) REFERENCES source_company.companies(id);


--
-- Name: company_documents company_documents_document_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.company_documents
    ADD CONSTRAINT company_documents_document_fkey FOREIGN KEY (document_id) REFERENCES source_company.documents(id);


--
-- Name: contact_addresses contact_addresses_address_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.contact_addresses
    ADD CONSTRAINT contact_addresses_address_fkey FOREIGN KEY (address_id) REFERENCES source_company.addresses(id);


--
-- Name: contact_addresses contact_addresses_contact_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.contact_addresses
    ADD CONSTRAINT contact_addresses_contact_fkey FOREIGN KEY (contact_id) REFERENCES source_company.contacts(id);


--
-- Name: contact_interactions contact_interactions_contact_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.contact_interactions
    ADD CONSTRAINT contact_interactions_contact_fkey FOREIGN KEY (contact_id) REFERENCES source_company.contacts(id);


--
-- Name: contacts contacts_company_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.contacts
    ADD CONSTRAINT contacts_company_fkey FOREIGN KEY (company_id) REFERENCES source_company.companies(id);


--
-- Name: contacts contacts_industry_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.contacts
    ADD CONSTRAINT contacts_industry_fkey FOREIGN KEY (industry_id) REFERENCES source_company.industries(id);


--
-- Name: employees employees_branch_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.employees
    ADD CONSTRAINT employees_branch_fkey FOREIGN KEY (branch_id) REFERENCES source_company.branches(id);


--
-- Name: engagement_assignments engagement_assignments_employee_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.engagement_assignments
    ADD CONSTRAINT engagement_assignments_employee_fkey FOREIGN KEY (employee_id) REFERENCES source_company.employees(id);


--
-- Name: engagement_assignments engagement_assignments_opportunity_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.engagement_assignments
    ADD CONSTRAINT engagement_assignments_opportunity_fkey FOREIGN KEY (opportunity_id) REFERENCES source_company.opportunities(id);


--
-- Name: gl_entries gl_entries_opportunity_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.gl_entries
    ADD CONSTRAINT gl_entries_opportunity_fkey FOREIGN KEY (opportunity_id) REFERENCES source_company.opportunities(id);


--
-- Name: inbound_email_attachments inbound_email_attachments_email_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.inbound_email_attachments
    ADD CONSTRAINT inbound_email_attachments_email_fkey FOREIGN KEY (inbound_email_id) REFERENCES source_company.inbound_emails(id);


--
-- Name: legal_entities legal_entities_billing_address_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.legal_entities
    ADD CONSTRAINT legal_entities_billing_address_fkey FOREIGN KEY (billing_address_id) REFERENCES source_company.addresses(id);


--
-- Name: opportunities opportunities_address_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.opportunities
    ADD CONSTRAINT opportunities_address_fkey FOREIGN KEY (address_id) REFERENCES source_company.addresses(id);


--
-- Name: opportunities opportunities_catastrophe_event_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.opportunities
    ADD CONSTRAINT opportunities_catastrophe_event_fkey FOREIGN KEY (catastrophe_event_id) REFERENCES source_company.catastrophe_events(id);


--
-- Name: opportunities opportunities_contact_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.opportunities
    ADD CONSTRAINT opportunities_contact_fkey FOREIGN KEY (contact_id) REFERENCES source_company.contacts(id);


--
-- Name: opportunities opportunities_operating_branch_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.opportunities
    ADD CONSTRAINT opportunities_operating_branch_fkey FOREIGN KEY (operating_branch_id) REFERENCES source_company.branches(id);


--
-- Name: opportunities opportunities_referral_contact_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.opportunities
    ADD CONSTRAINT opportunities_referral_contact_fkey FOREIGN KEY (referral_contact_id) REFERENCES source_company.contacts(id);


--
-- Name: opportunities opportunities_reporting_branch_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.opportunities
    ADD CONSTRAINT opportunities_reporting_branch_fkey FOREIGN KEY (reporting_branch_id) REFERENCES source_company.branches(id);


--
-- Name: opportunities opportunities_site_contact_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.opportunities
    ADD CONSTRAINT opportunities_site_contact_fkey FOREIGN KEY (site_contact_id) REFERENCES source_company.contacts(id);


--
-- Name: opportunity_documents opportunity_documents_document_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.opportunity_documents
    ADD CONSTRAINT opportunity_documents_document_fkey FOREIGN KEY (document_id) REFERENCES source_company.documents(id);


--
-- Name: opportunity_documents opportunity_documents_opportunity_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.opportunity_documents
    ADD CONSTRAINT opportunity_documents_opportunity_fkey FOREIGN KEY (opportunity_id) REFERENCES source_company.opportunities(id);


--
-- Name: project_documents project_documents_document_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.project_documents
    ADD CONSTRAINT project_documents_document_fkey FOREIGN KEY (document_id) REFERENCES source_company.documents(id);


--
-- Name: project_documents project_documents_project_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.project_documents
    ADD CONSTRAINT project_documents_project_fkey FOREIGN KEY (project_id) REFERENCES source_company.projects(id);


--
-- Name: project_notes project_notes_project_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.project_notes
    ADD CONSTRAINT project_notes_project_fkey FOREIGN KEY (project_id) REFERENCES source_company.projects(id);


--
-- Name: projects projects_contact_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.projects
    ADD CONSTRAINT projects_contact_fkey FOREIGN KEY (contact_id) REFERENCES source_company.contacts(id);


--
-- Name: projects projects_legal_entity_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.projects
    ADD CONSTRAINT projects_legal_entity_fkey FOREIGN KEY (legal_entity_id) REFERENCES source_company.legal_entities(id);


--
-- Name: projects projects_opportunity_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.projects
    ADD CONSTRAINT projects_opportunity_fkey FOREIGN KEY (opportunity_id) REFERENCES source_company.opportunities(id);


--
-- Name: vendor_accounts vendor_accounts_company_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.vendor_accounts
    ADD CONSTRAINT vendor_accounts_company_fkey FOREIGN KEY (company_id) REFERENCES source_company.companies(id);


--
-- Name: vendor_discount_terms vendor_discount_terms_company_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.vendor_discount_terms
    ADD CONSTRAINT vendor_discount_terms_company_fkey FOREIGN KEY (company_id) REFERENCES source_company.companies(id);


--
-- Name: work_authorizations work_authorizations_contact_fkey; Type: FK CONSTRAINT; Schema: source_company; Owner: -
--

ALTER TABLE ONLY source_company.work_authorizations
    ADD CONSTRAINT work_authorizations_contact_fkey FOREIGN KEY (contact_id) REFERENCES source_company.contacts(id);


--
-- PostgreSQL database dump complete
--

\unrestrict ZKBmQVxVB84hmoGE6ERRIUfTkuCxGmu2QNJB77e7HjFWd40UdwVkTC8ITjIlcqH

