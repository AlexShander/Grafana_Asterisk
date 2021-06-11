--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3 (Ubuntu 13.3-1.pgdg20.04+1)

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
-- Name: grafana; Type: DATABASE; Schema: -; Owner: asterisk
--

CREATE DATABASE grafana WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';


ALTER DATABASE grafana OWNER TO asterisk;

\connect grafana

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alert; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.alert (
    id integer NOT NULL,
    version bigint NOT NULL,
    dashboard_id bigint NOT NULL,
    panel_id bigint NOT NULL,
    org_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    message text NOT NULL,
    state character varying(190) NOT NULL,
    settings text NOT NULL,
    frequency bigint NOT NULL,
    handler bigint NOT NULL,
    severity text NOT NULL,
    silenced boolean NOT NULL,
    execution_error text NOT NULL,
    eval_data text,
    eval_date timestamp without time zone,
    new_state_date timestamp without time zone NOT NULL,
    state_changes integer NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    "for" bigint
);


ALTER TABLE public.alert OWNER TO asterisk;

--
-- Name: alert_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.alert_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_id_seq OWNER TO asterisk;

--
-- Name: alert_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.alert_id_seq OWNED BY public.alert.id;


--
-- Name: alert_notification; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.alert_notification (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    name character varying(190) NOT NULL,
    type character varying(255) NOT NULL,
    settings text NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    frequency bigint,
    send_reminder boolean DEFAULT false,
    disable_resolve_message boolean DEFAULT false NOT NULL,
    uid character varying(40),
    secure_settings text
);


ALTER TABLE public.alert_notification OWNER TO asterisk;

--
-- Name: alert_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.alert_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_notification_id_seq OWNER TO asterisk;

--
-- Name: alert_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.alert_notification_id_seq OWNED BY public.alert_notification.id;


--
-- Name: alert_notification_state; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.alert_notification_state (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    alert_id bigint NOT NULL,
    notifier_id bigint NOT NULL,
    state character varying(50) NOT NULL,
    version bigint NOT NULL,
    updated_at bigint NOT NULL,
    alert_rule_state_updated_version bigint NOT NULL
);


ALTER TABLE public.alert_notification_state OWNER TO asterisk;

--
-- Name: alert_notification_state_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.alert_notification_state_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_notification_state_id_seq OWNER TO asterisk;

--
-- Name: alert_notification_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.alert_notification_state_id_seq OWNED BY public.alert_notification_state.id;


