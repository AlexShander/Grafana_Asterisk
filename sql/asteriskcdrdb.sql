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
-- Name: asteriskcdrdb; Type: DATABASE; Schema: -; Owner: asterisk
--

CREATE DATABASE asteriskcdrdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';


ALTER DATABASE asteriskcdrdb OWNER TO asterisk;

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
-- Name: input_var(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: asterisk
--

CREATE FUNCTION public.input_var(aname character varying, anum character varying, atype character varying) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE exist boolean;
	begin
		if aname = 'error'  then 
		   return '{error}';
		else
		   exist := (select exists(select num from operators where num =  anum));
		   if atype = 'add' then 
		      if exist THEN
                 return '{exist}';
              else
                 if anum LIKE '1__' then
                    insert into operators (name,num) values(aname,anum);
                    return '{added}';
                 else 
                    return '{notinrange}';
                 end if;
              end if;  
           end if;   
	   	   if atype = 'update' then
		      if exist then
		         update operators set name = aname where num = anum;
		         return '{updated}';
		      else 
		         return '{notexist}';
		      end if;
		   end if;
		   if atype = 'del' then
		      if anum = '0'  then 
		         return '{error}';
		      else
		         if exist then
		            delete from operators where num = anum;
		            return '{deleted}';
		         else
		            return '{notexist}';
		         end if;
		      end if; 
		   end if;
		end if;
	END;
$$;


ALTER FUNCTION public.input_var(aname character varying, anum character varying, atype character varying) OWNER TO asterisk;

--
-- Name: q_replace(); Type: FUNCTION; Schema: public; Owner: asterisk
--

CREATE FUNCTION public.q_replace() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
 		IF (NEW.event = 'ENTERQUEUE')  THEN
           UPDATE cdr_queue_log set  src = NEW.data2 , queuename =  NEW.queuename where uniqueid = NEW.callid ;
        END IF;

        IF (NEW.event = 'DID') THEN
           Insert into cdr_queue_log (calldate, uniqueid, queuename, did,filename) VALUES (NEW.time,NEW.callid , NEW.queuename ,NEW.data1 ,NEW.data2);

          END IF;       
       
        IF (NEW.event = 'COMPLETECALLER')  OR (NEW.event = 'COMPLETEAGENT')  THEN
           UPDATE cdr_queue_log set  wait_time = NEW.data1::int, billsec = NEW.data2::int   where uniqueid = NEW.callid;
        END IF;

        IF (NEW.event = 'ABANDON')  THEN
           UPDATE cdr_queue_log set  wait_time = NEW.data3::int, disposition = 'NOANSWER',dst = 'nobody' where uniqueid = NEW.callid;
        END IF;

        IF (NEW.event = 'CONNECT')  THEN
           UPDATE cdr_queue_log set  disposition = 'ANSWER', dst = NEW.agent where uniqueid = NEW.callid;
        END IF;

        IF (NEW.event = 'TRANSFER') THEN
           UPDATE cdr_queue_log set  wait_time = NEW.data4 , billsec = NEW.data5::int  where uniqueid = NEW.callid;
        END IF;

        IF (NEW.event = 'EXITWITHTIMEOUT')  THEN
           UPDATE cdr_queue_log set  wait_time = NEW.data4 , disposition = 'NOANSWER' where uniqueid = NEW.callid;
        END if;	

		
		RETURN NEW;
		END; 
$$;


ALTER FUNCTION public.q_replace() OWNER TO asterisk;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cdr; Type: TABLE; Schema: public; Owner: asterisk
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
    endcall timestamp without time zone,
    peerip text,
    did text,
    linkedid text,
    sequence integer,
    filename text,
    useragent text,
    realsrc character varying(64)
);


ALTER TABLE public.cdr OWNER TO asterisk;

--
-- Name: cdr_acctid_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.cdr_acctid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cdr_acctid_seq OWNER TO asterisk;

--
-- Name: cdr_acctid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.cdr_acctid_seq OWNED BY public.cdr.id;


