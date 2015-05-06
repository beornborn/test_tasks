/* *********************************************************************** */
/* DB Extract 2011 for PostgreSQL                                  3.0.1.1 */
/* ----------------------------------------------------------------------- */
/* Server   : PostgreSQL 9.1                                               */
/* Host     : 127.0.0.1                                                    */
/* Port     : 5432                                                         */
 /** Database : postgres ********************************************************************** */

DROP ROLE IF EXISTS beorn;
CREATE ROLE beorn LOGIN
  SUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION;
SET ROLE beorn;
DROP SCHEMA IF EXISTS public CASCADE;
DROP SCHEMA IF EXISTS testschema CASCADE;
CREATE SCHEMA public
  AUTHORIZATION beorn;
DROP TABLE IF EXISTS public.employees;
DROP SEQUENCE IF EXISTS public.emp;
DROP TABLE IF EXISTS public.divisions;
DROP SEQUENCE IF EXISTS public.foo;

--
-- Definition for language plpgsql : 
--

--
-- Disable validation of the function body :
--
SET check_function_bodies = false;
--
-- Definition for sequence foo : 
--
CREATE SEQUENCE public.foo
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table divisions : 
--
CREATE TABLE public.divisions (
    id integer DEFAULT nextval('public.foo'::regclass) NOT NULL,
    nameofdivision text NOT NULL
) WITHOUT OIDS;
--
-- Definition for sequence emp : 
--
CREATE SEQUENCE public.emp
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table employees : 
--
CREATE TABLE public.employees (
    id bigint DEFAULT nextval('public.emp'::regclass) NOT NULL,
    firstname varchar(100),
    lastname text,
    division text,
    salary double precision,
    birthday date,
    active boolean
) WITHOUT OIDS;
--
-- Data for table public.divisions (LIMIT 0,5)
--
BEGIN;

INSERT INTO public.divisions (nameofdivision)
VALUES ('Programming');

INSERT INTO public.divisions (nameofdivision)
VALUES ('Testing');

INSERT INTO public.divisions (nameofdivision)
VALUES ('Management');

INSERT INTO public.divisions (nameofdivision)
VALUES ('Supply');

INSERT INTO public.divisions (nameofdivision)
VALUES ('Marketing');

COMMIT;

--
-- Definition for index divisions_pkey : 
--
ALTER TABLE ONLY public.divisions
    ADD CONSTRAINT divisions_pkey
    PRIMARY KEY (id);
--
-- Definition for index employees_pkey : 
--
ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey
    PRIMARY KEY (id);
--
-- Comments
--
COMMENT ON SCHEMA public IS 'test schema';
COMMENT ON LANGUAGE plpgsql IS 'PL/pgSQL procedural language';


CREATE SCHEMA testschema
  AUTHORIZATION beorn;
DROP TABLE IF EXISTS testschema.employees;
DROP SEQUENCE IF EXISTS testschema.emp;
DROP TABLE IF EXISTS testschema.divisions;
DROP SEQUENCE IF EXISTS testschema.foo;

--
-- Definition for language plpgsql : 
--

--
-- Disable validation of the function body :
--
SET check_function_bodies = false;
--
-- Definition for sequence foo : 
--
CREATE SEQUENCE testschema.foo
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table divisions : 
--
CREATE TABLE testschema.divisions (
    id integer DEFAULT nextval('testschema.foo'::regclass) NOT NULL,
    nameofdivision text NOT NULL
) WITHOUT OIDS;
--
-- Definition for sequence emp : 
--
CREATE SEQUENCE testschema.emp
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table employees : 
--
CREATE TABLE testschema.employees (
    id bigint DEFAULT nextval('testschema.emp'::regclass) NOT NULL,
    firstname varchar(100),
    lastname text,
    division text,
    salary double precision,
    birthday date,
    active boolean
) WITHOUT OIDS;
--
-- Data for table testschema.divisions (LIMIT 0,5)
--

--
-- Definition for index divisions_pkey : 
--
ALTER TABLE ONLY testschema.divisions
    ADD CONSTRAINT divisions_pkey
    PRIMARY KEY (id);
--
-- Definition for index employees_pkey : 
--
ALTER TABLE ONLY testschema.employees
    ADD CONSTRAINT employees_pkey
    PRIMARY KEY (id);
--
-- Comments
--
COMMENT ON SCHEMA testschema IS 'test schema';
COMMENT ON LANGUAGE plpgsql IS 'PL/pgSQL procedural language';