--
-- Name: alert_rule_tag; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.alert_rule_tag (
    id integer NOT NULL,
    alert_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.alert_rule_tag OWNER TO asterisk;

--
-- Name: alert_rule_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.alert_rule_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alert_rule_tag_id_seq OWNER TO asterisk;

--
-- Name: alert_rule_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.alert_rule_tag_id_seq OWNED BY public.alert_rule_tag.id;


--
-- Name: annotation; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.annotation (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    alert_id bigint,
    user_id bigint,
    dashboard_id bigint,
    panel_id bigint,
    category_id bigint,
    type character varying(25) NOT NULL,
    title text NOT NULL,
    text text NOT NULL,
    metric character varying(255),
    prev_state character varying(25) NOT NULL,
    new_state character varying(25) NOT NULL,
    data text NOT NULL,
    epoch bigint NOT NULL,
    region_id bigint DEFAULT 0,
    tags character varying(500),
    created bigint DEFAULT 0,
    updated bigint DEFAULT 0,
    epoch_end bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.annotation OWNER TO asterisk;

--
-- Name: annotation_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.annotation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annotation_id_seq OWNER TO asterisk;

--
-- Name: annotation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.annotation_id_seq OWNED BY public.annotation.id;


--
-- Name: annotation_tag; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.annotation_tag (
    id integer NOT NULL,
    annotation_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.annotation_tag OWNER TO asterisk;

--
-- Name: annotation_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.annotation_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.annotation_tag_id_seq OWNER TO asterisk;

--
-- Name: annotation_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.annotation_tag_id_seq OWNED BY public.annotation_tag.id;


--
-- Name: api_key; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.api_key (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    name character varying(190) NOT NULL,
    key character varying(190) NOT NULL,
    role character varying(255) NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    expires bigint
);


ALTER TABLE public.api_key OWNER TO asterisk;

--
-- Name: api_key_id_seq1; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.api_key_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_key_id_seq1 OWNER TO asterisk;

--
-- Name: api_key_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.api_key_id_seq1 OWNED BY public.api_key.id;


--
-- Name: cache_data; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.cache_data (
    cache_key character varying(168) NOT NULL,
    data bytea NOT NULL,
    expires integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.cache_data OWNER TO asterisk;

--
-- Name: dashboard; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.dashboard (
    id integer NOT NULL,
    version integer NOT NULL,
    slug character varying(189) NOT NULL,
    title character varying(189) NOT NULL,
    data text NOT NULL,
    org_id bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    updated_by integer,
    created_by integer,
    gnet_id bigint,
    plugin_id character varying(189),
    folder_id bigint DEFAULT 0 NOT NULL,
    is_folder boolean DEFAULT false NOT NULL,
    has_acl boolean DEFAULT false NOT NULL,
    uid character varying(40)
);


ALTER TABLE public.dashboard OWNER TO asterisk;

--
-- Name: dashboard_acl; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.dashboard_acl (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    dashboard_id bigint NOT NULL,
    user_id bigint,
    team_id bigint,
    permission smallint DEFAULT 4 NOT NULL,
    role character varying(20),
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.dashboard_acl OWNER TO asterisk;

--
-- Name: dashboard_acl_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.dashboard_acl_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_acl_id_seq OWNER TO asterisk;

--
-- Name: dashboard_acl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.dashboard_acl_id_seq OWNED BY public.dashboard_acl.id;


--
-- Name: dashboard_id_seq1; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.dashboard_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_id_seq1 OWNER TO asterisk;

--
-- Name: dashboard_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.dashboard_id_seq1 OWNED BY public.dashboard.id;


--
-- Name: dashboard_provisioning; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.dashboard_provisioning (
    id integer NOT NULL,
    dashboard_id bigint,
    name character varying(150) NOT NULL,
    external_id text NOT NULL,
    updated integer DEFAULT 0 NOT NULL,
    check_sum character varying(32)
);


ALTER TABLE public.dashboard_provisioning OWNER TO asterisk;

--
-- Name: dashboard_provisioning_id_seq1; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.dashboard_provisioning_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_provisioning_id_seq1 OWNER TO asterisk;

--
-- Name: dashboard_provisioning_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.dashboard_provisioning_id_seq1 OWNED BY public.dashboard_provisioning.id;


--
-- Name: dashboard_snapshot; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.dashboard_snapshot (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(190) NOT NULL,
    delete_key character varying(190) NOT NULL,
    org_id bigint NOT NULL,
    user_id bigint NOT NULL,
    external boolean NOT NULL,
    external_url character varying(255) NOT NULL,
    dashboard text NOT NULL,
    expires timestamp without time zone NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    external_delete_url character varying(255),
    dashboard_encrypted bytea
);


ALTER TABLE public.dashboard_snapshot OWNER TO asterisk;

--
-- Name: dashboard_snapshot_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.dashboard_snapshot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_snapshot_id_seq OWNER TO asterisk;

--
-- Name: dashboard_snapshot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.dashboard_snapshot_id_seq OWNED BY public.dashboard_snapshot.id;


--
-- Name: dashboard_tag; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.dashboard_tag (
    id integer NOT NULL,
    dashboard_id bigint NOT NULL,
    term character varying(50) NOT NULL
);


ALTER TABLE public.dashboard_tag OWNER TO asterisk;

--
-- Name: dashboard_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.dashboard_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_tag_id_seq OWNER TO asterisk;

--
-- Name: dashboard_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.dashboard_tag_id_seq OWNED BY public.dashboard_tag.id;


--
-- Name: dashboard_version; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.dashboard_version (
    id integer NOT NULL,
    dashboard_id bigint NOT NULL,
    parent_version integer NOT NULL,
    restored_from integer NOT NULL,
    version integer NOT NULL,
    created timestamp without time zone NOT NULL,
    created_by bigint NOT NULL,
    message text NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.dashboard_version OWNER TO asterisk;

--
-- Name: dashboard_version_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.dashboard_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_version_id_seq OWNER TO asterisk;

--
-- Name: dashboard_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.dashboard_version_id_seq OWNED BY public.dashboard_version.id;


--
-- Name: data_source; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.data_source (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    version integer NOT NULL,
    type character varying(255) NOT NULL,
    name character varying(190) NOT NULL,
    access character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    password character varying(255),
    "user" character varying(255),
    database character varying(255),
    basic_auth boolean NOT NULL,
    basic_auth_user character varying(255),
    basic_auth_password character varying(255),
    is_default boolean NOT NULL,
    json_data text,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    with_credentials boolean DEFAULT false NOT NULL,
    secure_json_data text,
    read_only boolean,
    uid character varying(40) DEFAULT 0 NOT NULL
);


ALTER TABLE public.data_source OWNER TO asterisk;

--
-- Name: data_source_id_seq1; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.data_source_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_source_id_seq1 OWNER TO asterisk;

--
-- Name: data_source_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.data_source_id_seq1 OWNED BY public.data_source.id;


--
-- Name: login_attempt; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.login_attempt (
    id integer NOT NULL,
    username character varying(190) NOT NULL,
    ip_address character varying(30) NOT NULL,
    created integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.login_attempt OWNER TO asterisk;

--
-- Name: login_attempt_id_seq1; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.login_attempt_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.login_attempt_id_seq1 OWNER TO asterisk;

--
-- Name: login_attempt_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.login_attempt_id_seq1 OWNED BY public.login_attempt.id;


--
-- Name: migration_log; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.migration_log (
    id integer NOT NULL,
    migration_id character varying(255) NOT NULL,
    sql text NOT NULL,
    success boolean NOT NULL,
    error text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE public.migration_log OWNER TO asterisk;

--
-- Name: migration_log_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.migration_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migration_log_id_seq OWNER TO asterisk;

--
-- Name: migration_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.migration_log_id_seq OWNED BY public.migration_log.id;


--
-- Name: org; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.org (
    id integer NOT NULL,
    version integer NOT NULL,
    name character varying(190) NOT NULL,
    address1 character varying(255),
    address2 character varying(255),
    city character varying(255),
    state character varying(255),
    zip_code character varying(50),
    country character varying(255),
    billing_email character varying(255),
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.org OWNER TO asterisk;

--
-- Name: org_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.org_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.org_id_seq OWNER TO asterisk;

--
-- Name: org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.org_id_seq OWNED BY public.org.id;


--
-- Name: org_user; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.org_user (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    user_id bigint NOT NULL,
    role character varying(20) NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.org_user OWNER TO asterisk;

--
-- Name: org_user_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.org_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.org_user_id_seq OWNER TO asterisk;

--
-- Name: org_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.org_user_id_seq OWNED BY public.org_user.id;


--
-- Name: playlist; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.playlist (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "interval" character varying(255) NOT NULL,
    org_id bigint NOT NULL
);


ALTER TABLE public.playlist OWNER TO asterisk;

--
-- Name: playlist_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.playlist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.playlist_id_seq OWNER TO asterisk;

--
-- Name: playlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.playlist_id_seq OWNED BY public.playlist.id;


--
-- Name: playlist_item; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.playlist_item (
    id integer NOT NULL,
    playlist_id bigint NOT NULL,
    type character varying(255) NOT NULL,
    value text NOT NULL,
    title text NOT NULL,
    "order" integer NOT NULL
);


ALTER TABLE public.playlist_item OWNER TO asterisk;

--
-- Name: playlist_item_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.playlist_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.playlist_item_id_seq OWNER TO asterisk;

--
-- Name: playlist_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.playlist_item_id_seq OWNED BY public.playlist_item.id;


--
-- Name: plugin_setting; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.plugin_setting (
    id integer NOT NULL,
    org_id bigint,
    plugin_id character varying(190) NOT NULL,
    enabled boolean NOT NULL,
    pinned boolean NOT NULL,
    json_data text,
    secure_json_data text,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    plugin_version character varying(50)
);


ALTER TABLE public.plugin_setting OWNER TO asterisk;

--
-- Name: plugin_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.plugin_setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plugin_setting_id_seq OWNER TO asterisk;

--
-- Name: plugin_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.plugin_setting_id_seq OWNED BY public.plugin_setting.id;


--
-- Name: preferences; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.preferences (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    user_id bigint NOT NULL,
    version integer NOT NULL,
    home_dashboard_id bigint NOT NULL,
    timezone character varying(50) NOT NULL,
    theme character varying(20) NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    team_id bigint
);


ALTER TABLE public.preferences OWNER TO asterisk;

--
-- Name: preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.preferences_id_seq OWNER TO asterisk;

--
-- Name: preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.preferences_id_seq OWNED BY public.preferences.id;


--
-- Name: quota; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.quota (
    id integer NOT NULL,
    org_id bigint,
    user_id bigint,
    target character varying(190) NOT NULL,
    "limit" bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL
);


ALTER TABLE public.quota OWNER TO asterisk;

--
-- Name: quota_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.quota_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quota_id_seq OWNER TO asterisk;

--
-- Name: quota_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.quota_id_seq OWNED BY public.quota.id;


--
-- Name: server_lock; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.server_lock (
    id integer NOT NULL,
    operation_uid character varying(100) NOT NULL,
    version bigint NOT NULL,
    last_execution bigint NOT NULL
);


ALTER TABLE public.server_lock OWNER TO asterisk;

--
-- Name: server_lock_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.server_lock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.server_lock_id_seq OWNER TO asterisk;

--
-- Name: server_lock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.server_lock_id_seq OWNED BY public.server_lock.id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.session (
    key character(16) NOT NULL,
    data bytea NOT NULL,
    expiry integer NOT NULL
);


ALTER TABLE public.session OWNER TO asterisk;

--
-- Name: short_url; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.short_url (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    uid character varying(40) NOT NULL,
    path text NOT NULL,
    created_by integer NOT NULL,
    created_at integer NOT NULL,
    last_seen_at integer
);


ALTER TABLE public.short_url OWNER TO asterisk;

--
-- Name: short_url_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.short_url_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.short_url_id_seq OWNER TO asterisk;

--
-- Name: short_url_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.short_url_id_seq OWNED BY public.short_url.id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.star (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    dashboard_id bigint NOT NULL
);


ALTER TABLE public.star OWNER TO asterisk;

--
-- Name: star_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_id_seq OWNER TO asterisk;

--
-- Name: star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.star_id_seq OWNED BY public.star.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value character varying(100) NOT NULL
);


ALTER TABLE public.tag OWNER TO asterisk;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO asterisk;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: team; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.team (
    id integer NOT NULL,
    name character varying(190) NOT NULL,
    org_id bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    email character varying(190)
);


ALTER TABLE public.team OWNER TO asterisk;

--
-- Name: team_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_id_seq OWNER TO asterisk;

--
-- Name: team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.team_id_seq OWNED BY public.team.id;


--
-- Name: team_member; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.team_member (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    team_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    external boolean,
    permission smallint
);


ALTER TABLE public.team_member OWNER TO asterisk;

--
-- Name: team_member_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.team_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_member_id_seq OWNER TO asterisk;

--
-- Name: team_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.team_member_id_seq OWNED BY public.team_member.id;


--
-- Name: temp_user; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.temp_user (
    id integer NOT NULL,
    org_id bigint NOT NULL,
    version integer NOT NULL,
    email character varying(190) NOT NULL,
    name character varying(255),
    role character varying(20),
    code character varying(190) NOT NULL,
    status character varying(20) NOT NULL,
    invited_by_user_id bigint,
    email_sent boolean NOT NULL,
    email_sent_on timestamp without time zone,
    remote_addr character varying(255),
    created integer DEFAULT 0 NOT NULL,
    updated integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.temp_user OWNER TO asterisk;

--
-- Name: temp_user_id_seq1; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.temp_user_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.temp_user_id_seq1 OWNER TO asterisk;

--
-- Name: temp_user_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.temp_user_id_seq1 OWNED BY public.temp_user.id;


--
-- Name: test_data; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.test_data (
    id integer NOT NULL,
    metric1 character varying(20),
    metric2 character varying(150),
    value_big_int bigint,
    value_double double precision,
    value_float real,
    value_int integer,
    time_epoch bigint NOT NULL,
    time_date_time timestamp without time zone NOT NULL,
    time_time_stamp timestamp without time zone NOT NULL
);


ALTER TABLE public.test_data OWNER TO asterisk;

--
-- Name: test_data_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.test_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_data_id_seq OWNER TO asterisk;

--
-- Name: test_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.test_data_id_seq OWNED BY public.test_data.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    version integer NOT NULL,
    login character varying(190) NOT NULL,
    email character varying(190) NOT NULL,
    name character varying(255),
    password character varying(255),
    salt character varying(50),
    rands character varying(50),
    company character varying(255),
    org_id bigint NOT NULL,
    is_admin boolean NOT NULL,
    email_verified boolean,
    theme character varying(255),
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    help_flags1 bigint DEFAULT 0 NOT NULL,
    last_seen_at timestamp without time zone,
    is_disabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public."user" OWNER TO asterisk;

--
-- Name: user_auth; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.user_auth (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    auth_module character varying(190) NOT NULL,
    auth_id character varying(190) NOT NULL,
    created timestamp without time zone NOT NULL,
    o_auth_access_token text,
    o_auth_refresh_token text,
    o_auth_token_type text,
    o_auth_expiry timestamp without time zone
);


ALTER TABLE public.user_auth OWNER TO asterisk;

--
-- Name: user_auth_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.user_auth_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_auth_id_seq OWNER TO asterisk;

--
-- Name: user_auth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.user_auth_id_seq OWNED BY public.user_auth.id;


--
-- Name: user_auth_token; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.user_auth_token (
    id integer NOT NULL,
    user_id bigint NOT NULL,
    auth_token character varying(100) NOT NULL,
    prev_auth_token character varying(100) NOT NULL,
    user_agent character varying(255) NOT NULL,
    client_ip character varying(255) NOT NULL,
    auth_token_seen boolean NOT NULL,
    seen_at integer,
    rotated_at integer NOT NULL,
    created_at integer NOT NULL,
    updated_at integer NOT NULL,
    revoked_at integer
);


ALTER TABLE public.user_auth_token OWNER TO asterisk;

--
-- Name: user_auth_token_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.user_auth_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_auth_token_id_seq OWNER TO asterisk;

--
-- Name: user_auth_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.user_auth_token_id_seq OWNED BY public.user_auth_token.id;


--
-- Name: user_id_seq1; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.user_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq1 OWNER TO asterisk;

--
-- Name: user_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.user_id_seq1 OWNED BY public."user".id;


--
-- Name: alert id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.alert ALTER COLUMN id SET DEFAULT nextval('public.alert_id_seq'::regclass);


--
-- Name: alert_notification id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.alert_notification ALTER COLUMN id SET DEFAULT nextval('public.alert_notification_id_seq'::regclass);


--
-- Name: alert_notification_state id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.alert_notification_state ALTER COLUMN id SET DEFAULT nextval('public.alert_notification_state_id_seq'::regclass);


--
-- Name: alert_rule_tag id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.alert_rule_tag ALTER COLUMN id SET DEFAULT nextval('public.alert_rule_tag_id_seq'::regclass);


--
-- Name: annotation id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.annotation ALTER COLUMN id SET DEFAULT nextval('public.annotation_id_seq'::regclass);


--
-- Name: annotation_tag id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.annotation_tag ALTER COLUMN id SET DEFAULT nextval('public.annotation_tag_id_seq'::regclass);


--
-- Name: api_key id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.api_key ALTER COLUMN id SET DEFAULT nextval('public.api_key_id_seq1'::regclass);


--
-- Name: dashboard id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.dashboard ALTER COLUMN id SET DEFAULT nextval('public.dashboard_id_seq1'::regclass);


--
-- Name: dashboard_acl id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.dashboard_acl ALTER COLUMN id SET DEFAULT nextval('public.dashboard_acl_id_seq'::regclass);


--
-- Name: dashboard_provisioning id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.dashboard_provisioning ALTER COLUMN id SET DEFAULT nextval('public.dashboard_provisioning_id_seq1'::regclass);


--
-- Name: dashboard_snapshot id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.dashboard_snapshot ALTER COLUMN id SET DEFAULT nextval('public.dashboard_snapshot_id_seq'::regclass);


--
-- Name: dashboard_tag id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.dashboard_tag ALTER COLUMN id SET DEFAULT nextval('public.dashboard_tag_id_seq'::regclass);


--
-- Name: dashboard_version id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.dashboard_version ALTER COLUMN id SET DEFAULT nextval('public.dashboard_version_id_seq'::regclass);


--
-- Name: data_source id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.data_source ALTER COLUMN id SET DEFAULT nextval('public.data_source_id_seq1'::regclass);


--
-- Name: login_attempt id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.login_attempt ALTER COLUMN id SET DEFAULT nextval('public.login_attempt_id_seq1'::regclass);


--
-- Name: migration_log id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.migration_log ALTER COLUMN id SET DEFAULT nextval('public.migration_log_id_seq'::regclass);


--
-- Name: org id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.org ALTER COLUMN id SET DEFAULT nextval('public.org_id_seq'::regclass);


--
-- Name: org_user id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.org_user ALTER COLUMN id SET DEFAULT nextval('public.org_user_id_seq'::regclass);


--
-- Name: playlist id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.playlist ALTER COLUMN id SET DEFAULT nextval('public.playlist_id_seq'::regclass);


--
-- Name: playlist_item id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.playlist_item ALTER COLUMN id SET DEFAULT nextval('public.playlist_item_id_seq'::regclass);


--
-- Name: plugin_setting id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.plugin_setting ALTER COLUMN id SET DEFAULT nextval('public.plugin_setting_id_seq'::regclass);


--
-- Name: preferences id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.preferences ALTER COLUMN id SET DEFAULT nextval('public.preferences_id_seq'::regclass);


--
-- Name: quota id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.quota ALTER COLUMN id SET DEFAULT nextval('public.quota_id_seq'::regclass);


--
-- Name: server_lock id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.server_lock ALTER COLUMN id SET DEFAULT nextval('public.server_lock_id_seq'::regclass);


--
-- Name: short_url id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.short_url ALTER COLUMN id SET DEFAULT nextval('public.short_url_id_seq'::regclass);


--
-- Name: star id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.star ALTER COLUMN id SET DEFAULT nextval('public.star_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: team id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.team ALTER COLUMN id SET DEFAULT nextval('public.team_id_seq'::regclass);


--
-- Name: team_member id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.team_member ALTER COLUMN id SET DEFAULT nextval('public.team_member_id_seq'::regclass);


--
-- Name: temp_user id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.temp_user ALTER COLUMN id SET DEFAULT nextval('public.temp_user_id_seq1'::regclass);


--
-- Name: test_data id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.test_data ALTER COLUMN id SET DEFAULT nextval('public.test_data_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq1'::regclass);


--
-- Name: user_auth id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.user_auth ALTER COLUMN id SET DEFAULT nextval('public.user_auth_id_seq'::regclass);


--
-- Name: user_auth_token id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.user_auth_token ALTER COLUMN id SET DEFAULT nextval('public.user_auth_token_id_seq'::regclass);


--
-- Data for Name: alert; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.alert (id, version, dashboard_id, panel_id, org_id, name, message, state, settings, frequency, handler, severity, silenced, execution_error, eval_data, eval_date, new_state_date, state_changes, created, updated, "for") FROM stdin;
\.


--
-- Data for Name: alert_notification; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.alert_notification (id, org_id, name, type, settings, created, updated, is_default, frequency, send_reminder, disable_resolve_message, uid, secure_settings) FROM stdin;
\.


--
-- Data for Name: alert_notification_state; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.alert_notification_state (id, org_id, alert_id, notifier_id, state, version, updated_at, alert_rule_state_updated_version) FROM stdin;
\.


--
-- Data for Name: alert_rule_tag; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.alert_rule_tag (id, alert_id, tag_id) FROM stdin;
\.


--
-- Data for Name: annotation; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.annotation (id, org_id, alert_id, user_id, dashboard_id, panel_id, category_id, type, title, text, metric, prev_state, new_state, data, epoch, region_id, tags, created, updated, epoch_end) FROM stdin;
\.


--
-- Data for Name: annotation_tag; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.annotation_tag (id, annotation_id, tag_id) FROM stdin;
\.


--
-- Data for Name: api_key; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.api_key (id, org_id, name, key, role, created, updated, expires) FROM stdin;
\.


--
-- Data for Name: cache_data; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.cache_data (cache_key, data, expires, created_at) FROM stdin;
\.


--
-- Data for Name: dashboard; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.dashboard (id, version, slug, title, data, org_id, created, updated, updated_by, created_by, gnet_id, plugin_id, folder_id, is_folder, has_acl, uid) FROM stdin;
1	1	statistika-zvonkov	Статистика звонков	{"annotations":{"list":[{"builtIn":1,"datasource":"-- Grafana --","enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","type":"dashboard"}]},"description":"Статистика звонков","editable":true,"gnetId":null,"graphTooltip":0,"id":null,"iteration":1623242568866,"links":[{"asDropdown":false,"icon":"dashboard","includeVars":false,"keepTime":false,"tags":[],"targetBlank":false,"title":"Управления операторами","tooltip":"","type":"link","url":"/grafana/d/yeTbSDqGz/upravleniia-operatorami?orgId=1\\u0026refresh=30s"}],"panels":[{"columns":[],"datasource":"asteriskcdrdb","description":"","fieldConfig":{"defaults":{},"overrides":[]},"fontSize":"100%","gridPos":{"h":17,"w":24,"x":0,"y":0},"id":2,"links":[],"pageSize":null,"repeatDirection":"v","showHeader":true,"sort":{"col":0,"desc":true},"styles":[{"$$hashKey":"object:1503","alias":"Дата и время","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":2,"mappingType":1,"pattern":"calldate","thresholds":[],"type":"date","unit":"short"},{"$$hashKey":"object:1592","alias":"Источник","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":null,"mappingType":1,"pattern":"src","thresholds":[],"type":"string","unit":"locale"},{"$$hashKey":"object:1831","alias":"Назначение","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":null,"mappingType":1,"pattern":"dst","thresholds":[],"type":"string","unit":"locale"},{"$$hashKey":"object:1918","alias":"Длительность(сек.)","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":null,"mappingType":1,"pattern":"billsec","thresholds":[],"type":"number","unit":"locale"},{"$$hashKey":"object:2157","alias":"Время ожидания(сек.)","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":null,"mappingType":1,"pattern":"wait_time","thresholds":[],"type":"number","unit":"locale"},{"$$hashKey":"object:2320","alias":"Статус","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":2,"mappingType":1,"pattern":"disposition","thresholds":[],"type":"string","unit":"short","valueMaps":[{"$$hashKey":"object:2457","text":"Не отвеченный","value":"NOANSWER"},{"$$hashKey":"object:2573","text":"Отвеченный","value":"ANSWER"},{"$$hashKey":"object:2632","text":"Отвеченный","value":"ANSWERED"},{"$$hashKey":"object:2672","text":"Занято","value":"BUSY"},{"$$hashKey":"object:2731","text":"Ошибка","value":"FAILED"},{"$$hashKey":"object:2790","text":"Не отвеченный","value":"NO ANSWER"}]},{"$$hashKey":"object:2849","alias":"Запись","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":2,"link":false,"mappingType":1,"pattern":"link","sanitize":true,"thresholds":[],"type":"string","unit":"short"}],"targets":[{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"select calldate,$src,$dst,billsec,\\n$wtime disposition,\\n'\\u003ca href=\\" /monitor'|| split_part(filename, 'monitor', 2)  || '\\" target=\\"_blank\\"\\u003e💾\\u003c/a\\u003e' link\\nfrom $direction_table\\nwhere $status\\n$out_sip1$sip_operators$out_sip2\\n\\n\\n","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"timeFrom":null,"timeShift":null,"transform":"table","transparent":true,"type":"table-old"},{"datasource":"asteriskcdrdb","fieldConfig":{"defaults":{"mappings":[{"from":"","id":0,"text":"","to":"","type":1}],"thresholds":{"mode":"absolute","steps":[{"color":"red","value":null}]}},"overrides":[{"matcher":{"id":"byName","options":"Отвеченные"},"properties":[{"id":"thresholds","value":{"mode":"absolute","steps":[{"color":"green","value":null}]}}]},{"matcher":{"id":"byName","options":"Все звонки"},"properties":[{"id":"thresholds","value":{"mode":"absolute","steps":[{"color":"blue","value":null}]}}]},{"matcher":{"id":"byName","options":"Не отвеченные"},"properties":[{"id":"thresholds","value":{"mode":"absolute","steps":[{"color":"red","value":null}]}}]}]},"gridPos":{"h":4,"w":12,"x":0,"y":17},"id":4,"options":{"orientation":"auto","reduceOptions":{"calcs":["mean"],"fields":"","values":false},"showThresholdLabels":false,"showThresholdMarkers":true,"text":{}},"pluginVersion":"7.5.6","targets":[{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"with t1 as (\\nselect calldate as time from cdr_queue_log \\nwhere disposition = 'ANSWER'\\nand calldate $__timeFilter()\\n),\\nt2 as (\\nselect count(*) cnt  from cdr_queue_log \\nwhere disposition = 'ANSWER'\\nand calldate $__timeFilter()\\n)\\nselect time, cnt as \\"Отвеченные\\" from t1 \\nleft join t2 on true","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]},{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"with t1 as (\\nselect calldate as time from cdr_queue_log \\nwhere calldate $__timeFilter()\\n),\\nt2 as (\\nselect count(*) cnt  from cdr_queue_log \\nwhere calldate $__timeFilter()\\n)\\nselect time, cnt as \\"Все звонки\\" from t1 \\nleft join t2 on true","refId":"B","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]},{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"with t1 as (\\nselect calldate as time from cdr_queue_log \\nwhere disposition in ('NOANSWER','BUSY')\\nand calldate $__timeFilter()\\n),\\nt2 as (\\nselect count(*) cnt  from cdr_queue_log \\nwhere disposition in ('NOANSWER','BUSY')\\nand calldate $__timeFilter()\\n)\\nselect time, cnt as \\"Не отвеченные\\" from t1 \\nleft join t2 on true\\n\\n","refId":"C","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"timeFrom":null,"timeShift":null,"title":"Входящие звонки за период","transparent":true,"type":"gauge"},{"datasource":"asteriskcdrdb","fieldConfig":{"defaults":{"mappings":[{"from":"","id":0,"text":"","to":"","type":1}],"thresholds":{"mode":"absolute","steps":[{"color":"red","value":null}]}},"overrides":[{"matcher":{"id":"byName","options":"Отвеченные"},"properties":[{"id":"thresholds","value":{"mode":"absolute","steps":[{"color":"green","value":null}]}}]},{"matcher":{"id":"byName","options":"Все звонки"},"properties":[{"id":"thresholds","value":{"mode":"absolute","steps":[{"color":"blue","value":null}]}}]},{"matcher":{"id":"byName","options":"Не отвеченные"},"properties":[{"id":"thresholds","value":{"mode":"absolute","steps":[{"color":"red","value":null}]}}]}]},"gridPos":{"h":4,"w":12,"x":12,"y":17},"id":5,"options":{"orientation":"auto","reduceOptions":{"calcs":["mean"],"fields":"","values":false},"showThresholdLabels":false,"showThresholdMarkers":true,"text":{}},"pluginVersion":"7.5.6","targets":[{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"with t1 as (\\nselect calldate as time from cdr\\nwhere disposition = 'ANSWERED'\\nand src in ($sip_operators)\\nand calldate $__timeFilter()\\n),\\nt2 as (\\nselect count(*) cnt  from cdr\\nwhere disposition = 'ANSWERED'\\nand src in ($sip_operators)\\nand calldate $__timeFilter()\\n)\\nselect time, cnt as \\"Отвеченные\\" from t1 \\nleft join t2 on true\\n","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]},{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"with t1 as (\\nselect calldate as time from cdr\\nwhere calldate $__timeFilter()\\nand src in ($sip_operators)\\n),\\nt2 as (\\nselect count(*) cnt  from cdr\\nwhere calldate $__timeFilter()\\nand src in ($sip_operators)\\n)\\nselect time, cnt as \\"Все звонки\\" from t1 \\nleft join t2 on true\\n","refId":"B","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]},{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"with t1 as (\\nselect calldate as time from cdr \\nwhere disposition in ('NO ANSWER','BUSY')\\nand calldate $__timeFilter()\\nand src in ($sip_operators)\\n),\\nt2 as (\\nselect count(*) cnt  from cdr\\nwhere disposition in ('NO ANSWER','BUSY')\\nand calldate $__timeFilter()\\nand src in ($sip_operators)\\n)\\nselect time, cnt as \\"Не отвеченные\\" from t1 \\nleft join t2 on true\\n","refId":"C","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"timeFrom":null,"timeShift":null,"title":"Исходящие звонки за период","transparent":true,"type":"gauge"}],"refresh":"5s","schemaVersion":27,"style":"dark","tags":[],"templating":{"list":[{"allValue":null,"current":{"selected":true,"text":"Входящие","value":"Входящие"},"description":null,"error":null,"hide":0,"includeAll":false,"label":"Направление","multi":false,"name":"direction","options":[{"selected":true,"text":"Входящие","value":"Входящие"},{"selected":false,"text":"Исходящие","value":"Исходящие"}],"query":"Входящие,Исходящие","queryValue":"","skipUrlSync":false,"type":"custom"},{"allValue":null,"current":{"selected":true,"text":"Все","value":"Все"},"description":null,"error":null,"hide":0,"includeAll":false,"label":"Статус звонка","multi":false,"name":"wcalls","options":[{"selected":true,"text":"Все","value":"Все"},{"selected":false,"text":"Отвеченные","value":"Отвеченные"},{"selected":false,"text":"Не отвеченные","value":"Не отвеченные"}],"query":"Все, Отвеченные, Не отвеченные","queryValue":"","skipUrlSync":false,"type":"custom"},{"allValue":null,"current":{"selected":false,"text":"cdr_queue_log","value":"cdr_queue_log"},"datasource":null,"definition":"select case when '$direction' = 'Входящие' then 'cdr_queue_log' when '$direction' = 'Исходящие' then 'cdr' end","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"direction_table","options":[],"query":"select case when '$direction' = 'Входящие' then 'cdr_queue_log' when '$direction' = 'Исходящие' then 'cdr' end","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"wait_time,","value":"wait_time,"},"datasource":null,"definition":"select case when '$direction' = 'Входящие' then 'wait_time,' when '$direction' = 'Исходящие' then '' end","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"wtime","options":[],"query":"select case when '$direction' = 'Входящие' then 'wait_time,' when '$direction' = 'Исходящие' then '' end","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"disposition is not null","value":"disposition is not null"},"datasource":null,"definition":"select case when '$direction' = 'Входящие' then '$wdirect_in' when '$direction' = 'Исходящие' then '$wdirect_out' end","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"status","options":[],"query":"select case when '$direction' = 'Входящие' then '$wdirect_in' when '$direction' = 'Исходящие' then '$wdirect_out' end","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"disposition is not null","value":"disposition is not null"},"datasource":null,"definition":"select case \\nwhen '$wcalls' = 'Все' then 'disposition is not null' \\nwhen '$wcalls' = 'Отвеченные' then 'disposition = $$ANSWER$$'\\nwhen '$wcalls' = 'Не отвеченные' then 'disposition = $$NOANSWER$$'\\nend","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"wdirect_in","options":[],"query":"select case \\nwhen '$wcalls' = 'Все' then 'disposition is not null' \\nwhen '$wcalls' = 'Отвеченные' then 'disposition = $$ANSWER$$'\\nwhen '$wcalls' = 'Не отвеченные' then 'disposition = $$NOANSWER$$'\\nend","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"disposition is not null","value":"disposition is not null"},"datasource":null,"definition":"select case \\nwhen '$wcalls' = 'Все' then 'disposition is not null'\\nwhen '$wcalls' = 'Отвеченные' then 'disposition = $$ANSWERED$$'\\nwhen '$wcalls' = 'Не отвеченные' then 'disposition in ($$NO ANSWER$$,$$BUSY$$)'\\nend","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"wdirect_out","options":[],"query":"select case \\nwhen '$wcalls' = 'Все' then 'disposition is not null'\\nwhen '$wcalls' = 'Отвеченные' then 'disposition = $$ANSWERED$$'\\nwhen '$wcalls' = 'Не отвеченные' then 'disposition in ($$NO ANSWER$$,$$BUSY$$)'\\nend","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"All","value":"$__all"},"datasource":null,"definition":"select num from operators where name in ($operators) ","description":null,"error":null,"hide":2,"includeAll":true,"label":null,"multi":false,"name":"sip_operators","options":[],"query":"select num from operators where name in ($operators) ","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"and dst in (","value":"and dst in ("},"datasource":null,"definition":"select case when '$direction' = 'Входящие' then 'and dst in (' when '$direction' = 'Исходящие' then 'and src in (' end","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"out_sip1","options":[],"query":"select case when '$direction' = 'Входящие' then 'and dst in (' when '$direction' = 'Исходящие' then 'and src in (' end","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":")","value":")"},"datasource":null,"definition":"select case when '$direction' = 'Входящие' then ')' when '$direction' = 'Исходящие' then ')' end","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"out_sip2","options":[],"query":"select case when '$direction' = 'Входящие' then ')' when '$direction' = 'Исходящие' then ')' end","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"All","value":"$__all"},"datasource":null,"definition":"select name from operators ","description":null,"error":null,"hide":0,"includeAll":true,"label":"Операторы","multi":false,"name":"operators","options":[],"query":"select name from operators ","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"src","value":"src"},"datasource":null,"definition":"select case \\nwhen '$direction' = 'Входящие' then 'src' \\nwhen '$direction' = 'Исходящие' then '(select name from operators where num=src )  src' \\nend","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"src","options":[],"query":"select case \\nwhen '$direction' = 'Входящие' then 'src' \\nwhen '$direction' = 'Исходящие' then '(select name from operators where num=src )  src' \\nend","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"(select name from operators where num=dst )::varchar dst","value":"(select name from operators where num=dst )::varchar dst"},"datasource":null,"definition":"select case \\nwhen '$direction' = 'Входящие' then '(select name from operators where num=dst )::varchar dst' \\nwhen '$direction' = 'Исходящие' then 'dst' \\nend","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"dst","options":[],"query":"select case \\nwhen '$direction' = 'Входящие' then '(select name from operators where num=dst )::varchar dst' \\nwhen '$direction' = 'Исходящие' then 'dst' \\nend","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false}]},"time":{"from":"now-24h","to":"now"},"timepicker":{},"timezone":"","title":"Статистика звонков","uid":"XIYq7MqMk","version":1}	1	2021-06-09 12:44:49	2021-06-09 12:44:49	1	1	0		0	f	f	XIYq7MqMk
\.


--
-- Data for Name: dashboard_acl; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.dashboard_acl (id, org_id, dashboard_id, user_id, team_id, permission, role, created, updated) FROM stdin;
1	-1	-1	\N	\N	1	Viewer	2017-06-20 00:00:00	2017-06-20 00:00:00
2	-1	-1	\N	\N	2	Editor	2017-06-20 00:00:00	2017-06-20 00:00:00
\.


--
-- Data for Name: dashboard_provisioning; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.dashboard_provisioning (id, dashboard_id, name, external_id, updated, check_sum) FROM stdin;
\.


--
-- Data for Name: dashboard_snapshot; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.dashboard_snapshot (id, name, key, delete_key, org_id, user_id, external, external_url, dashboard, expires, created, updated, external_delete_url, dashboard_encrypted) FROM stdin;
\.


--
-- Data for Name: dashboard_tag; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.dashboard_tag (id, dashboard_id, term) FROM stdin;
\.


--
-- Data for Name: dashboard_version; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.dashboard_version (id, dashboard_id, parent_version, restored_from, version, created, created_by, message, data) FROM stdin;
1	1	23	0	1	2021-06-09 12:44:49	1		{"annotations":{"list":[{"builtIn":1,"datasource":"-- Grafana --","enable":true,"hide":true,"iconColor":"rgba(0, 211, 255, 1)","name":"Annotations \\u0026 Alerts","type":"dashboard"}]},"description":"Статистика звонков","editable":true,"gnetId":null,"graphTooltip":0,"id":null,"iteration":1623242568866,"links":[{"asDropdown":false,"icon":"dashboard","includeVars":false,"keepTime":false,"tags":[],"targetBlank":false,"title":"Управления операторами","tooltip":"","type":"link","url":"/grafana/d/yeTbSDqGz/upravleniia-operatorami?orgId=1\\u0026refresh=30s"}],"panels":[{"columns":[],"datasource":"asteriskcdrdb","description":"","fieldConfig":{"defaults":{},"overrides":[]},"fontSize":"100%","gridPos":{"h":17,"w":24,"x":0,"y":0},"id":2,"links":[],"pageSize":null,"repeatDirection":"v","showHeader":true,"sort":{"col":0,"desc":true},"styles":[{"$$hashKey":"object:1503","alias":"Дата и время","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":2,"mappingType":1,"pattern":"calldate","thresholds":[],"type":"date","unit":"short"},{"$$hashKey":"object:1592","alias":"Источник","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":null,"mappingType":1,"pattern":"src","thresholds":[],"type":"string","unit":"locale"},{"$$hashKey":"object:1831","alias":"Назначение","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":null,"mappingType":1,"pattern":"dst","thresholds":[],"type":"string","unit":"locale"},{"$$hashKey":"object:1918","alias":"Длительность(сек.)","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":null,"mappingType":1,"pattern":"billsec","thresholds":[],"type":"number","unit":"locale"},{"$$hashKey":"object:2157","alias":"Время ожидания(сек.)","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":null,"mappingType":1,"pattern":"wait_time","thresholds":[],"type":"number","unit":"locale"},{"$$hashKey":"object:2320","alias":"Статус","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":2,"mappingType":1,"pattern":"disposition","thresholds":[],"type":"string","unit":"short","valueMaps":[{"$$hashKey":"object:2457","text":"Не отвеченный","value":"NOANSWER"},{"$$hashKey":"object:2573","text":"Отвеченный","value":"ANSWER"},{"$$hashKey":"object:2632","text":"Отвеченный","value":"ANSWERED"},{"$$hashKey":"object:2672","text":"Занято","value":"BUSY"},{"$$hashKey":"object:2731","text":"Ошибка","value":"FAILED"},{"$$hashKey":"object:2790","text":"Не отвеченный","value":"NO ANSWER"}]},{"$$hashKey":"object:2849","alias":"Запись","align":"auto","colorMode":null,"colors":["rgba(245, 54, 54, 0.9)","rgba(237, 129, 40, 0.89)","rgba(50, 172, 45, 0.97)"],"dateFormat":"YYYY-MM-DD HH:mm:ss","decimals":2,"link":false,"mappingType":1,"pattern":"link","sanitize":true,"thresholds":[],"type":"string","unit":"short"}],"targets":[{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"select calldate,$src,$dst,billsec,\\n$wtime disposition,\\n'\\u003ca href=\\" /monitor'|| split_part(filename, 'monitor', 2)  || '\\" target=\\"_blank\\"\\u003e💾\\u003c/a\\u003e' link\\nfrom $direction_table\\nwhere $status\\n$out_sip1$sip_operators$out_sip2\\n\\n\\n","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"timeFrom":null,"timeShift":null,"transform":"table","transparent":true,"type":"table-old"},{"datasource":"asteriskcdrdb","fieldConfig":{"defaults":{"mappings":[{"from":"","id":0,"text":"","to":"","type":1}],"thresholds":{"mode":"absolute","steps":[{"color":"red","value":null}]}},"overrides":[{"matcher":{"id":"byName","options":"Отвеченные"},"properties":[{"id":"thresholds","value":{"mode":"absolute","steps":[{"color":"green","value":null}]}}]},{"matcher":{"id":"byName","options":"Все звонки"},"properties":[{"id":"thresholds","value":{"mode":"absolute","steps":[{"color":"blue","value":null}]}}]},{"matcher":{"id":"byName","options":"Не отвеченные"},"properties":[{"id":"thresholds","value":{"mode":"absolute","steps":[{"color":"red","value":null}]}}]}]},"gridPos":{"h":4,"w":12,"x":0,"y":17},"id":4,"options":{"orientation":"auto","reduceOptions":{"calcs":["mean"],"fields":"","values":false},"showThresholdLabels":false,"showThresholdMarkers":true,"text":{}},"pluginVersion":"7.5.6","targets":[{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"with t1 as (\\nselect calldate as time from cdr_queue_log \\nwhere disposition = 'ANSWER'\\nand calldate $__timeFilter()\\n),\\nt2 as (\\nselect count(*) cnt  from cdr_queue_log \\nwhere disposition = 'ANSWER'\\nand calldate $__timeFilter()\\n)\\nselect time, cnt as \\"Отвеченные\\" from t1 \\nleft join t2 on true","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]},{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"with t1 as (\\nselect calldate as time from cdr_queue_log \\nwhere calldate $__timeFilter()\\n),\\nt2 as (\\nselect count(*) cnt  from cdr_queue_log \\nwhere calldate $__timeFilter()\\n)\\nselect time, cnt as \\"Все звонки\\" from t1 \\nleft join t2 on true","refId":"B","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]},{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"with t1 as (\\nselect calldate as time from cdr_queue_log \\nwhere disposition in ('NOANSWER','BUSY')\\nand calldate $__timeFilter()\\n),\\nt2 as (\\nselect count(*) cnt  from cdr_queue_log \\nwhere disposition in ('NOANSWER','BUSY')\\nand calldate $__timeFilter()\\n)\\nselect time, cnt as \\"Не отвеченные\\" from t1 \\nleft join t2 on true\\n\\n","refId":"C","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"timeFrom":null,"timeShift":null,"title":"Входящие звонки за период","transparent":true,"type":"gauge"},{"datasource":"asteriskcdrdb","fieldConfig":{"defaults":{"mappings":[{"from":"","id":0,"text":"","to":"","type":1}],"thresholds":{"mode":"absolute","steps":[{"color":"red","value":null}]}},"overrides":[{"matcher":{"id":"byName","options":"Отвеченные"},"properties":[{"id":"thresholds","value":{"mode":"absolute","steps":[{"color":"green","value":null}]}}]},{"matcher":{"id":"byName","options":"Все звонки"},"properties":[{"id":"thresholds","value":{"mode":"absolute","steps":[{"color":"blue","value":null}]}}]},{"matcher":{"id":"byName","options":"Не отвеченные"},"properties":[{"id":"thresholds","value":{"mode":"absolute","steps":[{"color":"red","value":null}]}}]}]},"gridPos":{"h":4,"w":12,"x":12,"y":17},"id":5,"options":{"orientation":"auto","reduceOptions":{"calcs":["mean"],"fields":"","values":false},"showThresholdLabels":false,"showThresholdMarkers":true,"text":{}},"pluginVersion":"7.5.6","targets":[{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"with t1 as (\\nselect calldate as time from cdr\\nwhere disposition = 'ANSWERED'\\nand src in ($sip_operators)\\nand calldate $__timeFilter()\\n),\\nt2 as (\\nselect count(*) cnt  from cdr\\nwhere disposition = 'ANSWERED'\\nand src in ($sip_operators)\\nand calldate $__timeFilter()\\n)\\nselect time, cnt as \\"Отвеченные\\" from t1 \\nleft join t2 on true\\n","refId":"A","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]},{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"with t1 as (\\nselect calldate as time from cdr\\nwhere calldate $__timeFilter()\\nand src in ($sip_operators)\\n),\\nt2 as (\\nselect count(*) cnt  from cdr\\nwhere calldate $__timeFilter()\\nand src in ($sip_operators)\\n)\\nselect time, cnt as \\"Все звонки\\" from t1 \\nleft join t2 on true\\n","refId":"B","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]},{"format":"table","group":[],"metricColumn":"none","rawQuery":true,"rawSql":"with t1 as (\\nselect calldate as time from cdr \\nwhere disposition in ('NO ANSWER','BUSY')\\nand calldate $__timeFilter()\\nand src in ($sip_operators)\\n),\\nt2 as (\\nselect count(*) cnt  from cdr\\nwhere disposition in ('NO ANSWER','BUSY')\\nand calldate $__timeFilter()\\nand src in ($sip_operators)\\n)\\nselect time, cnt as \\"Не отвеченные\\" from t1 \\nleft join t2 on true\\n","refId":"C","select":[[{"params":["value"],"type":"column"}]],"timeColumn":"time","where":[{"name":"$__timeFilter","params":[],"type":"macro"}]}],"timeFrom":null,"timeShift":null,"title":"Исходящие звонки за период","transparent":true,"type":"gauge"}],"refresh":"5s","schemaVersion":27,"style":"dark","tags":[],"templating":{"list":[{"allValue":null,"current":{"selected":true,"text":"Входящие","value":"Входящие"},"description":null,"error":null,"hide":0,"includeAll":false,"label":"Направление","multi":false,"name":"direction","options":[{"selected":true,"text":"Входящие","value":"Входящие"},{"selected":false,"text":"Исходящие","value":"Исходящие"}],"query":"Входящие,Исходящие","queryValue":"","skipUrlSync":false,"type":"custom"},{"allValue":null,"current":{"selected":true,"text":"Все","value":"Все"},"description":null,"error":null,"hide":0,"includeAll":false,"label":"Статус звонка","multi":false,"name":"wcalls","options":[{"selected":true,"text":"Все","value":"Все"},{"selected":false,"text":"Отвеченные","value":"Отвеченные"},{"selected":false,"text":"Не отвеченные","value":"Не отвеченные"}],"query":"Все, Отвеченные, Не отвеченные","queryValue":"","skipUrlSync":false,"type":"custom"},{"allValue":null,"current":{"selected":false,"text":"cdr_queue_log","value":"cdr_queue_log"},"datasource":null,"definition":"select case when '$direction' = 'Входящие' then 'cdr_queue_log' when '$direction' = 'Исходящие' then 'cdr' end","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"direction_table","options":[],"query":"select case when '$direction' = 'Входящие' then 'cdr_queue_log' when '$direction' = 'Исходящие' then 'cdr' end","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"wait_time,","value":"wait_time,"},"datasource":null,"definition":"select case when '$direction' = 'Входящие' then 'wait_time,' when '$direction' = 'Исходящие' then '' end","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"wtime","options":[],"query":"select case when '$direction' = 'Входящие' then 'wait_time,' when '$direction' = 'Исходящие' then '' end","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"disposition is not null","value":"disposition is not null"},"datasource":null,"definition":"select case when '$direction' = 'Входящие' then '$wdirect_in' when '$direction' = 'Исходящие' then '$wdirect_out' end","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"status","options":[],"query":"select case when '$direction' = 'Входящие' then '$wdirect_in' when '$direction' = 'Исходящие' then '$wdirect_out' end","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"disposition is not null","value":"disposition is not null"},"datasource":null,"definition":"select case \\nwhen '$wcalls' = 'Все' then 'disposition is not null' \\nwhen '$wcalls' = 'Отвеченные' then 'disposition = $$ANSWER$$'\\nwhen '$wcalls' = 'Не отвеченные' then 'disposition = $$NOANSWER$$'\\nend","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"wdirect_in","options":[],"query":"select case \\nwhen '$wcalls' = 'Все' then 'disposition is not null' \\nwhen '$wcalls' = 'Отвеченные' then 'disposition = $$ANSWER$$'\\nwhen '$wcalls' = 'Не отвеченные' then 'disposition = $$NOANSWER$$'\\nend","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"disposition is not null","value":"disposition is not null"},"datasource":null,"definition":"select case \\nwhen '$wcalls' = 'Все' then 'disposition is not null'\\nwhen '$wcalls' = 'Отвеченные' then 'disposition = $$ANSWERED$$'\\nwhen '$wcalls' = 'Не отвеченные' then 'disposition in ($$NO ANSWER$$,$$BUSY$$)'\\nend","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"wdirect_out","options":[],"query":"select case \\nwhen '$wcalls' = 'Все' then 'disposition is not null'\\nwhen '$wcalls' = 'Отвеченные' then 'disposition = $$ANSWERED$$'\\nwhen '$wcalls' = 'Не отвеченные' then 'disposition in ($$NO ANSWER$$,$$BUSY$$)'\\nend","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"All","value":"$__all"},"datasource":null,"definition":"select num from operators where name in ($operators) ","description":null,"error":null,"hide":2,"includeAll":true,"label":null,"multi":false,"name":"sip_operators","options":[],"query":"select num from operators where name in ($operators) ","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"and dst in (","value":"and dst in ("},"datasource":null,"definition":"select case when '$direction' = 'Входящие' then 'and dst in (' when '$direction' = 'Исходящие' then 'and src in (' end","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"out_sip1","options":[],"query":"select case when '$direction' = 'Входящие' then 'and dst in (' when '$direction' = 'Исходящие' then 'and src in (' end","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":")","value":")"},"datasource":null,"definition":"select case when '$direction' = 'Входящие' then ')' when '$direction' = 'Исходящие' then ')' end","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"out_sip2","options":[],"query":"select case when '$direction' = 'Входящие' then ')' when '$direction' = 'Исходящие' then ')' end","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"All","value":"$__all"},"datasource":null,"definition":"select name from operators ","description":null,"error":null,"hide":0,"includeAll":true,"label":"Операторы","multi":false,"name":"operators","options":[],"query":"select name from operators ","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"src","value":"src"},"datasource":null,"definition":"select case \\nwhen '$direction' = 'Входящие' then 'src' \\nwhen '$direction' = 'Исходящие' then '(select name from operators where num=src )  src' \\nend","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"src","options":[],"query":"select case \\nwhen '$direction' = 'Входящие' then 'src' \\nwhen '$direction' = 'Исходящие' then '(select name from operators where num=src )  src' \\nend","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false},{"allValue":null,"current":{"selected":false,"text":"(select name from operators where num=dst )::varchar dst","value":"(select name from operators where num=dst )::varchar dst"},"datasource":null,"definition":"select case \\nwhen '$direction' = 'Входящие' then '(select name from operators where num=dst )::varchar dst' \\nwhen '$direction' = 'Исходящие' then 'dst' \\nend","description":null,"error":null,"hide":2,"includeAll":false,"label":null,"multi":false,"name":"dst","options":[],"query":"select case \\nwhen '$direction' = 'Входящие' then '(select name from operators where num=dst )::varchar dst' \\nwhen '$direction' = 'Исходящие' then 'dst' \\nend","refresh":2,"regex":"","skipUrlSync":false,"sort":0,"tagValuesQuery":"","tags":[],"tagsQuery":"","type":"query","useTags":false}]},"time":{"from":"now-24h","to":"now"},"timepicker":{},"timezone":"","title":"Статистика звонков","uid":"XIYq7MqMk","version":1}
\.


--
-- Data for Name: data_source; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.data_source (id, org_id, version, type, name, access, url, password, "user", database, basic_auth, basic_auth_user, basic_auth_password, is_default, json_data, created, updated, with_credentials, secure_json_data, read_only, uid) FROM stdin;
1	1	4	postgres	asteriskcdrdb	proxy	asterisk-db		asterisk	asteriskcdrdb	f			t	{"postgresVersion":1300,"sslmode":"disable","timescaledb":false,"tlsAuth":false,"tlsAuthWithCACert":false,"tlsConfigurationMethod":"file-path","tlsSkipVerify":true}	2021-06-09 12:45:05	2021-06-09 12:49:11	f	{"password":"WUMzcUNUNTVd4JiCjiEdBWJ/1VsfmySU2MOgiOYnl98="}	f	jz5GnXeMz
\.


--
-- Data for Name: login_attempt; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.login_attempt (id, username, ip_address, created) FROM stdin;
\.


--
-- Data for Name: migration_log; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.migration_log (id, migration_id, sql, success, error, "timestamp") FROM stdin;
1	create migration_log table	CREATE TABLE IF NOT EXISTS "migration_log" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "migration_id" VARCHAR(255) NOT NULL\n, "sql" TEXT NOT NULL\n, "success" BOOL NOT NULL\n, "error" TEXT NOT NULL\n, "timestamp" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:28
2	create user table	CREATE TABLE IF NOT EXISTS "user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "login" VARCHAR(190) NOT NULL\n, "email" VARCHAR(190) NOT NULL\n, "name" VARCHAR(255) NULL\n, "password" VARCHAR(255) NULL\n, "salt" VARCHAR(50) NULL\n, "rands" VARCHAR(50) NULL\n, "company" VARCHAR(255) NULL\n, "account_id" BIGINT NOT NULL\n, "is_admin" BOOL NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:28
3	add unique index user.login	CREATE UNIQUE INDEX "UQE_user_login" ON "user" ("login");	t		2021-06-09 12:38:28
4	add unique index user.email	CREATE UNIQUE INDEX "UQE_user_email" ON "user" ("email");	t		2021-06-09 12:38:28
5	drop index UQE_user_login - v1	DROP INDEX "UQE_user_login" CASCADE	t		2021-06-09 12:38:28
6	drop index UQE_user_email - v1	DROP INDEX "UQE_user_email" CASCADE	t		2021-06-09 12:38:28
7	Rename table user to user_v1 - v1	ALTER TABLE "user" RENAME TO "user_v1"	t		2021-06-09 12:38:28
8	create user table v2	CREATE TABLE IF NOT EXISTS "user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "login" VARCHAR(190) NOT NULL\n, "email" VARCHAR(190) NOT NULL\n, "name" VARCHAR(255) NULL\n, "password" VARCHAR(255) NULL\n, "salt" VARCHAR(50) NULL\n, "rands" VARCHAR(50) NULL\n, "company" VARCHAR(255) NULL\n, "org_id" BIGINT NOT NULL\n, "is_admin" BOOL NOT NULL\n, "email_verified" BOOL NULL\n, "theme" VARCHAR(255) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:28
9	create index UQE_user_login - v2	CREATE UNIQUE INDEX "UQE_user_login" ON "user" ("login");	t		2021-06-09 12:38:28
10	create index UQE_user_email - v2	CREATE UNIQUE INDEX "UQE_user_email" ON "user" ("email");	t		2021-06-09 12:38:28
11	copy data_source v1 to v2	INSERT INTO "user" ("login"\n, "name"\n, "org_id"\n, "updated"\n, "rands"\n, "company"\n, "is_admin"\n, "id"\n, "version"\n, "email"\n, "password"\n, "salt"\n, "created") SELECT "login"\n, "name"\n, "account_id"\n, "updated"\n, "rands"\n, "company"\n, "is_admin"\n, "id"\n, "version"\n, "email"\n, "password"\n, "salt"\n, "created" FROM "user_v1"	t		2021-06-09 12:38:28
12	Drop old table user_v1	DROP TABLE IF EXISTS "user_v1"	t		2021-06-09 12:38:28
13	Add column help_flags1 to user table	alter table "user" ADD COLUMN "help_flags1" BIGINT NOT NULL DEFAULT 0 	t		2021-06-09 12:38:28
14	Update user table charset	ALTER TABLE "user" ALTER "login" TYPE VARCHAR(190), ALTER "email" TYPE VARCHAR(190), ALTER "name" TYPE VARCHAR(255), ALTER "password" TYPE VARCHAR(255), ALTER "salt" TYPE VARCHAR(50), ALTER "rands" TYPE VARCHAR(50), ALTER "company" TYPE VARCHAR(255), ALTER "theme" TYPE VARCHAR(255);	t		2021-06-09 12:38:28
15	Add last_seen_at column to user	alter table "user" ADD COLUMN "last_seen_at" TIMESTAMP NULL 	t		2021-06-09 12:38:28
16	Add missing user data	code migration	t		2021-06-09 12:38:28
17	Add is_disabled column to user	alter table "user" ADD COLUMN "is_disabled" BOOL NOT NULL DEFAULT FALSE 	t		2021-06-09 12:38:28
18	Add index user.login/user.email	CREATE INDEX "IDX_user_login_email" ON "user" ("login","email");	t		2021-06-09 12:38:28
19	create temp user table v1-7	CREATE TABLE IF NOT EXISTS "temp_user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "email" VARCHAR(190) NOT NULL\n, "name" VARCHAR(255) NULL\n, "role" VARCHAR(20) NULL\n, "code" VARCHAR(190) NOT NULL\n, "status" VARCHAR(20) NOT NULL\n, "invited_by_user_id" BIGINT NULL\n, "email_sent" BOOL NOT NULL\n, "email_sent_on" TIMESTAMP NULL\n, "remote_addr" VARCHAR(255) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:28
20	create index IDX_temp_user_email - v1-7	CREATE INDEX "IDX_temp_user_email" ON "temp_user" ("email");	t		2021-06-09 12:38:28
21	create index IDX_temp_user_org_id - v1-7	CREATE INDEX "IDX_temp_user_org_id" ON "temp_user" ("org_id");	t		2021-06-09 12:38:28
22	create index IDX_temp_user_code - v1-7	CREATE INDEX "IDX_temp_user_code" ON "temp_user" ("code");	t		2021-06-09 12:38:28
23	create index IDX_temp_user_status - v1-7	CREATE INDEX "IDX_temp_user_status" ON "temp_user" ("status");	t		2021-06-09 12:38:28
24	Update temp_user table charset	ALTER TABLE "temp_user" ALTER "email" TYPE VARCHAR(190), ALTER "name" TYPE VARCHAR(255), ALTER "role" TYPE VARCHAR(20), ALTER "code" TYPE VARCHAR(190), ALTER "status" TYPE VARCHAR(20), ALTER "remote_addr" TYPE VARCHAR(255);	t		2021-06-09 12:38:28
25	drop index IDX_temp_user_email - v1	DROP INDEX "IDX_temp_user_email" CASCADE	t		2021-06-09 12:38:28
26	drop index IDX_temp_user_org_id - v1	DROP INDEX "IDX_temp_user_org_id" CASCADE	t		2021-06-09 12:38:28
27	drop index IDX_temp_user_code - v1	DROP INDEX "IDX_temp_user_code" CASCADE	t		2021-06-09 12:38:28
28	drop index IDX_temp_user_status - v1	DROP INDEX "IDX_temp_user_status" CASCADE	t		2021-06-09 12:38:28
29	Rename table temp_user to temp_user_tmp_qwerty - v1	ALTER TABLE "temp_user" RENAME TO "temp_user_tmp_qwerty"	t		2021-06-09 12:38:28
30	create temp_user v2	CREATE TABLE IF NOT EXISTS "temp_user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "email" VARCHAR(190) NOT NULL\n, "name" VARCHAR(255) NULL\n, "role" VARCHAR(20) NULL\n, "code" VARCHAR(190) NOT NULL\n, "status" VARCHAR(20) NOT NULL\n, "invited_by_user_id" BIGINT NULL\n, "email_sent" BOOL NOT NULL\n, "email_sent_on" TIMESTAMP NULL\n, "remote_addr" VARCHAR(255) NULL\n, "created" INTEGER NOT NULL DEFAULT 0\n, "updated" INTEGER NOT NULL DEFAULT 0\n);	t		2021-06-09 12:38:28
31	create index IDX_temp_user_email - v2	CREATE INDEX "IDX_temp_user_email" ON "temp_user" ("email");	t		2021-06-09 12:38:28
32	create index IDX_temp_user_org_id - v2	CREATE INDEX "IDX_temp_user_org_id" ON "temp_user" ("org_id");	t		2021-06-09 12:38:28
33	create index IDX_temp_user_code - v2	CREATE INDEX "IDX_temp_user_code" ON "temp_user" ("code");	t		2021-06-09 12:38:28
34	create index IDX_temp_user_status - v2	CREATE INDEX "IDX_temp_user_status" ON "temp_user" ("status");	t		2021-06-09 12:38:28
35	copy temp_user v1 to v2	INSERT INTO "temp_user" ("email_sent"\n, "id"\n, "name"\n, "status"\n, "role"\n, "code"\n, "invited_by_user_id"\n, "email_sent_on"\n, "remote_addr"\n, "org_id"\n, "version"\n, "email") SELECT "email_sent"\n, "id"\n, "name"\n, "status"\n, "role"\n, "code"\n, "invited_by_user_id"\n, "email_sent_on"\n, "remote_addr"\n, "org_id"\n, "version"\n, "email" FROM "temp_user_tmp_qwerty"	t		2021-06-09 12:38:28
36	drop temp_user_tmp_qwerty	DROP TABLE IF EXISTS "temp_user_tmp_qwerty"	t		2021-06-09 12:38:28
37	Set created for temp users that will otherwise prematurely expire	code migration	t		2021-06-09 12:38:28
38	create star table	CREATE TABLE IF NOT EXISTS "star" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n);	t		2021-06-09 12:38:28
39	add unique index star.user_id_dashboard_id	CREATE UNIQUE INDEX "UQE_star_user_id_dashboard_id" ON "star" ("user_id","dashboard_id");	t		2021-06-09 12:38:28
40	create org table v1	CREATE TABLE IF NOT EXISTS "org" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "address1" VARCHAR(255) NULL\n, "address2" VARCHAR(255) NULL\n, "city" VARCHAR(255) NULL\n, "state" VARCHAR(255) NULL\n, "zip_code" VARCHAR(50) NULL\n, "country" VARCHAR(255) NULL\n, "billing_email" VARCHAR(255) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:28
41	create index UQE_org_name - v1	CREATE UNIQUE INDEX "UQE_org_name" ON "org" ("name");	t		2021-06-09 12:38:28
42	create org_user table v1	CREATE TABLE IF NOT EXISTS "org_user" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "role" VARCHAR(20) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:28
43	create index IDX_org_user_org_id - v1	CREATE INDEX "IDX_org_user_org_id" ON "org_user" ("org_id");	t		2021-06-09 12:38:28
44	create index UQE_org_user_org_id_user_id - v1	CREATE UNIQUE INDEX "UQE_org_user_org_id_user_id" ON "org_user" ("org_id","user_id");	t		2021-06-09 12:38:28
45	Update org table charset	ALTER TABLE "org" ALTER "name" TYPE VARCHAR(190), ALTER "address1" TYPE VARCHAR(255), ALTER "address2" TYPE VARCHAR(255), ALTER "city" TYPE VARCHAR(255), ALTER "state" TYPE VARCHAR(255), ALTER "zip_code" TYPE VARCHAR(50), ALTER "country" TYPE VARCHAR(255), ALTER "billing_email" TYPE VARCHAR(255);	t		2021-06-09 12:38:28
46	Update org_user table charset	ALTER TABLE "org_user" ALTER "role" TYPE VARCHAR(20);	t		2021-06-09 12:38:28
47	Migrate all Read Only Viewers to Viewers	UPDATE org_user SET role = 'Viewer' WHERE role = 'Read Only Editor'	t		2021-06-09 12:38:28
48	create dashboard table	CREATE TABLE IF NOT EXISTS "dashboard" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "slug" VARCHAR(189) NOT NULL\n, "title" VARCHAR(255) NOT NULL\n, "data" TEXT NOT NULL\n, "account_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:28
49	add index dashboard.account_id	CREATE INDEX "IDX_dashboard_account_id" ON "dashboard" ("account_id");	t		2021-06-09 12:38:28
50	add unique index dashboard_account_id_slug	CREATE UNIQUE INDEX "UQE_dashboard_account_id_slug" ON "dashboard" ("account_id","slug");	t		2021-06-09 12:38:28
51	create dashboard_tag table	CREATE TABLE IF NOT EXISTS "dashboard_tag" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "term" VARCHAR(50) NOT NULL\n);	t		2021-06-09 12:38:28
52	add unique index dashboard_tag.dasboard_id_term	CREATE UNIQUE INDEX "UQE_dashboard_tag_dashboard_id_term" ON "dashboard_tag" ("dashboard_id","term");	t		2021-06-09 12:38:28
53	drop index UQE_dashboard_tag_dashboard_id_term - v1	DROP INDEX "UQE_dashboard_tag_dashboard_id_term" CASCADE	t		2021-06-09 12:38:28
54	Rename table dashboard to dashboard_v1 - v1	ALTER TABLE "dashboard" RENAME TO "dashboard_v1"	t		2021-06-09 12:38:28
55	create dashboard v2	CREATE TABLE IF NOT EXISTS "dashboard" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" INTEGER NOT NULL\n, "slug" VARCHAR(189) NOT NULL\n, "title" VARCHAR(255) NOT NULL\n, "data" TEXT NOT NULL\n, "org_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:28
56	create index IDX_dashboard_org_id - v2	CREATE INDEX "IDX_dashboard_org_id" ON "dashboard" ("org_id");	t		2021-06-09 12:38:28
57	create index UQE_dashboard_org_id_slug - v2	CREATE UNIQUE INDEX "UQE_dashboard_org_id_slug" ON "dashboard" ("org_id","slug");	t		2021-06-09 12:38:28
58	copy dashboard v1 to v2	INSERT INTO "dashboard" ("version"\n, "slug"\n, "title"\n, "data"\n, "org_id"\n, "created"\n, "updated"\n, "id") SELECT "version"\n, "slug"\n, "title"\n, "data"\n, "account_id"\n, "created"\n, "updated"\n, "id" FROM "dashboard_v1"	t		2021-06-09 12:38:28
59	drop table dashboard_v1	DROP TABLE IF EXISTS "dashboard_v1"	t		2021-06-09 12:38:28
60	alter dashboard.data to mediumtext v1	SELECT 0;	t		2021-06-09 12:38:28
61	Add column updated_by in dashboard - v2	alter table "dashboard" ADD COLUMN "updated_by" INTEGER NULL 	t		2021-06-09 12:38:28
62	Add column created_by in dashboard - v2	alter table "dashboard" ADD COLUMN "created_by" INTEGER NULL 	t		2021-06-09 12:38:28
63	Add column gnetId in dashboard	alter table "dashboard" ADD COLUMN "gnet_id" BIGINT NULL 	t		2021-06-09 12:38:28
64	Add index for gnetId in dashboard	CREATE INDEX "IDX_dashboard_gnet_id" ON "dashboard" ("gnet_id");	t		2021-06-09 12:38:28
65	Add column plugin_id in dashboard	alter table "dashboard" ADD COLUMN "plugin_id" VARCHAR(189) NULL 	t		2021-06-09 12:38:29
66	Add index for plugin_id in dashboard	CREATE INDEX "IDX_dashboard_org_id_plugin_id" ON "dashboard" ("org_id","plugin_id");	t		2021-06-09 12:38:29
67	Add index for dashboard_id in dashboard_tag	CREATE INDEX "IDX_dashboard_tag_dashboard_id" ON "dashboard_tag" ("dashboard_id");	t		2021-06-09 12:38:29
68	Update dashboard table charset	ALTER TABLE "dashboard" ALTER "slug" TYPE VARCHAR(189), ALTER "title" TYPE VARCHAR(255), ALTER "plugin_id" TYPE VARCHAR(189), ALTER "data" TYPE TEXT;	t		2021-06-09 12:38:29
69	Update dashboard_tag table charset	ALTER TABLE "dashboard_tag" ALTER "term" TYPE VARCHAR(50);	t		2021-06-09 12:38:29
70	Add column folder_id in dashboard	alter table "dashboard" ADD COLUMN "folder_id" BIGINT NOT NULL DEFAULT 0 	t		2021-06-09 12:38:29
71	Add column isFolder in dashboard	alter table "dashboard" ADD COLUMN "is_folder" BOOL NOT NULL DEFAULT FALSE 	t		2021-06-09 12:38:29
72	Add column has_acl in dashboard	alter table "dashboard" ADD COLUMN "has_acl" BOOL NOT NULL DEFAULT FALSE 	t		2021-06-09 12:38:29
73	Add column uid in dashboard	alter table "dashboard" ADD COLUMN "uid" VARCHAR(40) NULL 	t		2021-06-09 12:38:29
74	Update uid column values in dashboard	UPDATE dashboard SET uid=lpad('' || id::text,9,'0') WHERE uid IS NULL;	t		2021-06-09 12:38:29
75	Add unique index dashboard_org_id_uid	CREATE UNIQUE INDEX "UQE_dashboard_org_id_uid" ON "dashboard" ("org_id","uid");	t		2021-06-09 12:38:29
76	Remove unique index org_id_slug	DROP INDEX "UQE_dashboard_org_id_slug" CASCADE	t		2021-06-09 12:38:29
77	Update dashboard title length	ALTER TABLE "dashboard" ALTER "title" TYPE VARCHAR(189);	t		2021-06-09 12:38:29
78	Add unique index for dashboard_org_id_title_folder_id	CREATE UNIQUE INDEX "UQE_dashboard_org_id_folder_id_title" ON "dashboard" ("org_id","folder_id","title");	t		2021-06-09 12:38:29
79	create dashboard_provisioning	CREATE TABLE IF NOT EXISTS "dashboard_provisioning" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NULL\n, "name" VARCHAR(150) NOT NULL\n, "external_id" TEXT NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:29
80	Rename table dashboard_provisioning to dashboard_provisioning_tmp_qwerty - v1	ALTER TABLE "dashboard_provisioning" RENAME TO "dashboard_provisioning_tmp_qwerty"	t		2021-06-09 12:38:29
81	create dashboard_provisioning v2	CREATE TABLE IF NOT EXISTS "dashboard_provisioning" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NULL\n, "name" VARCHAR(150) NOT NULL\n, "external_id" TEXT NOT NULL\n, "updated" INTEGER NOT NULL DEFAULT 0\n);	t		2021-06-09 12:38:29
82	create index IDX_dashboard_provisioning_dashboard_id - v2	CREATE INDEX "IDX_dashboard_provisioning_dashboard_id" ON "dashboard_provisioning" ("dashboard_id");	t		2021-06-09 12:38:29
83	create index IDX_dashboard_provisioning_dashboard_id_name - v2	CREATE INDEX "IDX_dashboard_provisioning_dashboard_id_name" ON "dashboard_provisioning" ("dashboard_id","name");	t		2021-06-09 12:38:29
84	copy dashboard_provisioning v1 to v2	INSERT INTO "dashboard_provisioning" ("external_id"\n, "id"\n, "dashboard_id"\n, "name") SELECT "external_id"\n, "id"\n, "dashboard_id"\n, "name" FROM "dashboard_provisioning_tmp_qwerty"	t		2021-06-09 12:38:29
85	drop dashboard_provisioning_tmp_qwerty	DROP TABLE IF EXISTS "dashboard_provisioning_tmp_qwerty"	t		2021-06-09 12:38:29
86	Add check_sum column	alter table "dashboard_provisioning" ADD COLUMN "check_sum" VARCHAR(32) NULL 	t		2021-06-09 12:38:29
87	Add index for dashboard_title	CREATE INDEX "IDX_dashboard_title" ON "dashboard" ("title");	t		2021-06-09 12:38:29
88	delete tags for deleted dashboards	DELETE FROM dashboard_tag WHERE dashboard_id NOT IN (SELECT id FROM dashboard)	t		2021-06-09 12:38:29
89	delete stars for deleted dashboards	DELETE FROM star WHERE dashboard_id NOT IN (SELECT id FROM dashboard)	t		2021-06-09 12:38:29
90	create data_source table	CREATE TABLE IF NOT EXISTS "data_source" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "account_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "access" VARCHAR(255) NOT NULL\n, "url" VARCHAR(255) NOT NULL\n, "password" VARCHAR(255) NULL\n, "user" VARCHAR(255) NULL\n, "database" VARCHAR(255) NULL\n, "basic_auth" BOOL NOT NULL\n, "basic_auth_user" VARCHAR(255) NULL\n, "basic_auth_password" VARCHAR(255) NULL\n, "is_default" BOOL NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:29
91	add index data_source.account_id	CREATE INDEX "IDX_data_source_account_id" ON "data_source" ("account_id");	t		2021-06-09 12:38:29
92	add unique index data_source.account_id_name	CREATE UNIQUE INDEX "UQE_data_source_account_id_name" ON "data_source" ("account_id","name");	t		2021-06-09 12:38:29
93	drop index IDX_data_source_account_id - v1	DROP INDEX "IDX_data_source_account_id" CASCADE	t		2021-06-09 12:38:29
94	drop index UQE_data_source_account_id_name - v1	DROP INDEX "UQE_data_source_account_id_name" CASCADE	t		2021-06-09 12:38:29
95	Rename table data_source to data_source_v1 - v1	ALTER TABLE "data_source" RENAME TO "data_source_v1"	t		2021-06-09 12:38:29
96	create data_source table v2	CREATE TABLE IF NOT EXISTS "data_source" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "access" VARCHAR(255) NOT NULL\n, "url" VARCHAR(255) NOT NULL\n, "password" VARCHAR(255) NULL\n, "user" VARCHAR(255) NULL\n, "database" VARCHAR(255) NULL\n, "basic_auth" BOOL NOT NULL\n, "basic_auth_user" VARCHAR(255) NULL\n, "basic_auth_password" VARCHAR(255) NULL\n, "is_default" BOOL NOT NULL\n, "json_data" TEXT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:29
97	create index IDX_data_source_org_id - v2	CREATE INDEX "IDX_data_source_org_id" ON "data_source" ("org_id");	t		2021-06-09 12:38:29
98	create index UQE_data_source_org_id_name - v2	CREATE UNIQUE INDEX "UQE_data_source_org_id_name" ON "data_source" ("org_id","name");	t		2021-06-09 12:38:29
99	copy data_source v1 to v2	INSERT INTO "data_source" ("database"\n, "basic_auth"\n, "name"\n, "created"\n, "org_id"\n, "version"\n, "type"\n, "access"\n, "user"\n, "password"\n, "basic_auth_password"\n, "id"\n, "url"\n, "basic_auth_user"\n, "is_default"\n, "updated") SELECT "database"\n, "basic_auth"\n, "name"\n, "created"\n, "account_id"\n, "version"\n, "type"\n, "access"\n, "user"\n, "password"\n, "basic_auth_password"\n, "id"\n, "url"\n, "basic_auth_user"\n, "is_default"\n, "updated" FROM "data_source_v1"	t		2021-06-09 12:38:29
100	Drop old table data_source_v1 #2	DROP TABLE IF EXISTS "data_source_v1"	t		2021-06-09 12:38:29
101	Add column with_credentials	alter table "data_source" ADD COLUMN "with_credentials" BOOL NOT NULL DEFAULT FALSE 	t		2021-06-09 12:38:29
102	Add secure json data column	alter table "data_source" ADD COLUMN "secure_json_data" TEXT NULL 	t		2021-06-09 12:38:29
103	Update data_source table charset	ALTER TABLE "data_source" ALTER "type" TYPE VARCHAR(255), ALTER "name" TYPE VARCHAR(190), ALTER "access" TYPE VARCHAR(255), ALTER "url" TYPE VARCHAR(255), ALTER "password" TYPE VARCHAR(255), ALTER "user" TYPE VARCHAR(255), ALTER "database" TYPE VARCHAR(255), ALTER "basic_auth_user" TYPE VARCHAR(255), ALTER "basic_auth_password" TYPE VARCHAR(255), ALTER "json_data" TYPE TEXT, ALTER "secure_json_data" TYPE TEXT;	t		2021-06-09 12:38:29
104	Update initial version to 1	UPDATE data_source SET version = 1 WHERE version = 0	t		2021-06-09 12:38:29
105	Add read_only data column	alter table "data_source" ADD COLUMN "read_only" BOOL NULL 	t		2021-06-09 12:38:29
106	Migrate logging ds to loki ds	UPDATE data_source SET type = 'loki' WHERE type = 'logging'	t		2021-06-09 12:38:29
107	Update json_data with nulls	UPDATE data_source SET json_data = '{}' WHERE json_data is null	t		2021-06-09 12:38:29
108	Add uid column	alter table "data_source" ADD COLUMN "uid" VARCHAR(40) NOT NULL DEFAULT 0 	t		2021-06-09 12:38:29
109	Update uid value	UPDATE data_source SET uid=lpad('' || id::text,9,'0');	t		2021-06-09 12:38:29
110	Add unique index datasource_org_id_uid	CREATE UNIQUE INDEX "UQE_data_source_org_id_uid" ON "data_source" ("org_id","uid");	t		2021-06-09 12:38:29
111	add unique index datasource_org_id_is_default	CREATE INDEX "IDX_data_source_org_id_is_default" ON "data_source" ("org_id","is_default");	t		2021-06-09 12:38:29
112	create api_key table	CREATE TABLE IF NOT EXISTS "api_key" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "account_id" BIGINT NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "key" VARCHAR(64) NOT NULL\n, "role" VARCHAR(255) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:29
113	add index api_key.account_id	CREATE INDEX "IDX_api_key_account_id" ON "api_key" ("account_id");	t		2021-06-09 12:38:29
114	add index api_key.key	CREATE UNIQUE INDEX "UQE_api_key_key" ON "api_key" ("key");	t		2021-06-09 12:38:29
115	add index api_key.account_id_name	CREATE UNIQUE INDEX "UQE_api_key_account_id_name" ON "api_key" ("account_id","name");	t		2021-06-09 12:38:29
116	drop index IDX_api_key_account_id - v1	DROP INDEX "IDX_api_key_account_id" CASCADE	t		2021-06-09 12:38:29
117	drop index UQE_api_key_key - v1	DROP INDEX "UQE_api_key_key" CASCADE	t		2021-06-09 12:38:29
118	drop index UQE_api_key_account_id_name - v1	DROP INDEX "UQE_api_key_account_id_name" CASCADE	t		2021-06-09 12:38:29
119	Rename table api_key to api_key_v1 - v1	ALTER TABLE "api_key" RENAME TO "api_key_v1"	t		2021-06-09 12:38:29
120	create api_key table v2	CREATE TABLE IF NOT EXISTS "api_key" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "key" VARCHAR(190) NOT NULL\n, "role" VARCHAR(255) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:29
121	create index IDX_api_key_org_id - v2	CREATE INDEX "IDX_api_key_org_id" ON "api_key" ("org_id");	t		2021-06-09 12:38:29
122	create index UQE_api_key_key - v2	CREATE UNIQUE INDEX "UQE_api_key_key" ON "api_key" ("key");	t		2021-06-09 12:38:29
123	create index UQE_api_key_org_id_name - v2	CREATE UNIQUE INDEX "UQE_api_key_org_id_name" ON "api_key" ("org_id","name");	t		2021-06-09 12:38:29
124	copy api_key v1 to v2	INSERT INTO "api_key" ("id"\n, "org_id"\n, "name"\n, "key"\n, "role"\n, "created"\n, "updated") SELECT "id"\n, "account_id"\n, "name"\n, "key"\n, "role"\n, "created"\n, "updated" FROM "api_key_v1"	t		2021-06-09 12:38:29
125	Drop old table api_key_v1	DROP TABLE IF EXISTS "api_key_v1"	t		2021-06-09 12:38:29
126	Update api_key table charset	ALTER TABLE "api_key" ALTER "name" TYPE VARCHAR(190), ALTER "key" TYPE VARCHAR(190), ALTER "role" TYPE VARCHAR(255);	t		2021-06-09 12:38:29
127	Add expires to api_key table	alter table "api_key" ADD COLUMN "expires" BIGINT NULL 	t		2021-06-09 12:38:29
128	create dashboard_snapshot table v4	CREATE TABLE IF NOT EXISTS "dashboard_snapshot" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(255) NOT NULL\n, "key" VARCHAR(190) NOT NULL\n, "dashboard" TEXT NOT NULL\n, "expires" TIMESTAMP NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:29
129	drop table dashboard_snapshot_v4 #1	DROP TABLE IF EXISTS "dashboard_snapshot"	t		2021-06-09 12:38:29
130	create dashboard_snapshot table v5 #2	CREATE TABLE IF NOT EXISTS "dashboard_snapshot" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(255) NOT NULL\n, "key" VARCHAR(190) NOT NULL\n, "delete_key" VARCHAR(190) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "external" BOOL NOT NULL\n, "external_url" VARCHAR(255) NOT NULL\n, "dashboard" TEXT NOT NULL\n, "expires" TIMESTAMP NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:29
131	create index UQE_dashboard_snapshot_key - v5	CREATE UNIQUE INDEX "UQE_dashboard_snapshot_key" ON "dashboard_snapshot" ("key");	t		2021-06-09 12:38:29
132	create index UQE_dashboard_snapshot_delete_key - v5	CREATE UNIQUE INDEX "UQE_dashboard_snapshot_delete_key" ON "dashboard_snapshot" ("delete_key");	t		2021-06-09 12:38:29
133	create index IDX_dashboard_snapshot_user_id - v5	CREATE INDEX "IDX_dashboard_snapshot_user_id" ON "dashboard_snapshot" ("user_id");	t		2021-06-09 12:38:29
134	alter dashboard_snapshot to mediumtext v2	SELECT 0;	t		2021-06-09 12:38:29
135	Update dashboard_snapshot table charset	ALTER TABLE "dashboard_snapshot" ALTER "name" TYPE VARCHAR(255), ALTER "key" TYPE VARCHAR(190), ALTER "delete_key" TYPE VARCHAR(190), ALTER "external_url" TYPE VARCHAR(255), ALTER "dashboard" TYPE TEXT;	t		2021-06-09 12:38:29
136	Add column external_delete_url to dashboard_snapshots table	alter table "dashboard_snapshot" ADD COLUMN "external_delete_url" VARCHAR(255) NULL 	t		2021-06-09 12:38:29
137	Add encrypted dashboard json column	alter table "dashboard_snapshot" ADD COLUMN "dashboard_encrypted" BYTEA NULL 	t		2021-06-09 12:38:29
138	Change dashboard_encrypted column to MEDIUMBLOB	SELECT 0;	t		2021-06-09 12:38:29
139	create quota table v1	CREATE TABLE IF NOT EXISTS "quota" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NULL\n, "user_id" BIGINT NULL\n, "target" VARCHAR(190) NOT NULL\n, "limit" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:29
140	create index UQE_quota_org_id_user_id_target - v1	CREATE UNIQUE INDEX "UQE_quota_org_id_user_id_target" ON "quota" ("org_id","user_id","target");	t		2021-06-09 12:38:29
141	Update quota table charset	ALTER TABLE "quota" ALTER "target" TYPE VARCHAR(190);	t		2021-06-09 12:38:29
142	create plugin_setting table	CREATE TABLE IF NOT EXISTS "plugin_setting" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NULL\n, "plugin_id" VARCHAR(190) NOT NULL\n, "enabled" BOOL NOT NULL\n, "pinned" BOOL NOT NULL\n, "json_data" TEXT NULL\n, "secure_json_data" TEXT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:29
143	create index UQE_plugin_setting_org_id_plugin_id - v1	CREATE UNIQUE INDEX "UQE_plugin_setting_org_id_plugin_id" ON "plugin_setting" ("org_id","plugin_id");	t		2021-06-09 12:38:29
144	Add column plugin_version to plugin_settings	alter table "plugin_setting" ADD COLUMN "plugin_version" VARCHAR(50) NULL 	t		2021-06-09 12:38:29
145	Update plugin_setting table charset	ALTER TABLE "plugin_setting" ALTER "plugin_id" TYPE VARCHAR(190), ALTER "json_data" TYPE TEXT, ALTER "secure_json_data" TYPE TEXT, ALTER "plugin_version" TYPE VARCHAR(50);	t		2021-06-09 12:38:29
146	create session table	CREATE TABLE IF NOT EXISTS "session" (\n"key" CHAR(16) PRIMARY KEY NOT NULL\n, "data" BYTEA NOT NULL\n, "expiry" INTEGER NOT NULL\n);	t		2021-06-09 12:38:29
147	Drop old table playlist table	DROP TABLE IF EXISTS "playlist"	t		2021-06-09 12:38:29
148	Drop old table playlist_item table	DROP TABLE IF EXISTS "playlist_item"	t		2021-06-09 12:38:29
149	create playlist table v2	CREATE TABLE IF NOT EXISTS "playlist" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(255) NOT NULL\n, "interval" VARCHAR(255) NOT NULL\n, "org_id" BIGINT NOT NULL\n);	t		2021-06-09 12:38:29
150	create playlist item table v2	CREATE TABLE IF NOT EXISTS "playlist_item" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "playlist_id" BIGINT NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "value" TEXT NOT NULL\n, "title" TEXT NOT NULL\n, "order" INTEGER NOT NULL\n);	t		2021-06-09 12:38:29
151	Update playlist table charset	ALTER TABLE "playlist" ALTER "name" TYPE VARCHAR(255), ALTER "interval" TYPE VARCHAR(255);	t		2021-06-09 12:38:29
152	Update playlist_item table charset	ALTER TABLE "playlist_item" ALTER "type" TYPE VARCHAR(255), ALTER "value" TYPE TEXT, ALTER "title" TYPE TEXT;	t		2021-06-09 12:38:29
153	drop preferences table v2	DROP TABLE IF EXISTS "preferences"	t		2021-06-09 12:38:29
154	drop preferences table v3	DROP TABLE IF EXISTS "preferences"	t		2021-06-09 12:38:29
155	create preferences table v3	CREATE TABLE IF NOT EXISTS "preferences" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "version" INTEGER NOT NULL\n, "home_dashboard_id" BIGINT NOT NULL\n, "timezone" VARCHAR(50) NOT NULL\n, "theme" VARCHAR(20) NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:29
156	Update preferences table charset	ALTER TABLE "preferences" ALTER "timezone" TYPE VARCHAR(50), ALTER "theme" TYPE VARCHAR(20);	t		2021-06-09 12:38:29
157	Add column team_id in preferences	alter table "preferences" ADD COLUMN "team_id" BIGINT NULL 	t		2021-06-09 12:38:29
158	Update team_id column values in preferences	UPDATE preferences SET team_id=0 WHERE team_id IS NULL;	t		2021-06-09 12:38:29
159	create alert table v1	CREATE TABLE IF NOT EXISTS "alert" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "version" BIGINT NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "panel_id" BIGINT NOT NULL\n, "org_id" BIGINT NOT NULL\n, "name" VARCHAR(255) NOT NULL\n, "message" TEXT NOT NULL\n, "state" VARCHAR(190) NOT NULL\n, "settings" TEXT NOT NULL\n, "frequency" BIGINT NOT NULL\n, "handler" BIGINT NOT NULL\n, "severity" TEXT NOT NULL\n, "silenced" BOOL NOT NULL\n, "execution_error" TEXT NOT NULL\n, "eval_data" TEXT NULL\n, "eval_date" TIMESTAMP NULL\n, "new_state_date" TIMESTAMP NOT NULL\n, "state_changes" INTEGER NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:29
160	add index alert org_id & id 	CREATE INDEX "IDX_alert_org_id_id" ON "alert" ("org_id","id");	t		2021-06-09 12:38:29
161	add index alert state	CREATE INDEX "IDX_alert_state" ON "alert" ("state");	t		2021-06-09 12:38:29
162	add index alert dashboard_id	CREATE INDEX "IDX_alert_dashboard_id" ON "alert" ("dashboard_id");	t		2021-06-09 12:38:29
163	Create alert_rule_tag table v1	CREATE TABLE IF NOT EXISTS "alert_rule_tag" (\n"alert_id" BIGINT NOT NULL\n, "tag_id" BIGINT NOT NULL\n);	t		2021-06-09 12:38:29
164	Add unique index alert_rule_tag.alert_id_tag_id	CREATE UNIQUE INDEX "UQE_alert_rule_tag_alert_id_tag_id" ON "alert_rule_tag" ("alert_id","tag_id");	t		2021-06-09 12:38:29
165	drop index UQE_alert_rule_tag_alert_id_tag_id - v1	DROP INDEX "UQE_alert_rule_tag_alert_id_tag_id" CASCADE	t		2021-06-09 12:38:29
166	Rename table alert_rule_tag to alert_rule_tag_v1 - v1	ALTER TABLE "alert_rule_tag" RENAME TO "alert_rule_tag_v1"	t		2021-06-09 12:38:29
167	Create alert_rule_tag table v2	CREATE TABLE IF NOT EXISTS "alert_rule_tag" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "alert_id" BIGINT NOT NULL\n, "tag_id" BIGINT NOT NULL\n);	t		2021-06-09 12:38:29
168	create index UQE_alert_rule_tag_alert_id_tag_id - Add unique index alert_rule_tag.alert_id_tag_id V2	CREATE UNIQUE INDEX "UQE_alert_rule_tag_alert_id_tag_id" ON "alert_rule_tag" ("alert_id","tag_id");	t		2021-06-09 12:38:29
169	copy alert_rule_tag v1 to v2	INSERT INTO "alert_rule_tag" ("alert_id"\n, "tag_id") SELECT "alert_id"\n, "tag_id" FROM "alert_rule_tag_v1"	t		2021-06-09 12:38:29
170	drop table alert_rule_tag_v1	DROP TABLE IF EXISTS "alert_rule_tag_v1"	t		2021-06-09 12:38:29
171	create alert_notification table v1	CREATE TABLE IF NOT EXISTS "alert_notification" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "type" VARCHAR(255) NOT NULL\n, "settings" TEXT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:29
172	Add column is_default	alter table "alert_notification" ADD COLUMN "is_default" BOOL NOT NULL DEFAULT FALSE 	t		2021-06-09 12:38:29
173	Add column frequency	alter table "alert_notification" ADD COLUMN "frequency" BIGINT NULL 	t		2021-06-09 12:38:29
174	Add column send_reminder	alter table "alert_notification" ADD COLUMN "send_reminder" BOOL NULL DEFAULT FALSE 	t		2021-06-09 12:38:29
175	Add column disable_resolve_message	alter table "alert_notification" ADD COLUMN "disable_resolve_message" BOOL NOT NULL DEFAULT FALSE 	t		2021-06-09 12:38:29
176	add index alert_notification org_id & name	CREATE UNIQUE INDEX "UQE_alert_notification_org_id_name" ON "alert_notification" ("org_id","name");	t		2021-06-09 12:38:29
177	Update alert table charset	ALTER TABLE "alert" ALTER "name" TYPE VARCHAR(255), ALTER "message" TYPE TEXT, ALTER "state" TYPE VARCHAR(190), ALTER "settings" TYPE TEXT, ALTER "severity" TYPE TEXT, ALTER "execution_error" TYPE TEXT, ALTER "eval_data" TYPE TEXT;	t		2021-06-09 12:38:29
178	Update alert_notification table charset	ALTER TABLE "alert_notification" ALTER "name" TYPE VARCHAR(190), ALTER "type" TYPE VARCHAR(255), ALTER "settings" TYPE TEXT;	t		2021-06-09 12:38:29
179	create notification_journal table v1	CREATE TABLE IF NOT EXISTS "alert_notification_journal" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "alert_id" BIGINT NOT NULL\n, "notifier_id" BIGINT NOT NULL\n, "sent_at" BIGINT NOT NULL\n, "success" BOOL NOT NULL\n);	t		2021-06-09 12:38:29
180	add index notification_journal org_id & alert_id & notifier_id	CREATE INDEX "IDX_alert_notification_journal_org_id_alert_id_notifier_id" ON "alert_notification_journal" ("org_id","alert_id","notifier_id");	t		2021-06-09 12:38:29
181	drop alert_notification_journal	DROP TABLE IF EXISTS "alert_notification_journal"	t		2021-06-09 12:38:29
182	create alert_notification_state table v1	CREATE TABLE IF NOT EXISTS "alert_notification_state" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "alert_id" BIGINT NOT NULL\n, "notifier_id" BIGINT NOT NULL\n, "state" VARCHAR(50) NOT NULL\n, "version" BIGINT NOT NULL\n, "updated_at" BIGINT NOT NULL\n, "alert_rule_state_updated_version" BIGINT NOT NULL\n);	t		2021-06-09 12:38:29
183	add index alert_notification_state org_id & alert_id & notifier_id	CREATE UNIQUE INDEX "UQE_alert_notification_state_org_id_alert_id_notifier_id" ON "alert_notification_state" ("org_id","alert_id","notifier_id");	t		2021-06-09 12:38:29
184	Add for to alert table	alter table "alert" ADD COLUMN "for" BIGINT NULL 	t		2021-06-09 12:38:29
185	Add column uid in alert_notification	alter table "alert_notification" ADD COLUMN "uid" VARCHAR(40) NULL 	t		2021-06-09 12:38:29
186	Update uid column values in alert_notification	UPDATE alert_notification SET uid=lpad('' || id::text,9,'0') WHERE uid IS NULL;	t		2021-06-09 12:38:29
187	Add unique index alert_notification_org_id_uid	CREATE UNIQUE INDEX "UQE_alert_notification_org_id_uid" ON "alert_notification" ("org_id","uid");	t		2021-06-09 12:38:29
188	Remove unique index org_id_name	DROP INDEX "UQE_alert_notification_org_id_name" CASCADE	t		2021-06-09 12:38:29
189	Add column secure_settings in alert_notification	alter table "alert_notification" ADD COLUMN "secure_settings" TEXT NULL 	t		2021-06-09 12:38:29
190	alter alert.settings to mediumtext	SELECT 0;	t		2021-06-09 12:38:29
191	Add non-unique index alert_notification_state_alert_id	CREATE INDEX "IDX_alert_notification_state_alert_id" ON "alert_notification_state" ("alert_id");	t		2021-06-09 12:38:29
192	Add non-unique index alert_rule_tag_alert_id	CREATE INDEX "IDX_alert_rule_tag_alert_id" ON "alert_rule_tag" ("alert_id");	t		2021-06-09 12:38:29
193	Drop old annotation table v4	DROP TABLE IF EXISTS "annotation"	t		2021-06-09 12:38:29
194	create annotation table v5	CREATE TABLE IF NOT EXISTS "annotation" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "alert_id" BIGINT NULL\n, "user_id" BIGINT NULL\n, "dashboard_id" BIGINT NULL\n, "panel_id" BIGINT NULL\n, "category_id" BIGINT NULL\n, "type" VARCHAR(25) NOT NULL\n, "title" TEXT NOT NULL\n, "text" TEXT NOT NULL\n, "metric" VARCHAR(255) NULL\n, "prev_state" VARCHAR(25) NOT NULL\n, "new_state" VARCHAR(25) NOT NULL\n, "data" TEXT NOT NULL\n, "epoch" BIGINT NOT NULL\n);	t		2021-06-09 12:38:29
195	add index annotation 0 v3	CREATE INDEX "IDX_annotation_org_id_alert_id" ON "annotation" ("org_id","alert_id");	t		2021-06-09 12:38:29
196	add index annotation 1 v3	CREATE INDEX "IDX_annotation_org_id_type" ON "annotation" ("org_id","type");	t		2021-06-09 12:38:29
197	add index annotation 2 v3	CREATE INDEX "IDX_annotation_org_id_category_id" ON "annotation" ("org_id","category_id");	t		2021-06-09 12:38:29
198	add index annotation 3 v3	CREATE INDEX "IDX_annotation_org_id_dashboard_id_panel_id_epoch" ON "annotation" ("org_id","dashboard_id","panel_id","epoch");	t		2021-06-09 12:38:29
199	add index annotation 4 v3	CREATE INDEX "IDX_annotation_org_id_epoch" ON "annotation" ("org_id","epoch");	t		2021-06-09 12:38:29
200	Update annotation table charset	ALTER TABLE "annotation" ALTER "type" TYPE VARCHAR(25), ALTER "title" TYPE TEXT, ALTER "text" TYPE TEXT, ALTER "metric" TYPE VARCHAR(255), ALTER "prev_state" TYPE VARCHAR(25), ALTER "new_state" TYPE VARCHAR(25), ALTER "data" TYPE TEXT;	t		2021-06-09 12:38:30
201	Add column region_id to annotation table	alter table "annotation" ADD COLUMN "region_id" BIGINT NULL DEFAULT 0 	t		2021-06-09 12:38:30
202	Drop category_id index	DROP INDEX "IDX_annotation_org_id_category_id" CASCADE	t		2021-06-09 12:38:30
203	Add column tags to annotation table	alter table "annotation" ADD COLUMN "tags" VARCHAR(500) NULL 	t		2021-06-09 12:38:30
204	Create annotation_tag table v2	CREATE TABLE IF NOT EXISTS "annotation_tag" (\n"annotation_id" BIGINT NOT NULL\n, "tag_id" BIGINT NOT NULL\n);	t		2021-06-09 12:38:30
205	Add unique index annotation_tag.annotation_id_tag_id	CREATE UNIQUE INDEX "UQE_annotation_tag_annotation_id_tag_id" ON "annotation_tag" ("annotation_id","tag_id");	t		2021-06-09 12:38:30
206	drop index UQE_annotation_tag_annotation_id_tag_id - v2	DROP INDEX "UQE_annotation_tag_annotation_id_tag_id" CASCADE	t		2021-06-09 12:38:30
207	Rename table annotation_tag to annotation_tag_v2 - v2	ALTER TABLE "annotation_tag" RENAME TO "annotation_tag_v2"	t		2021-06-09 12:38:30
208	Create annotation_tag table v3	CREATE TABLE IF NOT EXISTS "annotation_tag" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "annotation_id" BIGINT NOT NULL\n, "tag_id" BIGINT NOT NULL\n);	t		2021-06-09 12:38:30
209	create index UQE_annotation_tag_annotation_id_tag_id - Add unique index annotation_tag.annotation_id_tag_id V3	CREATE UNIQUE INDEX "UQE_annotation_tag_annotation_id_tag_id" ON "annotation_tag" ("annotation_id","tag_id");	t		2021-06-09 12:38:30
210	copy annotation_tag v2 to v3	INSERT INTO "annotation_tag" ("annotation_id"\n, "tag_id") SELECT "annotation_id"\n, "tag_id" FROM "annotation_tag_v2"	t		2021-06-09 12:38:30
211	drop table annotation_tag_v2	DROP TABLE IF EXISTS "annotation_tag_v2"	t		2021-06-09 12:38:30
212	Update alert annotations and set TEXT to empty	UPDATE annotation SET TEXT = '' WHERE alert_id > 0	t		2021-06-09 12:38:30
213	Add created time to annotation table	alter table "annotation" ADD COLUMN "created" BIGINT NULL DEFAULT 0 	t		2021-06-09 12:38:30
214	Add updated time to annotation table	alter table "annotation" ADD COLUMN "updated" BIGINT NULL DEFAULT 0 	t		2021-06-09 12:38:30
215	Add index for created in annotation table	CREATE INDEX "IDX_annotation_org_id_created" ON "annotation" ("org_id","created");	t		2021-06-09 12:38:30
216	Add index for updated in annotation table	CREATE INDEX "IDX_annotation_org_id_updated" ON "annotation" ("org_id","updated");	t		2021-06-09 12:38:30
217	Convert existing annotations from seconds to milliseconds	UPDATE annotation SET epoch = (epoch*1000) where epoch < 9999999999	t		2021-06-09 12:38:30
218	Add epoch_end column	alter table "annotation" ADD COLUMN "epoch_end" BIGINT NOT NULL DEFAULT 0 	t		2021-06-09 12:38:30
219	Add index for epoch_end	CREATE INDEX "IDX_annotation_org_id_epoch_epoch_end" ON "annotation" ("org_id","epoch","epoch_end");	t		2021-06-09 12:38:30
220	Make epoch_end the same as epoch	UPDATE annotation SET epoch_end = epoch	t		2021-06-09 12:38:30
221	Move region to single row	code migration	t		2021-06-09 12:38:30
222	Remove index org_id_epoch from annotation table	DROP INDEX "IDX_annotation_org_id_epoch" CASCADE	t		2021-06-09 12:38:30
223	Remove index org_id_dashboard_id_panel_id_epoch from annotation table	DROP INDEX "IDX_annotation_org_id_dashboard_id_panel_id_epoch" CASCADE	t		2021-06-09 12:38:30
224	Add index for org_id_dashboard_id_epoch_end_epoch on annotation table	CREATE INDEX "IDX_annotation_org_id_dashboard_id_epoch_end_epoch" ON "annotation" ("org_id","dashboard_id","epoch_end","epoch");	t		2021-06-09 12:38:30
225	Add index for org_id_epoch_end_epoch on annotation table	CREATE INDEX "IDX_annotation_org_id_epoch_end_epoch" ON "annotation" ("org_id","epoch_end","epoch");	t		2021-06-09 12:38:30
226	Remove index org_id_epoch_epoch_end from annotation table	DROP INDEX "IDX_annotation_org_id_epoch_epoch_end" CASCADE	t		2021-06-09 12:38:30
227	Add index for alert_id on annotation table	CREATE INDEX "IDX_annotation_alert_id" ON "annotation" ("alert_id");	t		2021-06-09 12:38:30
228	create test_data table	CREATE TABLE IF NOT EXISTS "test_data" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "metric1" VARCHAR(20) NULL\n, "metric2" VARCHAR(150) NULL\n, "value_big_int" BIGINT NULL\n, "value_double" DOUBLE PRECISION NULL\n, "value_float" REAL NULL\n, "value_int" INTEGER NULL\n, "time_epoch" BIGINT NOT NULL\n, "time_date_time" TIMESTAMP NOT NULL\n, "time_time_stamp" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:30
229	create dashboard_version table v1	CREATE TABLE IF NOT EXISTS "dashboard_version" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "parent_version" INTEGER NOT NULL\n, "restored_from" INTEGER NOT NULL\n, "version" INTEGER NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "created_by" BIGINT NOT NULL\n, "message" TEXT NOT NULL\n, "data" TEXT NOT NULL\n);	t		2021-06-09 12:38:30
230	add index dashboard_version.dashboard_id	CREATE INDEX "IDX_dashboard_version_dashboard_id" ON "dashboard_version" ("dashboard_id");	t		2021-06-09 12:38:30
231	add unique index dashboard_version.dashboard_id and dashboard_version.version	CREATE UNIQUE INDEX "UQE_dashboard_version_dashboard_id_version" ON "dashboard_version" ("dashboard_id","version");	t		2021-06-09 12:38:30
232	Set dashboard version to 1 where 0	UPDATE dashboard SET version = 1 WHERE version = 0	t		2021-06-09 12:38:30
233	save existing dashboard data in dashboard_version table v1	INSERT INTO dashboard_version\n(\n\tdashboard_id,\n\tversion,\n\tparent_version,\n\trestored_from,\n\tcreated,\n\tcreated_by,\n\tmessage,\n\tdata\n)\nSELECT\n\tdashboard.id,\n\tdashboard.version,\n\tdashboard.version,\n\tdashboard.version,\n\tdashboard.updated,\n\tCOALESCE(dashboard.updated_by, -1),\n\t'',\n\tdashboard.data\nFROM dashboard;	t		2021-06-09 12:38:30
234	alter dashboard_version.data to mediumtext v1	SELECT 0;	t		2021-06-09 12:38:30
235	create team table	CREATE TABLE IF NOT EXISTS "team" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "name" VARCHAR(190) NOT NULL\n, "org_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:30
236	add index team.org_id	CREATE INDEX "IDX_team_org_id" ON "team" ("org_id");	t		2021-06-09 12:38:30
237	add unique index team_org_id_name	CREATE UNIQUE INDEX "UQE_team_org_id_name" ON "team" ("org_id","name");	t		2021-06-09 12:38:30
238	create team member table	CREATE TABLE IF NOT EXISTS "team_member" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "team_id" BIGINT NOT NULL\n, "user_id" BIGINT NOT NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:30
239	add index team_member.org_id	CREATE INDEX "IDX_team_member_org_id" ON "team_member" ("org_id");	t		2021-06-09 12:38:30
240	add unique index team_member_org_id_team_id_user_id	CREATE UNIQUE INDEX "UQE_team_member_org_id_team_id_user_id" ON "team_member" ("org_id","team_id","user_id");	t		2021-06-09 12:38:30
241	add index team_member.team_id	CREATE INDEX "IDX_team_member_team_id" ON "team_member" ("team_id");	t		2021-06-09 12:38:30
242	Add column email to team table	alter table "team" ADD COLUMN "email" VARCHAR(190) NULL 	t		2021-06-09 12:38:30
243	Add column external to team_member table	alter table "team_member" ADD COLUMN "external" BOOL NULL 	t		2021-06-09 12:38:30
244	Add column permission to team_member table	alter table "team_member" ADD COLUMN "permission" SMALLINT NULL 	t		2021-06-09 12:38:30
245	create dashboard acl table	CREATE TABLE IF NOT EXISTS "dashboard_acl" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "dashboard_id" BIGINT NOT NULL\n, "user_id" BIGINT NULL\n, "team_id" BIGINT NULL\n, "permission" SMALLINT NOT NULL DEFAULT 4\n, "role" VARCHAR(20) NULL\n, "created" TIMESTAMP NOT NULL\n, "updated" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:30
246	add index dashboard_acl_dashboard_id	CREATE INDEX "IDX_dashboard_acl_dashboard_id" ON "dashboard_acl" ("dashboard_id");	t		2021-06-09 12:38:30
247	add unique index dashboard_acl_dashboard_id_user_id	CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_user_id" ON "dashboard_acl" ("dashboard_id","user_id");	t		2021-06-09 12:38:30
248	add unique index dashboard_acl_dashboard_id_team_id	CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_team_id" ON "dashboard_acl" ("dashboard_id","team_id");	t		2021-06-09 12:38:30
249	save default acl rules in dashboard_acl table	\nINSERT INTO dashboard_acl\n\t(\n\t\torg_id,\n\t\tdashboard_id,\n\t\tpermission,\n\t\trole,\n\t\tcreated,\n\t\tupdated\n\t)\n\tVALUES\n\t\t(-1,-1, 1,'Viewer','2017-06-20','2017-06-20'),\n\t\t(-1,-1, 2,'Editor','2017-06-20','2017-06-20')\n\t	t		2021-06-09 12:38:30
250	delete acl rules for deleted dashboards and folders	DELETE FROM dashboard_acl WHERE dashboard_id NOT IN (SELECT id FROM dashboard) AND dashboard_id != -1	t		2021-06-09 12:38:30
251	create tag table	CREATE TABLE IF NOT EXISTS "tag" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "key" VARCHAR(100) NOT NULL\n, "value" VARCHAR(100) NOT NULL\n);	t		2021-06-09 12:38:30
252	add index tag.key_value	CREATE UNIQUE INDEX "UQE_tag_key_value" ON "tag" ("key","value");	t		2021-06-09 12:38:30
253	create login attempt table	CREATE TABLE IF NOT EXISTS "login_attempt" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "username" VARCHAR(190) NOT NULL\n, "ip_address" VARCHAR(30) NOT NULL\n, "created" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:30
254	add index login_attempt.username	CREATE INDEX "IDX_login_attempt_username" ON "login_attempt" ("username");	t		2021-06-09 12:38:30
255	drop index IDX_login_attempt_username - v1	DROP INDEX "IDX_login_attempt_username" CASCADE	t		2021-06-09 12:38:30
256	Rename table login_attempt to login_attempt_tmp_qwerty - v1	ALTER TABLE "login_attempt" RENAME TO "login_attempt_tmp_qwerty"	t		2021-06-09 12:38:30
257	create login_attempt v2	CREATE TABLE IF NOT EXISTS "login_attempt" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "username" VARCHAR(190) NOT NULL\n, "ip_address" VARCHAR(30) NOT NULL\n, "created" INTEGER NOT NULL DEFAULT 0\n);	t		2021-06-09 12:38:30
258	create index IDX_login_attempt_username - v2	CREATE INDEX "IDX_login_attempt_username" ON "login_attempt" ("username");	t		2021-06-09 12:38:30
259	copy login_attempt v1 to v2	INSERT INTO "login_attempt" ("id"\n, "username"\n, "ip_address") SELECT "id"\n, "username"\n, "ip_address" FROM "login_attempt_tmp_qwerty"	t		2021-06-09 12:38:30
260	drop login_attempt_tmp_qwerty	DROP TABLE IF EXISTS "login_attempt_tmp_qwerty"	t		2021-06-09 12:38:30
261	create user auth table	CREATE TABLE IF NOT EXISTS "user_auth" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "auth_module" VARCHAR(190) NOT NULL\n, "auth_id" VARCHAR(100) NOT NULL\n, "created" TIMESTAMP NOT NULL\n);	t		2021-06-09 12:38:30
262	create index IDX_user_auth_auth_module_auth_id - v1	CREATE INDEX "IDX_user_auth_auth_module_auth_id" ON "user_auth" ("auth_module","auth_id");	t		2021-06-09 12:38:30
263	alter user_auth.auth_id to length 190	ALTER TABLE user_auth ALTER COLUMN auth_id TYPE VARCHAR(190);	t		2021-06-09 12:38:30
264	Add OAuth access token to user_auth	alter table "user_auth" ADD COLUMN "o_auth_access_token" TEXT NULL 	t		2021-06-09 12:38:30
265	Add OAuth refresh token to user_auth	alter table "user_auth" ADD COLUMN "o_auth_refresh_token" TEXT NULL 	t		2021-06-09 12:38:30
266	Add OAuth token type to user_auth	alter table "user_auth" ADD COLUMN "o_auth_token_type" TEXT NULL 	t		2021-06-09 12:38:30
267	Add OAuth expiry to user_auth	alter table "user_auth" ADD COLUMN "o_auth_expiry" TIMESTAMP NULL 	t		2021-06-09 12:38:30
268	Add index to user_id column in user_auth	CREATE INDEX "IDX_user_auth_user_id" ON "user_auth" ("user_id");	t		2021-06-09 12:38:30
269	create server_lock table	CREATE TABLE IF NOT EXISTS "server_lock" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "operation_uid" VARCHAR(100) NOT NULL\n, "version" BIGINT NOT NULL\n, "last_execution" BIGINT NOT NULL\n);	t		2021-06-09 12:38:30
270	add index server_lock.operation_uid	CREATE UNIQUE INDEX "UQE_server_lock_operation_uid" ON "server_lock" ("operation_uid");	t		2021-06-09 12:38:30
271	create user auth token table	CREATE TABLE IF NOT EXISTS "user_auth_token" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "user_id" BIGINT NOT NULL\n, "auth_token" VARCHAR(100) NOT NULL\n, "prev_auth_token" VARCHAR(100) NOT NULL\n, "user_agent" VARCHAR(255) NOT NULL\n, "client_ip" VARCHAR(255) NOT NULL\n, "auth_token_seen" BOOL NOT NULL\n, "seen_at" INTEGER NULL\n, "rotated_at" INTEGER NOT NULL\n, "created_at" INTEGER NOT NULL\n, "updated_at" INTEGER NOT NULL\n);	t		2021-06-09 12:38:30
272	add unique index user_auth_token.auth_token	CREATE UNIQUE INDEX "UQE_user_auth_token_auth_token" ON "user_auth_token" ("auth_token");	t		2021-06-09 12:38:30
273	add unique index user_auth_token.prev_auth_token	CREATE UNIQUE INDEX "UQE_user_auth_token_prev_auth_token" ON "user_auth_token" ("prev_auth_token");	t		2021-06-09 12:38:30
274	add index user_auth_token.user_id	CREATE INDEX "IDX_user_auth_token_user_id" ON "user_auth_token" ("user_id");	t		2021-06-09 12:38:30
275	Add revoked_at to the user auth token	alter table "user_auth_token" ADD COLUMN "revoked_at" INTEGER NULL 	t		2021-06-09 12:38:30
276	create cache_data table	CREATE TABLE IF NOT EXISTS "cache_data" (\n"cache_key" VARCHAR(168) PRIMARY KEY NOT NULL\n, "data" BYTEA NOT NULL\n, "expires" INTEGER NOT NULL\n, "created_at" INTEGER NOT NULL\n);	t		2021-06-09 12:38:30
277	add unique index cache_data.cache_key	CREATE UNIQUE INDEX "UQE_cache_data_cache_key" ON "cache_data" ("cache_key");	t		2021-06-09 12:38:30
278	create short_url table v1	CREATE TABLE IF NOT EXISTS "short_url" (\n"id" SERIAL PRIMARY KEY  NOT NULL\n, "org_id" BIGINT NOT NULL\n, "uid" VARCHAR(40) NOT NULL\n, "path" TEXT NOT NULL\n, "created_by" INTEGER NOT NULL\n, "created_at" INTEGER NOT NULL\n, "last_seen_at" INTEGER NULL\n);	t		2021-06-09 12:38:30
279	add index short_url.org_id-uid	CREATE UNIQUE INDEX "UQE_short_url_org_id_uid" ON "short_url" ("org_id","uid");	t		2021-06-09 12:38:30
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.org (id, version, name, address1, address2, city, state, zip_code, country, billing_email, created, updated) FROM stdin;
1	0	Main Org.							\N	2021-06-09 12:38:30	2021-06-09 12:38:30
\.