--
-- Name: cdr_queue_log; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.cdr_queue_log (
    calldate timestamp(0) with time zone,
    uniqueid character varying(64),
    queuename character varying(64),
    dst character varying(64),
    disposition character varying(32),
    billsec integer,
    did character varying,
    src character varying(64),
    wait_time integer,
    filename character varying
);


ALTER TABLE public.cdr_queue_log OWNER TO asterisk;

--
-- Name: operators; Type: TABLE; Schema: public; Owner: asterisk
--

CREATE TABLE public.operators (
    id bigint NOT NULL,
    name character varying,
    num character varying
);


ALTER TABLE public.operators OWNER TO asterisk;

--
-- Name: operators_id_seq; Type: SEQUENCE; Schema: public; Owner: asterisk
--

CREATE SEQUENCE public.operators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operators_id_seq OWNER TO asterisk;

--
-- Name: operators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asterisk
--

ALTER SEQUENCE public.operators_id_seq OWNED BY public.operators.id;


INSERT INTO public.operators (name,num) VALUES
('Оператор1','101'),
('Оператор2','102'),
('Оператор3','103'),
('Очередь','nobody');


--
-- Name: queue_log; Type: TABLE; Schema: public; Owner: asterisk
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


ALTER TABLE public.queue_log OWNER TO asterisk;

--
-- Name: cdr id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.cdr ALTER COLUMN id SET DEFAULT nextval('public.cdr_acctid_seq'::regclass);


--
-- Name: operators id; Type: DEFAULT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.operators ALTER COLUMN id SET DEFAULT nextval('public.operators_id_seq'::regclass);


--
-- Name: cdr cdr_pkey; Type: CONSTRAINT; Schema: public; Owner: asterisk
--

ALTER TABLE ONLY public.cdr
    ADD CONSTRAINT cdr_pkey PRIMARY KEY (id);


--
-- Name: queue_log q_before; Type: TRIGGER; Schema: public; Owner: asterisk
--

CREATE TRIGGER q_before BEFORE INSERT ON public.queue_log FOR EACH ROW EXECUTE FUNCTION public.q_replace();


--
-- Name: COLUMN cdr_queue_log.calldate; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(calldate) ON TABLE public.cdr_queue_log TO asterisk;


--
-- Name: COLUMN cdr_queue_log.uniqueid; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(uniqueid) ON TABLE public.cdr_queue_log TO asterisk;


--
-- Name: COLUMN cdr_queue_log.queuename; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(queuename) ON TABLE public.cdr_queue_log TO asterisk;


--
-- Name: COLUMN cdr_queue_log.dst; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(dst) ON TABLE public.cdr_queue_log TO asterisk;


--
-- Name: COLUMN cdr_queue_log.disposition; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(disposition) ON TABLE public.cdr_queue_log TO asterisk;


--
-- Name: COLUMN cdr_queue_log.billsec; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(billsec) ON TABLE public.cdr_queue_log TO asterisk;


--
-- Name: COLUMN cdr_queue_log.did; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(did) ON TABLE public.cdr_queue_log TO asterisk;


--
-- Name: COLUMN cdr_queue_log.src; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(src) ON TABLE public.cdr_queue_log TO asterisk;


--
-- Name: COLUMN cdr_queue_log.wait_time; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(wait_time) ON TABLE public.cdr_queue_log TO asterisk;


--
-- Name: TABLE operators; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL ON TABLE public.operators TO test;


--
-- Name: COLUMN queue_log."time"; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL("time") ON TABLE public.queue_log TO asterisk;


--
-- Name: COLUMN queue_log.callid; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(callid) ON TABLE public.queue_log TO asterisk;


--
-- Name: COLUMN queue_log.queuename; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(queuename) ON TABLE public.queue_log TO asterisk;


--
-- Name: COLUMN queue_log.agent; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(agent) ON TABLE public.queue_log TO asterisk;


--
-- Name: COLUMN queue_log.event; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(event) ON TABLE public.queue_log TO asterisk;


--
-- Name: COLUMN queue_log.data1; Type: ACL; Schema: public; Owner: asterisk
--

GRANT ALL(data1) ON TABLE public.queue_log TO asterisk;


--
-- PostgreSQL database dump complete
--

