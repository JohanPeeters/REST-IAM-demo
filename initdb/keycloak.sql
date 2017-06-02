--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS keycloak;
--
-- Name: keycloak; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE keycloak WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE keycloak OWNER TO keycloak;

\connect keycloak

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    client_template_id character varying(36),
    use_template_config boolean DEFAULT false NOT NULL,
    use_template_scope boolean DEFAULT false NOT NULL,
    use_template_mappers boolean DEFAULT false NOT NULL
);


ALTER TABLE client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE client_attributes OWNER TO keycloak;

--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE client_default_roles OWNER TO keycloak;

--
-- Name: client_identity_prov_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_identity_prov_mapping (
    client_id character varying(36) NOT NULL,
    identity_provider_id character varying(36) NOT NULL,
    retrieve_token boolean DEFAULT false NOT NULL
);


ALTER TABLE client_identity_prov_mapping OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE client_node_registrations OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_session_role OWNER TO keycloak;

--
-- Name: client_template; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_template (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255),
    full_scope_allowed boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    bearer_only boolean DEFAULT false NOT NULL,
    public_client boolean DEFAULT false NOT NULL
);


ALTER TABLE client_template OWNER TO keycloak;

--
-- Name: client_template_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_template_attributes (
    template_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE client_template_attributes OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE credential (
    id character varying(36) NOT NULL,
    device character varying(255),
    hash_iterations integer,
    salt bytea,
    type character varying(255),
    value character varying(4000),
    user_id character varying(36),
    created_date bigint,
    counter integer DEFAULT 0,
    digits integer DEFAULT 6,
    period integer DEFAULT 30,
    algorithm character varying(36) DEFAULT NULL::character varying
);


ALTER TABLE credential OWNER TO keycloak;

--
-- Name: credential_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE credential_attribute (
    id character varying(36) NOT NULL,
    credential_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE credential_attribute OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255)
);


ALTER TABLE databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE databasechangeloglock OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE event_entity OWNER TO keycloak;

--
-- Name: fed_credential_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_credential_attribute (
    id character varying(36) NOT NULL,
    credential_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE fed_credential_attribute OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint
);


ALTER TABLE fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_consent_prot_mapper (
    user_consent_id character varying(36) NOT NULL,
    protocol_mapper_id character varying(36) NOT NULL
);


ALTER TABLE fed_user_consent_prot_mapper OWNER TO keycloak;

--
-- Name: fed_user_consent_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_consent_role (
    user_consent_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE fed_user_consent_role OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_credential (
    id character varying(36) NOT NULL,
    device character varying(255),
    hash_iterations integer,
    salt bytea,
    type character varying(255),
    value character varying(255),
    created_date bigint,
    counter integer DEFAULT 0,
    digits integer DEFAULT 6,
    period integer DEFAULT 30,
    algorithm character varying(36) DEFAULT 'HmacSHA1'::character varying,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36),
    realm_id character varying(36)
);


ALTER TABLE keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(36),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36),
    scope_param_required boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE migration_model (
    id character varying(36) NOT NULL,
    version character varying(36)
);


ALTER TABLE migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE offline_client_session (
    client_session_id character varying(36) NOT NULL,
    user_session_id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text
);


ALTER TABLE offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    last_session_refresh integer,
    offline_flag character varying(4) NOT NULL,
    data text
);


ALTER TABLE offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    consent_text character varying(255),
    client_id character varying(36),
    client_template_id character varying(36)
);


ALTER TABLE protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL
);


ALTER TABLE realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE realm_default_groups OWNER TO keycloak;

--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE realm_default_roles OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255)
);


ALTER TABLE realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255)
);


ALTER TABLE realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255)
);


ALTER TABLE realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255)
);


ALTER TABLE redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255)
);


ALTER TABLE required_action_provider OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server (
    id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL
);


ALTER TABLE resource_server OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL
);


ALTER TABLE resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    uri character varying(255),
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(36) NOT NULL,
    resource_server_id character varying(36) NOT NULL
);


ALTER TABLE resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL
);


ALTER TABLE resource_server_scope OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE scope_policy OWNER TO keycloak;

--
-- Name: template_scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE template_scope_mapping (
    template_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE template_scope_mapping OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint
);


ALTER TABLE user_consent OWNER TO keycloak;

--
-- Name: user_consent_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_consent_prot_mapper (
    user_consent_id character varying(36) NOT NULL,
    protocol_mapper_id character varying(36) NOT NULL
);


ALTER TABLE user_consent_prot_mapper OWNER TO keycloak;

--
-- Name: user_consent_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_consent_role (
    user_consent_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE user_consent_role OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(36)
);


ALTER TABLE user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255)
);