--
-- Data for Name: org_user; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.org_user (id, org_id, user_id, role, created, updated) FROM stdin;
1	1	1	Admin	2021-06-09 12:38:30	2021-06-09 12:38:30
\.


--
-- Data for Name: playlist; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.playlist (id, name, "interval", org_id) FROM stdin;
\.


--
-- Data for Name: playlist_item; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.playlist_item (id, playlist_id, type, value, title, "order") FROM stdin;
\.


--
-- Data for Name: plugin_setting; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.plugin_setting (id, org_id, plugin_id, enabled, pinned, json_data, secure_json_data, created, updated, plugin_version) FROM stdin;
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.preferences (id, org_id, user_id, version, home_dashboard_id, timezone, theme, created, updated, team_id) FROM stdin;
\.


--
-- Data for Name: quota; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.quota (id, org_id, user_id, target, "limit", created, updated) FROM stdin;
\.


--
-- Data for Name: server_lock; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.server_lock (id, operation_uid, version, last_execution) FROM stdin;
1	cleanup expired auth tokens	3	1623380494
2	delete old login attempts	98	1623381694
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.session (key, data, expiry) FROM stdin;
\.


--
-- Data for Name: short_url; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.short_url (id, org_id, uid, path, created_by, created_at, last_seen_at) FROM stdin;
\.


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.star (id, user_id, dashboard_id) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.tag (id, key, value) FROM stdin;
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.team (id, name, org_id, created, updated, email) FROM stdin;
\.


