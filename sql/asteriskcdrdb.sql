--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3 (Ubuntu 12.3-1.pgdg18.04+1)
-- Dumped by pg_dump version 12.3 (Ubuntu 12.3-1.pgdg18.04+1)

-- Started on 2021-04-22 10:29:38 UTC

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

-- DROP DATABASE asteriskcdrdb;
--
-- TOC entry 2922 (class 1262 OID 24576)
-- Name: asteriskcdrdb; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE asteriskcdrdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


\connect asteriskcdrdb

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
-- TOC entry 220 (class 1255 OID 65544)
-- Name: q_replace(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.q_replace() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
 		IF (NEW.event = 'ENTERQUEUE')  THEN
           UPDATE cdr_queue_log set  src = NEW.data2 , queuename =  NEW.queuename where uniqueid = NEW.callid ;
        END IF;

        IF (NEW.event = 'DID') THEN
           Insert into cdr_queue_log (calldate, uniqueid, queuename, did,filename) VALUES (NEW.time,NEW.callid , NEW.queuename ,NEW.data1,NEW.data2);

          END IF;       
       
        IF (NEW.event = 'COMPLETECALLER')  OR (NEW.event = 'COMPLETEAGENT')  THEN
           UPDATE cdr_queue_log set  wait_time = NEW.data2, billsec = NEW.data3  where uniqueid = NEW.callid;
        END IF;

        IF (NEW.event = 'ABANDON')  THEN
           UPDATE cdr_queue_log set  wait_time = NEW.data3, disposition = 'NOANSWER',dst = 'nobody' where uniqueid = NEW.callid;
        END IF;

        IF (NEW.event = 'CONNECT')  THEN
           UPDATE cdr_queue_log set  wait_time = NEW.data2, disposition = 'ANSWER', dst = NEW.agent where uniqueid = NEW.callid;
        END IF;

        IF (NEW.event = 'TRANSFER') THEN
           UPDATE cdr_queue_log set  wait_time = NEW.data4, billsec = NEW.data5  where uniqueid = NEW.callid;
        END IF;

        IF (NEW.event = 'EXITWITHTIMEOUT')  THEN
           UPDATE cdr_queue_log set  wait_time = NEW.data4, disposition = 'NOANSWER' where uniqueid = NEW.callid;
        END if;	

		
		RETURN NEW;
		END; 
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 204 (class 1259 OID 49263)
-- Name: cdr; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cdr (
    id bigint NOT NULL,
    calldate timestamp with time zone,
    clid text,
    src text,
    dst text,
    dcontext text,
    channel text,
    dstchannel text,
    lastapp text,
    lastdata text,
    duration bigint,
    billsec bigint,
    disposition text,
    amaflags bigint,
    uniqueid text,
    realdst text,
    start timestamp with time zone,
    answer timestamp with time zone,
    endcall timestamp with time zone,
    peerip text,
    did text,
    linkedid text,
    sequence integer,
    filename text,
    useragent text
);


--
-- TOC entry 203 (class 1259 OID 49261)
-- Name: cdr_acctid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cdr_acctid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2925 (class 0 OID 0)
-- Dependencies: 203
-- Name: cdr_acctid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cdr_acctid_seq OWNED BY public.cdr.id;


--
-- TOC entry 205 (class 1259 OID 65565)
-- Name: cdr_queue_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cdr_queue_log (
    calldate timestamp(0) with time zone,
    uniqueid character varying(64),
    queuename character varying(64),
    dst character varying(64),
    disposition character varying(32),
    billsec character varying(64),
    did character varying(64),
    src character varying(64),
    wait_time character varying(64),
    filename character varying
);


--
-- TOC entry 206 (class 1259 OID 73729)
-- Name: operators; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.operators (
    id bigint NOT NULL,
    name character varying,
    num integer
);


--
-- TOC entry 207 (class 1259 OID 73735)
-- Name: operators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.operators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 207
-- Name: operators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.operators_id_seq OWNED BY public.operators.id;


--
-- TOC entry 202 (class 1259 OID 32768)
-- Name: queue_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.queue_log (
    "time" timestamp(0) with time zone,
    callid character varying(64),
    queuename character varying(64),
    agent character varying(64),
    event character varying(32),
    data1 character varying(255),
    data2 character varying,
    data3 character varying,
    data4 character varying,
    data5 character varying,
    data character varying
);


--
-- TOC entry 2786 (class 2604 OID 49266)
-- Name: cdr id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cdr ALTER COLUMN id SET DEFAULT nextval('public.cdr_acctid_seq'::regclass);


--
-- TOC entry 2787 (class 2604 OID 73737)
-- Name: operators id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operators ALTER COLUMN id SET DEFAULT nextval('public.operators_id_seq'::regclass);


--
-- TOC entry 2789 (class 2606 OID 49271)
-- Name: cdr cdr_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cdr
    ADD CONSTRAINT cdr_pkey PRIMARY KEY (id);


--
-- TOC entry 2790 (class 2620 OID 65564)
-- Name: queue_log q_before; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER q_before BEFORE INSERT ON public.queue_log FOR EACH ROW EXECUTE FUNCTION public.q_replace();


--
-- TOC entry 2923 (class 0 OID 0)
-- Dependencies: 2922
-- Name: DATABASE asteriskcdrdb; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON DATABASE asteriskcdrdb TO asterisk;


--
-- TOC entry 2924 (class 0 OID 0)
-- Dependencies: 204
-- Name: TABLE cdr; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.cdr TO asterisk;


--
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE cdr_queue_log; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.cdr_queue_log TO asterisk;


--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN cdr_queue_log.calldate; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(calldate) ON TABLE public.cdr_queue_log TO asterisk;


--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN cdr_queue_log.uniqueid; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(uniqueid) ON TABLE public.cdr_queue_log TO asterisk;


--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN cdr_queue_log.queuename; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(queuename) ON TABLE public.cdr_queue_log TO asterisk;


--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN cdr_queue_log.dst; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(dst) ON TABLE public.cdr_queue_log TO asterisk;


--
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN cdr_queue_log.disposition; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(disposition) ON TABLE public.cdr_queue_log TO asterisk;


--
-- TOC entry 2932 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN cdr_queue_log.billsec; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(billsec) ON TABLE public.cdr_queue_log TO asterisk;


--
-- TOC entry 2933 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN cdr_queue_log.did; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(did) ON TABLE public.cdr_queue_log TO asterisk;


--
-- TOC entry 2934 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN cdr_queue_log.src; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(src) ON TABLE public.cdr_queue_log TO asterisk;


--
-- TOC entry 2935 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN cdr_queue_log.wait_time; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(wait_time) ON TABLE public.cdr_queue_log TO asterisk;


--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE operators; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.operators TO asterisk;


--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE queue_log; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.queue_log TO asterisk;


--
-- TOC entry 2939 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN queue_log."time"; Type: ACL; Schema: public; Owner: -
--

GRANT ALL("time") ON TABLE public.queue_log TO asterisk;


--
-- TOC entry 2940 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN queue_log.callid; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(callid) ON TABLE public.queue_log TO asterisk;


--
-- TOC entry 2941 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN queue_log.queuename; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(queuename) ON TABLE public.queue_log TO asterisk;


--
-- TOC entry 2942 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN queue_log.agent; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(agent) ON TABLE public.queue_log TO asterisk;


--
-- TOC entry 2943 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN queue_log.event; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(event) ON TABLE public.queue_log TO asterisk;


--
-- TOC entry 2944 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN queue_log.data1; Type: ACL; Schema: public; Owner: -
--

GRANT ALL(data1) ON TABLE public.queue_log TO asterisk;


-- Completed on 2021-04-22 10:29:38 UTC

--
-- PostgreSQL database dump complete
--