ALTER TABLE web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO authentication_execution VALUES ('4caf57f9-13fe-482d-ae8d-495fc61b34b9', NULL, 'auth-cookie', 'master', 'f0ebf238-55ad-48b8-9a8e-93a023274534', 2, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('232180a3-681c-4488-a7f0-18ced3509fd9', NULL, 'auth-spnego', 'master', 'f0ebf238-55ad-48b8-9a8e-93a023274534', 3, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('cdf42ea4-80b3-439c-a765-c0b9fc0ebb9b', NULL, 'identity-provider-redirector', 'master', 'f0ebf238-55ad-48b8-9a8e-93a023274534', 2, 25, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('adb2c552-6259-4e5a-bee4-3e5c40716870', NULL, NULL, 'master', 'f0ebf238-55ad-48b8-9a8e-93a023274534', 2, 30, true, '04d94a07-a96a-406d-bef1-fe28dba1f4a6', NULL);
INSERT INTO authentication_execution VALUES ('b35c523f-a7d6-4094-bd5e-5ac3bf3e369b', NULL, 'auth-username-password-form', 'master', '04d94a07-a96a-406d-bef1-fe28dba1f4a6', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('c6cd6569-0a61-46cb-a793-f88ce3bbae8d', NULL, 'auth-otp-form', 'master', '04d94a07-a96a-406d-bef1-fe28dba1f4a6', 1, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('e63053fb-fe97-438f-810e-f325206d6891', NULL, 'direct-grant-validate-username', 'master', '0361b6f0-5b34-4646-9998-440f70d3e3fd', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('23171b9a-b716-476b-93a1-d9c369dab3bb', NULL, 'direct-grant-validate-password', 'master', '0361b6f0-5b34-4646-9998-440f70d3e3fd', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('0f0e910f-7895-4616-ab33-688b31454a97', NULL, 'direct-grant-validate-otp', 'master', '0361b6f0-5b34-4646-9998-440f70d3e3fd', 1, 30, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('06588c96-9f26-4ff0-b7fb-d6a14f069d0d', NULL, 'registration-page-form', 'master', '362ce71b-99ea-4d39-9e07-829122f0eb26', 0, 10, true, 'd93e271f-dcc7-48be-981e-db39e513e670', NULL);
INSERT INTO authentication_execution VALUES ('e64288ba-18fb-4e6f-bc0b-aa927cc996cd', NULL, 'registration-user-creation', 'master', 'd93e271f-dcc7-48be-981e-db39e513e670', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('65a0d46c-a085-45c5-8d85-e590473f6555', NULL, 'registration-profile-action', 'master', 'd93e271f-dcc7-48be-981e-db39e513e670', 0, 40, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('5cf30f2b-0e4d-42b0-9bed-bb4aef67e0ff', NULL, 'registration-password-action', 'master', 'd93e271f-dcc7-48be-981e-db39e513e670', 0, 50, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('b24609c2-00fc-444b-96eb-e2e602db1b09', NULL, 'registration-recaptcha-action', 'master', 'd93e271f-dcc7-48be-981e-db39e513e670', 3, 60, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('f74e798c-fdb5-4e7e-ae00-051e97b52f87', NULL, 'reset-credentials-choose-user', 'master', '67fee0b9-868f-496e-87e1-7c2f05fca317', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('7f072140-27b1-4fad-9e8c-e8668fcb8f6e', NULL, 'reset-credential-email', 'master', '67fee0b9-868f-496e-87e1-7c2f05fca317', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('068bd625-573b-406d-9018-507b713549c3', NULL, 'reset-password', 'master', '67fee0b9-868f-496e-87e1-7c2f05fca317', 0, 30, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('0144a563-bfdd-4bd1-a3c2-bd17020cb854', NULL, 'reset-otp', 'master', '67fee0b9-868f-496e-87e1-7c2f05fca317', 1, 40, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('7d8b580a-2c95-4fd6-8de1-b38d60248912', NULL, 'client-secret', 'master', '23261c24-99f4-4ce0-9c53-321c7acc9b9c', 2, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('4b3a59ee-f2e1-4515-9146-d3f74a47da13', NULL, 'client-jwt', 'master', '23261c24-99f4-4ce0-9c53-321c7acc9b9c', 2, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('89469b03-78a4-4049-8f6a-0805ff63f4b7', NULL, 'idp-review-profile', 'master', '89fdc027-e91e-48fc-b1ea-44e8cf2d39d7', 0, 10, false, NULL, 'b692ba14-ceed-4ce2-89d9-09a9d14dc2a3');
INSERT INTO authentication_execution VALUES ('603c295b-93d5-4f98-a66d-68884829dfa5', NULL, 'idp-create-user-if-unique', 'master', '89fdc027-e91e-48fc-b1ea-44e8cf2d39d7', 2, 20, false, NULL, '34d43252-a120-4ebb-b8ef-54a17bbc94e1');
INSERT INTO authentication_execution VALUES ('31aedff1-c3d4-4fb2-b0ec-5aaebb698cde', NULL, NULL, 'master', '89fdc027-e91e-48fc-b1ea-44e8cf2d39d7', 2, 30, true, '057db164-0177-4bfb-8330-118be85c2e14', NULL);
INSERT INTO authentication_execution VALUES ('75d67615-33c7-4d6e-b38d-03fb54f4e8d0', NULL, 'idp-confirm-link', 'master', '057db164-0177-4bfb-8330-118be85c2e14', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('ae744b8f-48fa-45a4-9182-7a004933ad93', NULL, 'idp-email-verification', 'master', '057db164-0177-4bfb-8330-118be85c2e14', 2, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('6f19a174-08b5-40d2-b4dc-54d76e425197', NULL, NULL, 'master', '057db164-0177-4bfb-8330-118be85c2e14', 2, 30, true, '29819766-56af-4842-bf6f-dbc1f03065fc', NULL);
INSERT INTO authentication_execution VALUES ('f9da4b42-b97e-4f96-bd23-d5f640ccfd8b', NULL, 'idp-username-password-form', 'master', '29819766-56af-4842-bf6f-dbc1f03065fc', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('42c4417b-95a4-402a-a4a6-2b1f0fa7c192', NULL, 'auth-otp-form', 'master', '29819766-56af-4842-bf6f-dbc1f03065fc', 1, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('5b74ce55-6308-4d8e-8f8d-366285a3518d', NULL, 'http-basic-authenticator', 'master', '123778c0-7127-4a6d-a282-eb9d0f15633b', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('a0e12503-a760-4745-9088-0d9620c61b21', NULL, 'idp-confirm-link', 'Joyn', '007ec7e0-829c-42b2-9e46-327bd34eb0f8', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('26652a83-10b1-414c-9fe4-cfca8b461e6b', NULL, 'idp-email-verification', 'Joyn', '007ec7e0-829c-42b2-9e46-327bd34eb0f8', 2, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('ddc11807-1339-4075-90d6-ec9eb21f7e78', NULL, NULL, 'Joyn', '007ec7e0-829c-42b2-9e46-327bd34eb0f8', 2, 30, true, 'fc2d3039-b9c6-4c17-84ec-b1dd4eca7d62', NULL);
INSERT INTO authentication_execution VALUES ('8024de0e-6f92-4214-bd4f-6423d8d4d350', NULL, 'idp-username-password-form', 'Joyn', 'fc2d3039-b9c6-4c17-84ec-b1dd4eca7d62', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('46fa7cd1-d222-4568-88e3-a218fcc22873', NULL, 'auth-otp-form', 'Joyn', 'fc2d3039-b9c6-4c17-84ec-b1dd4eca7d62', 1, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('ff36b463-f507-481c-9bdc-ff28b112837e', NULL, 'auth-cookie', 'Joyn', 'dde585ff-0e30-4a14-af37-d6fad287fd26', 2, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('fb43521e-4697-4dca-a17d-9384b80d6885', NULL, 'auth-spnego', 'Joyn', 'dde585ff-0e30-4a14-af37-d6fad287fd26', 3, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('17b83f5c-7636-48f1-b5d8-93f5b3767041', NULL, 'identity-provider-redirector', 'Joyn', 'dde585ff-0e30-4a14-af37-d6fad287fd26', 2, 25, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('5a1ff62f-2e45-4ace-b5d0-97128d52d660', NULL, NULL, 'Joyn', 'dde585ff-0e30-4a14-af37-d6fad287fd26', 2, 30, true, 'd0266fc6-2e98-4896-be6a-8b58274582c7', NULL);
INSERT INTO authentication_execution VALUES ('6178d248-6bba-4d83-a093-7b8e47da5111', NULL, 'client-secret', 'Joyn', '218dc39b-958a-44b5-b972-178aa7fa2d77', 2, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('c2319599-c1b1-4f21-818b-20c9a0ef1bf1', NULL, 'client-jwt', 'Joyn', '218dc39b-958a-44b5-b972-178aa7fa2d77', 2, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('f8e12007-2570-4e14-80a7-6214cebe8001', NULL, 'direct-grant-validate-username', 'Joyn', 'a5645acd-ae62-4d8a-abca-0eca8df24496', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('a18e14e9-88ae-45e8-9634-6ed268bc72bb', NULL, 'direct-grant-validate-password', 'Joyn', 'a5645acd-ae62-4d8a-abca-0eca8df24496', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('2d903c1f-a9fc-47ca-b716-af27cdab45a2', NULL, 'direct-grant-validate-otp', 'Joyn', 'a5645acd-ae62-4d8a-abca-0eca8df24496', 1, 30, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('e89bcf59-e819-499e-82a2-6ff534fd73fd', NULL, 'idp-review-profile', 'Joyn', '40c54f9a-e896-4fdd-af05-61933da0205e', 0, 10, false, NULL, '1e248c12-3b2b-4b19-a235-21f9dd35b135');
INSERT INTO authentication_execution VALUES ('15cce287-6536-4f4a-bf02-34a2bfa094c5', NULL, 'idp-create-user-if-unique', 'Joyn', '40c54f9a-e896-4fdd-af05-61933da0205e', 2, 20, false, NULL, '9b0d8966-bf5d-42a5-86af-5b89654fac39');
INSERT INTO authentication_execution VALUES ('74ad7922-a7fc-4b3f-b307-bf07fe83d105', NULL, NULL, 'Joyn', '40c54f9a-e896-4fdd-af05-61933da0205e', 2, 30, true, '007ec7e0-829c-42b2-9e46-327bd34eb0f8', NULL);
INSERT INTO authentication_execution VALUES ('2a54902a-16e8-4c3a-ac84-b4a0752d5153', NULL, 'auth-username-password-form', 'Joyn', 'd0266fc6-2e98-4896-be6a-8b58274582c7', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('186c6fad-5544-4633-bb62-ecf7a31aa5a0', NULL, 'auth-otp-form', 'Joyn', 'd0266fc6-2e98-4896-be6a-8b58274582c7', 1, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('85635584-127e-4e6d-89ad-b44d2fdbacce', NULL, 'registration-page-form', 'Joyn', '1592898e-e256-40cf-8117-bf08a175cd11', 0, 10, true, 'b8077afa-0c21-40a0-b057-d67066d6df48', NULL);
INSERT INTO authentication_execution VALUES ('4e27f4f2-3174-4c3b-9507-8aa5e5b9efeb', NULL, 'registration-user-creation', 'Joyn', 'b8077afa-0c21-40a0-b057-d67066d6df48', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('89d82860-a2a7-4358-be08-ca77b3629985', NULL, 'registration-profile-action', 'Joyn', 'b8077afa-0c21-40a0-b057-d67066d6df48', 0, 40, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('1b313df5-18e3-4515-8c54-8bf45c474a32', NULL, 'registration-password-action', 'Joyn', 'b8077afa-0c21-40a0-b057-d67066d6df48', 0, 50, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('5fcb9a79-c373-4906-ba4e-249823fe08ec', NULL, 'registration-recaptcha-action', 'Joyn', 'b8077afa-0c21-40a0-b057-d67066d6df48', 3, 60, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('395af642-f1c9-406c-98c4-86d84bf261e3', NULL, 'reset-credentials-choose-user', 'Joyn', '5e90527c-c7f7-42f6-b59b-9f52f4d1b3ef', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('08af577f-e8d2-4326-bca3-80ad18b16626', NULL, 'reset-credential-email', 'Joyn', '5e90527c-c7f7-42f6-b59b-9f52f4d1b3ef', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('fbf96bbd-a433-4d5b-a0ac-b4013afa14a7', NULL, 'reset-password', 'Joyn', '5e90527c-c7f7-42f6-b59b-9f52f4d1b3ef', 0, 30, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('13dd3d87-e5ac-43b4-ad35-48f0f7c18767', NULL, 'reset-otp', 'Joyn', '5e90527c-c7f7-42f6-b59b-9f52f4d1b3ef', 1, 40, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('f331d71c-29df-410c-be16-fc6cf0c661c2', NULL, 'http-basic-authenticator', 'Joyn', 'a0e15855-00af-4e02-965d-9fdeafcaf6cf', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('8bba81f9-67fb-4bb2-bdc6-c29f99c4a63d', NULL, 'auth-cookie', 'fa758415-6fe8-4313-b599-643292361e3d', 'bac93b82-ef24-47a3-a20a-3bce871303c4', 2, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('9f2eb289-122b-4145-9afb-c71485bc0ebc', NULL, 'auth-spnego', 'fa758415-6fe8-4313-b599-643292361e3d', 'bac93b82-ef24-47a3-a20a-3bce871303c4', 3, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('c66f558b-1308-4a7f-87d4-70628a31572a', NULL, 'identity-provider-redirector', 'fa758415-6fe8-4313-b599-643292361e3d', 'bac93b82-ef24-47a3-a20a-3bce871303c4', 2, 25, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('6d4186e3-3c1f-4cd1-af63-2a9a87748555', NULL, NULL, 'fa758415-6fe8-4313-b599-643292361e3d', 'bac93b82-ef24-47a3-a20a-3bce871303c4', 2, 30, true, '3a67249a-ab83-4d79-8d48-6be62ca0f3b7', NULL);
INSERT INTO authentication_execution VALUES ('6630dae7-ad8b-42dc-a33a-1f75fc0d5598', NULL, 'auth-username-password-form', 'fa758415-6fe8-4313-b599-643292361e3d', '3a67249a-ab83-4d79-8d48-6be62ca0f3b7', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('ba21cba5-ac26-49c1-b36e-43cccf91d88b', NULL, 'auth-otp-form', 'fa758415-6fe8-4313-b599-643292361e3d', '3a67249a-ab83-4d79-8d48-6be62ca0f3b7', 1, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('e422a8ec-53e6-498c-8ecb-36bb432972d3', NULL, 'direct-grant-validate-username', 'fa758415-6fe8-4313-b599-643292361e3d', '5ced2963-d2a9-4a1d-b5f7-0764ceb9f3a2', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('5fbccd2b-0ab8-41b8-b2c8-557d16fe0df4', NULL, 'direct-grant-validate-password', 'fa758415-6fe8-4313-b599-643292361e3d', '5ced2963-d2a9-4a1d-b5f7-0764ceb9f3a2', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('56a82b89-9635-47a5-8dee-4eb022b0ecfe', NULL, 'direct-grant-validate-otp', 'fa758415-6fe8-4313-b599-643292361e3d', '5ced2963-d2a9-4a1d-b5f7-0764ceb9f3a2', 1, 30, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('ddd9279d-9812-4388-a807-32297323269f', NULL, 'registration-page-form', 'fa758415-6fe8-4313-b599-643292361e3d', 'b3957b14-8be3-461e-83a6-cad78fa78d02', 0, 10, true, '53c4ab92-16c6-4242-8280-7e66a9e24dde', NULL);
INSERT INTO authentication_execution VALUES ('ff44d0c5-770c-4f8b-9815-85f6f36f1fcd', NULL, 'registration-user-creation', 'fa758415-6fe8-4313-b599-643292361e3d', '53c4ab92-16c6-4242-8280-7e66a9e24dde', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('8bfecd98-23e4-4939-b490-f07f74dd786b', NULL, 'registration-profile-action', 'fa758415-6fe8-4313-b599-643292361e3d', '53c4ab92-16c6-4242-8280-7e66a9e24dde', 0, 40, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('a20644c6-7e09-430a-a8ea-d10c3926cebc', NULL, 'registration-password-action', 'fa758415-6fe8-4313-b599-643292361e3d', '53c4ab92-16c6-4242-8280-7e66a9e24dde', 0, 50, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('5efcd859-ab34-4b07-af05-4fd13ada1ecf', NULL, 'registration-recaptcha-action', 'fa758415-6fe8-4313-b599-643292361e3d', '53c4ab92-16c6-4242-8280-7e66a9e24dde', 3, 60, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('c8849b14-3aed-4862-a7fe-0b96edaf164c', NULL, 'reset-credentials-choose-user', 'fa758415-6fe8-4313-b599-643292361e3d', '8cc9dbd4-272c-4dee-9b90-34f896827a7d', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('03dae82b-f507-4620-b4f1-473a5950776a', NULL, 'reset-credential-email', 'fa758415-6fe8-4313-b599-643292361e3d', '8cc9dbd4-272c-4dee-9b90-34f896827a7d', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('745feb3b-5d59-4a74-bb48-cf1e935f6a0b', NULL, 'reset-password', 'fa758415-6fe8-4313-b599-643292361e3d', '8cc9dbd4-272c-4dee-9b90-34f896827a7d', 0, 30, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('7f612564-ae1a-4616-b741-ba41407fd2df', NULL, 'reset-otp', 'fa758415-6fe8-4313-b599-643292361e3d', '8cc9dbd4-272c-4dee-9b90-34f896827a7d', 1, 40, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('bbd66f68-96bd-43dd-9c56-e552df9c8c86', NULL, 'client-secret', 'fa758415-6fe8-4313-b599-643292361e3d', 'caaf11ba-a8b4-4398-8895-7629eecd1e48', 2, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('9e44b2fe-03ea-46b3-8de6-e03fba555df8', NULL, 'client-jwt', 'fa758415-6fe8-4313-b599-643292361e3d', 'caaf11ba-a8b4-4398-8895-7629eecd1e48', 2, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('8098bb87-aebf-4a72-88bf-cbfac57bbdea', NULL, 'idp-review-profile', 'fa758415-6fe8-4313-b599-643292361e3d', 'f2041c81-e9fe-4d68-8e5a-99a4eb187624', 0, 10, false, NULL, 'd1f85878-8c0c-4ceb-b670-bd334b29c584');
INSERT INTO authentication_execution VALUES ('e317c0c9-cde6-4ebf-bf62-884ccf147352', NULL, 'idp-create-user-if-unique', 'fa758415-6fe8-4313-b599-643292361e3d', 'f2041c81-e9fe-4d68-8e5a-99a4eb187624', 2, 20, false, NULL, '4cc75ea9-8dfa-48db-b98d-cd284c0fba83');
INSERT INTO authentication_execution VALUES ('ebde6a31-6875-4ad3-aa3d-20b406957b66', NULL, NULL, 'fa758415-6fe8-4313-b599-643292361e3d', 'f2041c81-e9fe-4d68-8e5a-99a4eb187624', 2, 30, true, '2cdfd55b-2100-4de5-a1f9-803eef768877', NULL);
INSERT INTO authentication_execution VALUES ('20218370-0c94-4516-a6e3-6befd3dfd393', NULL, 'idp-confirm-link', 'fa758415-6fe8-4313-b599-643292361e3d', '2cdfd55b-2100-4de5-a1f9-803eef768877', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('08347f61-df25-47bd-b8ca-4a00193ba765', NULL, 'idp-email-verification', 'fa758415-6fe8-4313-b599-643292361e3d', '2cdfd55b-2100-4de5-a1f9-803eef768877', 2, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('df358ebd-a0c4-4425-8633-dcfae5feb20b', NULL, NULL, 'fa758415-6fe8-4313-b599-643292361e3d', '2cdfd55b-2100-4de5-a1f9-803eef768877', 2, 30, true, '7bca7b97-8b2d-4296-aef6-2507a4e9481a', NULL);
INSERT INTO authentication_execution VALUES ('6a78fc36-07a5-4cad-b80c-a1fb80ec8d85', NULL, 'idp-username-password-form', 'fa758415-6fe8-4313-b599-643292361e3d', '7bca7b97-8b2d-4296-aef6-2507a4e9481a', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('f419034f-7ea9-4da7-9ca8-2299aacbb402', NULL, 'auth-otp-form', 'fa758415-6fe8-4313-b599-643292361e3d', '7bca7b97-8b2d-4296-aef6-2507a4e9481a', 1, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('ac7af734-32a0-41ae-8ead-9984050f6e2c', NULL, 'http-basic-authenticator', 'fa758415-6fe8-4313-b599-643292361e3d', '83d8e778-0899-4f11-bc03-14095256a51c', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('b6676e4c-c03b-4580-be81-d89d94820089', NULL, 'idp-confirm-link', 'FidCash', '14aeab8d-47ac-4870-912c-99f6f741dabf', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('73a4a089-6b16-475a-b6b3-83252a587963', NULL, 'idp-email-verification', 'FidCash', '14aeab8d-47ac-4870-912c-99f6f741dabf', 2, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('5e2bdeed-c184-49ce-a6bb-a253367cd272', NULL, NULL, 'FidCash', '14aeab8d-47ac-4870-912c-99f6f741dabf', 2, 30, true, '757b1b50-fefd-4834-9109-7755d97b5425', NULL);
INSERT INTO authentication_execution VALUES ('98c29961-aa24-4afd-83d5-f5cc2a464aaf', NULL, 'idp-username-password-form', 'FidCash', '757b1b50-fefd-4834-9109-7755d97b5425', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('9ea00eb2-08df-41e2-93f6-c9d1b4c03f75', NULL, 'auth-otp-form', 'FidCash', '757b1b50-fefd-4834-9109-7755d97b5425', 1, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('4a5b0233-7af8-4438-8e4f-da1e819e43b1', NULL, 'auth-otp-form', 'FidCash', '60731bee-4f24-4bf1-a42b-828e19ed456e', 1, 0, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('8e6d0261-d199-46f1-b70c-b147d2295329', NULL, 'auth-cookie', 'FidCash', 'fb8b4160-f51c-4652-bcf6-accd50142f7f', 2, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('29903627-5b4b-4f79-8e20-2b418ae5d293', NULL, 'auth-spnego', 'FidCash', 'fb8b4160-f51c-4652-bcf6-accd50142f7f', 3, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('ea0977d6-34f3-4a5b-a681-4659981c83bd', NULL, 'identity-provider-redirector', 'FidCash', 'fb8b4160-f51c-4652-bcf6-accd50142f7f', 2, 25, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('87f95be2-32b5-4946-b815-e0bea35fb2fa', NULL, NULL, 'FidCash', 'fb8b4160-f51c-4652-bcf6-accd50142f7f', 2, 30, true, 'abf3e24f-f667-4bb8-adbe-2cce88f4ba28', NULL);
INSERT INTO authentication_execution VALUES ('197a21e8-aa9a-4725-b15d-7f53ddc782d3', NULL, 'client-secret', 'FidCash', '0ad7afbf-8ac4-44ca-a2cd-e02b53804d69', 2, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('1d1a4db4-fd7f-4923-b99c-2c78eef45434', NULL, 'client-jwt', 'FidCash', '0ad7afbf-8ac4-44ca-a2cd-e02b53804d69', 2, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('11af4727-55da-4621-b12f-083beb5ee556', NULL, 'direct-grant-validate-username', 'FidCash', 'fb37f684-1563-4fa7-a3ff-f592530db418', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('8c84c754-5e47-4dc1-9236-37b90a9c76d5', NULL, 'direct-grant-validate-password', 'FidCash', 'fb37f684-1563-4fa7-a3ff-f592530db418', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('17f2f597-3875-4536-ac86-2a73b29c2a7d', NULL, 'direct-grant-validate-otp', 'FidCash', 'fb37f684-1563-4fa7-a3ff-f592530db418', 1, 30, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('7ef59d78-9f50-4893-81b0-a3a5dd78f13b', NULL, 'idp-review-profile', 'FidCash', 'ae57d11c-3184-4758-99ed-b2734d502aff', 0, 10, false, NULL, '1abc1d19-55e5-4aed-92f7-428708a970dd');
INSERT INTO authentication_execution VALUES ('adc1b5dc-7fb4-4bae-ad05-ce902a73f743', NULL, 'idp-create-user-if-unique', 'FidCash', 'ae57d11c-3184-4758-99ed-b2734d502aff', 2, 20, false, NULL, 'dd1d7dfc-323b-4dd6-bcaa-9c9e6d8d4143');
INSERT INTO authentication_execution VALUES ('2012757d-230d-477e-8ed1-615d95af208e', NULL, NULL, 'FidCash', 'ae57d11c-3184-4758-99ed-b2734d502aff', 2, 30, true, '14aeab8d-47ac-4870-912c-99f6f741dabf', NULL);
INSERT INTO authentication_execution VALUES ('90e78214-1763-4220-9648-4333e1df5135', NULL, 'auth-username-password-form', 'FidCash', 'abf3e24f-f667-4bb8-adbe-2cce88f4ba28', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('066b55ae-f8f0-4954-b933-be37af41e35e', NULL, 'auth-otp-form', 'FidCash', 'abf3e24f-f667-4bb8-adbe-2cce88f4ba28', 1, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('ca4d7153-2bbd-4c42-8ac3-c085d5d65732', NULL, 'registration-page-form', 'FidCash', '23ca7c0f-5232-428a-a608-eda42c381449', 0, 10, true, '68852766-a55f-4ea2-b938-e9e283789131', NULL);
INSERT INTO authentication_execution VALUES ('6564a097-9539-4862-a637-ada092c1940f', NULL, 'registration-user-creation', 'FidCash', '68852766-a55f-4ea2-b938-e9e283789131', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('d830127b-eaf7-4047-8f0f-20e411cd5b64', NULL, 'registration-profile-action', 'FidCash', '68852766-a55f-4ea2-b938-e9e283789131', 0, 40, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('738e7bb6-e77f-4776-a064-af435a1efca4', NULL, 'registration-password-action', 'FidCash', '68852766-a55f-4ea2-b938-e9e283789131', 0, 50, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('e26c70bd-a11c-4265-bda7-9189bb2413b9', NULL, 'registration-recaptcha-action', 'FidCash', '68852766-a55f-4ea2-b938-e9e283789131', 3, 60, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('b8e42f61-c080-4a41-9ba8-0753e42ef0f5', NULL, 'reset-credentials-choose-user', 'FidCash', 'afc53ff5-fd60-48cc-9611-e1b1503d1394', 0, 10, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('a91b93b3-49e2-472e-8f2d-94ba1e5f7983', NULL, 'reset-credential-email', 'FidCash', 'afc53ff5-fd60-48cc-9611-e1b1503d1394', 0, 20, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('7d61375a-a54d-49d3-b189-e3fe14eccb76', NULL, 'reset-password', 'FidCash', 'afc53ff5-fd60-48cc-9611-e1b1503d1394', 0, 30, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('2491d3a1-95f3-457c-b166-ea182303b6d0', NULL, 'reset-otp', 'FidCash', 'afc53ff5-fd60-48cc-9611-e1b1503d1394', 1, 40, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('29cfb7d2-ef33-415d-95c6-75e0d401442c', NULL, 'reset-credentials-choose-user', 'FidCash', 'de65c6b1-4896-4b0a-b799-6694a0715c0a', 0, 0, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('2fc29639-2c2a-4f90-8b8c-c37476b0bdd6', NULL, 'reset-credential-email', 'FidCash', 'de65c6b1-4896-4b0a-b799-6694a0715c0a', 0, 1, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('2ce36a9c-e677-4734-8736-6ba3d6c43fb4', NULL, 'reset-password', 'FidCash', 'de65c6b1-4896-4b0a-b799-6694a0715c0a', 0, 2, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('1de364c5-9206-4750-87e2-aa4be7c851c6', NULL, 'auth-otp-form', 'FidCash', 'de65c6b1-4896-4b0a-b799-6694a0715c0a', 1, 3, false, NULL, NULL);
INSERT INTO authentication_execution VALUES ('211e9f3b-cd1c-4841-80f2-d4581846d86e', NULL, 'http-basic-authenticator', 'FidCash', 'b0dd91a9-0124-4791-99ed-2d8cb728765e', 0, 10, false, NULL, NULL);


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO authentication_flow VALUES ('f0ebf238-55ad-48b8-9a8e-93a023274534', 'browser', 'browser based authentication', 'master', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('04d94a07-a96a-406d-bef1-fe28dba1f4a6', 'forms', 'Username, password, otp and other auth forms.', 'master', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('0361b6f0-5b34-4646-9998-440f70d3e3fd', 'direct grant', 'OpenID Connect Resource Owner Grant', 'master', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('362ce71b-99ea-4d39-9e07-829122f0eb26', 'registration', 'registration flow', 'master', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('d93e271f-dcc7-48be-981e-db39e513e670', 'registration form', 'registration form', 'master', 'form-flow', false, true);
INSERT INTO authentication_flow VALUES ('67fee0b9-868f-496e-87e1-7c2f05fca317', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'master', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('23261c24-99f4-4ce0-9c53-321c7acc9b9c', 'clients', 'Base authentication for clients', 'master', 'client-flow', true, true);
INSERT INTO authentication_flow VALUES ('89fdc027-e91e-48fc-b1ea-44e8cf2d39d7', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'master', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('057db164-0177-4bfb-8330-118be85c2e14', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'master', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('29819766-56af-4842-bf6f-dbc1f03065fc', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'master', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('123778c0-7127-4a6d-a282-eb9d0f15633b', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'master', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('007ec7e0-829c-42b2-9e46-327bd34eb0f8', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'Joyn', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('fc2d3039-b9c6-4c17-84ec-b1dd4eca7d62', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'Joyn', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('dde585ff-0e30-4a14-af37-d6fad287fd26', 'browser', 'browser based authentication', 'Joyn', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('218dc39b-958a-44b5-b972-178aa7fa2d77', 'clients', 'Base authentication for clients', 'Joyn', 'client-flow', true, true);
INSERT INTO authentication_flow VALUES ('a5645acd-ae62-4d8a-abca-0eca8df24496', 'direct grant', 'OpenID Connect Resource Owner Grant', 'Joyn', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('40c54f9a-e896-4fdd-af05-61933da0205e', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'Joyn', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('d0266fc6-2e98-4896-be6a-8b58274582c7', 'forms', 'Username, password, otp and other auth forms.', 'Joyn', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('1592898e-e256-40cf-8117-bf08a175cd11', 'registration', 'registration flow', 'Joyn', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('b8077afa-0c21-40a0-b057-d67066d6df48', 'registration form', 'registration form', 'Joyn', 'form-flow', false, true);
INSERT INTO authentication_flow VALUES ('5e90527c-c7f7-42f6-b59b-9f52f4d1b3ef', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'Joyn', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('a0e15855-00af-4e02-965d-9fdeafcaf6cf', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'Joyn', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('bac93b82-ef24-47a3-a20a-3bce871303c4', 'browser', 'browser based authentication', 'fa758415-6fe8-4313-b599-643292361e3d', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('3a67249a-ab83-4d79-8d48-6be62ca0f3b7', 'forms', 'Username, password, otp and other auth forms.', 'fa758415-6fe8-4313-b599-643292361e3d', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('5ced2963-d2a9-4a1d-b5f7-0764ceb9f3a2', 'direct grant', 'OpenID Connect Resource Owner Grant', 'fa758415-6fe8-4313-b599-643292361e3d', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('b3957b14-8be3-461e-83a6-cad78fa78d02', 'registration', 'registration flow', 'fa758415-6fe8-4313-b599-643292361e3d', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('53c4ab92-16c6-4242-8280-7e66a9e24dde', 'registration form', 'registration form', 'fa758415-6fe8-4313-b599-643292361e3d', 'form-flow', false, true);
INSERT INTO authentication_flow VALUES ('8cc9dbd4-272c-4dee-9b90-34f896827a7d', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'fa758415-6fe8-4313-b599-643292361e3d', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('caaf11ba-a8b4-4398-8895-7629eecd1e48', 'clients', 'Base authentication for clients', 'fa758415-6fe8-4313-b599-643292361e3d', 'client-flow', true, true);
INSERT INTO authentication_flow VALUES ('f2041c81-e9fe-4d68-8e5a-99a4eb187624', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'fa758415-6fe8-4313-b599-643292361e3d', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('2cdfd55b-2100-4de5-a1f9-803eef768877', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'fa758415-6fe8-4313-b599-643292361e3d', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('7bca7b97-8b2d-4296-aef6-2507a4e9481a', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'fa758415-6fe8-4313-b599-643292361e3d', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('83d8e778-0899-4f11-bc03-14095256a51c', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'fa758415-6fe8-4313-b599-643292361e3d', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('14aeab8d-47ac-4870-912c-99f6f741dabf', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'FidCash', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('757b1b50-fefd-4834-9109-7755d97b5425', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'FidCash', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('60731bee-4f24-4bf1-a42b-828e19ed456e', 'broker-otp', 'Require OTP (when enabled) after social login.', 'FidCash', 'basic-flow', true, false);
INSERT INTO authentication_flow VALUES ('fb8b4160-f51c-4652-bcf6-accd50142f7f', 'browser', 'browser based authentication', 'FidCash', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('0ad7afbf-8ac4-44ca-a2cd-e02b53804d69', 'clients', 'Base authentication for clients', 'FidCash', 'client-flow', true, true);
INSERT INTO authentication_flow VALUES ('fb37f684-1563-4fa7-a3ff-f592530db418', 'direct grant', 'OpenID Connect Resource Owner Grant', 'FidCash', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('ae57d11c-3184-4758-99ed-b2734d502aff', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'FidCash', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('abf3e24f-f667-4bb8-adbe-2cce88f4ba28', 'forms', 'Username, password, otp and other auth forms.', 'FidCash', 'basic-flow', false, true);
INSERT INTO authentication_flow VALUES ('23ca7c0f-5232-428a-a608-eda42c381449', 'registration', 'registration flow', 'FidCash', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('68852766-a55f-4ea2-b938-e9e283789131', 'registration form', 'registration form', 'FidCash', 'form-flow', false, true);
INSERT INTO authentication_flow VALUES ('afc53ff5-fd60-48cc-9611-e1b1503d1394', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'FidCash', 'basic-flow', true, true);
INSERT INTO authentication_flow VALUES ('de65c6b1-4896-4b0a-b799-6694a0715c0a', 'reset-password-require-otp', 'This flow requires an OTP (when enabled) after a password reset. This means that, if a user loses the second factor, he will NEVER be able to login again. This is more secure and aligns with industry standards.', 'FidCash', 'basic-flow', true, false);
INSERT INTO authentication_flow VALUES ('b0dd91a9-0124-4791-99ed-2d8cb728765e', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'FidCash', 'basic-flow', true, true);


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO authenticator_config VALUES ('b692ba14-ceed-4ce2-89d9-09a9d14dc2a3', 'review profile config', 'master');
INSERT INTO authenticator_config VALUES ('34d43252-a120-4ebb-b8ef-54a17bbc94e1', 'create unique user config', 'master');
INSERT INTO authenticator_config VALUES ('9b0d8966-bf5d-42a5-86af-5b89654fac39', 'create unique user config', 'Joyn');
INSERT INTO authenticator_config VALUES ('1e248c12-3b2b-4b19-a235-21f9dd35b135', 'review profile config', 'Joyn');
INSERT INTO authenticator_config VALUES ('d1f85878-8c0c-4ceb-b670-bd334b29c584', 'review profile config', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO authenticator_config VALUES ('4cc75ea9-8dfa-48db-b98d-cd284c0fba83', 'create unique user config', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO authenticator_config VALUES ('dd1d7dfc-323b-4dd6-bcaa-9c9e6d8d4143', 'create unique user config', 'FidCash');
INSERT INTO authenticator_config VALUES ('1abc1d19-55e5-4aed-92f7-428708a970dd', 'review profile config', 'FidCash');


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO authenticator_config_entry VALUES ('b692ba14-ceed-4ce2-89d9-09a9d14dc2a3', 'missing', 'update.profile.on.first.login');
INSERT INTO authenticator_config_entry VALUES ('34d43252-a120-4ebb-b8ef-54a17bbc94e1', 'false', 'require.password.update.after.registration');
INSERT INTO authenticator_config_entry VALUES ('9b0d8966-bf5d-42a5-86af-5b89654fac39', 'false', 'require.password.update.after.registration');
INSERT INTO authenticator_config_entry VALUES ('1e248c12-3b2b-4b19-a235-21f9dd35b135', 'missing', 'update.profile.on.first.login');
INSERT INTO authenticator_config_entry VALUES ('d1f85878-8c0c-4ceb-b670-bd334b29c584', 'missing', 'update.profile.on.first.login');
INSERT INTO authenticator_config_entry VALUES ('4cc75ea9-8dfa-48db-b98d-cd284c0fba83', 'false', 'require.password.update.after.registration');
INSERT INTO authenticator_config_entry VALUES ('dd1d7dfc-323b-4dd6-bcaa-9c9e6d8d4143', 'false', 'require.password.update.after.registration');
INSERT INTO authenticator_config_entry VALUES ('1abc1d19-55e5-4aed-92f7-428708a970dd', 'missing', 'update.profile.on.first.login');


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO client VALUES ('662f42cf-dc6b-461d-9633-d8384f210692', true, true, 'master-realm', 0, false, '07922427-68d9-4681-bea9-f7fb43077a2a', NULL, true, NULL, false, 'master', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('d19d260c-bfd9-4375-b4f4-c9b7c6188289', true, false, 'account', 0, false, '57b773ed-29a1-4fad-82af-bc9f86cb737f', '/auth/realms/master/account', false, NULL, false, 'master', NULL, 0, false, false, '${client_account}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('b48a0302-d58e-430e-8ed8-8231a282da39', true, false, 'broker', 0, false, '3d4b0ac5-7eed-4846-9873-ce9900c79215', NULL, false, NULL, false, 'master', NULL, 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('84a138ae-2da9-4b1d-8149-7e1f726aefa8', true, false, 'security-admin-console', 0, true, 'ec5c551b-e052-4fb9-b16f-3e0ac0bd52e1', '/auth/admin/master/console/index.html', false, NULL, false, 'master', NULL, 0, false, false, '${client_security-admin-console}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('ea5c74a8-9fbf-4d1f-a63b-22f34ec80ab8', true, false, 'admin-cli', 0, true, '81bbaa05-8280-4891-b7f6-ffcc15edbada', NULL, false, NULL, false, 'master', NULL, 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, NULL, false, false, false);
INSERT INTO client VALUES ('0a87bd58-0cf4-4e19-a1e1-52525afc8823', true, false, 'admin-cli', 0, true, '5fdc349c-0452-4ec3-b197-e1b1a42e94a2', NULL, false, NULL, false, 'Joyn', NULL, 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, NULL, false, false, false);
INSERT INTO client VALUES ('b41ab070-1f92-4562-8f2c-965ab07138e0', true, false, 'broker', 0, false, 'a20c92c4-8431-44a5-acd0-247daf452496', NULL, false, NULL, false, 'Joyn', NULL, 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('8f8d9417-ed6c-481a-bac6-f2735a298156', true, false, 'realm-management', 0, false, 'd14ec4b5-8d2e-4a3b-b8f7-babfae1281a0', NULL, true, NULL, false, 'Joyn', NULL, 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', true, true, 'test_svc', 0, true, '07304f21-0bb8-49f7-b408-f70d6e641d21', NULL, true, NULL, false, 'Joyn', 'openid-connect', -1, false, false, NULL, false, 'client-secret', NULL, 'the test service', NULL, true, false, true, NULL, false, false, false);
INSERT INTO client VALUES ('9b1705ee-b907-443e-9fd9-568448f312d3', true, true, 'apiman-realm', 0, false, 'f7feb2e5-315f-4a6d-adef-56b18fe3329e', NULL, true, NULL, false, 'master', NULL, 0, false, false, 'apiman Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('5bb93364-13a4-4071-8275-14083447bba4', true, false, 'realm-management', 0, false, '02d203d4-c709-4a68-bd64-2c0ec8c3892e', NULL, true, NULL, false, 'fa758415-6fe8-4313-b599-643292361e3d', NULL, 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', true, false, 'account', 0, false, 'b706ac1b-2d7c-478b-a385-8c569ce6e53d', '/auth/realms/apiman/account', false, NULL, false, 'fa758415-6fe8-4313-b599-643292361e3d', NULL, 0, false, false, '${client_account}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('9027ac22-28b7-4c20-8de2-14f338db5580', true, false, 'broker', 0, false, 'a0c71e8a-9b18-414c-8cdc-bfb494636364', NULL, false, NULL, false, 'fa758415-6fe8-4313-b599-643292361e3d', NULL, 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('9d135049-107a-43fd-af59-46bfbe870158', true, false, 'security-admin-console', 0, true, '161bf852-d44f-4c3f-83f6-848f88cf1497', '/auth/admin/apiman/console/index.html', false, NULL, false, 'fa758415-6fe8-4313-b599-643292361e3d', NULL, 0, false, false, '${client_security-admin-console}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('cc90450b-01a7-4178-bd2b-74cf91436f2f', true, false, 'admin-cli', 0, true, 'a6150a9c-bb03-4dec-b78a-64e5abd9c466', NULL, false, NULL, false, 'fa758415-6fe8-4313-b599-643292361e3d', NULL, 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, NULL, false, false, false);
INSERT INTO client VALUES ('3b1e3885-0b42-4569-84c7-dc7f2dd7183b', true, true, 'apimanui', 0, true, '722557fd-a725-4cc0-9dff-7d09c0c47038', '/apimanui', false, NULL, false, 'fa758415-6fe8-4313-b599-643292361e3d', NULL, -1, false, false, NULL, false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('11afe0d4-0779-410a-a962-f9c50bd3122f', true, true, 'apiman', 0, false, '5af5458f-0a96-4251-8f92-08ebcc3a8aa2', '/apiman', false, NULL, false, 'fa758415-6fe8-4313-b599-643292361e3d', NULL, -1, false, false, NULL, false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('819991a5-96df-4ab0-bec2-c9a1cfdf86aa', true, false, 'admin-cli', 0, true, '8f9d7941-9eb6-4dfa-9761-eae8d6632ba8', NULL, false, NULL, false, 'FidCash', NULL, 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, NULL, false, false, false);
INSERT INTO client VALUES ('6a832b8b-e8e6-46f6-8a99-85e147e0448a', true, false, 'broker', 0, false, 'c370d4d0-3bfa-499a-b259-b3a9ba7a4575', NULL, false, NULL, false, 'FidCash', NULL, 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, false, 'realm-management', 0, false, '33f2806e-c83a-4aba-a4cd-8f7026aad13d', NULL, true, NULL, false, 'FidCash', NULL, 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', true, true, 'test_svc', 0, true, '07304f21-0bb8-49f7-b408-f70d6e641d21', NULL, true, NULL, false, 'FidCash', 'openid-connect', -1, false, false, NULL, false, 'client-secret', NULL, 'the test service', NULL, true, false, true, NULL, false, false, false);
INSERT INTO client VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', true, true, 'apiman-gateway-api', 0, true, '217b725d-7790-47a7-a3fc-5cf31f92a8db', '/apiman-gateway-api', false, NULL, false, 'fa758415-6fe8-4313-b599-643292361e3d', 'openid-connect', -1, false, false, NULL, false, 'client-secret', NULL, NULL, NULL, false, false, true, NULL, false, false, false);
INSERT INTO client VALUES ('dd112d33-6fb0-4566-8966-a70d5905c056', true, true, 'Aldi-realm', 0, false, '124d26e5-5191-434d-aa9c-5512b5d76025', NULL, true, NULL, false, 'master', NULL, 0, false, false, 'Joyn Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('8210d5e2-cc3c-4eb6-be99-3a32667a378a', true, false, 'security-admin-console', 0, true, 'f7ff058e-496d-41c7-a286-91e6ebbc8b35', '/auth/admin/Aldi/console/index.html', false, NULL, false, 'Joyn', NULL, 0, false, false, '${client_security-admin-console}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('ab721dba-4af4-4d1d-b686-aec44d62d883', true, false, 'account', 0, false, '27d83b9f-f309-45cc-a001-11e142510924', '/auth/realms/Aldi/account', false, NULL, false, 'Joyn', NULL, 0, false, false, '${client_account}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', true, false, 'aldiApplication', 0, true, '9a1fa4b9-eda1-493d-8bb8-246580b865a3', NULL, false, NULL, false, 'Joyn', 'openid-connect', -1, false, false, NULL, false, 'client-secret', NULL, NULL, NULL, false, false, true, NULL, false, false, false);
INSERT INTO client VALUES ('102112b4-0529-46c4-afc3-5dded7a42ff9', true, true, 'Colruyt-realm', 0, false, 'c1c23e2d-af1a-4185-90a7-a1ed63e4869c', NULL, true, NULL, false, 'master', NULL, 0, false, false, 'FidCash Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('3364267c-1dd3-4fdf-b323-2d05bf18beb5', true, false, 'security-admin-console', 0, true, '1e7712f0-c2bb-46db-978d-76e12dcf5b11', '/auth/admin/Colruyt/console/index.html', false, NULL, false, 'FidCash', NULL, 0, false, false, '${client_security-admin-console}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('8bc6a229-9e1d-4a74-8933-8fb0abf50fde', true, false, 'account', 0, false, 'e92a3264-9841-43a8-914d-8a4b87cc1434', '/auth/realms/Colruyt/account', false, NULL, false, 'FidCash', NULL, 0, false, false, '${client_account}', false, 'client-secret', NULL, NULL, NULL, true, false, false, NULL, false, false, false);
INSERT INTO client VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', true, false, 'colruytApplication', 0, true, '9a1fa4b9-eda1-493d-8bb8-246580b865a3', NULL, false, NULL, false, 'FidCash', 'openid-connect', -1, false, false, NULL, false, 'client-secret', NULL, NULL, NULL, true, false, true, NULL, false, false, false);


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO client_attributes VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', 'false', 'saml.assertion.signature');
INSERT INTO client_attributes VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', 'false', 'saml.force.post.binding');
INSERT INTO client_attributes VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', 'false', 'saml.multivalued.roles');
INSERT INTO client_attributes VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', 'false', 'saml.encrypt');
INSERT INTO client_attributes VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', 'false', 'saml_force_name_id_format');
INSERT INTO client_attributes VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', 'false', 'saml.client.signature');
INSERT INTO client_attributes VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', 'false', 'saml.authnstatement');
INSERT INTO client_attributes VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', 'false', 'saml.server.signature');
INSERT INTO client_attributes VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO client_attributes VALUES ('8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', 'false', 'saml.assertion.signature');
INSERT INTO client_attributes VALUES ('8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', 'false', 'saml.force.post.binding');
INSERT INTO client_attributes VALUES ('8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', 'false', 'saml.multivalued.roles');
INSERT INTO client_attributes VALUES ('8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', 'false', 'saml.encrypt');
INSERT INTO client_attributes VALUES ('8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', 'false', 'saml_force_name_id_format');
INSERT INTO client_attributes VALUES ('8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', 'false', 'saml.client.signature');
INSERT INTO client_attributes VALUES ('8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', 'false', 'saml.authnstatement');
INSERT INTO client_attributes VALUES ('8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', 'false', 'saml.server.signature');
INSERT INTO client_attributes VALUES ('8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO client_attributes VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'false', 'saml.assertion.signature');
INSERT INTO client_attributes VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'false', 'saml.force.post.binding');
INSERT INTO client_attributes VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'false', 'saml.multivalued.roles');
INSERT INTO client_attributes VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'false', 'saml.encrypt');
INSERT INTO client_attributes VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'false', 'saml_force_name_id_format');
INSERT INTO client_attributes VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'false', 'saml.client.signature');
INSERT INTO client_attributes VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'false', 'saml.authnstatement');
INSERT INTO client_attributes VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'false', 'saml.server.signature');
INSERT INTO client_attributes VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO client_attributes VALUES ('cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', 'false', 'saml.assertion.signature');
INSERT INTO client_attributes VALUES ('cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', 'false', 'saml.force.post.binding');
INSERT INTO client_attributes VALUES ('cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', 'false', 'saml.multivalued.roles');
INSERT INTO client_attributes VALUES ('cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', 'false', 'saml.encrypt');
INSERT INTO client_attributes VALUES ('cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', 'false', 'saml_force_name_id_format');
INSERT INTO client_attributes VALUES ('cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', 'false', 'saml.client.signature');
INSERT INTO client_attributes VALUES ('cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', 'false', 'saml.authnstatement');
INSERT INTO client_attributes VALUES ('cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', 'false', 'saml.server.signature');
INSERT INTO client_attributes VALUES ('cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO client_attributes VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', 'false', 'saml.assertion.signature');
INSERT INTO client_attributes VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', 'false', 'saml.multivalued.roles');
INSERT INTO client_attributes VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', 'false', 'saml.force.post.binding');
INSERT INTO client_attributes VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', 'false', 'saml.encrypt');
INSERT INTO client_attributes VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', 'false', 'saml_force_name_id_format');
INSERT INTO client_attributes VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', 'false', 'saml.client.signature');
INSERT INTO client_attributes VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', 'false', 'saml.authnstatement');
INSERT INTO client_attributes VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', 'false', 'saml.server.signature');
INSERT INTO client_attributes VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO client_attributes VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', 'false', 'saml.onetimeuse.condition');
INSERT INTO client_attributes VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'false', 'saml.onetimeuse.condition');


--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO client_default_roles VALUES ('d19d260c-bfd9-4375-b4f4-c9b7c6188289', '169ae6bd-87e6-4112-8411-b858eb5bcb35');
INSERT INTO client_default_roles VALUES ('d19d260c-bfd9-4375-b4f4-c9b7c6188289', '5ebaf50f-278f-4caa-bf2a-a6483ed909c0');
INSERT INTO client_default_roles VALUES ('ab721dba-4af4-4d1d-b686-aec44d62d883', '86c6f137-9d24-457f-90fb-97f052710b87');
INSERT INTO client_default_roles VALUES ('ab721dba-4af4-4d1d-b686-aec44d62d883', '502baf77-40f3-4968-8a6e-8830c0fa8dcd');
INSERT INTO client_default_roles VALUES ('4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', '8617b026-a097-49ff-8ddb-99b2703919c5');
INSERT INTO client_default_roles VALUES ('4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', '6d437c34-bb29-4f02-987a-eb18d022eb2f');
INSERT INTO client_default_roles VALUES ('8bc6a229-9e1d-4a74-8933-8fb0abf50fde', '88eac625-ce82-4e85-b60a-eec0c8ab2a50');
INSERT INTO client_default_roles VALUES ('8bc6a229-9e1d-4a74-8933-8fb0abf50fde', '44b6498c-c088-4bf6-a022-7f7e980ed7d7');


--
-- Data for Name: client_identity_prov_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_template; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_template_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO component VALUES ('54e07573-e55e-4509-9b44-3faeda551d93', 'Trusted Hosts', 'master', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO component VALUES ('59cc4231-0210-46e1-aad6-70b89abd71b6', 'Consent Required', 'master', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO component VALUES ('bead838e-c3f6-4f70-ab71-1c886c77149d', 'Full Scope Disabled', 'master', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO component VALUES ('5e1c7424-b08a-496e-ad28-58584a6c967b', 'Max Clients Limit', 'master', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO component VALUES ('1a9e9e69-28b4-4dd7-87fd-f676613e5abe', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO component VALUES ('f91d9699-49d1-4375-a3d5-a8900b298b83', 'Allowed Client Templates', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO component VALUES ('47f2595b-95bc-441c-a7f6-3e1dbc4ac31c', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO component VALUES ('44416f85-7bb3-460d-85f3-901faa905d11', 'Allowed Client Templates', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO component VALUES ('8de4ab23-9fca-44b4-8ddb-159882d2c469', 'rsa-generated', 'master', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO component VALUES ('038159ed-6d42-48a6-9f7d-9b2f30a28efd', 'hmac-generated', 'master', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO component VALUES ('a908a3bc-2dc5-43c2-b261-a97e7aea9bcd', 'Trusted Hosts', 'Joyn', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'Joyn', 'anonymous');
INSERT INTO component VALUES ('67280800-09a1-4689-9da6-f6cc151845ca', 'Consent Required', 'Joyn', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'Joyn', 'anonymous');
INSERT INTO component VALUES ('7e3ae67c-6cfb-4aaf-b3a1-9f125a1593e8', 'Full Scope Disabled', 'Joyn', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'Joyn', 'anonymous');
INSERT INTO component VALUES ('c7eb3b50-b48f-4359-a0b9-67e2c7fd5721', 'Max Clients Limit', 'Joyn', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'Joyn', 'anonymous');
INSERT INTO component VALUES ('e4c31105-4d6f-4ff8-b99b-95d2ac7154be', 'Allowed Protocol Mapper Types', 'Joyn', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'Joyn', 'anonymous');
INSERT INTO component VALUES ('fae8977b-7059-476e-8e40-26b4239c0ef0', 'Allowed Client Templates', 'Joyn', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'Joyn', 'anonymous');
INSERT INTO component VALUES ('80d5a93f-6a70-41f8-993b-48c405a1d80d', 'Allowed Protocol Mapper Types', 'Joyn', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'Joyn', 'authenticated');
INSERT INTO component VALUES ('4ebe0a1d-c4ef-49a0-818c-8e58b8a49c47', 'Allowed Client Templates', 'Joyn', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'Joyn', 'authenticated');
INSERT INTO component VALUES ('26433f9d-7a11-4494-abd2-2123f82cedfb', 'rsa-generated', 'Joyn', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'Joyn', NULL);
INSERT INTO component VALUES ('17a00c00-220e-4924-baad-8d6217281821', 'hmac-generated', 'Joyn', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'Joyn', NULL);
INSERT INTO component VALUES ('d5b76f5c-9909-4e84-8d49-eeb7b7cec1b4', 'rsa', 'fa758415-6fe8-4313-b599-643292361e3d', 'rsa', 'org.keycloak.keys.KeyProvider', 'fa758415-6fe8-4313-b599-643292361e3d', NULL);
INSERT INTO component VALUES ('6b95677d-2e84-4f6f-961f-93dafc2ef8c2', 'hmac-generated', 'fa758415-6fe8-4313-b599-643292361e3d', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'fa758415-6fe8-4313-b599-643292361e3d', NULL);
INSERT INTO component VALUES ('a91d3371-1743-47f0-ad58-d09ac94ccc63', 'Trusted Hosts', 'fa758415-6fe8-4313-b599-643292361e3d', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'fa758415-6fe8-4313-b599-643292361e3d', 'anonymous');
INSERT INTO component VALUES ('8d0d1552-342d-4a10-9f04-4e3da8c163bc', 'Consent Required', 'fa758415-6fe8-4313-b599-643292361e3d', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'fa758415-6fe8-4313-b599-643292361e3d', 'anonymous');
INSERT INTO component VALUES ('0c0a4a8f-60e3-436c-9ccc-7bf559a3e23f', 'Full Scope Disabled', 'fa758415-6fe8-4313-b599-643292361e3d', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'fa758415-6fe8-4313-b599-643292361e3d', 'anonymous');
INSERT INTO component VALUES ('1d391dd5-a5e5-43c9-b15a-df2db70f7539', 'Max Clients Limit', 'fa758415-6fe8-4313-b599-643292361e3d', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'fa758415-6fe8-4313-b599-643292361e3d', 'anonymous');
INSERT INTO component VALUES ('94b0c0db-0d9b-4bdc-9921-d05c09c2ede3', 'Allowed Protocol Mapper Types', 'fa758415-6fe8-4313-b599-643292361e3d', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'fa758415-6fe8-4313-b599-643292361e3d', 'anonymous');
INSERT INTO component VALUES ('694bfd8b-c229-4f5a-9219-60a755ea586a', 'Allowed Client Templates', 'fa758415-6fe8-4313-b599-643292361e3d', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'fa758415-6fe8-4313-b599-643292361e3d', 'anonymous');
INSERT INTO component VALUES ('4684b3a7-abfa-43ae-b462-77d26cc600a4', 'Allowed Protocol Mapper Types', 'fa758415-6fe8-4313-b599-643292361e3d', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'fa758415-6fe8-4313-b599-643292361e3d', 'authenticated');
INSERT INTO component VALUES ('adedde97-0a0e-4b9e-9e2c-0322a8985e79', 'Allowed Client Templates', 'fa758415-6fe8-4313-b599-643292361e3d', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'fa758415-6fe8-4313-b599-643292361e3d', 'authenticated');
INSERT INTO component VALUES ('c3a9528a-5cb8-4bcf-aeee-4e2e99ca7312', 'Trusted Hosts', 'FidCash', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'FidCash', 'anonymous');
INSERT INTO component VALUES ('667961d0-5f17-438a-8c88-083ac474a594', 'Consent Required', 'FidCash', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'FidCash', 'anonymous');
INSERT INTO component VALUES ('2acd0902-6370-4ecd-97b3-800a0f75aa55', 'Full Scope Disabled', 'FidCash', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'FidCash', 'anonymous');
INSERT INTO component VALUES ('65ddef6b-aa8d-4c4e-ba10-15495c05adaf', 'Max Clients Limit', 'FidCash', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'FidCash', 'anonymous');
INSERT INTO component VALUES ('82d9d641-2cef-449e-91bb-f04d03585cfb', 'Allowed Protocol Mapper Types', 'FidCash', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'FidCash', 'anonymous');
INSERT INTO component VALUES ('b60c1e22-020a-47a6-83d7-b11a27230e8a', 'Allowed Client Templates', 'FidCash', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'FidCash', 'anonymous');
INSERT INTO component VALUES ('3803a521-a51a-4e75-9e14-b7073e229697', 'Allowed Protocol Mapper Types', 'FidCash', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'FidCash', 'authenticated');
INSERT INTO component VALUES ('c27fafab-1c99-48c5-ade9-0a3752a59762', 'Allowed Client Templates', 'FidCash', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'FidCash', 'authenticated');
INSERT INTO component VALUES ('609655d0-3d1b-4100-92df-a9017238326c', 'rsa-generated', 'FidCash', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'FidCash', NULL);
INSERT INTO component VALUES ('24ea3a95-5bb4-4ba5-a6f5-7e0f147b0e58', 'hmac-generated', 'FidCash', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'FidCash', NULL);


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO component_config VALUES ('5c5761c9-9fca-4e52-890e-2e0c01374bdc', '54e07573-e55e-4509-9b44-3faeda551d93', 'host-sending-registration-request-must-match', 'true');
INSERT INTO component_config VALUES ('d953c297-efaf-4906-b6b8-58a31824c570', '54e07573-e55e-4509-9b44-3faeda551d93', 'client-uris-must-match', 'true');
INSERT INTO component_config VALUES ('6b845b59-cded-4553-a292-01a12bcf450d', '5e1c7424-b08a-496e-ad28-58584a6c967b', 'max-clients', '200');
INSERT INTO component_config VALUES ('6f4a3100-1638-47a0-8658-5013c8cbf5a8', '1a9e9e69-28b4-4dd7-87fd-f676613e5abe', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO component_config VALUES ('9b416462-17a6-4f5d-976f-f66191d2930d', '1a9e9e69-28b4-4dd7-87fd-f676613e5abe', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO component_config VALUES ('4d0a8738-65c7-475c-8d66-ae90a3aa58cd', '1a9e9e69-28b4-4dd7-87fd-f676613e5abe', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO component_config VALUES ('6ee04069-cc5e-4167-9ba2-d00d6b0c6add', '1a9e9e69-28b4-4dd7-87fd-f676613e5abe', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO component_config VALUES ('a01e36f4-700f-47d3-805c-68ed33a63954', '1a9e9e69-28b4-4dd7-87fd-f676613e5abe', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO component_config VALUES ('2724a87b-991a-4820-8198-f1400a144e38', '1a9e9e69-28b4-4dd7-87fd-f676613e5abe', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO component_config VALUES ('07d5431e-20cf-4f0a-84e0-5584a315b390', '1a9e9e69-28b4-4dd7-87fd-f676613e5abe', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO component_config VALUES ('3c06b511-fed1-43cd-ab2c-94db7a75609c', '1a9e9e69-28b4-4dd7-87fd-f676613e5abe', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO component_config VALUES ('9a7811b3-015c-48a0-b3a7-06269ce18cb0', '1a9e9e69-28b4-4dd7-87fd-f676613e5abe', 'consent-required-for-all-mappers', 'true');
INSERT INTO component_config VALUES ('25780216-e5b7-4173-ad52-641e66e9f9ed', '47f2595b-95bc-441c-a7f6-3e1dbc4ac31c', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO component_config VALUES ('465f7851-5a58-463f-a8f5-773b9c3cc169', '47f2595b-95bc-441c-a7f6-3e1dbc4ac31c', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO component_config VALUES ('a2e17f07-4e7a-41c1-8813-b3c8418d674c', '47f2595b-95bc-441c-a7f6-3e1dbc4ac31c', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO component_config VALUES ('fbf1f559-0fb8-4cd1-af99-7c53e4fabc04', '47f2595b-95bc-441c-a7f6-3e1dbc4ac31c', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO component_config VALUES ('134a2ab3-72e2-47b6-b377-dc2d01d5a10f', '47f2595b-95bc-441c-a7f6-3e1dbc4ac31c', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO component_config VALUES ('75169d90-c4a9-4cd7-b270-99d1b6ffe3c2', '47f2595b-95bc-441c-a7f6-3e1dbc4ac31c', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO component_config VALUES ('be940416-acd1-43ff-b2ae-ce7a507222bf', '47f2595b-95bc-441c-a7f6-3e1dbc4ac31c', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO component_config VALUES ('3a5960c5-a52b-4c89-b33e-1aa3671f4d05', '47f2595b-95bc-441c-a7f6-3e1dbc4ac31c', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO component_config VALUES ('37a7343b-7b14-41c1-8d46-05e0e8dd2321', '47f2595b-95bc-441c-a7f6-3e1dbc4ac31c', 'consent-required-for-all-mappers', 'true');
INSERT INTO component_config VALUES ('e19ff4fb-d22b-4e1e-9d4e-947d9fb04039', '8de4ab23-9fca-44b4-8ddb-159882d2c469', 'privateKey', 'MIIEowIBAAKCAQEAoC13mbNr6QMUrksVu8L81tKviSdKw3xauUmCLBFC9g242ayqfU9+1WjumpWJAorS0o+xh8CJIxeXd1AYxil3lOJ3tT8Q6IvMT7sR67LsO0QL7gNf06hAobkQ5pPk/IVqwv/P6da/rjTZ4hVhqr2HrKu2LzOZxVQG1qoZMwank7wWWBfVeUFuPYXZ38LSCH0k7bX6445jLPZU2dxCdn8rp2A7nvTZ4PNi/J4m9yZ85ISiosQ/rFLCAZ0+nJ1VUNICZs10KYey0SQ5khp7DObzVVtIgjNy2u1Tck8YooiAVrKI0m1RFJbL9pn/FypqcsI6G74AUh8EUFzoJ/T/YEkeDQIDAQABAoIBACFIkVuczsWCYF+/Nmrnn4Y8DUGgqoZoZqmtvqDNjW53d3uzx1F2nVJXFY2FmQywMBKUzTz6IwTpuA2Q1TUIFNMZI+rDig3oTrIamySw7yl5gEka5mSix5tTS1G+VYyrZH3Uji129CmMzeGOs9a4v2J/48F3JXK9fRZKDiZuMZAe5v9y6l312o3VbloQPyl1rKRwXBMXht2+PW0sybmrlmF8IkxfNixxSSSZ90DhFVncxj0+iP+qENfNQk7tjoNHaDZBpLMRRJkdGqbT2JkVN05V5Sv+5+VAO1T99VVkdRgvnvBKeHyF5X0cr/AkD4qFiUMdipc6Bpsp91WPEqcRf4ECgYEA0+96aa4Qy5FjDOWYug+5nCCZ/VMUt9ypPo4v6S4P7RkF/3tfdkAg3nfAL1bgmCoNPCpPUN8wYjNWzhDe/4Ac4glc6uBKgXQj2g8IeKbjhrjjL4Ax5v4eORn2vD0XU6dE3MV3kZX+0npFawrqvrwjEmnIWMRqRaOTgLLJwGhIPZECgYEAwXsdSv4OEuf9uezEvvJk5mqV6KuqZWV8Nk1JMBFUb8AyYseN+OVfU8uHdWkmKDKgAOHdcuB6FEZ4x8SheJO56S2xmWbnZu6os1rx1j3mis9tsUdowMJM7huQTLFa3sWFrPRh5p1XTpZE6whND7YTONPINHQqdxE8Z6eUSfHMCr0CgYEAwnJo7McQj8U/jJimzKca070xq7PrQVoKSeOo35csc4vO7f1is5rYzWQvhv99pv6GEBp9lSSBPsf9r6jZALCpT1Xp03GfyjAlqK68Rf5QqM2/W1iR8G5cimVg9IpUeaLxUmE2d/OXzcLzJ+fnQsJYp084ywDCxEv1TFI9OvQyu5ECgYAdITcQ0l02FX2K343jncT5N/Tn+eiGqZfg6RPqy8Elrg8n9hl27rnCePMlBza6eJzEZT0dDZTztoR6ty0EZWFpLPr/OJIAWlBF6JxegCVUotRGC5VG6DoC411/Xnhq79wnZQfUW74IU/F+XVqU0fnk5WXQF+lI0eyBQqa910y8FQKBgFsooro/ozChPAsktw62TRqjMb2+/s/8Hy2sQkJFtvt+6KLbV5WkzBJKcaV7cWvNueN/2x93xFjW+TzHAHwPpvKmwAJxlbiOQlG0E9DGrBS54SotnGkGcP5AqeDX/L8yeZ9Gzj2Rp1PnOgxtduYoWIc09G4kHToCzRldLbxOBYMN');
INSERT INTO component_config VALUES ('8bacb624-6688-4466-b26e-95a98c939ed4', '8de4ab23-9fca-44b4-8ddb-159882d2c469', 'certificate', 'MIICmzCCAYMCBgFasp8U6TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMTcwMzA5MTAyOTE0WhcNMjcwMzA5MTAzMDU0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCgLXeZs2vpAxSuSxW7wvzW0q+JJ0rDfFq5SYIsEUL2DbjZrKp9T37VaO6alYkCitLSj7GHwIkjF5d3UBjGKXeU4ne1PxDoi8xPuxHrsuw7RAvuA1/TqEChuRDmk+T8hWrC/8/p1r+uNNniFWGqvYesq7YvM5nFVAbWqhkzBqeTvBZYF9V5QW49hdnfwtIIfSTttfrjjmMs9lTZ3EJ2fyunYDue9Nng82L8nib3JnzkhKKixD+sUsIBnT6cnVVQ0gJmzXQph7LRJDmSGnsM5vNVW0iCM3La7VNyTxiiiIBWsojSbVEUlsv2mf8XKmpywjobvgBSHwRQXOgn9P9gSR4NAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABYF7gJzV7A41Xuq/upeHGa/bwMU0udCzxC9nLpjNDHJuUlZdSYXOBBR46NM9hqHKv2DHU/eda+qFmyz8sLGbSSMVMUU4LWUIxjKS+cu+lFlKuZ9+ADRK/AczdWUpRJKMMa2/wn5LLEv6bFXMjJ9GRjwSLlxLsnNekLXrACYgVnuU60LGkMe00VxOLCilVs4Ho1LPTOUNSujERu/XmUIVX0DUkcuEbGr4/bG3irBCdDPBoLD+MsEQL0qEc8gr8nWuhn56mRUTp+W9Dc1HHWqxiuubIbAJn9R/WbhvxFJmNpuV3fMr+n89g3eCWYGSBNUxaDtoj+YvyoEW37jvjBkn00=');
INSERT INTO component_config VALUES ('b3af2b53-d817-4198-8865-f66338445e08', '8de4ab23-9fca-44b4-8ddb-159882d2c469', 'priority', '100');
INSERT INTO component_config VALUES ('14223174-4a5c-4027-b163-e00979252eeb', '038159ed-6d42-48a6-9f7d-9b2f30a28efd', 'kid', 'e18a149c-c05c-4fa8-b320-0d10ccda7a4b');
INSERT INTO component_config VALUES ('e90c24d8-4ac5-4468-9999-f6f0239a4e6a', '038159ed-6d42-48a6-9f7d-9b2f30a28efd', 'secret', 'fWy-e6JkymHyVcKn3ekHK6-BDPERSrmUE-OWT230R4w');
INSERT INTO component_config VALUES ('94964220-6a56-4717-a291-8760b55af177', '038159ed-6d42-48a6-9f7d-9b2f30a28efd', 'priority', '100');
INSERT INTO component_config VALUES ('8e10598c-8cb3-470b-8628-8906cf9303db', 'a908a3bc-2dc5-43c2-b261-a97e7aea9bcd', 'host-sending-registration-request-must-match', 'true');
INSERT INTO component_config VALUES ('0b895266-18ad-4ed4-b30e-86effb6102a4', 'a908a3bc-2dc5-43c2-b261-a97e7aea9bcd', 'client-uris-must-match', 'true');
INSERT INTO component_config VALUES ('337b42ea-e4fa-452c-be28-e17700b5abb2', 'c7eb3b50-b48f-4359-a0b9-67e2c7fd5721', 'max-clients', '200');
INSERT INTO component_config VALUES ('1e8d4549-cf3a-4e24-a387-a2eab01ad494', 'e4c31105-4d6f-4ff8-b99b-95d2ac7154be', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO component_config VALUES ('120e31d3-7e5c-4485-bca8-a8bfe6fded67', 'e4c31105-4d6f-4ff8-b99b-95d2ac7154be', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO component_config VALUES ('0a7f1de5-56e6-42d4-b3ad-7a37bbef9987', 'e4c31105-4d6f-4ff8-b99b-95d2ac7154be', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO component_config VALUES ('13dad312-8221-4457-8c09-2d70a3bf389d', 'e4c31105-4d6f-4ff8-b99b-95d2ac7154be', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO component_config VALUES ('b6460ee1-45b0-4213-b56a-715a500dc5d8', 'e4c31105-4d6f-4ff8-b99b-95d2ac7154be', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO component_config VALUES ('cff11a3d-fb9d-416f-b1c5-70f4dca853d1', 'e4c31105-4d6f-4ff8-b99b-95d2ac7154be', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO component_config VALUES ('5fc2277d-ed2d-433e-b896-64bed94bf856', 'e4c31105-4d6f-4ff8-b99b-95d2ac7154be', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO component_config VALUES ('721e21d3-a11c-4380-abbb-94239a538084', 'e4c31105-4d6f-4ff8-b99b-95d2ac7154be', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO component_config VALUES ('d0ffea8a-19d0-433d-ae77-689f4a9283e7', 'e4c31105-4d6f-4ff8-b99b-95d2ac7154be', 'consent-required-for-all-mappers', 'true');
INSERT INTO component_config VALUES ('2f113710-a9c8-4843-b08f-d8d938c7d593', '80d5a93f-6a70-41f8-993b-48c405a1d80d', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO component_config VALUES ('259bd3dd-6c61-4567-9ed0-94df6e9b46b6', '80d5a93f-6a70-41f8-993b-48c405a1d80d', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO component_config VALUES ('17322530-6b30-49da-9376-17f3329bebdc', '80d5a93f-6a70-41f8-993b-48c405a1d80d', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO component_config VALUES ('bc3081b9-f97a-4606-b404-3750e0c86fe0', '80d5a93f-6a70-41f8-993b-48c405a1d80d', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO component_config VALUES ('dbe651b2-5e62-4cca-bcb7-d5c78b1b0897', '80d5a93f-6a70-41f8-993b-48c405a1d80d', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO component_config VALUES ('44532046-1896-4269-8265-84fe8ca6d000', '80d5a93f-6a70-41f8-993b-48c405a1d80d', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO component_config VALUES ('2c93f81b-e4fb-40d1-8a2e-0c977426207d', '80d5a93f-6a70-41f8-993b-48c405a1d80d', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO component_config VALUES ('d2d1a459-9eb1-402d-98b1-b0cee73ce422', '80d5a93f-6a70-41f8-993b-48c405a1d80d', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO component_config VALUES ('0158dfde-49f1-49f0-9a20-5d843a6161e4', '80d5a93f-6a70-41f8-993b-48c405a1d80d', 'consent-required-for-all-mappers', 'true');
INSERT INTO component_config VALUES ('752e4cea-2a96-4dfb-8151-33a5673b26ea', '26433f9d-7a11-4494-abd2-2123f82cedfb', 'privateKey', 'MIIEowIBAAKCAQEA1y3OTbib5WcnlMnvr5SDZZ3jS9wsPIBHQYx1aUJYMNKGQtHTNzydIbaWQXSHpXsWKXatjCu1yglkUh0+AepiZD9274f4iAsmjuLb4s1N8kMK1r0WDlR0xq9epVEYlTrFu3gC5e3yyKV9vfkIFjFE/cjy0AQTAZg8DJGsFlQRlybF2qQXQQG4skuPnjAFGn/7uWqM7yLkLUr7Ov/XbBAcnojnUlakEsahE6lDMz1nOzfJTwxXMWM4imR1nMEDkZY7UJKw0/6oiJWgzgLFP8wjj/yqfjPFGzIkCrUzXx3lexzxoHMgC52R5XhoESOrT96ACbbxwV9e+SrBulFPsDhvGwIDAQABAoIBAC46qRgJkXS3tMlCmTwfrBso0Kx7oQVeifCLPK5gkpHqqO2yJq63VwrnL2DgqEPlLd26oY571ZKScfsyTSAcOwdOmz7a94pC2wXXt2YCtbxWqv13okVx36TQCIV75swo1FJydizv8jkpVNp7pkEeVLQxd/k45txw2HXa1h318dGHHg1pakBAzvATZTXDL4jhb95WHMend5xWvF5heTjA19J3hb8m1wIAG2g+vyizXlWZLD88BH6Ay4OTaYAZTp3vPWnyX44K+AEcvsBFB3b+VZ2uGhhgyHrFjsvneiCsTk40B5EzYazPYR7tVizi8VqFrzXTIpeFs6givWLq0GmA2AECgYEA9CLBwAs8qIziF/N6GaBDTHRYRUbnTt6pYwOw7fDzu1S+9XGuEPdnI6vGXZAOP5k69nXsu0CyjKuVOUu8adgADvRRaJ2xDiypepBWg2OAwPuLsrL2+qj/ozYTAkmWnm6LrvO6901gc1Cvoxy0ltgLSQXOd5DqckpFyvM7lO4oEdcCgYEA4aLNi/rOGJEBhEzin58qMsPMjO8jKQUPsNmsvMkusmRGA4Bt/Ws+X5TK6Gk/UVxS5i+qA5p8ICeOaoHW83vz7jrN6MlP0f50TB0Ft3XJ/f9toGdCAvaYurHmvJKAmu5FOm8jc8tPe/5pjJ+dE1m7w+WcZaHCr1c25mJH/wsPLF0CgYEAm3z3gWSmwYLZDQAZJ/EWa7896QF7mJPfthxHt4Pa99jFtnUss8meeu2QbU6uhHsHPqlkmO5fyZAOfmtqGM9lWiDpKIQmnCx91H3RW+Unv8F1+95XxtWT21M5UB+mOkmV1VuOHKu/XjJpaq2BpwD6TwvPr/8wEpKTWOsJa5UzGAkCgYBCtK3N11z8uEnZgh1xkU2ZandbpwsfAmcMIp5FxbhvduOX/20FAaKUAVoncY4NkJzVfnvlytMtcmRRKoeQvjF0WaAsVO+rJm3dXqsk/Ma1t8ECLeS/GYY3k4aiczFgHFcNGnRBtHaQMrujnkCCywGOvaAKD9ONoNwTKjUcunlG5QKBgBYZPu5WFajrKHa/yU2xkCbcCHgnfGQ1JA1MFYMPhYPgTcqwk/qttZWz8Z7Om9Ae0DSXlEW3u6Q9lh9cAMOrfMXOTSiWzzFmep5/kuEx1Lz4mKzDIo/9BP5Atz7WZc5PeRrWZCnCew1CkfsSB/vr+lg2xsYnAMylwvT2cmhXbLSe');
INSERT INTO component_config VALUES ('c458e32f-dd02-4398-b084-0be91db3f462', '26433f9d-7a11-4494-abd2-2123f82cedfb', 'certificate', 'MIICnzCCAYcCBgFaQMYfLTANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhwYXJ0bmVyczAeFw0xNzAyMTUwNzU1MTBaFw0yNzAyMTUwNzU2NTBaMBMxETAPBgNVBAMMCHBhcnRuZXJzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1y3OTbib5WcnlMnvr5SDZZ3jS9wsPIBHQYx1aUJYMNKGQtHTNzydIbaWQXSHpXsWKXatjCu1yglkUh0+AepiZD9274f4iAsmjuLb4s1N8kMK1r0WDlR0xq9epVEYlTrFu3gC5e3yyKV9vfkIFjFE/cjy0AQTAZg8DJGsFlQRlybF2qQXQQG4skuPnjAFGn/7uWqM7yLkLUr7Ov/XbBAcnojnUlakEsahE6lDMz1nOzfJTwxXMWM4imR1nMEDkZY7UJKw0/6oiJWgzgLFP8wjj/yqfjPFGzIkCrUzXx3lexzxoHMgC52R5XhoESOrT96ACbbxwV9e+SrBulFPsDhvGwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBismnzZu3ZcDFPc+Joibjf1/UCjnyIDtweeHB1yzl+5G0Y24OiSXAdG7Hv0+qpYkDAPsmMABgtGHNtkJX37xi5AIlqq99W9I1nyECMrdNBytKYmh9lx4wM+VnekFn+uvAWGtKYukvMPkLxKpXzOVmuLshVSOVL/knKWS+FYtBv+nMEc/nlSl1gduaNFryjWAXdeaiF7qxTPatKq64MkUXXP/5o5SDQhHnN/sg8AjZ59HWgrNwJo0k/Uh80YtPyuc0HkUaiABVoob6hNiMDyakACIOxU1J2N41zdwFEyJbcqUIQEaDDr3fZ3ZFs9OdTOI3723J3AUIvpIBzLFLx0CWy');
INSERT INTO component_config VALUES ('47dcc181-94ff-4090-9a72-77864601ab6b', '26433f9d-7a11-4494-abd2-2123f82cedfb', 'priority', '100');
INSERT INTO component_config VALUES ('22d40ac5-d39c-4c40-b09c-0bd69f502274', '17a00c00-220e-4924-baad-8d6217281821', 'kid', '2f2d8923-caed-4cfb-a7de-1600f15c6284');
INSERT INTO component_config VALUES ('e8672bd5-0aa7-41e5-8ba7-30397391f933', '17a00c00-220e-4924-baad-8d6217281821', 'secret', '1e7Cjtda0n7ceDDI4HppGac4VYMhig8NcGF-sD0GE3M');
INSERT INTO component_config VALUES ('e52d6546-e8c5-4f8d-b3a3-e40016ba6666', '17a00c00-220e-4924-baad-8d6217281821', 'priority', '100');
INSERT INTO component_config VALUES ('ac3c553a-47ac-4d89-945a-bc5d95707855', 'd5b76f5c-9909-4e84-8d49-eeb7b7cec1b4', 'privateKey', 'MIICXAIBAAKBgQCrVrCuTtArbgaZzL1hvh0xtL5mc7o0NqPVnYXkLvgcwiC3BjLGw1tGEGoJaXDuSaRllobm53JBhjx33UNv+5z/UMG4kytBWxheNVKnL6GgqlNabMaFfPLPCF8kAgKnsi79NMo+n6KnSY8YeUmec/p2vjO2NjsSAVcWEQMVhJ31LwIDAQABAoGAfmO8gVhyBxdqlxmIuglbz8bcjQbhXJLR2EoS8ngTXmN1bo2L90M0mUKSdc7qF10LgETBzqL8jYlQIbt+e6TH8fcEpKCjUlyq0Mf/vVbfZSNaVycY13nTzo27iPyWQHK5NLuJzn1xvxxrUeXI6A2WFpGEBLbHjwpx5WQG9A+2scECQQDvdn9NE75HPTVPxBqsEd2z10TKkl9CZxu10Qby3iQQmWLEJ9LNmy3acvKrE3gMiYNWb6xHPKiIqOR1as7L24aTAkEAtyvQOlCvr5kAjVqrEKXalj0Tzewjweuxc0pskvArTI2Oo070h65GpoIKLc9jf+UA69cRtquwP93aZKtW06U8dQJAF2Y44ks/mK5+eyDqik3koCI08qaC8HYq2wVl7G2QkJ6sbAaILtcvD92ToOvyGyeE0flvmDZxMYlvaZnaQ0lcSQJBAKZU6umJi3/xeEbkJqMfeLclD27XGEFoPeNrmdx0q10Azp4NfJAY+Z8KRyQCR2BEG+oNitBOZ+YXF9KCpH3cdmECQHEigJhYg+ykOvr1aiZUMFT72HU0jnmQe2FVekuG+LJUt2Tm7GtMjTFoGpf0JwrVuZN39fOYAlo+nTixgeW7X8Y=');
INSERT INTO component_config VALUES ('48dc85d8-badb-4277-8ab1-790abe05e5df', 'd5b76f5c-9909-4e84-8d49-eeb7b7cec1b4', 'certificate', 'MIIBlTCB/wIGAVqynymKMA0GCSqGSIb3DQEBCwUAMBExDzANBgNVBAMMBmFwaW1hbjAeFw0xNzAzMDkxMDI5MTlaFw0yNzAzMDkxMDMwNTlaMBExDzANBgNVBAMMBmFwaW1hbjCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAq1awrk7QK24Gmcy9Yb4dMbS+ZnO6NDaj1Z2F5C74HMIgtwYyxsNbRhBqCWlw7kmkZZaG5udyQYY8d91Db/uc/1DBuJMrQVsYXjVSpy+hoKpTWmzGhXzyzwhfJAICp7Iu/TTKPp+ip0mPGHlJnnP6dr4ztjY7EgFXFhEDFYSd9S8CAwEAATANBgkqhkiG9w0BAQsFAAOBgQCl359JImzzhoHFOwzvfeQPLJX6/96FYuGbjfr/TnHBZ+qb5FwvoodvJjS1BqAo4be6SiezftoWr5dQktLrIvA+jBJMtJuVX8YjkbUSBVrWsnaSsXKLNdXGRC4qyq+0YuqZwupOZgQaEeK+sUGREvChnsxGvd/2J/NADUL8Sg5xlQ==');
INSERT INTO component_config VALUES ('3f39049d-0cc5-4f9c-b180-2e895087a8ee', 'd5b76f5c-9909-4e84-8d49-eeb7b7cec1b4', 'priority', '100');
INSERT INTO component_config VALUES ('5648128f-599a-4461-adf0-e344f3dfb78a', '6b95677d-2e84-4f6f-961f-93dafc2ef8c2', 'kid', '8c6c73fe-e2e8-474f-933b-a2224e1c04e8');
INSERT INTO component_config VALUES ('13a93021-d237-4db5-af9d-8d939dbd3282', '6b95677d-2e84-4f6f-961f-93dafc2ef8c2', 'secret', 'ZCvM0XJjyOtS0j3zCifVsX3Z3Fw8QlXWRHNy7hYe13c');
INSERT INTO component_config VALUES ('e2a225c4-c0a0-4a42-83f5-9a9bea8e5ab3', '6b95677d-2e84-4f6f-961f-93dafc2ef8c2', 'priority', '100');
INSERT INTO component_config VALUES ('dd1d8627-521b-4178-93f0-9c3a08b7bbf1', 'a91d3371-1743-47f0-ad58-d09ac94ccc63', 'host-sending-registration-request-must-match', 'true');
INSERT INTO component_config VALUES ('1df0583b-f551-41e2-ab30-9e317a62b1be', 'a91d3371-1743-47f0-ad58-d09ac94ccc63', 'client-uris-must-match', 'true');
INSERT INTO component_config VALUES ('442b55d2-82a5-49d8-a76a-2566ed52eabb', '1d391dd5-a5e5-43c9-b15a-df2db70f7539', 'max-clients', '200');
INSERT INTO component_config VALUES ('89a044e7-535a-4a7a-998e-df211ad37759', '94b0c0db-0d9b-4bdc-9921-d05c09c2ede3', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO component_config VALUES ('679899cb-04c9-40d2-b141-96cad9765eed', '94b0c0db-0d9b-4bdc-9921-d05c09c2ede3', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO component_config VALUES ('787e5d12-8f27-4abd-a0ad-71af8d95e7f1', '94b0c0db-0d9b-4bdc-9921-d05c09c2ede3', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO component_config VALUES ('7d0aa873-62f4-48e0-a3ab-f814e97f768e', '94b0c0db-0d9b-4bdc-9921-d05c09c2ede3', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO component_config VALUES ('3694f0ce-c0c4-4bda-8607-9923a698a3e2', '94b0c0db-0d9b-4bdc-9921-d05c09c2ede3', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO component_config VALUES ('3d510000-a3b1-4207-8031-0c762999b0e6', '94b0c0db-0d9b-4bdc-9921-d05c09c2ede3', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO component_config VALUES ('2fdfbc63-15f9-4f1e-bbf2-6820efb79da8', '94b0c0db-0d9b-4bdc-9921-d05c09c2ede3', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO component_config VALUES ('d39693c0-8d64-4307-a5e7-30f9516796e7', '94b0c0db-0d9b-4bdc-9921-d05c09c2ede3', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO component_config VALUES ('9e4aa466-1f59-4dfb-a808-2a82396508f2', '94b0c0db-0d9b-4bdc-9921-d05c09c2ede3', 'consent-required-for-all-mappers', 'true');
INSERT INTO component_config VALUES ('2ab50153-0de5-45b1-8dea-88de36451b1b', '4684b3a7-abfa-43ae-b462-77d26cc600a4', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO component_config VALUES ('0b978951-03ee-405f-9f16-ff7837fc75cd', '4684b3a7-abfa-43ae-b462-77d26cc600a4', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO component_config VALUES ('81e2ce1d-e16f-4927-8df4-f2de402a6876', '4684b3a7-abfa-43ae-b462-77d26cc600a4', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO component_config VALUES ('08cab7e6-8334-4173-8022-a85cefe3d150', '4684b3a7-abfa-43ae-b462-77d26cc600a4', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO component_config VALUES ('cb6886d4-c75c-46b4-8842-116bb366d004', '4684b3a7-abfa-43ae-b462-77d26cc600a4', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO component_config VALUES ('af7f78f4-5595-4788-a8ab-031af9cdbccd', '4684b3a7-abfa-43ae-b462-77d26cc600a4', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO component_config VALUES ('18df2c65-88c5-4916-b4a5-5629853f49e7', '4684b3a7-abfa-43ae-b462-77d26cc600a4', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO component_config VALUES ('607c186c-3bfe-4f6d-9adf-42c19fe00139', '4684b3a7-abfa-43ae-b462-77d26cc600a4', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO component_config VALUES ('8a01131e-801a-4cc5-9a62-ad77334349c5', '4684b3a7-abfa-43ae-b462-77d26cc600a4', 'consent-required-for-all-mappers', 'true');
INSERT INTO component_config VALUES ('733aa8ac-42bd-4dce-91ab-03a14794db43', 'c3a9528a-5cb8-4bcf-aeee-4e2e99ca7312', 'host-sending-registration-request-must-match', 'true');
INSERT INTO component_config VALUES ('3d49c33c-70cc-46af-8ca7-fe919224c701', 'c3a9528a-5cb8-4bcf-aeee-4e2e99ca7312', 'client-uris-must-match', 'true');
INSERT INTO component_config VALUES ('6b436689-d0ae-46a4-91b4-36616e610804', '65ddef6b-aa8d-4c4e-ba10-15495c05adaf', 'max-clients', '200');
INSERT INTO component_config VALUES ('53bdc3e9-6987-4327-92b1-89635532b404', '82d9d641-2cef-449e-91bb-f04d03585cfb', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO component_config VALUES ('71b6b2e1-cc5b-4afa-a24f-27881f1ce0e6', '82d9d641-2cef-449e-91bb-f04d03585cfb', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO component_config VALUES ('02afbe02-0a23-4be1-87c5-28c7e35cedaf', '82d9d641-2cef-449e-91bb-f04d03585cfb', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO component_config VALUES ('36f8d27e-51b6-443e-a95d-d85582ec4878', '82d9d641-2cef-449e-91bb-f04d03585cfb', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO component_config VALUES ('63504a1d-0c4d-4c53-9db8-2015aaa247f2', '82d9d641-2cef-449e-91bb-f04d03585cfb', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO component_config VALUES ('24ee94c3-624e-496a-8a02-951b811c3de9', '82d9d641-2cef-449e-91bb-f04d03585cfb', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO component_config VALUES ('db17d1e1-783d-4543-b78c-5c0224c601fa', '82d9d641-2cef-449e-91bb-f04d03585cfb', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO component_config VALUES ('abb71af9-2fc3-41cb-b632-c9b70859803c', '82d9d641-2cef-449e-91bb-f04d03585cfb', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO component_config VALUES ('916cee8c-74ec-4684-819a-3d83f5a0bb0a', '82d9d641-2cef-449e-91bb-f04d03585cfb', 'consent-required-for-all-mappers', 'true');
INSERT INTO component_config VALUES ('46fe6275-9529-4300-b6e7-2e9e92d68cc8', '3803a521-a51a-4e75-9e14-b7073e229697', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO component_config VALUES ('a072f35b-de34-417c-aff1-94d308a6130b', '3803a521-a51a-4e75-9e14-b7073e229697', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO component_config VALUES ('e451fc49-f8fd-4bec-b30b-344e0c0e954d', '3803a521-a51a-4e75-9e14-b7073e229697', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO component_config VALUES ('033c32f3-697f-44d6-98d7-42ce5044b9de', '3803a521-a51a-4e75-9e14-b7073e229697', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO component_config VALUES ('720a1baa-0205-4bf2-aad1-b0b9b8c024a7', '3803a521-a51a-4e75-9e14-b7073e229697', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO component_config VALUES ('e12f5525-6a5a-4f7e-a3e2-2a61d060e541', '3803a521-a51a-4e75-9e14-b7073e229697', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO component_config VALUES ('051d51e0-8892-4875-8218-fc6a1ed56b38', '3803a521-a51a-4e75-9e14-b7073e229697', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO component_config VALUES ('dd45f68f-2843-4e5b-8aed-6ad37986d4f2', '3803a521-a51a-4e75-9e14-b7073e229697', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO component_config VALUES ('7a051710-d298-4308-872b-14590da03d10', '3803a521-a51a-4e75-9e14-b7073e229697', 'consent-required-for-all-mappers', 'true');
INSERT INTO component_config VALUES ('3b59b687-2384-4427-9049-95c550628dc8', '609655d0-3d1b-4100-92df-a9017238326c', 'privateKey', 'MIIEowIBAAKCAQEAhTbRbu3rcI9OO8dey8fI7sKwxlrhPs9DOSYOqn+guTMAJcQWe+YT9102Tya8htaRDK0LNWR/rkN2hKxxV4HUkqz3cOB/kLR3r9FAzufbc2xsIU3NSs7Js6rcLllPpN0+XBgfLSNADSEb+I2OeKWSTat3EhKwW6X4xposmsvIrRmv4jdvLCPtEjAqOOFLALtm1kP22lEoX9/i0IDc/yNQNgC+cyjNqTcGPIfEmWkJJiM1qBcUH97V1SDJVvT3QPV1yhap/sKkZcARE0Mn63mEPRgRE07ne3Z0Z4v4YkzQ7T3tevqGfoc6YR6jYNiBdC0N8iHUxdNTYijH9/zG9gXdhwIDAQABAoIBAEfF50UrLwTwUShoHK0SsTHi97eHU4CxzvhFhvVZ2lCuJ9AxPCP5LJzEPfSbXEwR4wi/WyCjSx+q/XoyJscNDmkQhCju7AwdD7dMuOxBg71Gl2PCNW+uxoHk9siKGh0rjuOzo2iAa4wnYJikPDTIkHEEhxzXsOlQHR90BcBJN4/7T78z7QonJ9ezdkuM66Do09gA91OXrY5cl7G55GrKkZgEv07XNpkxLIMPKqQO2+Cf0m65IA6ipd3CNneG8pDmPK65U4b8pKXJ4RSdsZBnauJBCpGg8PI0HVFZSUCbn4h2nZD/5Eb2jYUkWaRtJZUiY6LQBPUTFa8hkXh6JTOxJ8ECgYEA7URsjBO0xGC4xXvxaPpkral4A4oNV9Au3dsnbKLNMgcR8xg/AwU/g/VJ0rNzEiDi9aiOw51ZmB37dux1cneWNePYAU+gwUhY3X2kA0IKGQ0OQ1e58Pp4GHbiXbGj6kZna8i34zgNFvEeFTGUM6sfL6EPKpErTGt0Dr+gc0DiYbECgYEAj7tNfPS0VtOTZK/r7img+R1Vaqj/nLkWm2FsAzaSJUxz3fY4ccQk8KMeANbMGn3Z0DZu55L1Yaw9uVq56PvTpTC/FbkQUM4n8hG5Bk/2VUt5HYH2PXz/lKO4a0Z/dWP2UdlBTxw7b7Iq0VCNrKwY/ATN/m3YOF02ftPoDXwMiLcCgYB87Xkl7D5S5AaF3PPIbYbTNZb+bhMGeJQktn60oaffPn/B+rM62OmPhnifW2MsWWqHJIA/GTuSb7726BwS8EqEB3q1fgLLoldAECZqnLwKYqhu5uL9sjPH1djsslr3QKi1xNKl7d5ehQhs6lT5O5HJF0mQBS3CKBXMqjNGXBSWkQKBgDaFelNYD8CP6W1cPkbNi75znh8jlDLDEwxF3E8ruCxl393mtGqTWN/fQFZZJHs4GhOdUlyNpn8ycweIntT+Eb6ryxBWbxX33bc5edInKu4X/w1uaxXQALNFl4M57sd878cEfn2f2/v2vb9Aqz1A2wleWTWWPVrEIRPjFjdnQunpAoGBANA4YXAN4AFu9iuTA7S8h/UUXqkYVxDC2aADZS/Wc7hjcTxrZ5F7ho6I6/HxAdKN944IBaXdI33p1TliRKDdCzTGM3wS+qzdJMmzyo+6nB2KtQXDdqTbb9pAB6SfUk+p7EWfxAJwhemy/vcVHekuYsdic3biKPKCnlRvcM5woVbR');
INSERT INTO component_config VALUES ('948082fb-3b23-4c9d-bbf6-c8ba05985985', '609655d0-3d1b-4100-92df-a9017238326c', 'certificate', 'MIICnTCCAYUCBgFZ20shKTANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdGaWRDYXNoMB4XDTE3MDEyNjE0NTkxMVoXDTI3MDEyNjE1MDA1MVowEjEQMA4GA1UEAwwHRmlkQ2FzaDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIU20W7t63CPTjvHXsvHyO7CsMZa4T7PQzkmDqp/oLkzACXEFnvmE/ddNk8mvIbWkQytCzVkf65DdoSscVeB1JKs93Dgf5C0d6/RQM7n23NsbCFNzUrOybOq3C5ZT6TdPlwYHy0jQA0hG/iNjnilkk2rdxISsFul+MaaLJrLyK0Zr+I3bywj7RIwKjjhSwC7ZtZD9tpRKF/f4tCA3P8jUDYAvnMozak3BjyHxJlpCSYjNagXFB/e1dUgyVb090D1dcoWqf7CpGXAERNDJ+t5hD0YERNO53t2dGeL+GJM0O097Xr6hn6HOmEeo2DYgXQtDfIh1MXTU2Iox/f8xvYF3YcCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEABcVOomIbAruvUSwVtF4nqfcZlLUuZX+DbIj6nedeEG3/wogJ3va0Q7hEvy7pQeIe1/WXoPdgJ8VegvFyyhNVzu7Z6oeE/tYevTIWrZgwqXqZzSbzD1ITZ1wBjZsztTFFbbcXXxICBiIZs66c3Lg8dBzR360FA/8WKbI+0NPgLdqxNT8xR6f5PD2EXY56eBB4VaTN3KuN36EW0dkNDfevvgR+lkRUzaTjBrEfyY/VmXRsE+ah+5+IsadEBudqLwPclgNaKZhQkFAk4WzFAIxj7dePkY+VEupii63CuDqzan1x0zwKWQ5S8RYoD/mXACTRFadVXBnPgKtpBjqpscq/sw==');
INSERT INTO component_config VALUES ('1bcba56e-f955-45d7-8e08-886d2766d0e7', '609655d0-3d1b-4100-92df-a9017238326c', 'priority', '100');
INSERT INTO component_config VALUES ('07145c98-32d6-4da6-97f9-be238f14dd9a', '24ea3a95-5bb4-4ba5-a6f5-7e0f147b0e58', 'kid', 'ba77753c-9b8c-46ff-b341-95239d06b505');
INSERT INTO component_config VALUES ('cc6ad458-b39f-45bd-802c-495c2297db3a', '24ea3a95-5bb4-4ba5-a6f5-7e0f147b0e58', 'secret', '1Zs2pW7FgCbcLu8HzTJf_zKkfnph9ZYS1NWrD2Z1kP4');
INSERT INTO component_config VALUES ('d9952201-9507-4370-b054-3ceac33f60bd', '24ea3a95-5bb4-4ba5-a6f5-7e0f147b0e58', 'priority', '100');


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '54b33529-d22a-4bbc-960f-4afb95c84e75');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '8288f470-023a-496b-bbbe-b2e5bb252eca');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '1e14d609-0e11-400f-8a26-6d3f420358e3');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '24591c17-e501-40c6-b40b-5bc1358aa7d5');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '7b35d9a4-95c4-4107-8c1c-05bea34b6bc6');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '7020121e-5a78-4c14-9066-6d39298bd4b6');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', 'ccf11ddb-e0c9-4792-8b28-96ec336a0609');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '31da9c2a-ee58-48ee-9cae-b76a34e5f9f2');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', 'e4252aa5-1853-4525-ac8a-f73de00b448a');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '37c90ab7-3aff-401e-a66d-9c27d2bc7419');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '188fc61d-19e3-46dd-b33c-faae634cae4b');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '2522dfa3-49b2-4ac4-b785-bbd681c2bbb6');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '0dcb9cd2-5c52-4fe6-b018-d7a25052306b');
INSERT INTO composite_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '5031d0e4-2130-4bcc-ba37-8c20f9c7ec5b');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', '551ed6ef-9409-44bb-b018-a0799df76964');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', '0d56915c-f0ff-497f-ae7d-8783bcf69792');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', 'f552f90c-e9ab-4211-80db-43354e466a2b');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', '4cc5a11a-c369-4dfb-90e0-6767ed8ab530');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', '738fb611-113e-4b0a-a313-f1850a63bdf5');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', '600613d5-ee2c-46ff-8797-df3e4951f046');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', 'f4ca63b2-4050-4f21-bf56-7a6b89beb4c4');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', 'e3f49dc6-569c-4225-ac6b-0835c35fbeba');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', '25f9a3bc-940e-4d26-afe3-e2c40bb36410');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', '43e55c67-5bb3-4849-abdf-2bf14af87f1d');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', 'aa147790-2c86-4d13-8e6f-7777cc4da060');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', '2534840d-d627-455c-81fb-892b7794bc44');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', '5a61940d-3562-4a9c-af1d-cb6be9baa26c');
INSERT INTO composite_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', '9f763615-6036-4c53-93a0-081395117ec8');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', '9b5b9465-81e5-4527-b748-bb576d991dd2');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', 'e0ec5a2d-61c0-4869-a7aa-63a57aa8d179');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', '2034fb26-c6d5-437d-9422-e8cb5c7c3cdb');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', '3a51e8db-95c1-4894-8c19-04ed30fceec2');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', 'c9de5732-8ba5-4ce6-9393-e3f802e4b3cc');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', 'f5ee24c7-1dfa-4a23-b1e3-9bc041d5601e');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', 'e1b21877-5702-48dd-a68a-2cdf71dc735b');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', '2f67cd22-d4db-41bd-aa7e-77fd99de1c2f');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', '35181378-b4d5-4ef1-90ce-00d947ddf48f');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', '83cf4abf-1a0a-4f7a-8e13-7f3f0306fc17');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', 'eca00f5a-b3b9-478c-b978-0137b67be51b');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', '7647de7e-dbde-44c6-8c6f-0d0f21e6f010');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', '03ca8ddd-6f25-4d05-9757-df54ac504fa1');
INSERT INTO composite_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', '71a185bf-c31d-43dd-9345-00ee164e4507');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '14c91ee4-6d0a-4c99-a854-bc1b0266f469');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '0bf5aa62-eab9-463b-a477-b6b27f4bce2f');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'f32511e0-96b1-49d5-b9f2-b7ce9ca90d28');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'ce3602c5-6aa2-4ea9-99ad-997064f278fd');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '587a1710-180c-47f3-a5c0-ca1dd0d6b47c');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'd640f93b-9803-45fe-ade9-30cbeac33622');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'ed9b438e-2624-45ee-bb19-a1f1c9ec69b0');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'b1643986-9b23-4f15-b7b7-1fd250669572');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'e41e1ad5-b083-477e-9098-226d8e838695');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'dd81fc64-e342-43e2-87ca-1595dfb89652');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '2e4357e6-7212-4af3-9e7b-a069a4221de2');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '30aa5562-b42c-4f4f-8b10-64e89576fbda');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '0ab5f2dd-cdb3-432e-a5e0-03b670aea3f1');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '4ad5bef4-1120-4703-a72f-57dfe9eb184c');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '4f768604-3d4b-4e1a-81df-ab9e23844ae1');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '07c76949-474f-476f-a1a7-9f267ab81319');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'bd9212d2-1ccb-412e-844d-0032184e8d9f');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '5698208e-eef1-4483-8065-ec4b0c4214ec');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'c58920b1-87ec-4581-bf7d-6d2d5c43939d');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'b808e06c-40ce-4c2e-b9c2-312ec80f2b26');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '79983404-8a59-4f8f-870a-d7ea54bd8957');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'e0eb44cf-b433-4e21-94a1-7119ce7fa3f5');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'c7f6c634-5787-47f2-823b-9ace7fc36110');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '0493bc74-7443-4203-9127-919438aa99ae');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '10f5b721-d2f7-4d52-953d-50a918b866d9');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'eea7a444-2d3f-4b46-bccd-117adcdc08c0');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'bae03369-0a24-4ca5-aafe-084cba142a2c');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '8317ddd4-5742-42f2-a3e7-11fe53908597');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '8dd17049-c17b-4b19-b565-256dc07740c7');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'd14d6329-1aff-488c-98fe-da6f922a330c');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '3bb793da-b479-4456-a6c5-e17a6198a042');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '68aa7197-e474-410d-8d8b-cd3e27cded3d');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'fa7c5352-bd3b-4dba-9df7-7a9872f3ed48');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '8a1e90c0-cf38-4223-8a3a-f88cefd307ba');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'bbd23e47-a179-462e-a84f-f336cce8b68f');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '70e4784b-339e-4849-91b1-954a472de48a');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'cba034f9-81c7-4d13-8baa-950ab0a24685');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '2a38eef0-1770-4359-835f-e36dd2ffda5c');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'b37ea29f-0e6e-46fe-9358-3c728a3d232d');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'd74bab18-c281-4449-b76b-054bd14fc05d');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'a4c336c1-3bb4-4c0f-a4de-2b12143ed960');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '24ad4ff8-d2e8-49c6-a2e1-dae358bde8d4');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'f908a4e0-8b3a-46b7-a73b-b4068a829548');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'fc156e7b-02b0-411c-be6b-33f398c78e31');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '7f4551e1-e5d0-4f41-938f-2cdeaea9b889');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '69ba84a7-9c7a-4b63-bf9e-aac5f4a77f1a');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '86f8ddfc-b19a-4541-b6c8-6cac8a027463');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '812e60af-384e-4f68-b4e5-6e85fa40c6e2');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '3b93f8d2-f298-430a-83e0-c1ad4326f50a');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'a3688a4e-a0b2-41e7-b645-e16b3882233a');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '8c2fe26e-b768-4923-ab31-0755d629ffe7');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'acb3fc2f-6615-49c8-bb86-bb48ac18aef4');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '43feedfe-2b85-4c8f-b651-c6089753df44');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '284d4171-aeca-4286-b373-8eb9fc2609ed');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '4bc18399-7574-4990-9405-8458ca6e93ac');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '534794c8-bd4c-4a2f-9dd9-f6b3bccca790');
INSERT INTO composite_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', '70afd8bd-cec3-485a-ba8a-0923b0b6fbad');
INSERT INTO composite_role VALUES ('5ebaf50f-278f-4caa-bf2a-a6483ed909c0', 'eb8c248a-0e0f-43eb-ac3d-0fade93c091f');
INSERT INTO composite_role VALUES ('502baf77-40f3-4968-8a6e-8830c0fa8dcd', '1f117d24-bb03-4b10-b319-e6c1e1a2cde5');
INSERT INTO composite_role VALUES ('6d437c34-bb29-4f02-987a-eb18d022eb2f', '426fd4f3-83bf-499f-b7b9-223a76846317');
INSERT INTO composite_role VALUES ('44b6498c-c088-4bf6-a022-7f7e980ed7d7', '99742840-92ca-4b33-894e-dc29354e6ef2');


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO credential VALUES ('0334edb8-1c34-45da-a74a-7d3ffb33fba0', NULL, 20000, '\x8cb968c397735d0109c2265a65a1134b', 'password', 'yHMY0vBi0jP1LlPYTfbIjqsfsWGmNzkvGQmIj99QLINIoOyRG//rsNAMRVWaDDIecnNutigoYdvjEFNgJKPBMA==', '32358881-30ad-4438-96bd-bf8ce355c3c3', 1489055457225, 0, 0, 0, 'pbkdf2');
INSERT INTO credential VALUES ('156aab24-d3c2-479e-9687-b9df75c4d003', NULL, 20000, '\xcd7ba74c7ebbc6e7e88d4035249f8409', 'password', '6NHM2JfYprcNiZnYnJbjCsHy7oBY4pIOIRP4SAa6atgmz4DSJFnNSjV2n7iHBsVqEXjXIXL+Pc5NEZpbmRvDOg==', 'f06239ea-7b23-4947-b7a2-ed860ab663a1', 1489055457560, 0, 0, 0, 'pbkdf2');
INSERT INTO credential VALUES ('d46a8afc-001d-4139-aaf6-9efa2e0d7814', NULL, 20000, '\xd33ec7e797e5b0bafe28901a11fa11e2', 'password', 'E1lXpMkwZsbDF0p6vqd30lIk7Gk8OCgnx5s2K8nhj82+s2F1u6U0wSN6FRqTb7ZOQPVnZ/ZPpn4s+oPokHoq8w==', 'cdc2a83b-1c36-4a13-854c-ed152c5f6f33', 1489055457861, 0, 0, 0, 'pbkdf2');
INSERT INTO credential VALUES ('80b5a2b5-366d-4d39-9ec3-1d4999c87c5b', NULL, 20000, '\x53e66291f9e1ff2328d90451d42a4005', 'password', 'an7JS6lyTa7UPG9Ex0ykAA8wSwgXUwAaFzdjxwSrtLkJytO5A6/FFHPiLjvDmqaoCNKIa88nJwGrs+Ul8KMw6w==', '95f05f01-0a98-4501-a637-5340add5db93', 1489055458052, 0, 0, 0, 'pbkdf2');
INSERT INTO credential VALUES ('44e0b0dc-5cd7-4184-9928-c6bbd64fa576', NULL, 20000, '\xa6d2014c8f4e74cf319135765e165ccb', 'password', '9triQhVrT1/dUrMSJYgGSuUP2mSbTJBIsVoom/P4dPMCRzjwdYfzhB9ZeaU1DQ+0STsvf9SKJTmMKNDkIQyI8g==', '1a13429f-e42d-4e57-aef8-aedaf164647c', 1489055459414, 0, 0, 0, 'pbkdf2');
INSERT INTO credential VALUES ('7ed691da-538e-4084-9262-29d40f781585', NULL, 20000, '\x3c7bf2a923dbbfc1d7e80cf462e9816f', 'password', 'l51aJN/EUYtr5eyMiseQoZEcBSLiounY8VZaMvL5LdeiOuIW5F4tx0BG3Q40AveukcX70zbyHKbZNGFgru+LBQ==', '11f68ecb-f7be-41d8-a6d6-cff1470aca9d', 1489055459567, 0, 0, 0, 'pbkdf2');
INSERT INTO credential VALUES ('371bf825-209a-4ef2-a148-b74e46c23afa', NULL, 20000, '\x8d68565c771ad3677109958d95b5b894', 'password', '21wKd76VZPfTTLbt/x4Uvw85TWiJVEGS1yKLx/JH+ODZ4MGbOOZ9u0tvtMrkN6kiJM560Ox3UcoOCr2ylky1lQ==', '016c5d30-ab12-42f2-ba9e-0b3efe81df4a', 1489055461366, 0, 0, 0, 'pbkdf2');
INSERT INTO credential VALUES ('f851ba7c-51ec-4a5c-951d-ab2b386eefa9', NULL, 20000, '\x5b70fd4a015b4364ec58205154596350', 'password', 'mBYfz2Ab6uWJGG/65uYcT1/4/6ypYxspuJ5MNgQmQFohrwoEXlwlVdLaASeNnTMWuKvOcvWJ7P5zDnd6pkmajQ==', '5a652b95-6f02-4806-8c06-f1263f7583ee', 1489055461520, 0, 0, 0, 'pbkdf2');
INSERT INTO credential VALUES ('13f17bbe-0495-4da9-b9d0-954b26404112', NULL, 20000, '\xb5cde7b6e98721c056c98f0fd2957382', 'password', '64gpTR+dGMHGEBcHwGB/PkxIZ2/RKR1Y550EJr6/2p5vCrGH61F66qdefFPkvLAsNfhTJCU0SGNLrQyH/PKTzw==', '564b4e34-db96-4e3e-8aa6-36a4e4df0c92', 1489055461696, 0, 0, 0, 'pbkdf2');
INSERT INTO credential VALUES ('560ccfc6-d413-4266-bf3d-323b3bf53955', NULL, 20000, '\x231f0eadf545960a85da41b005c242ed', 'password', 'z184LOS2JDTwlTEKm4cg3gFw0LgxW0Pk3qb2uJsgm51FavgBqD4uG17lUHQ2+QeVbZHGPWqNexlNVQwQ+nIzrg==', '4c8ef5d1-2b1e-4119-a105-8ddf181f7b7c', 1489055461872, 0, 0, 0, 'pbkdf2');
INSERT INTO credential VALUES ('9f57d6e3-79bf-407a-aca6-37b1af88b369', NULL, 20000, '\xa13e82f88149e698c77bd0354d11be1a', 'password', '5S1vO8b90/zpi8l5N57sbK4EL9DNrG8aiDYMB/sy5RpXkzogsZ0S6NHlXz9F4h0vsytv6kNBu6eDavn1jWolEw==', 'ab69c819-d744-406e-8a0f-ccc7db99fc98', NULL, 0, 0, 0, 'pbkdf2');


--
-- Data for Name: credential_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO databasechangelog VALUES ('1.0.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2017-03-09 10:29:05.804901', 1, 'EXECUTED', '7:00a57f7a6fb456639b34e62972e0ec02', 'createTable (x29), addPrimaryKey (x21), addUniqueConstraint (x9), addForeignKeyConstraint (x32)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.0.0.Final', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2017-03-09 10:29:06.243353', 2, 'MARK_RAN', '7:f061c3934594ee60a9b2343f5100ae4e', 'createTable (x29), addPrimaryKey (x21), addUniqueConstraint (x6), addForeignKeyConstraint (x30)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2017-03-09 10:29:12.174994', 3, 'EXECUTED', '7:0310eb8ba07cec616460794d42ade0fa', 'delete (x3), createTable (x3), addColumn (x5), addPrimaryKey (x3), addForeignKeyConstraint (x3), customChange', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2017-03-09 10:29:12.513876', 4, 'EXECUTED', '7:5d25857e708c3233ef4439df1f93f012', 'renameColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2017-03-09 10:29:24.000094', 5, 'EXECUTED', '7:c7a54a1041d58eb3817a4a883b4d4e84', 'delete (x4), createTable (x8), addColumn (x2), addPrimaryKey (x6), addForeignKeyConstraint (x9), addUniqueConstraint (x2), addColumn, dropForeignKeyConstraint (x2), dropUniqueConstraint, renameColumn (x3), addUniqueConstraint, addForeignKeyConstra...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2017-03-09 10:29:24.123885', 6, 'MARK_RAN', '7:2e01012df20974c1c2a605ef8afe25b7', 'delete (x4), createTable (x8), addColumn (x2), addPrimaryKey (x6), addForeignKeyConstraint (x9), addUniqueConstraint (x2), addColumn, dropForeignKeyConstraint (x2), dropUniqueConstraint, renameColumn (x3), customChange, dropForeignKeyConstraint, d...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2017-03-09 10:29:29.880481', 7, 'EXECUTED', '7:0f08df48468428e0f30ee59a8ec01a41', 'delete (x5), createTable (x3), addColumn, createTable (x4), addPrimaryKey (x7), addForeignKeyConstraint (x6), renameColumn, addColumn (x2), update, dropColumn, dropForeignKeyConstraint, renameColumn, addForeignKeyConstraint, dropForeignKeyConstrai...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2017-03-09 10:29:30.016828', 8, 'MARK_RAN', '7:a77ea2ad226b345e7d689d366f185c8c', 'delete (x5), createTable (x3), addColumn, createTable (x4), addPrimaryKey (x7), addForeignKeyConstraint (x6), renameColumn, addUniqueConstraint, addColumn (x2), update, dropColumn, dropForeignKeyConstraint, renameColumn, addForeignKeyConstraint, r...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2017-03-09 10:29:30.120688', 9, 'EXECUTED', '7:a3377a2059aefbf3b90ebb4c4cc8e2ab', 'update (x3)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2017-03-09 10:29:45.059846', 10, 'EXECUTED', '7:04c1dbedc2aa3e9756d1a1668e003451', 'delete (x6), createTable (x7), addColumn, createTable, addColumn (x2), update, dropDefaultValue, dropColumn, addColumn, update (x4), addPrimaryKey (x4), dropPrimaryKey, dropColumn, addPrimaryKey (x4), addForeignKeyConstraint (x8), dropDefaultValue...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2017-03-09 10:29:51.985763', 11, 'EXECUTED', '7:36ef39ed560ad07062d956db861042ba', 'delete (x7), addColumn (x5), dropColumn, renameTable (x2), update (x10), createTable (x3), customChange, dropPrimaryKey, addPrimaryKey (x4), addForeignKeyConstraint (x2), dropColumn, addColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2017-03-09 10:29:52.103793', 12, 'MARK_RAN', '7:d909180b2530479a716d3f9c9eaea3d7', 'delete (x7), addColumn (x5), dropColumn, renameTable, dropForeignKeyConstraint, renameTable, addForeignKeyConstraint, update (x10), createTable (x3), customChange, dropPrimaryKey, addPrimaryKey (x4), addForeignKeyConstraint (x2), dropColumn, addCo...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2017-03-09 10:30:00.776058', 13, 'EXECUTED', '7:cf12b04b79bea5152f165eb41f3955f6', 'delete (x7), dropDefaultValue, dropColumn, addColumn (x3)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2017-03-09 10:30:05.581238', 14, 'EXECUTED', '7:7e32c8f05c755e8675764e7d5f514509', 'addColumn (x3), createTable (x2), addPrimaryKey (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2017-03-09 10:30:05.691067', 15, 'MARK_RAN', '7:980ba23cc0ec39cab731ce903dd01291', 'delete (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2017-03-09 10:30:05.814886', 16, 'MARK_RAN', '7:2fa220758991285312eb84f3b4ff5336', 'dropPrimaryKey (x2), addColumn, update, dropColumn, addColumn, update, dropColumn, addPrimaryKey (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2017-03-09 10:30:05.938573', 17, 'EXECUTED', '7:d41d8cd98f00b204e9800998ecf8427e', 'Empty', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2017-03-09 10:30:13.270375', 18, 'EXECUTED', '7:91ace540896df890cc00a0490ee52bbc', 'createTable (x5), addColumn (x2), dropDefaultValue, dropColumn, addPrimaryKey, addForeignKeyConstraint, addPrimaryKey, addForeignKeyConstraint, addPrimaryKey, addForeignKeyConstraint, addPrimaryKey, addForeignKeyConstraint (x2), addUniqueConstrain...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2017-03-09 10:30:19.02864', 19, 'EXECUTED', '7:c31d1646dfa2618a9335c00e07f89f24', 'addColumn, createTable (x3), dropNotNullConstraint, addColumn (x2), createTable, addPrimaryKey, addUniqueConstraint, addForeignKeyConstraint (x5), addPrimaryKey, addForeignKeyConstraint (x2), addPrimaryKey, addForeignKeyConstraint, update', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2017-03-09 10:30:19.291505', 20, 'EXECUTED', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue, update', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2017-03-09 10:30:19.408278', 21, 'MARK_RAN', '7:f987971fe6b37d963bc95fee2b27f8df', 'addColumn, createTable (x3), dropNotNullConstraint, addColumn (x2), createTable, addPrimaryKey, addUniqueConstraint, addForeignKeyConstraint (x5), addPrimaryKey, addForeignKeyConstraint (x2), addPrimaryKey, addForeignKeyConstraint, update', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2017-03-09 10:30:19.56487', 22, 'MARK_RAN', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue, update', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2017-03-09 10:30:20.368742', 23, 'EXECUTED', '7:ed2dc7f799d19ac452cbcda56c929e47', 'update (x9), customChange, dropForeignKeyConstraint (x2), dropUniqueConstraint, dropTable, dropForeignKeyConstraint (x2), dropTable, dropForeignKeyConstraint (x2), dropUniqueConstraint, dropTable, createIndex', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2017-03-09 10:30:20.870417', 24, 'EXECUTED', '7:80b5db88a5dda36ece5f235be8757615', 'modifyDataType (x3)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2017-03-09 10:30:21.328938', 25, 'MARK_RAN', '7:1437310ed1305a9b93f8848f301726ce', 'modifyDataType (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2017-03-09 10:30:25.399855', 26, 'EXECUTED', '7:b82ffb34850fa0836be16deefc6a87c4', 'createIndex (x11)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2017-03-09 10:30:31.768699', 27, 'EXECUTED', '7:9cc98082921330d8d9266decdd4bd658', 'createTable, addPrimaryKey, addUniqueConstraint, createTable, addPrimaryKey, addForeignKeyConstraint, addUniqueConstraint, createTable, addPrimaryKey, addForeignKeyConstraint, addUniqueConstraint, createTable, addPrimaryKey, addForeignKeyConstrain...', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.1.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2017-03-09 10:30:37.851073', 28, 'EXECUTED', '7:e01599a82bf8d6dc22a9da506e22e868', 'createTable (x11), addPrimaryKey (x11), addForeignKeyConstraint (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2017-03-09 10:30:39.269182', 29, 'EXECUTED', '7:53188c3eb1107546e6f765835705b6c1', 'addColumn, createTable (x2), modifyDataType, addForeignKeyConstraint (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2017-03-09 10:30:40.602899', 30, 'EXECUTED', '7:d6e6f3bc57a0c5586737d1351725d4d4', 'createTable, addPrimaryKey, dropDefaultValue, dropColumn, addColumn (x2), customChange, dropColumn (x4), addColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2017-03-09 10:30:40.805839', 31, 'EXECUTED', '7:454d604fbd755d9df3fd9c6329043aa5', 'customChange', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2017-03-09 10:30:41.159193', 32, 'EXECUTED', '7:57e98a3077e29caf562f7dbf80c72600', 'customChange, modifyDataType', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2017-03-09 10:30:41.329493', 33, 'MARK_RAN', '7:e4c7e8f2256210aee71ddc42f538b57a', 'modifyDataType (x13), addColumn, sql, dropColumn, renameColumn, modifyDataType (x2)', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2017-03-09 10:30:42.964316', 34, 'EXECUTED', '7:09a43c97e49bc626460480aa1379b522', 'modifyDataType (x5), dropUniqueConstraint, modifyDataType (x3), addUniqueConstraint, dropPrimaryKey, modifyDataType, addNotNullConstraint, addPrimaryKey, modifyDataType (x5), dropUniqueConstraint, modifyDataType, addUniqueConstraint, modifyDataType', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2017-03-09 10:30:45.910127', 35, 'EXECUTED', '7:26bfc7c74fefa9126f2ce702fb775553', 'addColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2017-03-09 10:30:46.46756', 36, 'EXECUTED', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2017-06-02 20:31:57.149483', 37, 'EXECUTED', '7:03d64aeed9cb52b969bd30a7ac0db57e', 'update', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2017-06-02 20:31:57.33414', 38, 'EXECUTED', '7:37fc1781855ac5388c494f1442b3f717', 'addColumn', '', NULL, '3.4.1', NULL, NULL);
INSERT INTO databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2017-06-02 20:31:58.900901', 39, 'EXECUTED', '7:13a27db0dae6049541136adad7261d27', 'addColumn', '', NULL, '3.4.1', NULL, NULL);


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO databasechangeloglock VALUES (1, false, NULL, NULL);


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_credential_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_consent_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_consent_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO group_attribute VALUES ('4989bfc4-a779-4258-9b71-d515f54a1045', 'business', 'carrefour', '4e630f16-cc0e-4fdb-a430-190ce9e8bbf7');
INSERT INTO group_attribute VALUES ('be3624ac-9800-4e80-b82a-8f0259cf44cc', 'business', 'delhaize', '4e3ea1f9-761e-4888-9ac4-81efd61c2638');
INSERT INTO group_attribute VALUES ('41b0b238-1e51-4104-b51e-662213842dd1', 'business', 'carrefour', '603ce513-8f56-4efc-8de6-400c5fbaa38a');
INSERT INTO group_attribute VALUES ('d4ba9062-0399-4ce1-89a6-af476f5c909d', 'business', 'colruyt', 'a6ce1c4e-80d3-48b1-a861-db93f3ea7950');


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO identity_provider VALUES ('f1dab45d-6003-4822-814c-29057998fa19', true, 'google', 'google', false, false, 'FidCash', false, true, 'ae57d11c-3184-4758-99ed-b2734d502aff', '60731bee-4f24-4bf1-a42b-828e19ed456e', NULL, false);
INSERT INTO identity_provider VALUES ('856b5a67-625d-4694-9f49-3157e7b405b2', true, 'facebook', 'facebook', false, false, 'FidCash', false, true, 'ae57d11c-3184-4758-99ed-b2734d502aff', '60731bee-4f24-4bf1-a42b-828e19ed456e', NULL, false);


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO identity_provider_config VALUES ('f1dab45d-6003-4822-814c-29057998fa19', 'OluvYcGn-xWXHNBbhN9VZW52', 'clientSecret');
INSERT INTO identity_provider_config VALUES ('f1dab45d-6003-4822-814c-29057998fa19', '1098423361907-9sbjmg1bvhq6vbqil13ou8e982kh3oj2.apps.googleusercontent.com', 'clientId');
INSERT INTO identity_provider_config VALUES ('f1dab45d-6003-4822-814c-29057998fa19', 'true', 'useJwksUrl');
INSERT INTO identity_provider_config VALUES ('856b5a67-625d-4694-9f49-3157e7b405b2', 'e1abc40b088dcb9fce3fa2b93650a058', 'clientSecret');
INSERT INTO identity_provider_config VALUES ('856b5a67-625d-4694-9f49-3157e7b405b2', '1840993939475914', 'clientId');
INSERT INTO identity_provider_config VALUES ('856b5a67-625d-4694-9f49-3157e7b405b2', 'true', 'useJwksUrl');


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO keycloak_group VALUES ('4e630f16-cc0e-4fdb-a430-190ce9e8bbf7', 'Carrefour', NULL, 'Joyn');
INSERT INTO keycloak_group VALUES ('4e3ea1f9-761e-4888-9ac4-81efd61c2638', 'Delhaize', NULL, 'Joyn');
INSERT INTO keycloak_group VALUES ('603ce513-8f56-4efc-8de6-400c5fbaa38a', 'Carrefour', NULL, 'FidCash');
INSERT INTO keycloak_group VALUES ('a6ce1c4e-80d3-48b1-a861-db93f3ea7950', 'Colruyt', NULL, 'FidCash');


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO keycloak_role VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'master', false, '${role_admin}', 'admin', 'master', NULL, 'master', false);
INSERT INTO keycloak_role VALUES ('14c91ee4-6d0a-4c99-a854-bc1b0266f469', 'master', false, '${role_create-realm}', 'create-realm', 'master', NULL, 'master', false);
INSERT INTO keycloak_role VALUES ('0bf5aa62-eab9-463b-a477-b6b27f4bce2f', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_create-client}', 'create-client', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('f32511e0-96b1-49d5-b9f2-b7ce9ca90d28', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_view-realm}', 'view-realm', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('ce3602c5-6aa2-4ea9-99ad-997064f278fd', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_view-users}', 'view-users', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('587a1710-180c-47f3-a5c0-ca1dd0d6b47c', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_view-clients}', 'view-clients', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('d640f93b-9803-45fe-ade9-30cbeac33622', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_view-events}', 'view-events', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('ed9b438e-2624-45ee-bb19-a1f1c9ec69b0', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('b1643986-9b23-4f15-b7b7-1fd250669572', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_view-authorization}', 'view-authorization', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('e41e1ad5-b083-477e-9098-226d8e838695', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_manage-realm}', 'manage-realm', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('dd81fc64-e342-43e2-87ca-1595dfb89652', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_manage-users}', 'manage-users', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('2e4357e6-7212-4af3-9e7b-a069a4221de2', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_manage-clients}', 'manage-clients', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('30aa5562-b42c-4f4f-8b10-64e89576fbda', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_manage-events}', 'manage-events', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('0ab5f2dd-cdb3-432e-a5e0-03b670aea3f1', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('4ad5bef4-1120-4703-a72f-57dfe9eb184c', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_manage-authorization}', 'manage-authorization', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('169ae6bd-87e6-4112-8411-b858eb5bcb35', 'd19d260c-bfd9-4375-b4f4-c9b7c6188289', true, '${role_view-profile}', 'view-profile', 'master', 'd19d260c-bfd9-4375-b4f4-c9b7c6188289', NULL, false);
INSERT INTO keycloak_role VALUES ('5ebaf50f-278f-4caa-bf2a-a6483ed909c0', 'd19d260c-bfd9-4375-b4f4-c9b7c6188289', true, '${role_manage-account}', 'manage-account', 'master', 'd19d260c-bfd9-4375-b4f4-c9b7c6188289', NULL, false);
INSERT INTO keycloak_role VALUES ('7e3c2597-8a31-4a7f-825a-c418d7262668', 'b48a0302-d58e-430e-8ed8-8231a282da39', true, '${role_read-token}', 'read-token', 'master', 'b48a0302-d58e-430e-8ed8-8231a282da39', NULL, false);
INSERT INTO keycloak_role VALUES ('4f768604-3d4b-4e1a-81df-ab9e23844ae1', '662f42cf-dc6b-461d-9633-d8384f210692', true, '${role_impersonation}', 'impersonation', 'master', '662f42cf-dc6b-461d-9633-d8384f210692', NULL, false);
INSERT INTO keycloak_role VALUES ('c2f327cc-12b7-4388-8641-1ea36f94ca48', 'master', false, '${role_offline-access}', 'offline_access', 'master', NULL, 'master', true);
INSERT INTO keycloak_role VALUES ('af5f4188-9dbd-49b0-bfb2-ffabb9652c79', 'master', false, '${role_uma_authorization}', 'uma_authorization', 'master', NULL, 'master', false);
INSERT INTO keycloak_role VALUES ('07c76949-474f-476f-a1a7-9f267ab81319', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_create-client}', 'create-client', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('bd9212d2-1ccb-412e-844d-0032184e8d9f', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_view-realm}', 'view-realm', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('5698208e-eef1-4483-8065-ec4b0c4214ec', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_view-users}', 'view-users', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('c58920b1-87ec-4581-bf7d-6d2d5c43939d', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_view-clients}', 'view-clients', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('b808e06c-40ce-4c2e-b9c2-312ec80f2b26', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_view-events}', 'view-events', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('79983404-8a59-4f8f-870a-d7ea54bd8957', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('e0eb44cf-b433-4e21-94a1-7119ce7fa3f5', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_view-authorization}', 'view-authorization', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('c7f6c634-5787-47f2-823b-9ace7fc36110', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_manage-realm}', 'manage-realm', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('0493bc74-7443-4203-9127-919438aa99ae', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_manage-users}', 'manage-users', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('10f5b721-d2f7-4d52-953d-50a918b866d9', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_manage-clients}', 'manage-clients', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('eea7a444-2d3f-4b46-bccd-117adcdc08c0', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_manage-events}', 'manage-events', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('bae03369-0a24-4ca5-aafe-084cba142a2c', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('8317ddd4-5742-42f2-a3e7-11fe53908597', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_manage-authorization}', 'manage-authorization', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('3dfbfa77-87b9-4c75-a18e-9e59c9d91d4f', 'Joyn', false, NULL, 'owner', 'Joyn', NULL, 'Joyn', false);
INSERT INTO keycloak_role VALUES ('fa815218-cd81-4597-baac-af223756575c', 'Joyn', false, '${role_offline-access}', 'offline_access', 'Joyn', NULL, 'Joyn', true);
INSERT INTO keycloak_role VALUES ('a6dfff4f-01a8-44b6-bf19-839ed6115eb2', 'Joyn', false, NULL, 'partner', 'Joyn', NULL, 'Joyn', false);
INSERT INTO keycloak_role VALUES ('b9ac942b-35dc-42ee-892c-84ec221c9667', 'Joyn', false, NULL, 'user', 'Joyn', NULL, 'Joyn', false);
INSERT INTO keycloak_role VALUES ('e3b79268-dae0-4b2b-9884-a0ac61fac3d9', 'Joyn', false, '${role_uma_authorization}', 'uma_authorization', 'Joyn', NULL, 'Joyn', false);
INSERT INTO keycloak_role VALUES ('54b33529-d22a-4bbc-960f-4afb95c84e75', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_manage-events}', 'manage-events', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('e30d8fee-b354-4ad5-9cc8-5cb693df8fbf', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_realm-admin}', 'realm-admin', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('8288f470-023a-496b-bbbe-b2e5bb252eca', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_view-users}', 'view-users', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('1e14d609-0e11-400f-8a26-6d3f420358e3', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_view-realm}', 'view-realm', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('24591c17-e501-40c6-b40b-5bc1358aa7d5', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_view-events}', 'view-events', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('7b35d9a4-95c4-4107-8c1c-05bea34b6bc6', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_manage-users}', 'manage-users', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('7020121e-5a78-4c14-9066-6d39298bd4b6', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_create-client}', 'create-client', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('ccf11ddb-e0c9-4792-8b28-96ec336a0609', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_view-clients}', 'view-clients', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('31da9c2a-ee58-48ee-9cae-b76a34e5f9f2', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_manage-clients}', 'manage-clients', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('e4252aa5-1853-4525-ac8a-f73de00b448a', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_manage-realm}', 'manage-realm', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('37c90ab7-3aff-401e-a66d-9c27d2bc7419', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_view-identity-providers}', 'view-identity-providers', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('188fc61d-19e3-46dd-b33c-faae634cae4b', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_impersonation}', 'impersonation', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('2522dfa3-49b2-4ac4-b785-bbd681c2bbb6', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('0dcb9cd2-5c52-4fe6-b018-d7a25052306b', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_manage-authorization}', 'manage-authorization', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('5031d0e4-2130-4bcc-ba37-8c20f9c7ec5b', '8f8d9417-ed6c-481a-bac6-f2735a298156', true, '${role_view-authorization}', 'view-authorization', 'Joyn', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL, false);
INSERT INTO keycloak_role VALUES ('3963e438-62e9-4b8a-bc5a-9bfb1332c11d', 'b41ab070-1f92-4562-8f2c-965ab07138e0', true, '${role_read-token}', 'read-token', 'Joyn', 'b41ab070-1f92-4562-8f2c-965ab07138e0', NULL, false);
INSERT INTO keycloak_role VALUES ('502baf77-40f3-4968-8a6e-8830c0fa8dcd', 'ab721dba-4af4-4d1d-b686-aec44d62d883', true, '${role_manage-account}', 'manage-account', 'Joyn', 'ab721dba-4af4-4d1d-b686-aec44d62d883', NULL, false);
INSERT INTO keycloak_role VALUES ('86c6f137-9d24-457f-90fb-97f052710b87', 'ab721dba-4af4-4d1d-b686-aec44d62d883', true, '${role_view-profile}', 'view-profile', 'Joyn', 'ab721dba-4af4-4d1d-b686-aec44d62d883', NULL, false);
INSERT INTO keycloak_role VALUES ('8dd17049-c17b-4b19-b565-256dc07740c7', 'dd112d33-6fb0-4566-8966-a70d5905c056', true, '${role_impersonation}', 'impersonation', 'master', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL, false);
INSERT INTO keycloak_role VALUES ('d14d6329-1aff-488c-98fe-da6f922a330c', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_create-client}', 'create-client', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('3bb793da-b479-4456-a6c5-e17a6198a042', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_view-realm}', 'view-realm', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('68aa7197-e474-410d-8d8b-cd3e27cded3d', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_view-users}', 'view-users', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('fa7c5352-bd3b-4dba-9df7-7a9872f3ed48', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_view-clients}', 'view-clients', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('8a1e90c0-cf38-4223-8a3a-f88cefd307ba', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_view-events}', 'view-events', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('bbd23e47-a179-462e-a84f-f336cce8b68f', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('70e4784b-339e-4849-91b1-954a472de48a', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_view-authorization}', 'view-authorization', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('cba034f9-81c7-4d13-8baa-950ab0a24685', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_manage-realm}', 'manage-realm', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('2a38eef0-1770-4359-835f-e36dd2ffda5c', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_manage-users}', 'manage-users', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('b37ea29f-0e6e-46fe-9358-3c728a3d232d', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_manage-clients}', 'manage-clients', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('d74bab18-c281-4449-b76b-054bd14fc05d', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_manage-events}', 'manage-events', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('a4c336c1-3bb4-4c0f-a4de-2b12143ed960', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('24ad4ff8-d2e8-49c6-a2e1-dae358bde8d4', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_manage-authorization}', 'manage-authorization', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_realm-admin}', 'realm-admin', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('551ed6ef-9409-44bb-b018-a0799df76964', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_create-client}', 'create-client', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('0d56915c-f0ff-497f-ae7d-8783bcf69792', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_view-realm}', 'view-realm', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('f552f90c-e9ab-4211-80db-43354e466a2b', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_view-users}', 'view-users', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('4cc5a11a-c369-4dfb-90e0-6767ed8ab530', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_view-clients}', 'view-clients', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('738fb611-113e-4b0a-a313-f1850a63bdf5', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_view-events}', 'view-events', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('600613d5-ee2c-46ff-8797-df3e4951f046', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_view-identity-providers}', 'view-identity-providers', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('f4ca63b2-4050-4f21-bf56-7a6b89beb4c4', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_view-authorization}', 'view-authorization', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('e3f49dc6-569c-4225-ac6b-0835c35fbeba', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_manage-realm}', 'manage-realm', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('25f9a3bc-940e-4d26-afe3-e2c40bb36410', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_manage-users}', 'manage-users', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('43e55c67-5bb3-4849-abdf-2bf14af87f1d', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_manage-clients}', 'manage-clients', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('aa147790-2c86-4d13-8e6f-7777cc4da060', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_manage-events}', 'manage-events', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('2534840d-d627-455c-81fb-892b7794bc44', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('5a61940d-3562-4a9c-af1d-cb6be9baa26c', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_manage-authorization}', 'manage-authorization', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('8617b026-a097-49ff-8ddb-99b2703919c5', '4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', true, '${role_view-profile}', 'view-profile', 'fa758415-6fe8-4313-b599-643292361e3d', '4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', NULL, false);
INSERT INTO keycloak_role VALUES ('6d437c34-bb29-4f02-987a-eb18d022eb2f', '4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', true, '${role_manage-account}', 'manage-account', 'fa758415-6fe8-4313-b599-643292361e3d', '4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', NULL, false);
INSERT INTO keycloak_role VALUES ('f908a4e0-8b3a-46b7-a73b-b4068a829548', '9b1705ee-b907-443e-9fd9-568448f312d3', true, '${role_impersonation}', 'impersonation', 'master', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL, false);
INSERT INTO keycloak_role VALUES ('9f763615-6036-4c53-93a0-081395117ec8', '5bb93364-13a4-4071-8275-14083447bba4', true, '${role_impersonation}', 'impersonation', 'fa758415-6fe8-4313-b599-643292361e3d', '5bb93364-13a4-4071-8275-14083447bba4', NULL, false);
INSERT INTO keycloak_role VALUES ('90a1e8af-20aa-4ad4-9820-ff9e3e57b995', '9027ac22-28b7-4c20-8de2-14f338db5580', true, '${role_read-token}', 'read-token', 'fa758415-6fe8-4313-b599-643292361e3d', '9027ac22-28b7-4c20-8de2-14f338db5580', NULL, false);
INSERT INTO keycloak_role VALUES ('8c9f575b-f95a-469d-b3ae-54524b93cec6', 'fa758415-6fe8-4313-b599-643292361e3d', false, '${role_offline-access}', 'offline_access', 'fa758415-6fe8-4313-b599-643292361e3d', NULL, 'fa758415-6fe8-4313-b599-643292361e3d', true);
INSERT INTO keycloak_role VALUES ('05a65ccb-6b36-4db5-a4f7-ed1a9b5ed2b6', 'fa758415-6fe8-4313-b599-643292361e3d', false, 'User privileges.', 'apiuser', 'fa758415-6fe8-4313-b599-643292361e3d', NULL, 'fa758415-6fe8-4313-b599-643292361e3d', false);
INSERT INTO keycloak_role VALUES ('32611b2f-374e-47fc-87e4-e1be3d42f184', 'fa758415-6fe8-4313-b599-643292361e3d', false, 'Administrator privileges.', 'apiadmin', 'fa758415-6fe8-4313-b599-643292361e3d', NULL, 'fa758415-6fe8-4313-b599-643292361e3d', false);
INSERT INTO keycloak_role VALUES ('1ebf939e-32f4-431e-b12e-051c5d8a99f4', 'fa758415-6fe8-4313-b599-643292361e3d', false, 'Required to publish to the API Gateway.', 'apipublisher', 'fa758415-6fe8-4313-b599-643292361e3d', NULL, 'fa758415-6fe8-4313-b599-643292361e3d', false);
INSERT INTO keycloak_role VALUES ('c2d86a8e-7c89-4587-985b-8cc673ec9f19', 'fa758415-6fe8-4313-b599-643292361e3d', false, '${role_uma_authorization}', 'uma_authorization', 'fa758415-6fe8-4313-b599-643292361e3d', NULL, 'fa758415-6fe8-4313-b599-643292361e3d', false);
INSERT INTO keycloak_role VALUES ('fc156e7b-02b0-411c-be6b-33f398c78e31', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_create-client}', 'create-client', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('7f4551e1-e5d0-4f41-938f-2cdeaea9b889', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_view-realm}', 'view-realm', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('69ba84a7-9c7a-4b63-bf9e-aac5f4a77f1a', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_view-users}', 'view-users', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('86f8ddfc-b19a-4541-b6c8-6cac8a027463', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_view-clients}', 'view-clients', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('812e60af-384e-4f68-b4e5-6e85fa40c6e2', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_view-events}', 'view-events', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('3b93f8d2-f298-430a-83e0-c1ad4326f50a', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('a3688a4e-a0b2-41e7-b645-e16b3882233a', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_view-authorization}', 'view-authorization', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('8c2fe26e-b768-4923-ab31-0755d629ffe7', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_manage-realm}', 'manage-realm', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('acb3fc2f-6615-49c8-bb86-bb48ac18aef4', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_manage-users}', 'manage-users', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('43feedfe-2b85-4c8f-b651-c6089753df44', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_manage-clients}', 'manage-clients', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('284d4171-aeca-4286-b373-8eb9fc2609ed', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_manage-events}', 'manage-events', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('4bc18399-7574-4990-9405-8458ca6e93ac', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('534794c8-bd4c-4a2f-9dd9-f6b3bccca790', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_manage-authorization}', 'manage-authorization', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('65cc597c-a172-4db4-9597-fa3c79b5ec10', 'FidCash', false, NULL, 'user', 'FidCash', NULL, 'FidCash', false);
INSERT INTO keycloak_role VALUES ('ff02f592-f2d9-4748-8f3b-78c6ecea6f08', 'FidCash', false, NULL, 'owner', 'FidCash', NULL, 'FidCash', false);
INSERT INTO keycloak_role VALUES ('d60ee4da-cc16-4b12-829a-42feabd04aaf', 'FidCash', false, '${role_uma_authorization}', 'uma_authorization', 'FidCash', NULL, 'FidCash', false);
INSERT INTO keycloak_role VALUES ('5ebcc062-ca37-43ba-bb07-421340d13d5d', 'FidCash', false, NULL, 'partner', 'FidCash', NULL, 'FidCash', false);
INSERT INTO keycloak_role VALUES ('4779830c-ad5a-4848-b4cd-599c580255a1', 'FidCash', false, '${role_offline-access}', 'offline_access', 'FidCash', NULL, 'FidCash', true);
INSERT INTO keycloak_role VALUES ('78d83a83-c469-413c-b0f4-509e1b5cb9f7', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_realm-admin}', 'realm-admin', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('9b5b9465-81e5-4527-b748-bb576d991dd2', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('e0ec5a2d-61c0-4869-a7aa-63a57aa8d179', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_manage-users}', 'manage-users', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('2034fb26-c6d5-437d-9422-e8cb5c7c3cdb', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_create-client}', 'create-client', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('3a51e8db-95c1-4894-8c19-04ed30fceec2', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_view-clients}', 'view-clients', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('c9de5732-8ba5-4ce6-9393-e3f802e4b3cc', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_view-users}', 'view-users', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('f5ee24c7-1dfa-4a23-b1e3-9bc041d5601e', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_manage-clients}', 'manage-clients', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('e1b21877-5702-48dd-a68a-2cdf71dc735b', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_impersonation}', 'impersonation', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('2f67cd22-d4db-41bd-aa7e-77fd99de1c2f', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_manage-events}', 'manage-events', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('35181378-b4d5-4ef1-90ce-00d947ddf48f', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_manage-realm}', 'manage-realm', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('83cf4abf-1a0a-4f7a-8e13-7f3f0306fc17', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_view-realm}', 'view-realm', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('eca00f5a-b3b9-478c-b978-0137b67be51b', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_view-identity-providers}', 'view-identity-providers', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('7647de7e-dbde-44c6-8c6f-0d0f21e6f010', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_view-authorization}', 'view-authorization', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('03ca8ddd-6f25-4d05-9757-df54ac504fa1', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_manage-authorization}', 'manage-authorization', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('71a185bf-c31d-43dd-9345-00ee164e4507', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', true, '${role_view-events}', 'view-events', 'FidCash', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL, false);
INSERT INTO keycloak_role VALUES ('3c907ccd-57ae-4a18-af0c-e27663937d49', '6a832b8b-e8e6-46f6-8a99-85e147e0448a', true, '${role_read-token}', 'read-token', 'FidCash', '6a832b8b-e8e6-46f6-8a99-85e147e0448a', NULL, false);
INSERT INTO keycloak_role VALUES ('88eac625-ce82-4e85-b60a-eec0c8ab2a50', '8bc6a229-9e1d-4a74-8933-8fb0abf50fde', true, '${role_view-profile}', 'view-profile', 'FidCash', '8bc6a229-9e1d-4a74-8933-8fb0abf50fde', NULL, false);
INSERT INTO keycloak_role VALUES ('44b6498c-c088-4bf6-a022-7f7e980ed7d7', '8bc6a229-9e1d-4a74-8933-8fb0abf50fde', true, '${role_manage-account}', 'manage-account', 'FidCash', '8bc6a229-9e1d-4a74-8933-8fb0abf50fde', NULL, false);
INSERT INTO keycloak_role VALUES ('70afd8bd-cec3-485a-ba8a-0923b0b6fbad', '102112b4-0529-46c4-afc3-5dded7a42ff9', true, '${role_impersonation}', 'impersonation', 'master', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL, false);
INSERT INTO keycloak_role VALUES ('eb8c248a-0e0f-43eb-ac3d-0fade93c091f', 'd19d260c-bfd9-4375-b4f4-c9b7c6188289', true, NULL, 'manage-account-links', 'master', 'd19d260c-bfd9-4375-b4f4-c9b7c6188289', NULL, false);
INSERT INTO keycloak_role VALUES ('1f117d24-bb03-4b10-b319-e6c1e1a2cde5', 'ab721dba-4af4-4d1d-b686-aec44d62d883', true, NULL, 'manage-account-links', 'Joyn', 'ab721dba-4af4-4d1d-b686-aec44d62d883', NULL, false);
INSERT INTO keycloak_role VALUES ('426fd4f3-83bf-499f-b7b9-223a76846317', '4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', true, NULL, 'manage-account-links', 'fa758415-6fe8-4313-b599-643292361e3d', '4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', NULL, false);
INSERT INTO keycloak_role VALUES ('99742840-92ca-4b33-894e-dc29354e6ef2', '8bc6a229-9e1d-4a74-8933-8fb0abf50fde', true, NULL, 'manage-account-links', 'FidCash', '8bc6a229-9e1d-4a74-8933-8fb0abf50fde', NULL, false);


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO migration_model VALUES ('SINGLETON', '3.1.0');


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO protocol_mapper VALUES ('f95112fd-8de1-4637-8c30-bd01e72b543c', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '662f42cf-dc6b-461d-9633-d8384f210692', NULL);
INSERT INTO protocol_mapper VALUES ('05b912ca-4d0a-4b55-96f4-db326373ce67', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '662f42cf-dc6b-461d-9633-d8384f210692', NULL);
INSERT INTO protocol_mapper VALUES ('54b8d58a-2012-453e-9997-9541e65cf98f', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '662f42cf-dc6b-461d-9633-d8384f210692', NULL);
INSERT INTO protocol_mapper VALUES ('651d91f6-8bd4-45e5-a793-6e6a006785d3', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '662f42cf-dc6b-461d-9633-d8384f210692', NULL);
INSERT INTO protocol_mapper VALUES ('00921216-63c9-461e-8145-060e6162483e', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '662f42cf-dc6b-461d-9633-d8384f210692', NULL);
INSERT INTO protocol_mapper VALUES ('d36a13a9-4979-4cdf-8447-964ca4352e1b', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '662f42cf-dc6b-461d-9633-d8384f210692', NULL);
INSERT INTO protocol_mapper VALUES ('a0b44515-1722-4fbe-bd4a-33f76d41fd0a', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'd19d260c-bfd9-4375-b4f4-c9b7c6188289', NULL);
INSERT INTO protocol_mapper VALUES ('b1ec9a41-c540-457e-9118-efa48f56c3c6', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'd19d260c-bfd9-4375-b4f4-c9b7c6188289', NULL);
INSERT INTO protocol_mapper VALUES ('8f1f2ba1-0c56-44cf-b723-e26f0f891d93', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'd19d260c-bfd9-4375-b4f4-c9b7c6188289', NULL);
INSERT INTO protocol_mapper VALUES ('9f5ed0af-29aa-4e8c-8f55-a3a170820e8a', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'd19d260c-bfd9-4375-b4f4-c9b7c6188289', NULL);
INSERT INTO protocol_mapper VALUES ('6488d0f9-74df-4ee7-9d9d-8a6d2dd38edb', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'd19d260c-bfd9-4375-b4f4-c9b7c6188289', NULL);
INSERT INTO protocol_mapper VALUES ('b81bbdfa-de23-48bc-959b-ab016bb408fe', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'd19d260c-bfd9-4375-b4f4-c9b7c6188289', NULL);
INSERT INTO protocol_mapper VALUES ('e1dc606b-1b35-4e33-b0bd-96ccfb2fd76d', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'b48a0302-d58e-430e-8ed8-8231a282da39', NULL);
INSERT INTO protocol_mapper VALUES ('7327a7cd-92c3-4d0b-ae71-03fd540f6714', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'b48a0302-d58e-430e-8ed8-8231a282da39', NULL);
INSERT INTO protocol_mapper VALUES ('81cde12f-c585-4723-8166-370cf0a97add', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'b48a0302-d58e-430e-8ed8-8231a282da39', NULL);
INSERT INTO protocol_mapper VALUES ('b19c09fa-fab2-451f-b4c1-91d000d2fcb1', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'b48a0302-d58e-430e-8ed8-8231a282da39', NULL);
INSERT INTO protocol_mapper VALUES ('f053ea09-884d-45b8-b461-aab768ae0548', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'b48a0302-d58e-430e-8ed8-8231a282da39', NULL);
INSERT INTO protocol_mapper VALUES ('4e629be4-3dcc-435f-8d6b-2253b6f7480f', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'b48a0302-d58e-430e-8ed8-8231a282da39', NULL);
INSERT INTO protocol_mapper VALUES ('0fb56878-b2b7-4e3d-b8c3-41bb4e8637c4', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '84a138ae-2da9-4b1d-8149-7e1f726aefa8', NULL);
INSERT INTO protocol_mapper VALUES ('a0a73147-bdb7-4bb9-9266-90930b5d89ce', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '84a138ae-2da9-4b1d-8149-7e1f726aefa8', NULL);
INSERT INTO protocol_mapper VALUES ('7686ef42-2bf5-4ddd-b31f-38501ac6809b', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '84a138ae-2da9-4b1d-8149-7e1f726aefa8', NULL);
INSERT INTO protocol_mapper VALUES ('d5e27131-1010-490b-9ad2-42de550f36c1', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '84a138ae-2da9-4b1d-8149-7e1f726aefa8', NULL);
INSERT INTO protocol_mapper VALUES ('ed12e601-e422-4680-b862-64e47948e59c', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '84a138ae-2da9-4b1d-8149-7e1f726aefa8', NULL);
INSERT INTO protocol_mapper VALUES ('80083d5c-9ad3-4981-b7e3-e17ed53a27a4', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '84a138ae-2da9-4b1d-8149-7e1f726aefa8', NULL);
INSERT INTO protocol_mapper VALUES ('793f62ef-73f8-4762-ac32-68e74f428b55', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', false, '${locale}', '84a138ae-2da9-4b1d-8149-7e1f726aefa8', NULL);
INSERT INTO protocol_mapper VALUES ('01590ace-f237-4164-a6ba-6a9a18db7e4b', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'ea5c74a8-9fbf-4d1f-a63b-22f34ec80ab8', NULL);
INSERT INTO protocol_mapper VALUES ('3d9e7d65-6de1-4d99-92d3-6e5d62364493', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'ea5c74a8-9fbf-4d1f-a63b-22f34ec80ab8', NULL);
INSERT INTO protocol_mapper VALUES ('d639a201-cc9d-4dfb-9f48-c9fa6816d82c', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'ea5c74a8-9fbf-4d1f-a63b-22f34ec80ab8', NULL);
INSERT INTO protocol_mapper VALUES ('bdf09cca-558e-4aa5-9f3e-08ca385f0f7f', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'ea5c74a8-9fbf-4d1f-a63b-22f34ec80ab8', NULL);
INSERT INTO protocol_mapper VALUES ('49be601a-9bee-4553-9ff2-9f4539a42a08', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'ea5c74a8-9fbf-4d1f-a63b-22f34ec80ab8', NULL);
INSERT INTO protocol_mapper VALUES ('d3621c7e-f99e-464b-96a1-5757cb4c86c3', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'ea5c74a8-9fbf-4d1f-a63b-22f34ec80ab8', NULL);
INSERT INTO protocol_mapper VALUES ('76e383ed-cc1d-4a6a-939a-8000040830d2', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL);
INSERT INTO protocol_mapper VALUES ('8295ddeb-dd37-4730-9893-7dec3880fdae', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL);
INSERT INTO protocol_mapper VALUES ('e2eb6ce6-bbe4-4ef7-afb7-37815c8d9779', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL);
INSERT INTO protocol_mapper VALUES ('3e1cae50-2b7b-40f4-8320-363f14c4ab87', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL);
INSERT INTO protocol_mapper VALUES ('90cafe3d-0522-4d45-bdd1-eceec5394493', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL);
INSERT INTO protocol_mapper VALUES ('079eaa79-6e5b-4376-be02-20b09ddbbb7d', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'dd112d33-6fb0-4566-8966-a70d5905c056', NULL);
INSERT INTO protocol_mapper VALUES ('9efec4fa-82b6-4cf1-bbc0-58054b1c6e70', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'ab721dba-4af4-4d1d-b686-aec44d62d883', NULL);
INSERT INTO protocol_mapper VALUES ('84a7b2e2-8578-44b0-9fd1-0229153c37a4', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'ab721dba-4af4-4d1d-b686-aec44d62d883', NULL);
INSERT INTO protocol_mapper VALUES ('06b89ae5-a460-4a1d-8bf5-f75d4b37175d', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'ab721dba-4af4-4d1d-b686-aec44d62d883', NULL);
INSERT INTO protocol_mapper VALUES ('782fb24e-4ff2-496d-9af4-0d141821b4cb', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'ab721dba-4af4-4d1d-b686-aec44d62d883', NULL);
INSERT INTO protocol_mapper VALUES ('2278ba5f-55da-4481-8c6f-000f1f1e91f6', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'ab721dba-4af4-4d1d-b686-aec44d62d883', NULL);
INSERT INTO protocol_mapper VALUES ('b3562163-3048-4488-8059-02a2ea5ec036', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'ab721dba-4af4-4d1d-b686-aec44d62d883', NULL);
INSERT INTO protocol_mapper VALUES ('27f48305-f707-4804-a1a9-84ce2641827a', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '0a87bd58-0cf4-4e19-a1e1-52525afc8823', NULL);
INSERT INTO protocol_mapper VALUES ('3dd7e928-2e00-4ac8-a9e4-5ae106691814', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '0a87bd58-0cf4-4e19-a1e1-52525afc8823', NULL);
INSERT INTO protocol_mapper VALUES ('e649716c-fb2a-46b4-9484-42543829b913', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '0a87bd58-0cf4-4e19-a1e1-52525afc8823', NULL);
INSERT INTO protocol_mapper VALUES ('3ff71428-6f2c-48c1-89b7-d82be1e50ce2', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '0a87bd58-0cf4-4e19-a1e1-52525afc8823', NULL);
INSERT INTO protocol_mapper VALUES ('2b3ac893-f0f2-48cb-8ddc-4b300b4323c5', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '0a87bd58-0cf4-4e19-a1e1-52525afc8823', NULL);
INSERT INTO protocol_mapper VALUES ('a5636e39-c241-4406-a825-db94b9d76123', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '0a87bd58-0cf4-4e19-a1e1-52525afc8823', NULL);
INSERT INTO protocol_mapper VALUES ('3bb4dda0-571b-4082-9dac-9823b8031c08', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'b41ab070-1f92-4562-8f2c-965ab07138e0', NULL);
INSERT INTO protocol_mapper VALUES ('793b7577-dce6-4d00-9518-54fd685540b2', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'b41ab070-1f92-4562-8f2c-965ab07138e0', NULL);
INSERT INTO protocol_mapper VALUES ('96295be5-2114-4b97-8f44-da19d108353a', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'b41ab070-1f92-4562-8f2c-965ab07138e0', NULL);
INSERT INTO protocol_mapper VALUES ('6e1fc862-8c41-495c-bc40-eb3d3ae31812', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'b41ab070-1f92-4562-8f2c-965ab07138e0', NULL);
INSERT INTO protocol_mapper VALUES ('f20eef92-7f45-4981-b3c0-fd8b6ff7ec96', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'b41ab070-1f92-4562-8f2c-965ab07138e0', NULL);
INSERT INTO protocol_mapper VALUES ('98ac557c-165c-4d65-aa82-47bcf71d1eac', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'b41ab070-1f92-4562-8f2c-965ab07138e0', NULL);
INSERT INTO protocol_mapper VALUES ('d28578aa-5c16-4f13-ba16-2e12a86e5155', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'f8692af8-3bed-4a28-891d-0b2e5de5e9a0', NULL);
INSERT INTO protocol_mapper VALUES ('8114bb1c-0012-4a61-bf92-664cb914ec84', 'business', 'openid-connect', 'oidc-usermodel-attribute-mapper', false, NULL, 'f8692af8-3bed-4a28-891d-0b2e5de5e9a0', NULL);
INSERT INTO protocol_mapper VALUES ('c0f858cb-dcab-4eed-a247-e0a309921cf4', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'f8692af8-3bed-4a28-891d-0b2e5de5e9a0', NULL);
INSERT INTO protocol_mapper VALUES ('47c78075-7033-47e1-b64c-2b510871c4df', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'f8692af8-3bed-4a28-891d-0b2e5de5e9a0', NULL);
INSERT INTO protocol_mapper VALUES ('f8af2a0c-3010-43dc-9206-f6616ce16467', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'f8692af8-3bed-4a28-891d-0b2e5de5e9a0', NULL);
INSERT INTO protocol_mapper VALUES ('d7878519-315b-49d6-8d7e-c01d5257d598', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'f8692af8-3bed-4a28-891d-0b2e5de5e9a0', NULL);
INSERT INTO protocol_mapper VALUES ('7ac0e221-b758-4081-a050-849bf409e091', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'f8692af8-3bed-4a28-891d-0b2e5de5e9a0', NULL);
INSERT INTO protocol_mapper VALUES ('7691315a-2396-48a2-b41d-66cb67e27f2f', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL);
INSERT INTO protocol_mapper VALUES ('1d62fd37-1329-4326-b353-b419274360a4', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL);
INSERT INTO protocol_mapper VALUES ('3d183075-34ba-4cd4-9a5a-daa1d67fa249', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL);
INSERT INTO protocol_mapper VALUES ('5a9b4139-9423-4672-b4f1-e18c9a09403a', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL);
INSERT INTO protocol_mapper VALUES ('0c5d49c0-fb01-409a-b2e9-023c5b0366b0', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL);
INSERT INTO protocol_mapper VALUES ('0290c229-3264-4885-9522-a9be10928749', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '8f8d9417-ed6c-481a-bac6-f2735a298156', NULL);
INSERT INTO protocol_mapper VALUES ('5cd9937c-631c-456f-bf19-0e11340b0ace', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '8210d5e2-cc3c-4eb6-be99-3a32667a378a', NULL);
INSERT INTO protocol_mapper VALUES ('73b6a4af-1d09-40f1-a202-75897aa60e61', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '8210d5e2-cc3c-4eb6-be99-3a32667a378a', NULL);
INSERT INTO protocol_mapper VALUES ('59f686ed-ee07-42f0-a417-eed4eee5d7d6', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '8210d5e2-cc3c-4eb6-be99-3a32667a378a', NULL);
INSERT INTO protocol_mapper VALUES ('e54f85df-4f20-4659-b1f5-9187229913a2', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '8210d5e2-cc3c-4eb6-be99-3a32667a378a', NULL);
INSERT INTO protocol_mapper VALUES ('b4dcc008-3bf2-401d-b459-89b8e3d6d1f9', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '8210d5e2-cc3c-4eb6-be99-3a32667a378a', NULL);
INSERT INTO protocol_mapper VALUES ('13da77e9-2836-455f-be7c-0c2b693161c2', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '8210d5e2-cc3c-4eb6-be99-3a32667a378a', NULL);
INSERT INTO protocol_mapper VALUES ('5f713740-890b-4e75-a85f-9196599de876', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', false, '${locale}', '8210d5e2-cc3c-4eb6-be99-3a32667a378a', NULL);
INSERT INTO protocol_mapper VALUES ('465d8b8c-65c5-476c-9607-a9c24595fd78', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', NULL);
INSERT INTO protocol_mapper VALUES ('659b9c81-3dda-49c9-9473-d490c35c99c3', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', NULL);
INSERT INTO protocol_mapper VALUES ('82a99f59-c24d-4a69-b4ba-bb0198706786', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', NULL);
INSERT INTO protocol_mapper VALUES ('cfbeb98b-e1d7-4268-b956-eea872444e8f', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', NULL);
INSERT INTO protocol_mapper VALUES ('0750676e-40bf-4ac5-b096-e79b553c1836', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', NULL);
INSERT INTO protocol_mapper VALUES ('2394f69d-b19e-4d4d-87ce-4efd0b0c89b3', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', NULL);
INSERT INTO protocol_mapper VALUES ('8e4e3cf5-a19b-43f2-b821-19e65cd2bbed', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '9b1705ee-b907-443e-9fd9-568448f312d3', NULL);
INSERT INTO protocol_mapper VALUES ('b3e05b61-49fb-4bf8-b39e-fcb77e456cc3', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL);
INSERT INTO protocol_mapper VALUES ('b9ea8fff-ea43-4903-9514-250ff229dbc8', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL);
INSERT INTO protocol_mapper VALUES ('c5957252-719d-4bc2-895f-ca0355e29f25', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL);
INSERT INTO protocol_mapper VALUES ('3429a882-345e-4c16-930b-445373112d0e', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL);
INSERT INTO protocol_mapper VALUES ('c085fd8f-eeb6-4b46-be52-c4ff06c83686', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '9b1705ee-b907-443e-9fd9-568448f312d3', NULL);
INSERT INTO protocol_mapper VALUES ('9219b8c1-c34e-42e8-b7a8-95397625411c', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '5bb93364-13a4-4071-8275-14083447bba4', NULL);
INSERT INTO protocol_mapper VALUES ('da4d213e-da85-450b-83ff-d76cff8233dd', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '5bb93364-13a4-4071-8275-14083447bba4', NULL);
INSERT INTO protocol_mapper VALUES ('961f737e-8bb0-47d5-baba-06c1eff01e9f', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '5bb93364-13a4-4071-8275-14083447bba4', NULL);
INSERT INTO protocol_mapper VALUES ('d116367b-0fb6-4bf5-b05a-160c6af040c5', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '5bb93364-13a4-4071-8275-14083447bba4', NULL);
INSERT INTO protocol_mapper VALUES ('31a60a36-5213-43ce-9bd5-b5b56df7be94', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '5bb93364-13a4-4071-8275-14083447bba4', NULL);
INSERT INTO protocol_mapper VALUES ('aceb6ad5-4b04-45bc-8346-00cb7c7eebd4', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '5bb93364-13a4-4071-8275-14083447bba4', NULL);
INSERT INTO protocol_mapper VALUES ('b348320a-65e9-4775-8612-1ee081521f49', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', NULL);
INSERT INTO protocol_mapper VALUES ('b7107c1c-cde4-4145-bb44-65a6a354b4bc', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', NULL);
INSERT INTO protocol_mapper VALUES ('3c659083-47fd-431f-8449-56eead903a58', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', NULL);
INSERT INTO protocol_mapper VALUES ('2b0c9785-88b2-42b1-974e-e132292b2a37', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', NULL);
INSERT INTO protocol_mapper VALUES ('a60b31d0-72b8-4aed-9a13-724d255e4ee2', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', NULL);
INSERT INTO protocol_mapper VALUES ('2715500c-6596-43da-bcea-08ff91796d35', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', NULL);
INSERT INTO protocol_mapper VALUES ('cb6e4e71-93b7-4cf3-81eb-4eb680d62dd4', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '9027ac22-28b7-4c20-8de2-14f338db5580', NULL);
INSERT INTO protocol_mapper VALUES ('d8c2db1d-110a-4c05-8290-b13ef121edb6', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '9027ac22-28b7-4c20-8de2-14f338db5580', NULL);
INSERT INTO protocol_mapper VALUES ('8d87a25c-5bea-4592-985a-56a4d193bea6', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '9027ac22-28b7-4c20-8de2-14f338db5580', NULL);
INSERT INTO protocol_mapper VALUES ('4c120972-1c87-4471-8b89-3150d9498f9a', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '9027ac22-28b7-4c20-8de2-14f338db5580', NULL);
INSERT INTO protocol_mapper VALUES ('d16d4e85-02f0-4788-bac7-8505cffb3fa4', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '9027ac22-28b7-4c20-8de2-14f338db5580', NULL);
INSERT INTO protocol_mapper VALUES ('225ff267-4640-4751-8253-34fef25e2e6f', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '9027ac22-28b7-4c20-8de2-14f338db5580', NULL);
INSERT INTO protocol_mapper VALUES ('b416c3c7-49d0-4179-b1d8-9bcba7ade9bb', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '9d135049-107a-43fd-af59-46bfbe870158', NULL);
INSERT INTO protocol_mapper VALUES ('9e6f6349-2f93-4eb3-9583-e5e03fdcddb2', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '9d135049-107a-43fd-af59-46bfbe870158', NULL);
INSERT INTO protocol_mapper VALUES ('82a53aa9-dbaf-4788-9c51-31d66d53d221', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '9d135049-107a-43fd-af59-46bfbe870158', NULL);
INSERT INTO protocol_mapper VALUES ('9f4827f6-a5da-44dc-8b05-faf97e1c0cc6', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '9d135049-107a-43fd-af59-46bfbe870158', NULL);
INSERT INTO protocol_mapper VALUES ('a3657ad2-3cbd-45f3-accf-d50018b0fa79', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '9d135049-107a-43fd-af59-46bfbe870158', NULL);
INSERT INTO protocol_mapper VALUES ('005ca01e-df5a-47fe-b394-6d3167d51e45', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '9d135049-107a-43fd-af59-46bfbe870158', NULL);
INSERT INTO protocol_mapper VALUES ('d9bf2e9e-0ef4-4d3d-ba45-4110e2857156', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'cc90450b-01a7-4178-bd2b-74cf91436f2f', NULL);
INSERT INTO protocol_mapper VALUES ('f7807fb9-76f3-4748-a79b-8d7687744611', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'cc90450b-01a7-4178-bd2b-74cf91436f2f', NULL);
INSERT INTO protocol_mapper VALUES ('b3bdd5bc-b687-4fef-aa27-205a3757192b', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'cc90450b-01a7-4178-bd2b-74cf91436f2f', NULL);
INSERT INTO protocol_mapper VALUES ('d3532850-2450-418e-8c4d-3bf4ebb94f56', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'cc90450b-01a7-4178-bd2b-74cf91436f2f', NULL);
INSERT INTO protocol_mapper VALUES ('0f671019-03b8-4ad1-a451-f04e19790e19', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'cc90450b-01a7-4178-bd2b-74cf91436f2f', NULL);
INSERT INTO protocol_mapper VALUES ('a6ca4ce6-bb60-4073-ba8e-93766cfc48e6', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'cc90450b-01a7-4178-bd2b-74cf91436f2f', NULL);
INSERT INTO protocol_mapper VALUES ('f36d0248-a06a-4faa-8163-49c4d544bfb4', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '3b1e3885-0b42-4569-84c7-dc7f2dd7183b', NULL);
INSERT INTO protocol_mapper VALUES ('e884d19f-d180-46b0-ba74-d1ed65f0bf60', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '3b1e3885-0b42-4569-84c7-dc7f2dd7183b', NULL);
INSERT INTO protocol_mapper VALUES ('a00583c9-2418-4a7f-afeb-1c113a8c9c8d', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '3b1e3885-0b42-4569-84c7-dc7f2dd7183b', NULL);
INSERT INTO protocol_mapper VALUES ('acd796a4-1212-460b-8851-3a6119fe25db', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '3b1e3885-0b42-4569-84c7-dc7f2dd7183b', NULL);
INSERT INTO protocol_mapper VALUES ('12b12841-db83-4ffa-8bea-968b33bc713f', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '3b1e3885-0b42-4569-84c7-dc7f2dd7183b', NULL);
INSERT INTO protocol_mapper VALUES ('c432a439-fe56-4737-adc6-02bd04196f14', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '3b1e3885-0b42-4569-84c7-dc7f2dd7183b', NULL);
INSERT INTO protocol_mapper VALUES ('bc7421c6-dba3-493b-bb75-b9912f242a10', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '11afe0d4-0779-410a-a962-f9c50bd3122f', NULL);
INSERT INTO protocol_mapper VALUES ('c6e0cd97-5ae1-4fab-8201-8c023f9f364c', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '11afe0d4-0779-410a-a962-f9c50bd3122f', NULL);
INSERT INTO protocol_mapper VALUES ('e89dfd5f-46d0-464f-a213-fb625be7c82b', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '11afe0d4-0779-410a-a962-f9c50bd3122f', NULL);
INSERT INTO protocol_mapper VALUES ('8c4cc255-433b-4057-a8a0-c7c7cafec29d', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '11afe0d4-0779-410a-a962-f9c50bd3122f', NULL);
INSERT INTO protocol_mapper VALUES ('c8d263df-c77c-4af5-a215-d1a6633be57e', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '11afe0d4-0779-410a-a962-f9c50bd3122f', NULL);
INSERT INTO protocol_mapper VALUES ('aedfedde-30f5-4311-973a-ae13971f9667', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '11afe0d4-0779-410a-a962-f9c50bd3122f', NULL);
INSERT INTO protocol_mapper VALUES ('12a7b1a8-47cf-4461-955e-db214e604ace', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'fd470925-9bc4-46ab-8e4b-e09094ba3c53', NULL);
INSERT INTO protocol_mapper VALUES ('9b8c3254-4bd0-4085-9032-330032c9085c', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'fd470925-9bc4-46ab-8e4b-e09094ba3c53', NULL);
INSERT INTO protocol_mapper VALUES ('e212bfe3-7709-4a14-b4e2-34215cee582d', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'fd470925-9bc4-46ab-8e4b-e09094ba3c53', NULL);
INSERT INTO protocol_mapper VALUES ('b59e6e14-8d29-46fc-ac49-25401d6f3aba', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'fd470925-9bc4-46ab-8e4b-e09094ba3c53', NULL);
INSERT INTO protocol_mapper VALUES ('465add93-6c33-4e6f-bb0b-e59c84a89044', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'fd470925-9bc4-46ab-8e4b-e09094ba3c53', NULL);
INSERT INTO protocol_mapper VALUES ('565760ff-7946-48b1-81ed-70b6e63177c4', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'fd470925-9bc4-46ab-8e4b-e09094ba3c53', NULL);
INSERT INTO protocol_mapper VALUES ('19af46a6-078b-474f-8f65-d14383275eb9', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', false, '${locale}', '9d135049-107a-43fd-af59-46bfbe870158', NULL);
INSERT INTO protocol_mapper VALUES ('23e2039d-7f9d-4343-bc95-3025509d5c08', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL);
INSERT INTO protocol_mapper VALUES ('0be16822-e4b3-4539-8a8e-e315340ef9eb', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL);
INSERT INTO protocol_mapper VALUES ('1a63f89f-5bd6-43bd-9e73-34a7c1226fb4', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL);
INSERT INTO protocol_mapper VALUES ('767fba71-8a7d-4307-9cae-bdb39b44a49a', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL);
INSERT INTO protocol_mapper VALUES ('3f0cd897-fba4-4e96-93b8-d658e4675617', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL);
INSERT INTO protocol_mapper VALUES ('6b3620ca-4501-4195-8999-27371b537137', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '102112b4-0529-46c4-afc3-5dded7a42ff9', NULL);
INSERT INTO protocol_mapper VALUES ('41dd64f2-8150-407d-8945-99b14558692d', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '8bc6a229-9e1d-4a74-8933-8fb0abf50fde', NULL);
INSERT INTO protocol_mapper VALUES ('ad476ec0-5165-4b7f-9d26-577886ca46e0', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '8bc6a229-9e1d-4a74-8933-8fb0abf50fde', NULL);
INSERT INTO protocol_mapper VALUES ('add91b90-1bce-405a-b127-291ff4f8b2e5', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '8bc6a229-9e1d-4a74-8933-8fb0abf50fde', NULL);
INSERT INTO protocol_mapper VALUES ('7ec6957a-949b-42eb-bf6a-db967baa673a', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '8bc6a229-9e1d-4a74-8933-8fb0abf50fde', NULL);
INSERT INTO protocol_mapper VALUES ('c6677bf5-999b-4eab-899c-d5e1a58de912', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '8bc6a229-9e1d-4a74-8933-8fb0abf50fde', NULL);
INSERT INTO protocol_mapper VALUES ('1f06bcd5-3e4a-4f46-819e-952cd51c7e78', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '8bc6a229-9e1d-4a74-8933-8fb0abf50fde', NULL);
INSERT INTO protocol_mapper VALUES ('8d14db4d-5c18-44e8-8a32-0f1418ecfa8a', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '819991a5-96df-4ab0-bec2-c9a1cfdf86aa', NULL);
INSERT INTO protocol_mapper VALUES ('9a7eed78-eca7-4fab-bc60-9a5ca1192d0a', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '819991a5-96df-4ab0-bec2-c9a1cfdf86aa', NULL);
INSERT INTO protocol_mapper VALUES ('4de0148e-4610-401f-b1e2-459d4b4ce3d0', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '819991a5-96df-4ab0-bec2-c9a1cfdf86aa', NULL);
INSERT INTO protocol_mapper VALUES ('cf99d710-20d5-41b1-bf5b-3e430c562136', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '819991a5-96df-4ab0-bec2-c9a1cfdf86aa', NULL);
INSERT INTO protocol_mapper VALUES ('2169fa9d-6dda-4182-91a7-67e5d8231a92', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '819991a5-96df-4ab0-bec2-c9a1cfdf86aa', NULL);
INSERT INTO protocol_mapper VALUES ('19ee051c-a0a2-4f33-b814-c388bebd00e1', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '819991a5-96df-4ab0-bec2-c9a1cfdf86aa', NULL);
INSERT INTO protocol_mapper VALUES ('b4962f2c-093b-4c9e-97b0-760254b3227e', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '6a832b8b-e8e6-46f6-8a99-85e147e0448a', NULL);
INSERT INTO protocol_mapper VALUES ('df7fcb66-e925-4379-b353-9dd03c83c760', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '6a832b8b-e8e6-46f6-8a99-85e147e0448a', NULL);
INSERT INTO protocol_mapper VALUES ('3e9f21ea-ac73-46fe-9f35-f1d02d0bb258', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '6a832b8b-e8e6-46f6-8a99-85e147e0448a', NULL);
INSERT INTO protocol_mapper VALUES ('fc4db302-d68e-46ba-b97b-af839a084550', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '6a832b8b-e8e6-46f6-8a99-85e147e0448a', NULL);
INSERT INTO protocol_mapper VALUES ('b97644a4-ac73-45b5-bcb6-87732ad4b2fa', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '6a832b8b-e8e6-46f6-8a99-85e147e0448a', NULL);
INSERT INTO protocol_mapper VALUES ('8b9b0d59-3aa0-4a7f-96c8-1ab22fc52953', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '6a832b8b-e8e6-46f6-8a99-85e147e0448a', NULL);
INSERT INTO protocol_mapper VALUES ('86a7a614-b8f2-4584-93e8-90ccd4dfb949', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '505e6b3f-1884-4b26-a68a-0635ff513fad', NULL);
INSERT INTO protocol_mapper VALUES ('fb029142-60b0-4dfb-9905-09508ba92370', 'business', 'openid-connect', 'oidc-usermodel-attribute-mapper', false, NULL, '505e6b3f-1884-4b26-a68a-0635ff513fad', NULL);
INSERT INTO protocol_mapper VALUES ('1c483f8a-9c29-4b7d-a6eb-3c38f86ed8ac', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '505e6b3f-1884-4b26-a68a-0635ff513fad', NULL);
INSERT INTO protocol_mapper VALUES ('2e649adc-0c34-4969-b6e6-06a2ec3c2159', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '505e6b3f-1884-4b26-a68a-0635ff513fad', NULL);
INSERT INTO protocol_mapper VALUES ('f97e0d70-f45a-4d4f-9282-f8ef3a14b0dc', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '505e6b3f-1884-4b26-a68a-0635ff513fad', NULL);
INSERT INTO protocol_mapper VALUES ('c689cdda-841e-4b18-b6d5-e61aee108241', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '505e6b3f-1884-4b26-a68a-0635ff513fad', NULL);
INSERT INTO protocol_mapper VALUES ('c33a9264-ea51-4b67-9a7a-6f55959f661d', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '505e6b3f-1884-4b26-a68a-0635ff513fad', NULL);
INSERT INTO protocol_mapper VALUES ('1aaf2ebf-3f21-4d06-8f34-7772eb943148', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL);
INSERT INTO protocol_mapper VALUES ('94c5198d-81bb-4c33-b2d9-633254fa9823', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL);
INSERT INTO protocol_mapper VALUES ('efb542f5-1815-4c5f-b3fc-0a04d35a2245', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL);
INSERT INTO protocol_mapper VALUES ('31cbd9fe-f107-44fe-94fa-20b1ecfc29d0', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL);
INSERT INTO protocol_mapper VALUES ('47d720a2-aaf6-4d8c-b562-5199d2e180cd', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL);
INSERT INTO protocol_mapper VALUES ('b4778825-6b35-4ebb-9274-cfa8baffa92e', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '1de8d9fb-fb3f-4671-bd6a-148ad6cfd9d5', NULL);
INSERT INTO protocol_mapper VALUES ('0b2ba676-dffe-4ed8-97c8-0605c15b5610', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, '3364267c-1dd3-4fdf-b323-2d05bf18beb5', NULL);
INSERT INTO protocol_mapper VALUES ('7b05989e-aac1-477d-8943-822ac0106c3d', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', '3364267c-1dd3-4fdf-b323-2d05bf18beb5', NULL);
INSERT INTO protocol_mapper VALUES ('928013b1-3d7a-4912-a024-9e6b0f8a8641', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', '3364267c-1dd3-4fdf-b323-2d05bf18beb5', NULL);
INSERT INTO protocol_mapper VALUES ('452cd390-3613-412c-ba1a-1f0f25868f34', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', false, '${locale}', '3364267c-1dd3-4fdf-b323-2d05bf18beb5', NULL);
INSERT INTO protocol_mapper VALUES ('1d4b3089-3785-4845-b121-0728b3c21ac7', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', '3364267c-1dd3-4fdf-b323-2d05bf18beb5', NULL);
INSERT INTO protocol_mapper VALUES ('a2423729-550f-4ed4-9426-7e6aecf9bc60', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', '3364267c-1dd3-4fdf-b323-2d05bf18beb5', NULL);
INSERT INTO protocol_mapper VALUES ('c6af9911-fecd-4b32-8729-803f7625293b', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', '3364267c-1dd3-4fdf-b323-2d05bf18beb5', NULL);
INSERT INTO protocol_mapper VALUES ('34599620-04dd-4425-b5d1-3475065a694c', 'full name', 'openid-connect', 'oidc-full-name-mapper', true, '${fullName}', 'cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', NULL);
INSERT INTO protocol_mapper VALUES ('163e2145-bec2-452a-978c-ba7570509475', 'role list', 'saml', 'saml-role-list-mapper', false, NULL, 'cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', NULL);
INSERT INTO protocol_mapper VALUES ('afc6c1ae-8ea2-4da4-a753-946d3653b87f', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${username}', 'cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', NULL);
INSERT INTO protocol_mapper VALUES ('40f0cf2d-b53a-41b4-bc65-62f0234a2821', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${familyName}', 'cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', NULL);
INSERT INTO protocol_mapper VALUES ('bc85be73-18e1-4120-9e1a-935c8d17673c', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${givenName}', 'cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', NULL);
INSERT INTO protocol_mapper VALUES ('4fd7006e-571f-4e01-8a7f-50c8f6ad6637', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', true, '${email}', 'cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', NULL);


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO protocol_mapper_config VALUES ('f95112fd-8de1-4637-8c30-bd01e72b543c', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('f95112fd-8de1-4637-8c30-bd01e72b543c', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('f95112fd-8de1-4637-8c30-bd01e72b543c', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('05b912ca-4d0a-4b55-96f4-db326373ce67', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('05b912ca-4d0a-4b55-96f4-db326373ce67', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('05b912ca-4d0a-4b55-96f4-db326373ce67', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('05b912ca-4d0a-4b55-96f4-db326373ce67', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('05b912ca-4d0a-4b55-96f4-db326373ce67', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('05b912ca-4d0a-4b55-96f4-db326373ce67', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('54b8d58a-2012-453e-9997-9541e65cf98f', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('54b8d58a-2012-453e-9997-9541e65cf98f', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('54b8d58a-2012-453e-9997-9541e65cf98f', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('54b8d58a-2012-453e-9997-9541e65cf98f', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('54b8d58a-2012-453e-9997-9541e65cf98f', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('54b8d58a-2012-453e-9997-9541e65cf98f', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('651d91f6-8bd4-45e5-a793-6e6a006785d3', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('651d91f6-8bd4-45e5-a793-6e6a006785d3', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('651d91f6-8bd4-45e5-a793-6e6a006785d3', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('651d91f6-8bd4-45e5-a793-6e6a006785d3', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('651d91f6-8bd4-45e5-a793-6e6a006785d3', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('651d91f6-8bd4-45e5-a793-6e6a006785d3', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('00921216-63c9-461e-8145-060e6162483e', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('00921216-63c9-461e-8145-060e6162483e', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('00921216-63c9-461e-8145-060e6162483e', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('00921216-63c9-461e-8145-060e6162483e', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('00921216-63c9-461e-8145-060e6162483e', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('00921216-63c9-461e-8145-060e6162483e', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('d36a13a9-4979-4cdf-8447-964ca4352e1b', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d36a13a9-4979-4cdf-8447-964ca4352e1b', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a0b44515-1722-4fbe-bd4a-33f76d41fd0a', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('a0b44515-1722-4fbe-bd4a-33f76d41fd0a', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('a0b44515-1722-4fbe-bd4a-33f76d41fd0a', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('b1ec9a41-c540-457e-9118-efa48f56c3c6', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b1ec9a41-c540-457e-9118-efa48f56c3c6', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b1ec9a41-c540-457e-9118-efa48f56c3c6', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b1ec9a41-c540-457e-9118-efa48f56c3c6', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b1ec9a41-c540-457e-9118-efa48f56c3c6', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b1ec9a41-c540-457e-9118-efa48f56c3c6', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('8f1f2ba1-0c56-44cf-b723-e26f0f891d93', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8f1f2ba1-0c56-44cf-b723-e26f0f891d93', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('8f1f2ba1-0c56-44cf-b723-e26f0f891d93', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8f1f2ba1-0c56-44cf-b723-e26f0f891d93', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8f1f2ba1-0c56-44cf-b723-e26f0f891d93', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('8f1f2ba1-0c56-44cf-b723-e26f0f891d93', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('9f5ed0af-29aa-4e8c-8f55-a3a170820e8a', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9f5ed0af-29aa-4e8c-8f55-a3a170820e8a', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('9f5ed0af-29aa-4e8c-8f55-a3a170820e8a', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9f5ed0af-29aa-4e8c-8f55-a3a170820e8a', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9f5ed0af-29aa-4e8c-8f55-a3a170820e8a', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('9f5ed0af-29aa-4e8c-8f55-a3a170820e8a', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('6488d0f9-74df-4ee7-9d9d-8a6d2dd38edb', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('6488d0f9-74df-4ee7-9d9d-8a6d2dd38edb', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('6488d0f9-74df-4ee7-9d9d-8a6d2dd38edb', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('6488d0f9-74df-4ee7-9d9d-8a6d2dd38edb', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('6488d0f9-74df-4ee7-9d9d-8a6d2dd38edb', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('6488d0f9-74df-4ee7-9d9d-8a6d2dd38edb', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('b81bbdfa-de23-48bc-959b-ab016bb408fe', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b81bbdfa-de23-48bc-959b-ab016bb408fe', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e1dc606b-1b35-4e33-b0bd-96ccfb2fd76d', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('e1dc606b-1b35-4e33-b0bd-96ccfb2fd76d', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('e1dc606b-1b35-4e33-b0bd-96ccfb2fd76d', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('7327a7cd-92c3-4d0b-ae71-03fd540f6714', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7327a7cd-92c3-4d0b-ae71-03fd540f6714', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('7327a7cd-92c3-4d0b-ae71-03fd540f6714', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7327a7cd-92c3-4d0b-ae71-03fd540f6714', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7327a7cd-92c3-4d0b-ae71-03fd540f6714', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('7327a7cd-92c3-4d0b-ae71-03fd540f6714', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('81cde12f-c585-4723-8166-370cf0a97add', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('81cde12f-c585-4723-8166-370cf0a97add', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('81cde12f-c585-4723-8166-370cf0a97add', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('81cde12f-c585-4723-8166-370cf0a97add', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('81cde12f-c585-4723-8166-370cf0a97add', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('81cde12f-c585-4723-8166-370cf0a97add', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('b19c09fa-fab2-451f-b4c1-91d000d2fcb1', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b19c09fa-fab2-451f-b4c1-91d000d2fcb1', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b19c09fa-fab2-451f-b4c1-91d000d2fcb1', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b19c09fa-fab2-451f-b4c1-91d000d2fcb1', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b19c09fa-fab2-451f-b4c1-91d000d2fcb1', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b19c09fa-fab2-451f-b4c1-91d000d2fcb1', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('f053ea09-884d-45b8-b461-aab768ae0548', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f053ea09-884d-45b8-b461-aab768ae0548', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('f053ea09-884d-45b8-b461-aab768ae0548', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f053ea09-884d-45b8-b461-aab768ae0548', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f053ea09-884d-45b8-b461-aab768ae0548', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('f053ea09-884d-45b8-b461-aab768ae0548', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('4e629be4-3dcc-435f-8d6b-2253b6f7480f', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('4e629be4-3dcc-435f-8d6b-2253b6f7480f', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0fb56878-b2b7-4e3d-b8c3-41bb4e8637c4', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('0fb56878-b2b7-4e3d-b8c3-41bb4e8637c4', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('0fb56878-b2b7-4e3d-b8c3-41bb4e8637c4', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('a0a73147-bdb7-4bb9-9266-90930b5d89ce', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a0a73147-bdb7-4bb9-9266-90930b5d89ce', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('a0a73147-bdb7-4bb9-9266-90930b5d89ce', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a0a73147-bdb7-4bb9-9266-90930b5d89ce', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a0a73147-bdb7-4bb9-9266-90930b5d89ce', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('a0a73147-bdb7-4bb9-9266-90930b5d89ce', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('7686ef42-2bf5-4ddd-b31f-38501ac6809b', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7686ef42-2bf5-4ddd-b31f-38501ac6809b', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('7686ef42-2bf5-4ddd-b31f-38501ac6809b', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7686ef42-2bf5-4ddd-b31f-38501ac6809b', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7686ef42-2bf5-4ddd-b31f-38501ac6809b', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('7686ef42-2bf5-4ddd-b31f-38501ac6809b', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('d5e27131-1010-490b-9ad2-42de550f36c1', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d5e27131-1010-490b-9ad2-42de550f36c1', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('d5e27131-1010-490b-9ad2-42de550f36c1', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d5e27131-1010-490b-9ad2-42de550f36c1', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d5e27131-1010-490b-9ad2-42de550f36c1', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('d5e27131-1010-490b-9ad2-42de550f36c1', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('ed12e601-e422-4680-b862-64e47948e59c', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('ed12e601-e422-4680-b862-64e47948e59c', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('ed12e601-e422-4680-b862-64e47948e59c', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('ed12e601-e422-4680-b862-64e47948e59c', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('ed12e601-e422-4680-b862-64e47948e59c', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('ed12e601-e422-4680-b862-64e47948e59c', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('80083d5c-9ad3-4981-b7e3-e17ed53a27a4', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('80083d5c-9ad3-4981-b7e3-e17ed53a27a4', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('793f62ef-73f8-4762-ac32-68e74f428b55', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('793f62ef-73f8-4762-ac32-68e74f428b55', 'locale', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('793f62ef-73f8-4762-ac32-68e74f428b55', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('793f62ef-73f8-4762-ac32-68e74f428b55', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('793f62ef-73f8-4762-ac32-68e74f428b55', 'locale', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('793f62ef-73f8-4762-ac32-68e74f428b55', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('01590ace-f237-4164-a6ba-6a9a18db7e4b', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('01590ace-f237-4164-a6ba-6a9a18db7e4b', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('01590ace-f237-4164-a6ba-6a9a18db7e4b', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('3d9e7d65-6de1-4d99-92d3-6e5d62364493', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3d9e7d65-6de1-4d99-92d3-6e5d62364493', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('3d9e7d65-6de1-4d99-92d3-6e5d62364493', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3d9e7d65-6de1-4d99-92d3-6e5d62364493', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3d9e7d65-6de1-4d99-92d3-6e5d62364493', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('3d9e7d65-6de1-4d99-92d3-6e5d62364493', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('d639a201-cc9d-4dfb-9f48-c9fa6816d82c', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d639a201-cc9d-4dfb-9f48-c9fa6816d82c', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('d639a201-cc9d-4dfb-9f48-c9fa6816d82c', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d639a201-cc9d-4dfb-9f48-c9fa6816d82c', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d639a201-cc9d-4dfb-9f48-c9fa6816d82c', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('d639a201-cc9d-4dfb-9f48-c9fa6816d82c', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('bdf09cca-558e-4aa5-9f3e-08ca385f0f7f', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('bdf09cca-558e-4aa5-9f3e-08ca385f0f7f', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('bdf09cca-558e-4aa5-9f3e-08ca385f0f7f', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('bdf09cca-558e-4aa5-9f3e-08ca385f0f7f', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('bdf09cca-558e-4aa5-9f3e-08ca385f0f7f', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('bdf09cca-558e-4aa5-9f3e-08ca385f0f7f', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('49be601a-9bee-4553-9ff2-9f4539a42a08', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('49be601a-9bee-4553-9ff2-9f4539a42a08', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('49be601a-9bee-4553-9ff2-9f4539a42a08', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('49be601a-9bee-4553-9ff2-9f4539a42a08', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('49be601a-9bee-4553-9ff2-9f4539a42a08', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('49be601a-9bee-4553-9ff2-9f4539a42a08', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('d3621c7e-f99e-464b-96a1-5757cb4c86c3', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d3621c7e-f99e-464b-96a1-5757cb4c86c3', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('76e383ed-cc1d-4a6a-939a-8000040830d2', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('76e383ed-cc1d-4a6a-939a-8000040830d2', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('76e383ed-cc1d-4a6a-939a-8000040830d2', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('8295ddeb-dd37-4730-9893-7dec3880fdae', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8295ddeb-dd37-4730-9893-7dec3880fdae', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('8295ddeb-dd37-4730-9893-7dec3880fdae', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8295ddeb-dd37-4730-9893-7dec3880fdae', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8295ddeb-dd37-4730-9893-7dec3880fdae', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('8295ddeb-dd37-4730-9893-7dec3880fdae', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('e2eb6ce6-bbe4-4ef7-afb7-37815c8d9779', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e2eb6ce6-bbe4-4ef7-afb7-37815c8d9779', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('e2eb6ce6-bbe4-4ef7-afb7-37815c8d9779', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e2eb6ce6-bbe4-4ef7-afb7-37815c8d9779', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e2eb6ce6-bbe4-4ef7-afb7-37815c8d9779', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('e2eb6ce6-bbe4-4ef7-afb7-37815c8d9779', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('3e1cae50-2b7b-40f4-8320-363f14c4ab87', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3e1cae50-2b7b-40f4-8320-363f14c4ab87', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('3e1cae50-2b7b-40f4-8320-363f14c4ab87', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3e1cae50-2b7b-40f4-8320-363f14c4ab87', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3e1cae50-2b7b-40f4-8320-363f14c4ab87', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('3e1cae50-2b7b-40f4-8320-363f14c4ab87', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('90cafe3d-0522-4d45-bdd1-eceec5394493', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('90cafe3d-0522-4d45-bdd1-eceec5394493', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('90cafe3d-0522-4d45-bdd1-eceec5394493', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('90cafe3d-0522-4d45-bdd1-eceec5394493', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('90cafe3d-0522-4d45-bdd1-eceec5394493', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('90cafe3d-0522-4d45-bdd1-eceec5394493', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('079eaa79-6e5b-4376-be02-20b09ddbbb7d', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('079eaa79-6e5b-4376-be02-20b09ddbbb7d', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9efec4fa-82b6-4cf1-bbc0-58054b1c6e70', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('9efec4fa-82b6-4cf1-bbc0-58054b1c6e70', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('9efec4fa-82b6-4cf1-bbc0-58054b1c6e70', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('84a7b2e2-8578-44b0-9fd1-0229153c37a4', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('84a7b2e2-8578-44b0-9fd1-0229153c37a4', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('84a7b2e2-8578-44b0-9fd1-0229153c37a4', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('84a7b2e2-8578-44b0-9fd1-0229153c37a4', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('84a7b2e2-8578-44b0-9fd1-0229153c37a4', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('84a7b2e2-8578-44b0-9fd1-0229153c37a4', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('06b89ae5-a460-4a1d-8bf5-f75d4b37175d', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('06b89ae5-a460-4a1d-8bf5-f75d4b37175d', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('06b89ae5-a460-4a1d-8bf5-f75d4b37175d', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('782fb24e-4ff2-496d-9af4-0d141821b4cb', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('782fb24e-4ff2-496d-9af4-0d141821b4cb', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('782fb24e-4ff2-496d-9af4-0d141821b4cb', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('782fb24e-4ff2-496d-9af4-0d141821b4cb', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('782fb24e-4ff2-496d-9af4-0d141821b4cb', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('782fb24e-4ff2-496d-9af4-0d141821b4cb', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('2278ba5f-55da-4481-8c6f-000f1f1e91f6', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2278ba5f-55da-4481-8c6f-000f1f1e91f6', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('2278ba5f-55da-4481-8c6f-000f1f1e91f6', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2278ba5f-55da-4481-8c6f-000f1f1e91f6', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2278ba5f-55da-4481-8c6f-000f1f1e91f6', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('2278ba5f-55da-4481-8c6f-000f1f1e91f6', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('b3562163-3048-4488-8059-02a2ea5ec036', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b3562163-3048-4488-8059-02a2ea5ec036', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b3562163-3048-4488-8059-02a2ea5ec036', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b3562163-3048-4488-8059-02a2ea5ec036', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b3562163-3048-4488-8059-02a2ea5ec036', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b3562163-3048-4488-8059-02a2ea5ec036', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('27f48305-f707-4804-a1a9-84ce2641827a', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('27f48305-f707-4804-a1a9-84ce2641827a', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('27f48305-f707-4804-a1a9-84ce2641827a', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('27f48305-f707-4804-a1a9-84ce2641827a', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('27f48305-f707-4804-a1a9-84ce2641827a', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('27f48305-f707-4804-a1a9-84ce2641827a', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('3dd7e928-2e00-4ac8-a9e4-5ae106691814', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('3dd7e928-2e00-4ac8-a9e4-5ae106691814', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('3dd7e928-2e00-4ac8-a9e4-5ae106691814', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('e649716c-fb2a-46b4-9484-42543829b913', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e649716c-fb2a-46b4-9484-42543829b913', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e649716c-fb2a-46b4-9484-42543829b913', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3ff71428-6f2c-48c1-89b7-d82be1e50ce2', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3ff71428-6f2c-48c1-89b7-d82be1e50ce2', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('3ff71428-6f2c-48c1-89b7-d82be1e50ce2', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3ff71428-6f2c-48c1-89b7-d82be1e50ce2', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3ff71428-6f2c-48c1-89b7-d82be1e50ce2', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('3ff71428-6f2c-48c1-89b7-d82be1e50ce2', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('2b3ac893-f0f2-48cb-8ddc-4b300b4323c5', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2b3ac893-f0f2-48cb-8ddc-4b300b4323c5', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('2b3ac893-f0f2-48cb-8ddc-4b300b4323c5', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2b3ac893-f0f2-48cb-8ddc-4b300b4323c5', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2b3ac893-f0f2-48cb-8ddc-4b300b4323c5', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('2b3ac893-f0f2-48cb-8ddc-4b300b4323c5', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('a5636e39-c241-4406-a825-db94b9d76123', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a5636e39-c241-4406-a825-db94b9d76123', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('a5636e39-c241-4406-a825-db94b9d76123', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a5636e39-c241-4406-a825-db94b9d76123', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a5636e39-c241-4406-a825-db94b9d76123', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('a5636e39-c241-4406-a825-db94b9d76123', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('3bb4dda0-571b-4082-9dac-9823b8031c08', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3bb4dda0-571b-4082-9dac-9823b8031c08', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('3bb4dda0-571b-4082-9dac-9823b8031c08', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3bb4dda0-571b-4082-9dac-9823b8031c08', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3bb4dda0-571b-4082-9dac-9823b8031c08', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('3bb4dda0-571b-4082-9dac-9823b8031c08', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('793b7577-dce6-4d00-9518-54fd685540b2', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('793b7577-dce6-4d00-9518-54fd685540b2', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('793b7577-dce6-4d00-9518-54fd685540b2', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('793b7577-dce6-4d00-9518-54fd685540b2', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('793b7577-dce6-4d00-9518-54fd685540b2', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('793b7577-dce6-4d00-9518-54fd685540b2', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('96295be5-2114-4b97-8f44-da19d108353a', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('96295be5-2114-4b97-8f44-da19d108353a', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('96295be5-2114-4b97-8f44-da19d108353a', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('6e1fc862-8c41-495c-bc40-eb3d3ae31812', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('6e1fc862-8c41-495c-bc40-eb3d3ae31812', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('6e1fc862-8c41-495c-bc40-eb3d3ae31812', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('6e1fc862-8c41-495c-bc40-eb3d3ae31812', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('6e1fc862-8c41-495c-bc40-eb3d3ae31812', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('6e1fc862-8c41-495c-bc40-eb3d3ae31812', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('f20eef92-7f45-4981-b3c0-fd8b6ff7ec96', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f20eef92-7f45-4981-b3c0-fd8b6ff7ec96', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f20eef92-7f45-4981-b3c0-fd8b6ff7ec96', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('98ac557c-165c-4d65-aa82-47bcf71d1eac', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('98ac557c-165c-4d65-aa82-47bcf71d1eac', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('98ac557c-165c-4d65-aa82-47bcf71d1eac', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('98ac557c-165c-4d65-aa82-47bcf71d1eac', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('98ac557c-165c-4d65-aa82-47bcf71d1eac', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('98ac557c-165c-4d65-aa82-47bcf71d1eac', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('d28578aa-5c16-4f13-ba16-2e12a86e5155', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('d28578aa-5c16-4f13-ba16-2e12a86e5155', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('d28578aa-5c16-4f13-ba16-2e12a86e5155', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('8114bb1c-0012-4a61-bf92-664cb914ec84', 'business', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('8114bb1c-0012-4a61-bf92-664cb914ec84', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8114bb1c-0012-4a61-bf92-664cb914ec84', 'business', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('8114bb1c-0012-4a61-bf92-664cb914ec84', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('c0f858cb-dcab-4eed-a247-e0a309921cf4', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c0f858cb-dcab-4eed-a247-e0a309921cf4', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('c0f858cb-dcab-4eed-a247-e0a309921cf4', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c0f858cb-dcab-4eed-a247-e0a309921cf4', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c0f858cb-dcab-4eed-a247-e0a309921cf4', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('c0f858cb-dcab-4eed-a247-e0a309921cf4', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('47c78075-7033-47e1-b64c-2b510871c4df', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('47c78075-7033-47e1-b64c-2b510871c4df', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('47c78075-7033-47e1-b64c-2b510871c4df', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f8af2a0c-3010-43dc-9206-f6616ce16467', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f8af2a0c-3010-43dc-9206-f6616ce16467', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('f8af2a0c-3010-43dc-9206-f6616ce16467', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f8af2a0c-3010-43dc-9206-f6616ce16467', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f8af2a0c-3010-43dc-9206-f6616ce16467', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('f8af2a0c-3010-43dc-9206-f6616ce16467', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('d7878519-315b-49d6-8d7e-c01d5257d598', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d7878519-315b-49d6-8d7e-c01d5257d598', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('d7878519-315b-49d6-8d7e-c01d5257d598', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d7878519-315b-49d6-8d7e-c01d5257d598', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d7878519-315b-49d6-8d7e-c01d5257d598', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('d7878519-315b-49d6-8d7e-c01d5257d598', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('7ac0e221-b758-4081-a050-849bf409e091', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7ac0e221-b758-4081-a050-849bf409e091', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('7ac0e221-b758-4081-a050-849bf409e091', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7ac0e221-b758-4081-a050-849bf409e091', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7ac0e221-b758-4081-a050-849bf409e091', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('7ac0e221-b758-4081-a050-849bf409e091', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('7691315a-2396-48a2-b41d-66cb67e27f2f', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7691315a-2396-48a2-b41d-66cb67e27f2f', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('7691315a-2396-48a2-b41d-66cb67e27f2f', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7691315a-2396-48a2-b41d-66cb67e27f2f', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7691315a-2396-48a2-b41d-66cb67e27f2f', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('7691315a-2396-48a2-b41d-66cb67e27f2f', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('1d62fd37-1329-4326-b353-b419274360a4', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('1d62fd37-1329-4326-b353-b419274360a4', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('1d62fd37-1329-4326-b353-b419274360a4', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('3d183075-34ba-4cd4-9a5a-daa1d67fa249', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3d183075-34ba-4cd4-9a5a-daa1d67fa249', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('3d183075-34ba-4cd4-9a5a-daa1d67fa249', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3d183075-34ba-4cd4-9a5a-daa1d67fa249', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3d183075-34ba-4cd4-9a5a-daa1d67fa249', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('3d183075-34ba-4cd4-9a5a-daa1d67fa249', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('5a9b4139-9423-4672-b4f1-e18c9a09403a', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('5a9b4139-9423-4672-b4f1-e18c9a09403a', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('5a9b4139-9423-4672-b4f1-e18c9a09403a', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('5a9b4139-9423-4672-b4f1-e18c9a09403a', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('5a9b4139-9423-4672-b4f1-e18c9a09403a', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('5a9b4139-9423-4672-b4f1-e18c9a09403a', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('0c5d49c0-fb01-409a-b2e9-023c5b0366b0', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0c5d49c0-fb01-409a-b2e9-023c5b0366b0', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0c5d49c0-fb01-409a-b2e9-023c5b0366b0', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0290c229-3264-4885-9522-a9be10928749', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0290c229-3264-4885-9522-a9be10928749', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('0290c229-3264-4885-9522-a9be10928749', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0290c229-3264-4885-9522-a9be10928749', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0290c229-3264-4885-9522-a9be10928749', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('0290c229-3264-4885-9522-a9be10928749', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('5cd9937c-631c-456f-bf19-0e11340b0ace', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('5cd9937c-631c-456f-bf19-0e11340b0ace', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('5cd9937c-631c-456f-bf19-0e11340b0ace', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('5cd9937c-631c-456f-bf19-0e11340b0ace', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('5cd9937c-631c-456f-bf19-0e11340b0ace', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('5cd9937c-631c-456f-bf19-0e11340b0ace', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('73b6a4af-1d09-40f1-a202-75897aa60e61', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('73b6a4af-1d09-40f1-a202-75897aa60e61', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('73b6a4af-1d09-40f1-a202-75897aa60e61', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('73b6a4af-1d09-40f1-a202-75897aa60e61', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('73b6a4af-1d09-40f1-a202-75897aa60e61', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('73b6a4af-1d09-40f1-a202-75897aa60e61', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('59f686ed-ee07-42f0-a417-eed4eee5d7d6', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('59f686ed-ee07-42f0-a417-eed4eee5d7d6', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('59f686ed-ee07-42f0-a417-eed4eee5d7d6', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e54f85df-4f20-4659-b1f5-9187229913a2', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('e54f85df-4f20-4659-b1f5-9187229913a2', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('e54f85df-4f20-4659-b1f5-9187229913a2', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('b4dcc008-3bf2-401d-b459-89b8e3d6d1f9', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b4dcc008-3bf2-401d-b459-89b8e3d6d1f9', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b4dcc008-3bf2-401d-b459-89b8e3d6d1f9', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b4dcc008-3bf2-401d-b459-89b8e3d6d1f9', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b4dcc008-3bf2-401d-b459-89b8e3d6d1f9', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b4dcc008-3bf2-401d-b459-89b8e3d6d1f9', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('13da77e9-2836-455f-be7c-0c2b693161c2', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('13da77e9-2836-455f-be7c-0c2b693161c2', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('13da77e9-2836-455f-be7c-0c2b693161c2', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('13da77e9-2836-455f-be7c-0c2b693161c2', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('13da77e9-2836-455f-be7c-0c2b693161c2', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('13da77e9-2836-455f-be7c-0c2b693161c2', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('5f713740-890b-4e75-a85f-9196599de876', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('5f713740-890b-4e75-a85f-9196599de876', 'locale', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('5f713740-890b-4e75-a85f-9196599de876', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('5f713740-890b-4e75-a85f-9196599de876', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('5f713740-890b-4e75-a85f-9196599de876', 'locale', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('5f713740-890b-4e75-a85f-9196599de876', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('465d8b8c-65c5-476c-9607-a9c24595fd78', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('465d8b8c-65c5-476c-9607-a9c24595fd78', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('465d8b8c-65c5-476c-9607-a9c24595fd78', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('659b9c81-3dda-49c9-9473-d490c35c99c3', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('659b9c81-3dda-49c9-9473-d490c35c99c3', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('659b9c81-3dda-49c9-9473-d490c35c99c3', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('82a99f59-c24d-4a69-b4ba-bb0198706786', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('82a99f59-c24d-4a69-b4ba-bb0198706786', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('82a99f59-c24d-4a69-b4ba-bb0198706786', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('82a99f59-c24d-4a69-b4ba-bb0198706786', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('82a99f59-c24d-4a69-b4ba-bb0198706786', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('82a99f59-c24d-4a69-b4ba-bb0198706786', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('cfbeb98b-e1d7-4268-b956-eea872444e8f', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('cfbeb98b-e1d7-4268-b956-eea872444e8f', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('cfbeb98b-e1d7-4268-b956-eea872444e8f', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('cfbeb98b-e1d7-4268-b956-eea872444e8f', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('cfbeb98b-e1d7-4268-b956-eea872444e8f', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('cfbeb98b-e1d7-4268-b956-eea872444e8f', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('0750676e-40bf-4ac5-b096-e79b553c1836', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0750676e-40bf-4ac5-b096-e79b553c1836', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('0750676e-40bf-4ac5-b096-e79b553c1836', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0750676e-40bf-4ac5-b096-e79b553c1836', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0750676e-40bf-4ac5-b096-e79b553c1836', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('0750676e-40bf-4ac5-b096-e79b553c1836', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('2394f69d-b19e-4d4d-87ce-4efd0b0c89b3', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2394f69d-b19e-4d4d-87ce-4efd0b0c89b3', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('2394f69d-b19e-4d4d-87ce-4efd0b0c89b3', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2394f69d-b19e-4d4d-87ce-4efd0b0c89b3', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2394f69d-b19e-4d4d-87ce-4efd0b0c89b3', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('2394f69d-b19e-4d4d-87ce-4efd0b0c89b3', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('8e4e3cf5-a19b-43f2-b821-19e65cd2bbed', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('8e4e3cf5-a19b-43f2-b821-19e65cd2bbed', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('8e4e3cf5-a19b-43f2-b821-19e65cd2bbed', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('b3e05b61-49fb-4bf8-b39e-fcb77e456cc3', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b3e05b61-49fb-4bf8-b39e-fcb77e456cc3', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b3e05b61-49fb-4bf8-b39e-fcb77e456cc3', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b3e05b61-49fb-4bf8-b39e-fcb77e456cc3', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b3e05b61-49fb-4bf8-b39e-fcb77e456cc3', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b3e05b61-49fb-4bf8-b39e-fcb77e456cc3', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('b9ea8fff-ea43-4903-9514-250ff229dbc8', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b9ea8fff-ea43-4903-9514-250ff229dbc8', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b9ea8fff-ea43-4903-9514-250ff229dbc8', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b9ea8fff-ea43-4903-9514-250ff229dbc8', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b9ea8fff-ea43-4903-9514-250ff229dbc8', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b9ea8fff-ea43-4903-9514-250ff229dbc8', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('c5957252-719d-4bc2-895f-ca0355e29f25', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c5957252-719d-4bc2-895f-ca0355e29f25', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('c5957252-719d-4bc2-895f-ca0355e29f25', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c5957252-719d-4bc2-895f-ca0355e29f25', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c5957252-719d-4bc2-895f-ca0355e29f25', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('c5957252-719d-4bc2-895f-ca0355e29f25', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('3429a882-345e-4c16-930b-445373112d0e', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3429a882-345e-4c16-930b-445373112d0e', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('3429a882-345e-4c16-930b-445373112d0e', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3429a882-345e-4c16-930b-445373112d0e', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3429a882-345e-4c16-930b-445373112d0e', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('3429a882-345e-4c16-930b-445373112d0e', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('c085fd8f-eeb6-4b46-be52-c4ff06c83686', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c085fd8f-eeb6-4b46-be52-c4ff06c83686', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9219b8c1-c34e-42e8-b7a8-95397625411c', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('9219b8c1-c34e-42e8-b7a8-95397625411c', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('9219b8c1-c34e-42e8-b7a8-95397625411c', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('da4d213e-da85-450b-83ff-d76cff8233dd', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('da4d213e-da85-450b-83ff-d76cff8233dd', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('da4d213e-da85-450b-83ff-d76cff8233dd', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('da4d213e-da85-450b-83ff-d76cff8233dd', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('da4d213e-da85-450b-83ff-d76cff8233dd', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('da4d213e-da85-450b-83ff-d76cff8233dd', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('961f737e-8bb0-47d5-baba-06c1eff01e9f', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('961f737e-8bb0-47d5-baba-06c1eff01e9f', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('961f737e-8bb0-47d5-baba-06c1eff01e9f', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('961f737e-8bb0-47d5-baba-06c1eff01e9f', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('961f737e-8bb0-47d5-baba-06c1eff01e9f', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('961f737e-8bb0-47d5-baba-06c1eff01e9f', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('d116367b-0fb6-4bf5-b05a-160c6af040c5', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d116367b-0fb6-4bf5-b05a-160c6af040c5', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('d116367b-0fb6-4bf5-b05a-160c6af040c5', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d116367b-0fb6-4bf5-b05a-160c6af040c5', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d116367b-0fb6-4bf5-b05a-160c6af040c5', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('d116367b-0fb6-4bf5-b05a-160c6af040c5', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('31a60a36-5213-43ce-9bd5-b5b56df7be94', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('31a60a36-5213-43ce-9bd5-b5b56df7be94', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('31a60a36-5213-43ce-9bd5-b5b56df7be94', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('31a60a36-5213-43ce-9bd5-b5b56df7be94', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('31a60a36-5213-43ce-9bd5-b5b56df7be94', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('31a60a36-5213-43ce-9bd5-b5b56df7be94', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('aceb6ad5-4b04-45bc-8346-00cb7c7eebd4', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('aceb6ad5-4b04-45bc-8346-00cb7c7eebd4', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b348320a-65e9-4775-8612-1ee081521f49', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('b348320a-65e9-4775-8612-1ee081521f49', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('b348320a-65e9-4775-8612-1ee081521f49', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('b7107c1c-cde4-4145-bb44-65a6a354b4bc', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b7107c1c-cde4-4145-bb44-65a6a354b4bc', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b7107c1c-cde4-4145-bb44-65a6a354b4bc', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b7107c1c-cde4-4145-bb44-65a6a354b4bc', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b7107c1c-cde4-4145-bb44-65a6a354b4bc', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b7107c1c-cde4-4145-bb44-65a6a354b4bc', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('3c659083-47fd-431f-8449-56eead903a58', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3c659083-47fd-431f-8449-56eead903a58', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('3c659083-47fd-431f-8449-56eead903a58', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3c659083-47fd-431f-8449-56eead903a58', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3c659083-47fd-431f-8449-56eead903a58', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('3c659083-47fd-431f-8449-56eead903a58', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('2b0c9785-88b2-42b1-974e-e132292b2a37', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2b0c9785-88b2-42b1-974e-e132292b2a37', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('2b0c9785-88b2-42b1-974e-e132292b2a37', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2b0c9785-88b2-42b1-974e-e132292b2a37', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2b0c9785-88b2-42b1-974e-e132292b2a37', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('2b0c9785-88b2-42b1-974e-e132292b2a37', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('a60b31d0-72b8-4aed-9a13-724d255e4ee2', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a60b31d0-72b8-4aed-9a13-724d255e4ee2', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('a60b31d0-72b8-4aed-9a13-724d255e4ee2', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a60b31d0-72b8-4aed-9a13-724d255e4ee2', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a60b31d0-72b8-4aed-9a13-724d255e4ee2', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('a60b31d0-72b8-4aed-9a13-724d255e4ee2', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('2715500c-6596-43da-bcea-08ff91796d35', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2715500c-6596-43da-bcea-08ff91796d35', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('cb6e4e71-93b7-4cf3-81eb-4eb680d62dd4', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('cb6e4e71-93b7-4cf3-81eb-4eb680d62dd4', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('cb6e4e71-93b7-4cf3-81eb-4eb680d62dd4', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('d8c2db1d-110a-4c05-8290-b13ef121edb6', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d8c2db1d-110a-4c05-8290-b13ef121edb6', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('d8c2db1d-110a-4c05-8290-b13ef121edb6', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d8c2db1d-110a-4c05-8290-b13ef121edb6', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d8c2db1d-110a-4c05-8290-b13ef121edb6', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('d8c2db1d-110a-4c05-8290-b13ef121edb6', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('8d87a25c-5bea-4592-985a-56a4d193bea6', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8d87a25c-5bea-4592-985a-56a4d193bea6', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('8d87a25c-5bea-4592-985a-56a4d193bea6', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8d87a25c-5bea-4592-985a-56a4d193bea6', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8d87a25c-5bea-4592-985a-56a4d193bea6', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('8d87a25c-5bea-4592-985a-56a4d193bea6', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('4c120972-1c87-4471-8b89-3150d9498f9a', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('4c120972-1c87-4471-8b89-3150d9498f9a', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('4c120972-1c87-4471-8b89-3150d9498f9a', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('4c120972-1c87-4471-8b89-3150d9498f9a', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('4c120972-1c87-4471-8b89-3150d9498f9a', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('4c120972-1c87-4471-8b89-3150d9498f9a', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('d16d4e85-02f0-4788-bac7-8505cffb3fa4', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d16d4e85-02f0-4788-bac7-8505cffb3fa4', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('d16d4e85-02f0-4788-bac7-8505cffb3fa4', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d16d4e85-02f0-4788-bac7-8505cffb3fa4', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d16d4e85-02f0-4788-bac7-8505cffb3fa4', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('d16d4e85-02f0-4788-bac7-8505cffb3fa4', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('225ff267-4640-4751-8253-34fef25e2e6f', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('225ff267-4640-4751-8253-34fef25e2e6f', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b416c3c7-49d0-4179-b1d8-9bcba7ade9bb', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('b416c3c7-49d0-4179-b1d8-9bcba7ade9bb', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('b416c3c7-49d0-4179-b1d8-9bcba7ade9bb', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('9e6f6349-2f93-4eb3-9583-e5e03fdcddb2', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9e6f6349-2f93-4eb3-9583-e5e03fdcddb2', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('9e6f6349-2f93-4eb3-9583-e5e03fdcddb2', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9e6f6349-2f93-4eb3-9583-e5e03fdcddb2', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9e6f6349-2f93-4eb3-9583-e5e03fdcddb2', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('9e6f6349-2f93-4eb3-9583-e5e03fdcddb2', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('82a53aa9-dbaf-4788-9c51-31d66d53d221', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('82a53aa9-dbaf-4788-9c51-31d66d53d221', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('82a53aa9-dbaf-4788-9c51-31d66d53d221', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('82a53aa9-dbaf-4788-9c51-31d66d53d221', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('82a53aa9-dbaf-4788-9c51-31d66d53d221', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('82a53aa9-dbaf-4788-9c51-31d66d53d221', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('9f4827f6-a5da-44dc-8b05-faf97e1c0cc6', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9f4827f6-a5da-44dc-8b05-faf97e1c0cc6', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('9f4827f6-a5da-44dc-8b05-faf97e1c0cc6', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9f4827f6-a5da-44dc-8b05-faf97e1c0cc6', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9f4827f6-a5da-44dc-8b05-faf97e1c0cc6', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('9f4827f6-a5da-44dc-8b05-faf97e1c0cc6', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('a3657ad2-3cbd-45f3-accf-d50018b0fa79', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a3657ad2-3cbd-45f3-accf-d50018b0fa79', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('a3657ad2-3cbd-45f3-accf-d50018b0fa79', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a3657ad2-3cbd-45f3-accf-d50018b0fa79', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a3657ad2-3cbd-45f3-accf-d50018b0fa79', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('a3657ad2-3cbd-45f3-accf-d50018b0fa79', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('005ca01e-df5a-47fe-b394-6d3167d51e45', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('005ca01e-df5a-47fe-b394-6d3167d51e45', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d9bf2e9e-0ef4-4d3d-ba45-4110e2857156', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('d9bf2e9e-0ef4-4d3d-ba45-4110e2857156', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('d9bf2e9e-0ef4-4d3d-ba45-4110e2857156', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('f7807fb9-76f3-4748-a79b-8d7687744611', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f7807fb9-76f3-4748-a79b-8d7687744611', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('f7807fb9-76f3-4748-a79b-8d7687744611', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f7807fb9-76f3-4748-a79b-8d7687744611', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f7807fb9-76f3-4748-a79b-8d7687744611', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('f7807fb9-76f3-4748-a79b-8d7687744611', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('b3bdd5bc-b687-4fef-aa27-205a3757192b', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b3bdd5bc-b687-4fef-aa27-205a3757192b', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b3bdd5bc-b687-4fef-aa27-205a3757192b', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b3bdd5bc-b687-4fef-aa27-205a3757192b', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b3bdd5bc-b687-4fef-aa27-205a3757192b', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b3bdd5bc-b687-4fef-aa27-205a3757192b', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('d3532850-2450-418e-8c4d-3bf4ebb94f56', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d3532850-2450-418e-8c4d-3bf4ebb94f56', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('d3532850-2450-418e-8c4d-3bf4ebb94f56', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d3532850-2450-418e-8c4d-3bf4ebb94f56', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('d3532850-2450-418e-8c4d-3bf4ebb94f56', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('d3532850-2450-418e-8c4d-3bf4ebb94f56', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('0f671019-03b8-4ad1-a451-f04e19790e19', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0f671019-03b8-4ad1-a451-f04e19790e19', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('0f671019-03b8-4ad1-a451-f04e19790e19', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0f671019-03b8-4ad1-a451-f04e19790e19', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0f671019-03b8-4ad1-a451-f04e19790e19', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('0f671019-03b8-4ad1-a451-f04e19790e19', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('a6ca4ce6-bb60-4073-ba8e-93766cfc48e6', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a6ca4ce6-bb60-4073-ba8e-93766cfc48e6', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f36d0248-a06a-4faa-8163-49c4d544bfb4', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('f36d0248-a06a-4faa-8163-49c4d544bfb4', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('f36d0248-a06a-4faa-8163-49c4d544bfb4', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('e884d19f-d180-46b0-ba74-d1ed65f0bf60', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e884d19f-d180-46b0-ba74-d1ed65f0bf60', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('e884d19f-d180-46b0-ba74-d1ed65f0bf60', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e884d19f-d180-46b0-ba74-d1ed65f0bf60', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e884d19f-d180-46b0-ba74-d1ed65f0bf60', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('e884d19f-d180-46b0-ba74-d1ed65f0bf60', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('a00583c9-2418-4a7f-afeb-1c113a8c9c8d', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a00583c9-2418-4a7f-afeb-1c113a8c9c8d', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('a00583c9-2418-4a7f-afeb-1c113a8c9c8d', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a00583c9-2418-4a7f-afeb-1c113a8c9c8d', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a00583c9-2418-4a7f-afeb-1c113a8c9c8d', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('a00583c9-2418-4a7f-afeb-1c113a8c9c8d', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('acd796a4-1212-460b-8851-3a6119fe25db', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('acd796a4-1212-460b-8851-3a6119fe25db', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('acd796a4-1212-460b-8851-3a6119fe25db', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('acd796a4-1212-460b-8851-3a6119fe25db', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('acd796a4-1212-460b-8851-3a6119fe25db', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('acd796a4-1212-460b-8851-3a6119fe25db', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('12b12841-db83-4ffa-8bea-968b33bc713f', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('12b12841-db83-4ffa-8bea-968b33bc713f', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('12b12841-db83-4ffa-8bea-968b33bc713f', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('12b12841-db83-4ffa-8bea-968b33bc713f', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('12b12841-db83-4ffa-8bea-968b33bc713f', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('12b12841-db83-4ffa-8bea-968b33bc713f', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('c432a439-fe56-4737-adc6-02bd04196f14', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c432a439-fe56-4737-adc6-02bd04196f14', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('bc7421c6-dba3-493b-bb75-b9912f242a10', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('bc7421c6-dba3-493b-bb75-b9912f242a10', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('bc7421c6-dba3-493b-bb75-b9912f242a10', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('c6e0cd97-5ae1-4fab-8201-8c023f9f364c', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c6e0cd97-5ae1-4fab-8201-8c023f9f364c', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('c6e0cd97-5ae1-4fab-8201-8c023f9f364c', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c6e0cd97-5ae1-4fab-8201-8c023f9f364c', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c6e0cd97-5ae1-4fab-8201-8c023f9f364c', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('c6e0cd97-5ae1-4fab-8201-8c023f9f364c', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('e89dfd5f-46d0-464f-a213-fb625be7c82b', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e89dfd5f-46d0-464f-a213-fb625be7c82b', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('e89dfd5f-46d0-464f-a213-fb625be7c82b', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e89dfd5f-46d0-464f-a213-fb625be7c82b', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e89dfd5f-46d0-464f-a213-fb625be7c82b', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('e89dfd5f-46d0-464f-a213-fb625be7c82b', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('8c4cc255-433b-4057-a8a0-c7c7cafec29d', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8c4cc255-433b-4057-a8a0-c7c7cafec29d', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('8c4cc255-433b-4057-a8a0-c7c7cafec29d', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8c4cc255-433b-4057-a8a0-c7c7cafec29d', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8c4cc255-433b-4057-a8a0-c7c7cafec29d', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('8c4cc255-433b-4057-a8a0-c7c7cafec29d', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('c8d263df-c77c-4af5-a215-d1a6633be57e', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c8d263df-c77c-4af5-a215-d1a6633be57e', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('c8d263df-c77c-4af5-a215-d1a6633be57e', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c8d263df-c77c-4af5-a215-d1a6633be57e', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c8d263df-c77c-4af5-a215-d1a6633be57e', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('c8d263df-c77c-4af5-a215-d1a6633be57e', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('aedfedde-30f5-4311-973a-ae13971f9667', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('aedfedde-30f5-4311-973a-ae13971f9667', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('12a7b1a8-47cf-4461-955e-db214e604ace', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('12a7b1a8-47cf-4461-955e-db214e604ace', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('12a7b1a8-47cf-4461-955e-db214e604ace', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('9b8c3254-4bd0-4085-9032-330032c9085c', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9b8c3254-4bd0-4085-9032-330032c9085c', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('9b8c3254-4bd0-4085-9032-330032c9085c', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9b8c3254-4bd0-4085-9032-330032c9085c', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('9b8c3254-4bd0-4085-9032-330032c9085c', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('9b8c3254-4bd0-4085-9032-330032c9085c', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('e212bfe3-7709-4a14-b4e2-34215cee582d', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e212bfe3-7709-4a14-b4e2-34215cee582d', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('e212bfe3-7709-4a14-b4e2-34215cee582d', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e212bfe3-7709-4a14-b4e2-34215cee582d', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('e212bfe3-7709-4a14-b4e2-34215cee582d', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('e212bfe3-7709-4a14-b4e2-34215cee582d', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('b59e6e14-8d29-46fc-ac49-25401d6f3aba', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b59e6e14-8d29-46fc-ac49-25401d6f3aba', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b59e6e14-8d29-46fc-ac49-25401d6f3aba', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b59e6e14-8d29-46fc-ac49-25401d6f3aba', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b59e6e14-8d29-46fc-ac49-25401d6f3aba', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b59e6e14-8d29-46fc-ac49-25401d6f3aba', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('465add93-6c33-4e6f-bb0b-e59c84a89044', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('465add93-6c33-4e6f-bb0b-e59c84a89044', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('465add93-6c33-4e6f-bb0b-e59c84a89044', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('465add93-6c33-4e6f-bb0b-e59c84a89044', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('465add93-6c33-4e6f-bb0b-e59c84a89044', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('465add93-6c33-4e6f-bb0b-e59c84a89044', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('565760ff-7946-48b1-81ed-70b6e63177c4', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('565760ff-7946-48b1-81ed-70b6e63177c4', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('19af46a6-078b-474f-8f65-d14383275eb9', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('19af46a6-078b-474f-8f65-d14383275eb9', 'locale', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('19af46a6-078b-474f-8f65-d14383275eb9', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('19af46a6-078b-474f-8f65-d14383275eb9', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('19af46a6-078b-474f-8f65-d14383275eb9', 'locale', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('19af46a6-078b-474f-8f65-d14383275eb9', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('23e2039d-7f9d-4343-bc95-3025509d5c08', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('23e2039d-7f9d-4343-bc95-3025509d5c08', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('23e2039d-7f9d-4343-bc95-3025509d5c08', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('0be16822-e4b3-4539-8a8e-e315340ef9eb', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0be16822-e4b3-4539-8a8e-e315340ef9eb', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('0be16822-e4b3-4539-8a8e-e315340ef9eb', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0be16822-e4b3-4539-8a8e-e315340ef9eb', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('0be16822-e4b3-4539-8a8e-e315340ef9eb', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('0be16822-e4b3-4539-8a8e-e315340ef9eb', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('1a63f89f-5bd6-43bd-9e73-34a7c1226fb4', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1a63f89f-5bd6-43bd-9e73-34a7c1226fb4', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('1a63f89f-5bd6-43bd-9e73-34a7c1226fb4', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1a63f89f-5bd6-43bd-9e73-34a7c1226fb4', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1a63f89f-5bd6-43bd-9e73-34a7c1226fb4', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('1a63f89f-5bd6-43bd-9e73-34a7c1226fb4', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('767fba71-8a7d-4307-9cae-bdb39b44a49a', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('767fba71-8a7d-4307-9cae-bdb39b44a49a', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('767fba71-8a7d-4307-9cae-bdb39b44a49a', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('767fba71-8a7d-4307-9cae-bdb39b44a49a', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('767fba71-8a7d-4307-9cae-bdb39b44a49a', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('767fba71-8a7d-4307-9cae-bdb39b44a49a', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('3f0cd897-fba4-4e96-93b8-d658e4675617', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3f0cd897-fba4-4e96-93b8-d658e4675617', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('3f0cd897-fba4-4e96-93b8-d658e4675617', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3f0cd897-fba4-4e96-93b8-d658e4675617', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3f0cd897-fba4-4e96-93b8-d658e4675617', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('3f0cd897-fba4-4e96-93b8-d658e4675617', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('6b3620ca-4501-4195-8999-27371b537137', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('6b3620ca-4501-4195-8999-27371b537137', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('41dd64f2-8150-407d-8945-99b14558692d', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('41dd64f2-8150-407d-8945-99b14558692d', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('41dd64f2-8150-407d-8945-99b14558692d', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('ad476ec0-5165-4b7f-9d26-577886ca46e0', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('ad476ec0-5165-4b7f-9d26-577886ca46e0', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('ad476ec0-5165-4b7f-9d26-577886ca46e0', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('ad476ec0-5165-4b7f-9d26-577886ca46e0', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('ad476ec0-5165-4b7f-9d26-577886ca46e0', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('ad476ec0-5165-4b7f-9d26-577886ca46e0', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('add91b90-1bce-405a-b127-291ff4f8b2e5', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('add91b90-1bce-405a-b127-291ff4f8b2e5', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('add91b90-1bce-405a-b127-291ff4f8b2e5', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('7ec6957a-949b-42eb-bf6a-db967baa673a', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7ec6957a-949b-42eb-bf6a-db967baa673a', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('7ec6957a-949b-42eb-bf6a-db967baa673a', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7ec6957a-949b-42eb-bf6a-db967baa673a', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7ec6957a-949b-42eb-bf6a-db967baa673a', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('7ec6957a-949b-42eb-bf6a-db967baa673a', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('c6677bf5-999b-4eab-899c-d5e1a58de912', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c6677bf5-999b-4eab-899c-d5e1a58de912', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('c6677bf5-999b-4eab-899c-d5e1a58de912', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c6677bf5-999b-4eab-899c-d5e1a58de912', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c6677bf5-999b-4eab-899c-d5e1a58de912', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('c6677bf5-999b-4eab-899c-d5e1a58de912', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('1f06bcd5-3e4a-4f46-819e-952cd51c7e78', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1f06bcd5-3e4a-4f46-819e-952cd51c7e78', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('1f06bcd5-3e4a-4f46-819e-952cd51c7e78', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1f06bcd5-3e4a-4f46-819e-952cd51c7e78', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1f06bcd5-3e4a-4f46-819e-952cd51c7e78', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('1f06bcd5-3e4a-4f46-819e-952cd51c7e78', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('8d14db4d-5c18-44e8-8a32-0f1418ecfa8a', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8d14db4d-5c18-44e8-8a32-0f1418ecfa8a', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('8d14db4d-5c18-44e8-8a32-0f1418ecfa8a', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8d14db4d-5c18-44e8-8a32-0f1418ecfa8a', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8d14db4d-5c18-44e8-8a32-0f1418ecfa8a', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('8d14db4d-5c18-44e8-8a32-0f1418ecfa8a', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('9a7eed78-eca7-4fab-bc60-9a5ca1192d0a', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('9a7eed78-eca7-4fab-bc60-9a5ca1192d0a', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('9a7eed78-eca7-4fab-bc60-9a5ca1192d0a', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('4de0148e-4610-401f-b1e2-459d4b4ce3d0', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('4de0148e-4610-401f-b1e2-459d4b4ce3d0', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('4de0148e-4610-401f-b1e2-459d4b4ce3d0', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('cf99d710-20d5-41b1-bf5b-3e430c562136', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('cf99d710-20d5-41b1-bf5b-3e430c562136', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('cf99d710-20d5-41b1-bf5b-3e430c562136', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('cf99d710-20d5-41b1-bf5b-3e430c562136', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('cf99d710-20d5-41b1-bf5b-3e430c562136', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('cf99d710-20d5-41b1-bf5b-3e430c562136', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('2169fa9d-6dda-4182-91a7-67e5d8231a92', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2169fa9d-6dda-4182-91a7-67e5d8231a92', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('2169fa9d-6dda-4182-91a7-67e5d8231a92', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2169fa9d-6dda-4182-91a7-67e5d8231a92', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2169fa9d-6dda-4182-91a7-67e5d8231a92', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('2169fa9d-6dda-4182-91a7-67e5d8231a92', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('19ee051c-a0a2-4f33-b814-c388bebd00e1', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('19ee051c-a0a2-4f33-b814-c388bebd00e1', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('19ee051c-a0a2-4f33-b814-c388bebd00e1', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('19ee051c-a0a2-4f33-b814-c388bebd00e1', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('19ee051c-a0a2-4f33-b814-c388bebd00e1', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('19ee051c-a0a2-4f33-b814-c388bebd00e1', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('b4962f2c-093b-4c9e-97b0-760254b3227e', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b4962f2c-093b-4c9e-97b0-760254b3227e', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b4962f2c-093b-4c9e-97b0-760254b3227e', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b4962f2c-093b-4c9e-97b0-760254b3227e', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b4962f2c-093b-4c9e-97b0-760254b3227e', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b4962f2c-093b-4c9e-97b0-760254b3227e', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('df7fcb66-e925-4379-b353-9dd03c83c760', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('df7fcb66-e925-4379-b353-9dd03c83c760', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('df7fcb66-e925-4379-b353-9dd03c83c760', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('df7fcb66-e925-4379-b353-9dd03c83c760', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('df7fcb66-e925-4379-b353-9dd03c83c760', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('df7fcb66-e925-4379-b353-9dd03c83c760', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('3e9f21ea-ac73-46fe-9f35-f1d02d0bb258', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3e9f21ea-ac73-46fe-9f35-f1d02d0bb258', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('3e9f21ea-ac73-46fe-9f35-f1d02d0bb258', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('fc4db302-d68e-46ba-b97b-af839a084550', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('fc4db302-d68e-46ba-b97b-af839a084550', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('fc4db302-d68e-46ba-b97b-af839a084550', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('b97644a4-ac73-45b5-bcb6-87732ad4b2fa', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b97644a4-ac73-45b5-bcb6-87732ad4b2fa', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b97644a4-ac73-45b5-bcb6-87732ad4b2fa', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b97644a4-ac73-45b5-bcb6-87732ad4b2fa', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b97644a4-ac73-45b5-bcb6-87732ad4b2fa', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b97644a4-ac73-45b5-bcb6-87732ad4b2fa', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('8b9b0d59-3aa0-4a7f-96c8-1ab22fc52953', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8b9b0d59-3aa0-4a7f-96c8-1ab22fc52953', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('8b9b0d59-3aa0-4a7f-96c8-1ab22fc52953', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8b9b0d59-3aa0-4a7f-96c8-1ab22fc52953', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('8b9b0d59-3aa0-4a7f-96c8-1ab22fc52953', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('8b9b0d59-3aa0-4a7f-96c8-1ab22fc52953', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('86a7a614-b8f2-4584-93e8-90ccd4dfb949', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('86a7a614-b8f2-4584-93e8-90ccd4dfb949', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('86a7a614-b8f2-4584-93e8-90ccd4dfb949', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('fb029142-60b0-4dfb-9905-09508ba92370', 'business', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('fb029142-60b0-4dfb-9905-09508ba92370', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('fb029142-60b0-4dfb-9905-09508ba92370', 'business', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('fb029142-60b0-4dfb-9905-09508ba92370', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('1c483f8a-9c29-4b7d-a6eb-3c38f86ed8ac', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1c483f8a-9c29-4b7d-a6eb-3c38f86ed8ac', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('1c483f8a-9c29-4b7d-a6eb-3c38f86ed8ac', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1c483f8a-9c29-4b7d-a6eb-3c38f86ed8ac', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1c483f8a-9c29-4b7d-a6eb-3c38f86ed8ac', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('1c483f8a-9c29-4b7d-a6eb-3c38f86ed8ac', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('2e649adc-0c34-4969-b6e6-06a2ec3c2159', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2e649adc-0c34-4969-b6e6-06a2ec3c2159', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('2e649adc-0c34-4969-b6e6-06a2ec3c2159', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f97e0d70-f45a-4d4f-9282-f8ef3a14b0dc', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f97e0d70-f45a-4d4f-9282-f8ef3a14b0dc', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('f97e0d70-f45a-4d4f-9282-f8ef3a14b0dc', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f97e0d70-f45a-4d4f-9282-f8ef3a14b0dc', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('f97e0d70-f45a-4d4f-9282-f8ef3a14b0dc', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('f97e0d70-f45a-4d4f-9282-f8ef3a14b0dc', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('c689cdda-841e-4b18-b6d5-e61aee108241', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c689cdda-841e-4b18-b6d5-e61aee108241', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('c689cdda-841e-4b18-b6d5-e61aee108241', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c689cdda-841e-4b18-b6d5-e61aee108241', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c689cdda-841e-4b18-b6d5-e61aee108241', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('c689cdda-841e-4b18-b6d5-e61aee108241', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('c33a9264-ea51-4b67-9a7a-6f55959f661d', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c33a9264-ea51-4b67-9a7a-6f55959f661d', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('c33a9264-ea51-4b67-9a7a-6f55959f661d', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c33a9264-ea51-4b67-9a7a-6f55959f661d', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c33a9264-ea51-4b67-9a7a-6f55959f661d', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('c33a9264-ea51-4b67-9a7a-6f55959f661d', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('1aaf2ebf-3f21-4d06-8f34-7772eb943148', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1aaf2ebf-3f21-4d06-8f34-7772eb943148', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('1aaf2ebf-3f21-4d06-8f34-7772eb943148', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1aaf2ebf-3f21-4d06-8f34-7772eb943148', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1aaf2ebf-3f21-4d06-8f34-7772eb943148', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('1aaf2ebf-3f21-4d06-8f34-7772eb943148', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('94c5198d-81bb-4c33-b2d9-633254fa9823', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('94c5198d-81bb-4c33-b2d9-633254fa9823', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('94c5198d-81bb-4c33-b2d9-633254fa9823', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('94c5198d-81bb-4c33-b2d9-633254fa9823', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('94c5198d-81bb-4c33-b2d9-633254fa9823', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('94c5198d-81bb-4c33-b2d9-633254fa9823', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('efb542f5-1815-4c5f-b3fc-0a04d35a2245', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('efb542f5-1815-4c5f-b3fc-0a04d35a2245', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('efb542f5-1815-4c5f-b3fc-0a04d35a2245', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('31cbd9fe-f107-44fe-94fa-20b1ecfc29d0', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('31cbd9fe-f107-44fe-94fa-20b1ecfc29d0', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('31cbd9fe-f107-44fe-94fa-20b1ecfc29d0', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('47d720a2-aaf6-4d8c-b562-5199d2e180cd', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('47d720a2-aaf6-4d8c-b562-5199d2e180cd', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('47d720a2-aaf6-4d8c-b562-5199d2e180cd', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('47d720a2-aaf6-4d8c-b562-5199d2e180cd', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('47d720a2-aaf6-4d8c-b562-5199d2e180cd', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('47d720a2-aaf6-4d8c-b562-5199d2e180cd', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('b4778825-6b35-4ebb-9274-cfa8baffa92e', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b4778825-6b35-4ebb-9274-cfa8baffa92e', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('b4778825-6b35-4ebb-9274-cfa8baffa92e', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b4778825-6b35-4ebb-9274-cfa8baffa92e', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('b4778825-6b35-4ebb-9274-cfa8baffa92e', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('b4778825-6b35-4ebb-9274-cfa8baffa92e', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('0b2ba676-dffe-4ed8-97c8-0605c15b5610', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('0b2ba676-dffe-4ed8-97c8-0605c15b5610', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('0b2ba676-dffe-4ed8-97c8-0605c15b5610', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('7b05989e-aac1-477d-8943-822ac0106c3d', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7b05989e-aac1-477d-8943-822ac0106c3d', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('7b05989e-aac1-477d-8943-822ac0106c3d', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('928013b1-3d7a-4912-a024-9e6b0f8a8641', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('928013b1-3d7a-4912-a024-9e6b0f8a8641', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('928013b1-3d7a-4912-a024-9e6b0f8a8641', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('928013b1-3d7a-4912-a024-9e6b0f8a8641', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('928013b1-3d7a-4912-a024-9e6b0f8a8641', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('928013b1-3d7a-4912-a024-9e6b0f8a8641', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('452cd390-3613-412c-ba1a-1f0f25868f34', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('452cd390-3613-412c-ba1a-1f0f25868f34', 'locale', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('452cd390-3613-412c-ba1a-1f0f25868f34', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('452cd390-3613-412c-ba1a-1f0f25868f34', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('452cd390-3613-412c-ba1a-1f0f25868f34', 'locale', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('452cd390-3613-412c-ba1a-1f0f25868f34', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('1d4b3089-3785-4845-b121-0728b3c21ac7', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1d4b3089-3785-4845-b121-0728b3c21ac7', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('1d4b3089-3785-4845-b121-0728b3c21ac7', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1d4b3089-3785-4845-b121-0728b3c21ac7', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('1d4b3089-3785-4845-b121-0728b3c21ac7', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('1d4b3089-3785-4845-b121-0728b3c21ac7', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('a2423729-550f-4ed4-9426-7e6aecf9bc60', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a2423729-550f-4ed4-9426-7e6aecf9bc60', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('a2423729-550f-4ed4-9426-7e6aecf9bc60', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a2423729-550f-4ed4-9426-7e6aecf9bc60', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('a2423729-550f-4ed4-9426-7e6aecf9bc60', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('a2423729-550f-4ed4-9426-7e6aecf9bc60', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('c6af9911-fecd-4b32-8729-803f7625293b', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c6af9911-fecd-4b32-8729-803f7625293b', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('c6af9911-fecd-4b32-8729-803f7625293b', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c6af9911-fecd-4b32-8729-803f7625293b', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('c6af9911-fecd-4b32-8729-803f7625293b', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('c6af9911-fecd-4b32-8729-803f7625293b', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('34599620-04dd-4425-b5d1-3475065a694c', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('34599620-04dd-4425-b5d1-3475065a694c', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('34599620-04dd-4425-b5d1-3475065a694c', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('163e2145-bec2-452a-978c-ba7570509475', 'false', 'single');
INSERT INTO protocol_mapper_config VALUES ('163e2145-bec2-452a-978c-ba7570509475', 'Basic', 'attribute.nameformat');
INSERT INTO protocol_mapper_config VALUES ('163e2145-bec2-452a-978c-ba7570509475', 'Role', 'attribute.name');
INSERT INTO protocol_mapper_config VALUES ('afc6c1ae-8ea2-4da4-a753-946d3653b87f', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('afc6c1ae-8ea2-4da4-a753-946d3653b87f', 'username', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('afc6c1ae-8ea2-4da4-a753-946d3653b87f', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('afc6c1ae-8ea2-4da4-a753-946d3653b87f', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('afc6c1ae-8ea2-4da4-a753-946d3653b87f', 'preferred_username', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('afc6c1ae-8ea2-4da4-a753-946d3653b87f', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('40f0cf2d-b53a-41b4-bc65-62f0234a2821', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('40f0cf2d-b53a-41b4-bc65-62f0234a2821', 'lastName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('40f0cf2d-b53a-41b4-bc65-62f0234a2821', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('40f0cf2d-b53a-41b4-bc65-62f0234a2821', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('40f0cf2d-b53a-41b4-bc65-62f0234a2821', 'family_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('40f0cf2d-b53a-41b4-bc65-62f0234a2821', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('bc85be73-18e1-4120-9e1a-935c8d17673c', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('bc85be73-18e1-4120-9e1a-935c8d17673c', 'firstName', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('bc85be73-18e1-4120-9e1a-935c8d17673c', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('bc85be73-18e1-4120-9e1a-935c8d17673c', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('bc85be73-18e1-4120-9e1a-935c8d17673c', 'given_name', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('bc85be73-18e1-4120-9e1a-935c8d17673c', 'String', 'jsonType.label');
INSERT INTO protocol_mapper_config VALUES ('4fd7006e-571f-4e01-8a7f-50c8f6ad6637', 'true', 'userinfo.token.claim');
INSERT INTO protocol_mapper_config VALUES ('4fd7006e-571f-4e01-8a7f-50c8f6ad6637', 'email', 'user.attribute');
INSERT INTO protocol_mapper_config VALUES ('4fd7006e-571f-4e01-8a7f-50c8f6ad6637', 'true', 'id.token.claim');
INSERT INTO protocol_mapper_config VALUES ('4fd7006e-571f-4e01-8a7f-50c8f6ad6637', 'true', 'access.token.claim');
INSERT INTO protocol_mapper_config VALUES ('4fd7006e-571f-4e01-8a7f-50c8f6ad6637', 'email', 'claim.name');
INSERT INTO protocol_mapper_config VALUES ('4fd7006e-571f-4e01-8a7f-50c8f6ad6637', 'String', 'jsonType.label');


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO realm VALUES ('master', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, 'hashIterations(20000)', false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, '662f42cf-dc6b-461d-9633-d8384f210692', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', 'f0ebf238-55ad-48b8-9a8e-93a023274534', '362ce71b-99ea-4d39-9e07-829122f0eb26', '0361b6f0-5b34-4646-9998-440f70d3e3fd', '67fee0b9-868f-496e-87e1-7c2f05fca317', '23261c24-99f4-4ce0-9c53-321c7acc9b9c', 2592000, false, 900, true, false);
INSERT INTO realm VALUES ('fa758415-6fe8-4313-b599-643292361e3d', 60, 300, 240, NULL, NULL, NULL, true, false, 0, NULL, 'apiman', 0, 'hashIterations(20000)', true, false, false, false, 'EXTERNAL', 600, 36000, false, false, '9b1705ee-b907-443e-9fd9-568448f312d3', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', 'bac93b82-ef24-47a3-a20a-3bce871303c4', 'b3957b14-8be3-461e-83a6-cad78fa78d02', '5ced2963-d2a9-4a1d-b5f7-0764ceb9f3a2', '8cc9dbd4-272c-4dee-9b90-34f896827a7d', 'caaf11ba-a8b4-4398-8895-7629eecd1e48', 2592000, false, 900, true, false);
INSERT INTO realm VALUES ('Joyn', 60, 300, 300, NULL, NULL, NULL, true, false, 0, NULL, 'Aldi', 0, 'hashIterations(20000)', true, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'dd112d33-6fb0-4566-8966-a70d5905c056', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', 'dde585ff-0e30-4a14-af37-d6fad287fd26', '1592898e-e256-40cf-8117-bf08a175cd11', 'a5645acd-ae62-4d8a-abca-0eca8df24496', '5e90527c-c7f7-42f6-b59b-9f52f4d1b3ef', '218dc39b-958a-44b5-b972-178aa7fa2d77', 2592000, false, 900, true, false);
INSERT INTO realm VALUES ('FidCash', 60, 86400, 300, 'keycloak', 'keycloak', 'keycloak', true, false, 0, 'keycloak', 'Colruyt', 0, 'hashIterations and regexPattern(((^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[,!\\@#\$%\^&\*\(\)_+\|~\-=`{}\[\]:";''<>?\/])(.{8,})$)|(^.{20,}$)))', true, false, true, false, 'EXTERNAL', 1800, 36000, false, true, '102112b4-0529-46c4-afc3-5dded7a42ff9', 1800, true, 'en', false, false, false, false, 0, 1, 30, 6, 'HmacSHA512', 'totp', 'fb8b4160-f51c-4652-bcf6-accd50142f7f', '23ca7c0f-5232-428a-a608-eda42c381449', 'fb37f684-1563-4fa7-a3ff-f592530db418', 'de65c6b1-4896-4b0a-b799-6694a0715c0a', '0ad7afbf-8ac4-44ca-a2cd-e02b53804d69', 2592000, false, 900, true, false);


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'nosniff', 'master');
INSERT INTO realm_attribute VALUES ('_browser_header.xFrameOptions', 'SAMEORIGIN', 'master');
INSERT INTO realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'frame-src ''self''', 'master');
INSERT INTO realm_attribute VALUES ('bruteForceProtected', 'false', 'master');
INSERT INTO realm_attribute VALUES ('maxFailureWaitSeconds', '900', 'master');
INSERT INTO realm_attribute VALUES ('minimumQuickLoginWaitSeconds', '60', 'master');
INSERT INTO realm_attribute VALUES ('waitIncrementSeconds', '60', 'master');
INSERT INTO realm_attribute VALUES ('quickLoginCheckMilliSeconds', '1000', 'master');
INSERT INTO realm_attribute VALUES ('maxDeltaTimeSeconds', '43200', 'master');
INSERT INTO realm_attribute VALUES ('failureFactor', '30', 'master');
INSERT INTO realm_attribute VALUES ('displayName', 'Keycloak', 'master');
INSERT INTO realm_attribute VALUES ('displayNameHtml', '<div class="kc-logo-text"><span>Keycloak</span></div>', 'master');
INSERT INTO realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'nosniff', 'Joyn');
INSERT INTO realm_attribute VALUES ('_browser_header.xFrameOptions', 'SAMEORIGIN', 'Joyn');
INSERT INTO realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'frame-src ''self''', 'Joyn');
INSERT INTO realm_attribute VALUES ('bruteForceProtected', 'false', 'Joyn');
INSERT INTO realm_attribute VALUES ('maxFailureWaitSeconds', '900', 'Joyn');
INSERT INTO realm_attribute VALUES ('minimumQuickLoginWaitSeconds', '60', 'Joyn');
INSERT INTO realm_attribute VALUES ('waitIncrementSeconds', '60', 'Joyn');
INSERT INTO realm_attribute VALUES ('quickLoginCheckMilliSeconds', '1000', 'Joyn');
INSERT INTO realm_attribute VALUES ('maxDeltaTimeSeconds', '43200', 'Joyn');
INSERT INTO realm_attribute VALUES ('failureFactor', '30', 'Joyn');
INSERT INTO realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'nosniff', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('_browser_header.xFrameOptions', 'SAMEORIGIN', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'frame-src ''self''', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('bruteForceProtected', 'false', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('maxFailureWaitSeconds', '900', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('minimumQuickLoginWaitSeconds', '60', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('waitIncrementSeconds', '60', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('quickLoginCheckMilliSeconds', '1000', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('maxDeltaTimeSeconds', '43200', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('failureFactor', '30', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('displayNameHtml', '<div class="kc-logo-text"><span>Keycloak & Apiman Quickstart</span></div>', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'nosniff', 'FidCash');
INSERT INTO realm_attribute VALUES ('_browser_header.xFrameOptions', 'SAMEORIGIN', 'FidCash');
INSERT INTO realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'frame-src ''self''', 'FidCash');
INSERT INTO realm_attribute VALUES ('bruteForceProtected', 'false', 'FidCash');
INSERT INTO realm_attribute VALUES ('maxFailureWaitSeconds', '900', 'FidCash');
INSERT INTO realm_attribute VALUES ('minimumQuickLoginWaitSeconds', '60', 'FidCash');
INSERT INTO realm_attribute VALUES ('waitIncrementSeconds', '60', 'FidCash');
INSERT INTO realm_attribute VALUES ('quickLoginCheckMilliSeconds', '1000', 'FidCash');
INSERT INTO realm_attribute VALUES ('maxDeltaTimeSeconds', '43200', 'FidCash');
INSERT INTO realm_attribute VALUES ('failureFactor', '30', 'FidCash');
INSERT INTO realm_attribute VALUES ('_browser_header.xXSSProtection', '1; mode=block', 'master');
INSERT INTO realm_attribute VALUES ('_browser_header.xRobotsTag', 'none', 'master');
INSERT INTO realm_attribute VALUES ('_browser_header.xXSSProtection', '1; mode=block', 'Joyn');
INSERT INTO realm_attribute VALUES ('_browser_header.xRobotsTag', 'none', 'Joyn');
INSERT INTO realm_attribute VALUES ('_browser_header.xXSSProtection', '1; mode=block', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('_browser_header.xRobotsTag', 'none', 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_attribute VALUES ('_browser_header.xXSSProtection', '1; mode=block', 'FidCash');
INSERT INTO realm_attribute VALUES ('_browser_header.xRobotsTag', 'none', 'FidCash');
INSERT INTO realm_attribute VALUES ('displayName', 'Aldi', 'Joyn');


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO realm_default_roles VALUES ('master', 'c2f327cc-12b7-4388-8641-1ea36f94ca48');
INSERT INTO realm_default_roles VALUES ('master', 'af5f4188-9dbd-49b0-bfb2-ffabb9652c79');
INSERT INTO realm_default_roles VALUES ('Joyn', 'fa815218-cd81-4597-baac-af223756575c');
INSERT INTO realm_default_roles VALUES ('Joyn', 'e3b79268-dae0-4b2b-9884-a0ac61fac3d9');
INSERT INTO realm_default_roles VALUES ('fa758415-6fe8-4313-b599-643292361e3d', '8c9f575b-f95a-469d-b3ae-54524b93cec6');
INSERT INTO realm_default_roles VALUES ('fa758415-6fe8-4313-b599-643292361e3d', '05a65ccb-6b36-4db5-a4f7-ed1a9b5ed2b6');
INSERT INTO realm_default_roles VALUES ('fa758415-6fe8-4313-b599-643292361e3d', 'c2d86a8e-7c89-4587-985b-8cc673ec9f19');
INSERT INTO realm_default_roles VALUES ('FidCash', '4779830c-ad5a-4848-b4cd-599c580255a1');
INSERT INTO realm_default_roles VALUES ('FidCash', 'd60ee4da-cc16-4b12-829a-42feabd04aaf');


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO realm_events_listeners VALUES ('master', 'jboss-logging');
INSERT INTO realm_events_listeners VALUES ('fa758415-6fe8-4313-b599-643292361e3d', 'jboss-logging');
INSERT INTO realm_events_listeners VALUES ('Joyn', 'jboss-logging');
INSERT INTO realm_events_listeners VALUES ('FidCash', 'jboss-logging');


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO realm_required_credential VALUES ('password', 'password', true, true, 'master');
INSERT INTO realm_required_credential VALUES ('password', 'password', true, true, 'Joyn');
INSERT INTO realm_required_credential VALUES ('password', 'password', true, true, 'fa758415-6fe8-4313-b599-643292361e3d');
INSERT INTO realm_required_credential VALUES ('password', 'password', true, true, 'FidCash');


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO realm_smtp_config VALUES ('FidCash', '%Hr05fx2UB^v', 'password');
INSERT INTO realm_smtp_config VALUES ('FidCash', 'true', 'auth');
INSERT INTO realm_smtp_config VALUES ('FidCash', '465', 'port');
INSERT INTO realm_smtp_config VALUES ('FidCash', 'smtp.gmail.com', 'host');
INSERT INTO realm_smtp_config VALUES ('FidCash', 'iamtestprojectyo@gmail.com', 'from');
INSERT INTO realm_smtp_config VALUES ('FidCash', 'true', 'ssl');
INSERT INTO realm_smtp_config VALUES ('FidCash', 'iamtestprojectyo@gmail.com', 'user');


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO realm_supported_locales VALUES ('FidCash', 'en');
INSERT INTO realm_supported_locales VALUES ('FidCash', 'fr');


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO redirect_uris VALUES ('d19d260c-bfd9-4375-b4f4-c9b7c6188289', '/auth/realms/master/account/*');
INSERT INTO redirect_uris VALUES ('84a138ae-2da9-4b1d-8149-7e1f726aefa8', '/auth/admin/master/console/*');
INSERT INTO redirect_uris VALUES ('8b21dd0e-1799-45fe-ae06-d4ffe1f596a3', 'https://*');
INSERT INTO redirect_uris VALUES ('4dd5f99f-18cf-4f4f-ad84-bb6a0f566d15', '/auth/realms/apiman/account/*');
INSERT INTO redirect_uris VALUES ('9d135049-107a-43fd-af59-46bfbe870158', '/auth/admin/apiman/console/*');
INSERT INTO redirect_uris VALUES ('3b1e3885-0b42-4569-84c7-dc7f2dd7183b', 'https://ec2-34-248-65-114.eu-west-1.compute.amazonaws.com:8444/apimanui/*');
INSERT INTO redirect_uris VALUES ('3b1e3885-0b42-4569-84c7-dc7f2dd7183b', 'https://apiman.com:8444/apimanui/*');
INSERT INTO redirect_uris VALUES ('11afe0d4-0779-410a-a962-f9c50bd3122f', 'https://apiman.com:8444/apiman/*');
INSERT INTO redirect_uris VALUES ('11afe0d4-0779-410a-a962-f9c50bd3122f', 'https://ec2-34-248-65-114.eu-west-1.compute.amazonaws.com:8444/apiman/*');
INSERT INTO redirect_uris VALUES ('cf2c62a5-c21b-44e3-a9a3-2b88fad2992f', 'https://*');
INSERT INTO redirect_uris VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', 'https://apiman.com:8444/apiman-gateway-api/*');
INSERT INTO redirect_uris VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', 'https://ec2-34-248-65-114.eu-west-1.compute.amazonaws.com:8444/apiman-gateway-api/*');
INSERT INTO redirect_uris VALUES ('8210d5e2-cc3c-4eb6-be99-3a32667a378a', '/auth/admin/Aldi/console/*');
INSERT INTO redirect_uris VALUES ('ab721dba-4af4-4d1d-b686-aec44d62d883', '/auth/realms/Aldi/account/*');
INSERT INTO redirect_uris VALUES ('3364267c-1dd3-4fdf-b323-2d05bf18beb5', '/auth/admin/Colruyt/console/*');
INSERT INTO redirect_uris VALUES ('8bc6a229-9e1d-4a74-8933-8fb0abf50fde', '/auth/realms/Colruyt/account/*');
INSERT INTO redirect_uris VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'http://spa:4200/*');
INSERT INTO redirect_uris VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'http://localhost:4200/*');


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO required_action_provider VALUES ('0c5875b3-feaf-425e-8d20-e335dcc82318', 'VERIFY_EMAIL', 'Verify Email', 'master', true, false, 'VERIFY_EMAIL');
INSERT INTO required_action_provider VALUES ('52cd8b99-a074-4213-ba6d-4990bc2f9942', 'UPDATE_PROFILE', 'Update Profile', 'master', true, false, 'UPDATE_PROFILE');
INSERT INTO required_action_provider VALUES ('a82b1bc3-7b51-48e2-b7cd-df04db66221e', 'CONFIGURE_TOTP', 'Configure OTP', 'master', true, false, 'CONFIGURE_TOTP');
INSERT INTO required_action_provider VALUES ('7895d7ad-171b-4e82-9b8b-bf58ebf65334', 'UPDATE_PASSWORD', 'Update Password', 'master', true, false, 'UPDATE_PASSWORD');
INSERT INTO required_action_provider VALUES ('b36b8061-e932-4c8d-9a20-6b8f508bbd2f', 'terms_and_conditions', 'Terms and Conditions', 'master', false, false, 'terms_and_conditions');
INSERT INTO required_action_provider VALUES ('7ed5931a-8d06-421f-ae34-14ea4706b643', 'CONFIGURE_TOTP', 'Configure OTP', 'Joyn', true, false, 'CONFIGURE_TOTP');
INSERT INTO required_action_provider VALUES ('6e4cf26e-f46d-4b84-b11b-bc94c090ea61', 'UPDATE_PASSWORD', 'Update Password', 'Joyn', true, false, 'UPDATE_PASSWORD');
INSERT INTO required_action_provider VALUES ('d7ed69a3-43db-4fed-b597-30ef5c0e3c1a', 'UPDATE_PROFILE', 'Update Profile', 'Joyn', true, false, 'UPDATE_PROFILE');
INSERT INTO required_action_provider VALUES ('ab641883-5b15-4a19-8d5e-997507e0cf82', 'VERIFY_EMAIL', 'Verify Email', 'Joyn', true, false, 'VERIFY_EMAIL');
INSERT INTO required_action_provider VALUES ('d5203c5d-b318-4efd-bc14-588fe0f225d6', 'terms_and_conditions', 'Terms and Conditions', 'Joyn', false, false, 'terms_and_conditions');
INSERT INTO required_action_provider VALUES ('195165ab-c2b9-41bf-bb78-b22b86dfe6c5', 'VERIFY_EMAIL', 'Verify Email', 'fa758415-6fe8-4313-b599-643292361e3d', true, false, 'VERIFY_EMAIL');
INSERT INTO required_action_provider VALUES ('9dd59e54-ece1-42d1-8c0f-9a79f1cdfe9c', 'UPDATE_PROFILE', 'Update Profile', 'fa758415-6fe8-4313-b599-643292361e3d', true, false, 'UPDATE_PROFILE');
INSERT INTO required_action_provider VALUES ('bb81db10-20e4-4cf7-a5ad-a4f6e4a066cb', 'CONFIGURE_TOTP', 'Configure OTP', 'fa758415-6fe8-4313-b599-643292361e3d', true, false, 'CONFIGURE_TOTP');
INSERT INTO required_action_provider VALUES ('05484398-7ada-48d6-a426-22145c07431b', 'UPDATE_PASSWORD', 'Update Password', 'fa758415-6fe8-4313-b599-643292361e3d', true, false, 'UPDATE_PASSWORD');
INSERT INTO required_action_provider VALUES ('1346210e-fcac-4983-b108-543bb4cc31de', 'terms_and_conditions', 'Terms and Conditions', 'fa758415-6fe8-4313-b599-643292361e3d', false, false, 'terms_and_conditions');
INSERT INTO required_action_provider VALUES ('0623a654-a9b3-45c1-8f53-6c6be0c83c97', 'CONFIGURE_TOTP', 'Configure OTP', 'FidCash', true, false, 'CONFIGURE_TOTP');
INSERT INTO required_action_provider VALUES ('7c1240c7-2e3b-4111-bc8d-90a8ff4f2513', 'UPDATE_PASSWORD', 'Update Password', 'FidCash', true, false, 'UPDATE_PASSWORD');
INSERT INTO required_action_provider VALUES ('7bdd0093-c43c-40e9-920b-b366388d8015', 'UPDATE_PROFILE', 'Update Profile', 'FidCash', true, false, 'UPDATE_PROFILE');
INSERT INTO required_action_provider VALUES ('602b9c0c-7fff-4c40-adff-39c8b8d80e16', 'VERIFY_EMAIL', 'Verify Email', 'FidCash', true, false, 'VERIFY_EMAIL');
INSERT INTO required_action_provider VALUES ('057c9944-70f7-4835-a438-1dd5ffba7ded', 'terms_and_conditions', 'Terms and Conditions', 'FidCash', false, false, 'terms_and_conditions');


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO scope_mapping VALUES ('84a138ae-2da9-4b1d-8149-7e1f726aefa8', 'd26a5067-239f-4c4f-979b-02d617de32af');
INSERT INTO scope_mapping VALUES ('ea5c74a8-9fbf-4d1f-a63b-22f34ec80ab8', 'd26a5067-239f-4c4f-979b-02d617de32af');
INSERT INTO scope_mapping VALUES ('0a87bd58-0cf4-4e19-a1e1-52525afc8823', 'e30d8fee-b354-4ad5-9cc8-5cb693df8fbf');
INSERT INTO scope_mapping VALUES ('8210d5e2-cc3c-4eb6-be99-3a32667a378a', 'e30d8fee-b354-4ad5-9cc8-5cb693df8fbf');
INSERT INTO scope_mapping VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', '3dfbfa77-87b9-4c75-a18e-9e59c9d91d4f');
INSERT INTO scope_mapping VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', 'a6dfff4f-01a8-44b6-bf19-839ed6115eb2');
INSERT INTO scope_mapping VALUES ('f8692af8-3bed-4a28-891d-0b2e5de5e9a0', 'b9ac942b-35dc-42ee-892c-84ec221c9667');
INSERT INTO scope_mapping VALUES ('9d135049-107a-43fd-af59-46bfbe870158', 'bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a');
INSERT INTO scope_mapping VALUES ('cc90450b-01a7-4178-bd2b-74cf91436f2f', 'bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a');
INSERT INTO scope_mapping VALUES ('819991a5-96df-4ab0-bec2-c9a1cfdf86aa', '78d83a83-c469-413c-b0f4-509e1b5cb9f7');
INSERT INTO scope_mapping VALUES ('3364267c-1dd3-4fdf-b323-2d05bf18beb5', '78d83a83-c469-413c-b0f4-509e1b5cb9f7');
INSERT INTO scope_mapping VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'ff02f592-f2d9-4748-8f3b-78c6ecea6f08');
INSERT INTO scope_mapping VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', '5ebcc062-ca37-43ba-bb07-421340d13d5d');
INSERT INTO scope_mapping VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', '65cc597c-a172-4db4-9597-fa3c79b5ec10');


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: template_scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO user_attribute VALUES ('locale', 'en', '564b4e34-db96-4e3e-8aa6-36a4e4df0c92', 'e2e9321e-590b-4b85-97ab-405aa7517703');


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_consent_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_consent_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO user_entity VALUES ('32358881-30ad-4438-96bd-bf8ce355c3c3', NULL, '04b7bfb7-e8c5-43e8-b56f-316c9a0df49f', false, true, NULL, NULL, NULL, 'Joyn', 'omer owner', NULL, NULL);
INSERT INTO user_entity VALUES ('f06239ea-7b23-4947-b7a2-ed860ab663a1', NULL, 'b7273c1d-6282-4412-a53a-4fd456b61852', false, true, NULL, NULL, NULL, 'Joyn', 'patricia partner', NULL, NULL);
INSERT INTO user_entity VALUES ('cdc2a83b-1c36-4a13-854c-ed152c5f6f33', NULL, '03340128-877e-4fce-aaa4-86d3e196560c', false, true, NULL, NULL, NULL, 'Joyn', 'pauline partner', NULL, NULL);
INSERT INTO user_entity VALUES ('95f05f01-0a98-4501-a637-5340add5db93', NULL, '8b1a57b4-9799-40f8-b8d5-04327475ced4', false, true, NULL, NULL, NULL, 'Joyn', 'ursula user', NULL, NULL);
INSERT INTO user_entity VALUES ('1a13429f-e42d-4e57-aef8-aedaf164647c', 'admin@example.org', 'admin@example.org', false, true, NULL, 'apiman', 'admin', 'fa758415-6fe8-4313-b599-643292361e3d', 'admin', NULL, NULL);
INSERT INTO user_entity VALUES ('11f68ecb-f7be-41d8-a6d6-cff1470aca9d', 'apimanager@example.org', 'apimanager@example.org', false, true, NULL, 'api', 'manager', 'fa758415-6fe8-4313-b599-643292361e3d', 'apimanager', NULL, NULL);
INSERT INTO user_entity VALUES ('016c5d30-ab12-42f2-ba9e-0b3efe81df4a', NULL, 'df50dc63-6c5c-4fc1-9d83-0ab0bb3389bd', true, true, NULL, NULL, NULL, 'FidCash', 'odette owner', NULL, NULL);
INSERT INTO user_entity VALUES ('5a652b95-6f02-4806-8c06-f1263f7583ee', NULL, '695973cc-c6f9-4fa0-a754-caf7727d6773', true, true, NULL, NULL, NULL, 'FidCash', 'paul partner', NULL, NULL);
INSERT INTO user_entity VALUES ('564b4e34-db96-4e3e-8aa6-36a4e4df0c92', NULL, '8101bfb7-7b71-40f4-bb5a-c5ac034c33c0', true, true, NULL, NULL, NULL, 'FidCash', 'patrick partner', NULL, NULL);
INSERT INTO user_entity VALUES ('4c8ef5d1-2b1e-4119-a105-8ddf181f7b7c', NULL, '49cb29e5-c446-4033-913a-df15eba3925f', true, true, NULL, NULL, NULL, 'FidCash', 'urbain user', NULL, NULL);
INSERT INTO user_entity VALUES ('ab69c819-d744-406e-8a0f-ccc7db99fc98', NULL, '0a7e92e5-bb6b-4104-b91e-d370d0c3b835', false, true, NULL, NULL, NULL, 'master', 'admin', 1489055462368, NULL);


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO user_group_membership VALUES ('4e630f16-cc0e-4fdb-a430-190ce9e8bbf7', 'f06239ea-7b23-4947-b7a2-ed860ab663a1');
INSERT INTO user_group_membership VALUES ('4e3ea1f9-761e-4888-9ac4-81efd61c2638', 'cdc2a83b-1c36-4a13-854c-ed152c5f6f33');
INSERT INTO user_group_membership VALUES ('603ce513-8f56-4efc-8de6-400c5fbaa38a', '5a652b95-6f02-4806-8c06-f1263f7583ee');
INSERT INTO user_group_membership VALUES ('a6ce1c4e-80d3-48b1-a861-db93f3ea7950', '564b4e34-db96-4e3e-8aa6-36a4e4df0c92');


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO user_role_mapping VALUES ('3dfbfa77-87b9-4c75-a18e-9e59c9d91d4f', '32358881-30ad-4438-96bd-bf8ce355c3c3');
INSERT INTO user_role_mapping VALUES ('502baf77-40f3-4968-8a6e-8830c0fa8dcd', '32358881-30ad-4438-96bd-bf8ce355c3c3');
INSERT INTO user_role_mapping VALUES ('86c6f137-9d24-457f-90fb-97f052710b87', '32358881-30ad-4438-96bd-bf8ce355c3c3');
INSERT INTO user_role_mapping VALUES ('a6dfff4f-01a8-44b6-bf19-839ed6115eb2', 'f06239ea-7b23-4947-b7a2-ed860ab663a1');
INSERT INTO user_role_mapping VALUES ('502baf77-40f3-4968-8a6e-8830c0fa8dcd', 'f06239ea-7b23-4947-b7a2-ed860ab663a1');
INSERT INTO user_role_mapping VALUES ('86c6f137-9d24-457f-90fb-97f052710b87', 'f06239ea-7b23-4947-b7a2-ed860ab663a1');
INSERT INTO user_role_mapping VALUES ('a6dfff4f-01a8-44b6-bf19-839ed6115eb2', 'cdc2a83b-1c36-4a13-854c-ed152c5f6f33');
INSERT INTO user_role_mapping VALUES ('502baf77-40f3-4968-8a6e-8830c0fa8dcd', 'cdc2a83b-1c36-4a13-854c-ed152c5f6f33');
INSERT INTO user_role_mapping VALUES ('86c6f137-9d24-457f-90fb-97f052710b87', 'cdc2a83b-1c36-4a13-854c-ed152c5f6f33');
INSERT INTO user_role_mapping VALUES ('b9ac942b-35dc-42ee-892c-84ec221c9667', '95f05f01-0a98-4501-a637-5340add5db93');
INSERT INTO user_role_mapping VALUES ('502baf77-40f3-4968-8a6e-8830c0fa8dcd', '95f05f01-0a98-4501-a637-5340add5db93');
INSERT INTO user_role_mapping VALUES ('86c6f137-9d24-457f-90fb-97f052710b87', '95f05f01-0a98-4501-a637-5340add5db93');
INSERT INTO user_role_mapping VALUES ('05a65ccb-6b36-4db5-a4f7-ed1a9b5ed2b6', '1a13429f-e42d-4e57-aef8-aedaf164647c');
INSERT INTO user_role_mapping VALUES ('32611b2f-374e-47fc-87e4-e1be3d42f184', '1a13429f-e42d-4e57-aef8-aedaf164647c');
INSERT INTO user_role_mapping VALUES ('bb5d9c9a-32ed-4f8e-97f2-1230a8182c4a', '1a13429f-e42d-4e57-aef8-aedaf164647c');
INSERT INTO user_role_mapping VALUES ('1ebf939e-32f4-431e-b12e-051c5d8a99f4', '11f68ecb-f7be-41d8-a6d6-cff1470aca9d');
INSERT INTO user_role_mapping VALUES ('ff02f592-f2d9-4748-8f3b-78c6ecea6f08', '016c5d30-ab12-42f2-ba9e-0b3efe81df4a');
INSERT INTO user_role_mapping VALUES ('44b6498c-c088-4bf6-a022-7f7e980ed7d7', '016c5d30-ab12-42f2-ba9e-0b3efe81df4a');
INSERT INTO user_role_mapping VALUES ('88eac625-ce82-4e85-b60a-eec0c8ab2a50', '016c5d30-ab12-42f2-ba9e-0b3efe81df4a');
INSERT INTO user_role_mapping VALUES ('5ebcc062-ca37-43ba-bb07-421340d13d5d', '5a652b95-6f02-4806-8c06-f1263f7583ee');
INSERT INTO user_role_mapping VALUES ('44b6498c-c088-4bf6-a022-7f7e980ed7d7', '5a652b95-6f02-4806-8c06-f1263f7583ee');
INSERT INTO user_role_mapping VALUES ('88eac625-ce82-4e85-b60a-eec0c8ab2a50', '5a652b95-6f02-4806-8c06-f1263f7583ee');
INSERT INTO user_role_mapping VALUES ('5ebcc062-ca37-43ba-bb07-421340d13d5d', '564b4e34-db96-4e3e-8aa6-36a4e4df0c92');
INSERT INTO user_role_mapping VALUES ('44b6498c-c088-4bf6-a022-7f7e980ed7d7', '564b4e34-db96-4e3e-8aa6-36a4e4df0c92');
INSERT INTO user_role_mapping VALUES ('88eac625-ce82-4e85-b60a-eec0c8ab2a50', '564b4e34-db96-4e3e-8aa6-36a4e4df0c92');
INSERT INTO user_role_mapping VALUES ('65cc597c-a172-4db4-9597-fa3c79b5ec10', '4c8ef5d1-2b1e-4119-a105-8ddf181f7b7c');
INSERT INTO user_role_mapping VALUES ('44b6498c-c088-4bf6-a022-7f7e980ed7d7', '4c8ef5d1-2b1e-4119-a105-8ddf181f7b7c');
INSERT INTO user_role_mapping VALUES ('88eac625-ce82-4e85-b60a-eec0c8ab2a50', '4c8ef5d1-2b1e-4119-a105-8ddf181f7b7c');
INSERT INTO user_role_mapping VALUES ('c2f327cc-12b7-4388-8641-1ea36f94ca48', 'ab69c819-d744-406e-8a0f-ccc7db99fc98');
INSERT INTO user_role_mapping VALUES ('5ebaf50f-278f-4caa-bf2a-a6483ed909c0', 'ab69c819-d744-406e-8a0f-ccc7db99fc98');
INSERT INTO user_role_mapping VALUES ('af5f4188-9dbd-49b0-bfb2-ffabb9652c79', 'ab69c819-d744-406e-8a0f-ccc7db99fc98');
INSERT INTO user_role_mapping VALUES ('169ae6bd-87e6-4112-8411-b858eb5bcb35', 'ab69c819-d744-406e-8a0f-ccc7db99fc98');
INSERT INTO user_role_mapping VALUES ('d26a5067-239f-4c4f-979b-02d617de32af', 'ab69c819-d744-406e-8a0f-ccc7db99fc98');


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--



--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

INSERT INTO web_origins VALUES ('3b1e3885-0b42-4569-84c7-dc7f2dd7183b', 'https://apiman.com:8444');
INSERT INTO web_origins VALUES ('3b1e3885-0b42-4569-84c7-dc7f2dd7183b', 'https://ec2-34-248-65-114.eu-west-1.compute.amazonaws.com:8444');
INSERT INTO web_origins VALUES ('11afe0d4-0779-410a-a962-f9c50bd3122f', '*');
INSERT INTO web_origins VALUES ('fd470925-9bc4-46ab-8e4b-e09094ba3c53', '*');
INSERT INTO web_origins VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'http://spa:4200');
INSERT INTO web_origins VALUES ('505e6b3f-1884-4b26-a68a-0635ff513fad', 'http://localhost:4200');


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: fed_user_consent_prot_mapper constr_user_consent_protm_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_consent_prot_mapper
    ADD CONSTRAINT constr_user_consent_protm_pk PRIMARY KEY (user_consent_id, protocol_mapper_id);


--
-- Name: fed_user_consent_role constr_user_consent_role_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_consent_role
    ADD CONSTRAINT constr_user_consent_role_pk PRIMARY KEY (user_consent_id, role_id);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server constraint_fars; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server
    ADD CONSTRAINT constraint_fars PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: user_consent_prot_mapper constraint_grntcsnt_prm_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent_prot_mapper
    ADD CONSTRAINT constraint_grntcsnt_prm_pm PRIMARY KEY (user_consent_id, protocol_mapper_id);


--
-- Name: user_consent_role constraint_grntcsnt_role_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent_role
    ADD CONSTRAINT constraint_grntcsnt_role_pm PRIMARY KEY (user_consent_id, role_id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk2 PRIMARY KEY (client_session_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: client_template_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (template_id, name);


--
-- Name: client_template pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: template_scope_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY template_scope_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (template_id, role_id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_identity_prov_mapping uk_7caelwnibji49avxsrtuf6xj12; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_identity_prov_mapping
    ADD CONSTRAINT uk_7caelwnibji49avxsrtuf6xj12 UNIQUE (identity_provider_id, client_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: resource_server uk_au8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server
    ADD CONSTRAINT uk_au8tt6t700s9v50bu18ws5ha6 UNIQUE (client_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_template uk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template
    ADD CONSTRAINT uk_cli_template UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_consent_protmapper; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_consent_protmapper ON user_consent_prot_mapper USING btree (user_consent_id);


--
-- Name: idx_consent_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_consent_role ON user_consent_role USING btree (user_consent_id);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON federated_identity USING btree (user_id);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON offline_client_session USING btree (user_session_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON user_role_mapping USING btree (user_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: client_identity_prov_mapping fk_56elwnibji49avxsrtuf6xj23; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_identity_prov_mapping
    ADD CONSTRAINT fk_56elwnibji49avxsrtuf6xj23 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_identity_prov_mapping fk_7celwnibji49avxsrtuf6xj12; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_identity_prov_mapping
    ADD CONSTRAINT fk_7celwnibji49avxsrtuf6xj12 FOREIGN KEY (identity_provider_id) REFERENCES identity_provider(internal_id);


--
-- Name: client_default_roles fk_8aelwnibji49avxsrtuf6xjow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT fk_8aelwnibji49avxsrtuf6xjow FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: client_template_attributes fk_cl_templ_attr_templ; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template_attributes
    ADD CONSTRAINT fk_cl_templ_attr_templ FOREIGN KEY (template_id) REFERENCES client_template(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: client fk_cli_tmplt_client; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client
    ADD CONSTRAINT fk_cli_tmplt_client FOREIGN KEY (client_template_id) REFERENCES client_template(id);


--
-- Name: protocol_mapper fk_cli_tmplt_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper
    ADD CONSTRAINT fk_cli_tmplt_mapper FOREIGN KEY (client_template_id) REFERENCES client_template(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: credential_attribute fk_cred_attr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY credential_attribute
    ADD CONSTRAINT fk_cred_attr FOREIGN KEY (credential_id) REFERENCES credential(id);


--
-- Name: realm_default_groups fk_def_groups_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT fk_def_groups_group FOREIGN KEY (group_id) REFERENCES keycloak_group(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: fed_credential_attribute fk_fed_cred_attr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_credential_attribute
    ADD CONSTRAINT fk_fed_cred_attr FOREIGN KEY (credential_id) REFERENCES fed_user_credential(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES keycloak_role(id);


--
-- Name: user_consent_prot_mapper fk_grntcsnt_prm_gr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent_prot_mapper
    ADD CONSTRAINT fk_grntcsnt_prm_gr FOREIGN KEY (user_consent_id) REFERENCES user_consent(id);


--
-- Name: user_consent_role fk_grntcsnt_role_gr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent_role
    ADD CONSTRAINT fk_grntcsnt_role_gr FOREIGN KEY (user_consent_id) REFERENCES user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_role_mapping
    ADD CONSTRAINT fk_group_role_role FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: realm_default_roles fk_h4wpd7w4hsoolni3h0sw7btje; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT fk_h4wpd7w4hsoolni3h0sw7btje FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES identity_provider_mapper(id);


--
-- Name: keycloak_role fk_kjho5le2c0ral09fl8cm9wfw9; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT fk_kjho5le2c0ral09fl8cm9wfw9 FOREIGN KEY (client) REFERENCES client(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: scope_mapping fk_p3rh9grku11kqfrs4fltt7rnq; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_mapping
    ADD CONSTRAINT fk_p3rh9grku11kqfrs4fltt7rnq FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES protocol_mapper(id);


--
-- Name: client_template fk_realm_cli_tmplt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template
    ADD CONSTRAINT fk_realm_cli_tmplt FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES user_federation_provider(id);


--
-- Name: template_scope_mapping fk_templ_scope_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY template_scope_mapping
    ADD CONSTRAINT fk_templ_scope_role FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: template_scope_mapping fk_templ_scope_templ; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY template_scope_mapping
    ADD CONSTRAINT fk_templ_scope_templ FOREIGN KEY (template_id) REFERENCES client_template(id);


--
-- Name: realm fk_traf444kk6qrkms7n56aiwq5y; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm
    ADD CONSTRAINT fk_traf444kk6qrkms7n56aiwq5y FOREIGN KEY (master_admin_client) REFERENCES client(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