--
-- Data for Name: team_member; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.team_member (id, org_id, team_id, user_id, created, updated, external, permission) FROM stdin;
\.


--
-- Data for Name: temp_user; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.temp_user (id, org_id, version, email, name, role, code, status, invited_by_user_id, email_sent, email_sent_on, remote_addr, created, updated) FROM stdin;
\.


--
-- Data for Name: test_data; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.test_data (id, metric1, metric2, value_big_int, value_double, value_float, value_int, time_epoch, time_date_time, time_time_stamp) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public."user" (id, version, login, email, name, password, salt, rands, company, org_id, is_admin, email_verified, theme, created, updated, help_flags1, last_seen_at, is_disabled) FROM stdin;
1	0	admin	admin@localhost		1a8c72b7ff806759971e13acb094f2de74cbcee38e184d79c9581219cb760251cc7ade2b131e9b745e00c873b4159f4dc97f	M0Ttyrifz5	NqPKmUH1IY		1	t	f		2021-06-09 12:38:30	2021-06-09 12:38:30	0	2021-06-10 16:34:46	f
\.


--
-- Data for Name: user_auth; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.user_auth (id, user_id, auth_module, auth_id, created, o_auth_access_token, o_auth_refresh_token, o_auth_token_type, o_auth_expiry) FROM stdin;
\.


--
-- Data for Name: user_auth_token; Type: TABLE DATA; Schema: public; Owner: asterisk
--

COPY public.user_auth_token (id, user_id, auth_token, prev_auth_token, user_agent, client_ip, auth_token_seen, seen_at, rotated_at, created_at, updated_at, revoked_at) FROM stdin;
1	1	8501655857e41fcadec8e8f2f0e2d4a67f8be6a49c4aa3df199fdbf28524be8c	c9cb2c39a922b6761a1ef0b58100d3ddc936f422e7473c0eb061cc8d150a4a6d	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36	10.0.0.2	t	1623342866	1623342866	1623242520	1623242520	0
\.


--
-- Name: alert_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.alert_id_seq', 1, false);


--
-- Name: alert_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.alert_notification_id_seq', 1, false);


--
-- Name: alert_notification_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.alert_notification_state_id_seq', 1, false);


--
-- Name: alert_rule_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.alert_rule_tag_id_seq', 1, false);


--
-- Name: annotation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.annotation_id_seq', 1, false);


--
-- Name: annotation_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.annotation_tag_id_seq', 1, false);


--
-- Name: api_key_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.api_key_id_seq1', 1, false);


--
-- Name: dashboard_acl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.dashboard_acl_id_seq', 2, true);


--
-- Name: dashboard_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.dashboard_id_seq1', 1, true);


--
-- Name: dashboard_provisioning_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.dashboard_provisioning_id_seq1', 1, false);


--
-- Name: dashboard_snapshot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.dashboard_snapshot_id_seq', 1, false);


--
-- Name: dashboard_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.dashboard_tag_id_seq', 1, false);


--
-- Name: dashboard_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.dashboard_version_id_seq', 1, true);


--
-- Name: data_source_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.data_source_id_seq1', 1, true);


--
-- Name: login_attempt_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.login_attempt_id_seq1', 1, false);


--
-- Name: migration_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.migration_log_id_seq', 279, true);


--
-- Name: org_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.org_id_seq', 1, true);


--
-- Name: org_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.org_user_id_seq', 1, true);


--
-- Name: playlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.playlist_id_seq', 1, false);


--
-- Name: playlist_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.playlist_item_id_seq', 1, false);


--
-- Name: plugin_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.plugin_setting_id_seq', 1, false);


--
-- Name: preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.preferences_id_seq', 1, false);


--
-- Name: quota_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.quota_id_seq', 1, false);


--
-- Name: server_lock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.server_lock_id_seq', 2, true);


--
-- Name: short_url_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.short_url_id_seq', 1, false);


--
-- Name: star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.star_id_seq', 1, false);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- Name: team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.team_id_seq', 1, false);


--
-- Name: team_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.team_member_id_seq', 1, false);


--
-- Name: temp_user_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.temp_user_id_seq1', 1, false);


--
-- Name: test_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.test_data_id_seq', 1, false);


--
-- Name: user_auth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.user_auth_id_seq', 1, false);


--
-- Name: user_auth_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.user_auth_token_id_seq', 1, true);


--
-- Name: user_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: asterisk
--

SELECT pg_catalog.setval('public.user_id_seq1', 1, true);


--
-- Name: alert_notification alert_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.alert_notification
    ADD CONSTRAINT alert_notification_pkey PRIMARY KEY (id);


--
-- Name: alert_notification_state alert_notification_state_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.alert_notification_state
    ADD CONSTRAINT alert_notification_state_pkey PRIMARY KEY (id);


--
-- Name: alert alert_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.alert
    ADD CONSTRAINT alert_pkey PRIMARY KEY (id);


--
-- Name: alert_rule_tag alert_rule_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.alert_rule_tag
    ADD CONSTRAINT alert_rule_tag_pkey PRIMARY KEY (id);


--
-- Name: annotation annotation_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.annotation
    ADD CONSTRAINT annotation_pkey PRIMARY KEY (id);


--
-- Name: annotation_tag annotation_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.annotation_tag
    ADD CONSTRAINT annotation_tag_pkey PRIMARY KEY (id);


--
-- Name: api_key api_key_pkey1; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_pkey1 PRIMARY KEY (id);


--
-- Name: cache_data cache_data_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.cache_data
    ADD CONSTRAINT cache_data_pkey PRIMARY KEY (cache_key);


--
-- Name: dashboard_acl dashboard_acl_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.dashboard_acl
    ADD CONSTRAINT dashboard_acl_pkey PRIMARY KEY (id);


--
-- Name: dashboard dashboard_pkey1; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT dashboard_pkey1 PRIMARY KEY (id);


--
-- Name: dashboard_provisioning dashboard_provisioning_pkey1; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.dashboard_provisioning
    ADD CONSTRAINT dashboard_provisioning_pkey1 PRIMARY KEY (id);


--
-- Name: dashboard_snapshot dashboard_snapshot_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.dashboard_snapshot
    ADD CONSTRAINT dashboard_snapshot_pkey PRIMARY KEY (id);


--
-- Name: dashboard_tag dashboard_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.dashboard_tag
    ADD CONSTRAINT dashboard_tag_pkey PRIMARY KEY (id);


--
-- Name: dashboard_version dashboard_version_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.dashboard_version
    ADD CONSTRAINT dashboard_version_pkey PRIMARY KEY (id);


--
-- Name: data_source data_source_pkey1; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.data_source
    ADD CONSTRAINT data_source_pkey1 PRIMARY KEY (id);


--
-- Name: login_attempt login_attempt_pkey1; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.login_attempt
    ADD CONSTRAINT login_attempt_pkey1 PRIMARY KEY (id);


--
-- Name: migration_log migration_log_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.migration_log
    ADD CONSTRAINT migration_log_pkey PRIMARY KEY (id);


--
-- Name: org org_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT org_pkey PRIMARY KEY (id);


--
-- Name: org_user org_user_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.org_user
    ADD CONSTRAINT org_user_pkey PRIMARY KEY (id);


--
-- Name: playlist_item playlist_item_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.playlist_item
    ADD CONSTRAINT playlist_item_pkey PRIMARY KEY (id);


--
-- Name: playlist playlist_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.playlist
    ADD CONSTRAINT playlist_pkey PRIMARY KEY (id);


--
-- Name: plugin_setting plugin_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.plugin_setting
    ADD CONSTRAINT plugin_setting_pkey PRIMARY KEY (id);


--
-- Name: preferences preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT preferences_pkey PRIMARY KEY (id);


--
-- Name: quota quota_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.quota
    ADD CONSTRAINT quota_pkey PRIMARY KEY (id);


--
-- Name: server_lock server_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.server_lock
    ADD CONSTRAINT server_lock_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (key);


--
-- Name: short_url short_url_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.short_url
    ADD CONSTRAINT short_url_pkey PRIMARY KEY (id);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: team_member team_member_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.team_member
    ADD CONSTRAINT team_member_pkey PRIMARY KEY (id);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);


--
-- Name: temp_user temp_user_pkey1; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.temp_user
    ADD CONSTRAINT temp_user_pkey1 PRIMARY KEY (id);


--
-- Name: test_data test_data_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.test_data
    ADD CONSTRAINT test_data_pkey PRIMARY KEY (id);


--
-- Name: user_auth user_auth_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.user_auth
    ADD CONSTRAINT user_auth_pkey PRIMARY KEY (id);


--
-- Name: user_auth_token user_auth_token_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.user_auth_token
    ADD CONSTRAINT user_auth_token_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey1; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey1 PRIMARY KEY (id);


--
-- Name: IDX_alert_dashboard_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_alert_dashboard_id" ON public.alert USING btree (dashboard_id);


--
-- Name: IDX_alert_notification_state_alert_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_alert_notification_state_alert_id" ON public.alert_notification_state USING btree (alert_id);


--
-- Name: IDX_alert_org_id_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_alert_org_id_id" ON public.alert USING btree (org_id, id);


--
-- Name: IDX_alert_rule_tag_alert_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_alert_rule_tag_alert_id" ON public.alert_rule_tag USING btree (alert_id);


--
-- Name: IDX_alert_state; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_alert_state" ON public.alert USING btree (state);


--
-- Name: IDX_annotation_alert_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_annotation_alert_id" ON public.annotation USING btree (alert_id);


--
-- Name: IDX_annotation_org_id_alert_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_annotation_org_id_alert_id" ON public.annotation USING btree (org_id, alert_id);


--
-- Name: IDX_annotation_org_id_created; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_annotation_org_id_created" ON public.annotation USING btree (org_id, created);


--
-- Name: IDX_annotation_org_id_dashboard_id_epoch_end_epoch; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_annotation_org_id_dashboard_id_epoch_end_epoch" ON public.annotation USING btree (org_id, dashboard_id, epoch_end, epoch);


--
-- Name: IDX_annotation_org_id_epoch_end_epoch; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_annotation_org_id_epoch_end_epoch" ON public.annotation USING btree (org_id, epoch_end, epoch);


--
-- Name: IDX_annotation_org_id_type; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_annotation_org_id_type" ON public.annotation USING btree (org_id, type);


--
-- Name: IDX_annotation_org_id_updated; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_annotation_org_id_updated" ON public.annotation USING btree (org_id, updated);


--
-- Name: IDX_api_key_org_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_api_key_org_id" ON public.api_key USING btree (org_id);


--
-- Name: IDX_dashboard_acl_dashboard_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_dashboard_acl_dashboard_id" ON public.dashboard_acl USING btree (dashboard_id);


--
-- Name: IDX_dashboard_gnet_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_dashboard_gnet_id" ON public.dashboard USING btree (gnet_id);


--
-- Name: IDX_dashboard_org_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_dashboard_org_id" ON public.dashboard USING btree (org_id);


--
-- Name: IDX_dashboard_org_id_plugin_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_dashboard_org_id_plugin_id" ON public.dashboard USING btree (org_id, plugin_id);


--
-- Name: IDX_dashboard_provisioning_dashboard_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_dashboard_provisioning_dashboard_id" ON public.dashboard_provisioning USING btree (dashboard_id);


--
-- Name: IDX_dashboard_provisioning_dashboard_id_name; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_dashboard_provisioning_dashboard_id_name" ON public.dashboard_provisioning USING btree (dashboard_id, name);


--
-- Name: IDX_dashboard_snapshot_user_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_dashboard_snapshot_user_id" ON public.dashboard_snapshot USING btree (user_id);


--
-- Name: IDX_dashboard_tag_dashboard_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_dashboard_tag_dashboard_id" ON public.dashboard_tag USING btree (dashboard_id);


--
-- Name: IDX_dashboard_title; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_dashboard_title" ON public.dashboard USING btree (title);


--
-- Name: IDX_dashboard_version_dashboard_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_dashboard_version_dashboard_id" ON public.dashboard_version USING btree (dashboard_id);


--
-- Name: IDX_data_source_org_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_data_source_org_id" ON public.data_source USING btree (org_id);


--
-- Name: IDX_data_source_org_id_is_default; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_data_source_org_id_is_default" ON public.data_source USING btree (org_id, is_default);


--
-- Name: IDX_login_attempt_username; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_login_attempt_username" ON public.login_attempt USING btree (username);


--
-- Name: IDX_org_user_org_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_org_user_org_id" ON public.org_user USING btree (org_id);


--
-- Name: IDX_team_member_org_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_team_member_org_id" ON public.team_member USING btree (org_id);


--
-- Name: IDX_team_member_team_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_team_member_team_id" ON public.team_member USING btree (team_id);


--
-- Name: IDX_team_org_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_team_org_id" ON public.team USING btree (org_id);


--
-- Name: IDX_temp_user_code; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_temp_user_code" ON public.temp_user USING btree (code);


--
-- Name: IDX_temp_user_email; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_temp_user_email" ON public.temp_user USING btree (email);


--
-- Name: IDX_temp_user_org_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_temp_user_org_id" ON public.temp_user USING btree (org_id);


--
-- Name: IDX_temp_user_status; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_temp_user_status" ON public.temp_user USING btree (status);


--
-- Name: IDX_user_auth_auth_module_auth_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_user_auth_auth_module_auth_id" ON public.user_auth USING btree (auth_module, auth_id);


--
-- Name: IDX_user_auth_token_user_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_user_auth_token_user_id" ON public.user_auth_token USING btree (user_id);


--
-- Name: IDX_user_auth_user_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_user_auth_user_id" ON public.user_auth USING btree (user_id);


--
-- Name: IDX_user_login_email; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE INDEX "IDX_user_login_email" ON public."user" USING btree (login, email);


--
-- Name: UQE_alert_notification_org_id_uid; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_alert_notification_org_id_uid" ON public.alert_notification USING btree (org_id, uid);


--
-- Name: UQE_alert_notification_state_org_id_alert_id_notifier_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_alert_notification_state_org_id_alert_id_notifier_id" ON public.alert_notification_state USING btree (org_id, alert_id, notifier_id);


--
-- Name: UQE_alert_rule_tag_alert_id_tag_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_alert_rule_tag_alert_id_tag_id" ON public.alert_rule_tag USING btree (alert_id, tag_id);


--
-- Name: UQE_annotation_tag_annotation_id_tag_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_annotation_tag_annotation_id_tag_id" ON public.annotation_tag USING btree (annotation_id, tag_id);


--
-- Name: UQE_api_key_key; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_api_key_key" ON public.api_key USING btree (key);


--
-- Name: UQE_api_key_org_id_name; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_api_key_org_id_name" ON public.api_key USING btree (org_id, name);


--
-- Name: UQE_cache_data_cache_key; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_cache_data_cache_key" ON public.cache_data USING btree (cache_key);


--
-- Name: UQE_dashboard_acl_dashboard_id_team_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_team_id" ON public.dashboard_acl USING btree (dashboard_id, team_id);


--
-- Name: UQE_dashboard_acl_dashboard_id_user_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_dashboard_acl_dashboard_id_user_id" ON public.dashboard_acl USING btree (dashboard_id, user_id);


--
-- Name: UQE_dashboard_org_id_folder_id_title; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_dashboard_org_id_folder_id_title" ON public.dashboard USING btree (org_id, folder_id, title);


--
-- Name: UQE_dashboard_org_id_uid; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_dashboard_org_id_uid" ON public.dashboard USING btree (org_id, uid);


--
-- Name: UQE_dashboard_snapshot_delete_key; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_dashboard_snapshot_delete_key" ON public.dashboard_snapshot USING btree (delete_key);


--
-- Name: UQE_dashboard_snapshot_key; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_dashboard_snapshot_key" ON public.dashboard_snapshot USING btree (key);


--
-- Name: UQE_dashboard_version_dashboard_id_version; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_dashboard_version_dashboard_id_version" ON public.dashboard_version USING btree (dashboard_id, version);


--
-- Name: UQE_data_source_org_id_name; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_data_source_org_id_name" ON public.data_source USING btree (org_id, name);


--
-- Name: UQE_data_source_org_id_uid; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_data_source_org_id_uid" ON public.data_source USING btree (org_id, uid);


--
-- Name: UQE_org_name; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_org_name" ON public.org USING btree (name);


--
-- Name: UQE_org_user_org_id_user_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_org_user_org_id_user_id" ON public.org_user USING btree (org_id, user_id);


--
-- Name: UQE_plugin_setting_org_id_plugin_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_plugin_setting_org_id_plugin_id" ON public.plugin_setting USING btree (org_id, plugin_id);


--
-- Name: UQE_quota_org_id_user_id_target; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_quota_org_id_user_id_target" ON public.quota USING btree (org_id, user_id, target);


--
-- Name: UQE_server_lock_operation_uid; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_server_lock_operation_uid" ON public.server_lock USING btree (operation_uid);


--
-- Name: UQE_short_url_org_id_uid; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_short_url_org_id_uid" ON public.short_url USING btree (org_id, uid);


--
-- Name: UQE_star_user_id_dashboard_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_star_user_id_dashboard_id" ON public.star USING btree (user_id, dashboard_id);


--
-- Name: UQE_tag_key_value; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_tag_key_value" ON public.tag USING btree (key, value);


--
-- Name: UQE_team_member_org_id_team_id_user_id; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_team_member_org_id_team_id_user_id" ON public.team_member USING btree (org_id, team_id, user_id);


--
-- Name: UQE_team_org_id_name; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_team_org_id_name" ON public.team USING btree (org_id, name);


--
-- Name: UQE_user_auth_token_auth_token; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_user_auth_token_auth_token" ON public.user_auth_token USING btree (auth_token);


--
-- Name: UQE_user_auth_token_prev_auth_token; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_user_auth_token_prev_auth_token" ON public.user_auth_token USING btree (prev_auth_token);


--
-- Name: UQE_user_email; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_user_email" ON public."user" USING btree (email);


--
-- Name: UQE_user_login; Type: INDEX; Schema: public; Owner: asterisk
--

CREATE UNIQUE INDEX "UQE_user_login" ON public."user" USING btree (login);


--
-- PostgreSQL database dump complete
--

