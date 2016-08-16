--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

SET statement_timeout = 0;
SET lock_timeout = 0;
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
-- Name: cf_food; Type: TABLE; Schema: public; Owner: cafe
--

CREATE TABLE cf_food (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    menu_title_pl character varying(256),
    menu_title_en character varying(256),
    menu_title_jp character varying(256),
    menu_title_it character varying(256),
    units character varying(64),
    food_type_id integer NOT NULL,
    description character varying(256),
    menu_title_uk character varying(256),
    menu_title_ru character varying(256)
);


ALTER TABLE cf_food OWNER TO cafe;

--
-- Name: cf_food_id_seq; Type: SEQUENCE; Schema: public; Owner: cafe
--

CREATE SEQUENCE cf_food_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cf_food_id_seq OWNER TO cafe;

--
-- Name: cf_food_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cafe
--

ALTER SEQUENCE cf_food_id_seq OWNED BY cf_food.id;


--
-- Name: cf_food_type; Type: TABLE; Schema: public; Owner: cafe
--

CREATE TABLE cf_food_type (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256)
);


ALTER TABLE cf_food_type OWNER TO cafe;

--
-- Name: cf_food_type_id_seq; Type: SEQUENCE; Schema: public; Owner: cafe
--

CREATE SEQUENCE cf_food_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cf_food_type_id_seq OWNER TO cafe;

--
-- Name: cf_food_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cafe
--

ALTER SEQUENCE cf_food_type_id_seq OWNED BY cf_food_type.id;


--
-- Name: cf_kitchen; Type: TABLE; Schema: public; Owner: cafe
--

CREATE TABLE cf_kitchen (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256)
);


ALTER TABLE cf_kitchen OWNER TO cafe;

--
-- Name: cf_kitchen_display; Type: TABLE; Schema: public; Owner: cafe
--

CREATE TABLE cf_kitchen_display (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256),
    kitchen_id integer NOT NULL
);


ALTER TABLE cf_kitchen_display OWNER TO cafe;

--
-- Name: cf_kitchen_display_id_seq; Type: SEQUENCE; Schema: public; Owner: cafe
--

CREATE SEQUENCE cf_kitchen_display_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cf_kitchen_display_id_seq OWNER TO cafe;

--
-- Name: cf_kitchen_display_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cafe
--

ALTER SEQUENCE cf_kitchen_display_id_seq OWNED BY cf_kitchen_display.id;


--
-- Name: cf_kitchen_id_seq; Type: SEQUENCE; Schema: public; Owner: cafe
--

CREATE SEQUENCE cf_kitchen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cf_kitchen_id_seq OWNER TO cafe;

--
-- Name: cf_kitchen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cafe
--

ALTER SEQUENCE cf_kitchen_id_seq OWNED BY cf_kitchen.id;


--
-- Name: cf_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: cafe
--

CREATE SEQUENCE cf_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cf_menu_id_seq OWNER TO cafe;

--
-- Name: cf_menu; Type: TABLE; Schema: public; Owner: cafe
--

CREATE TABLE cf_menu (
    id integer DEFAULT nextval('cf_menu_id_seq'::regclass) NOT NULL,
    dt date NOT NULL,
    menu_type_id integer NOT NULL,
    notes character varying(1024)
);


ALTER TABLE cf_menu OWNER TO cafe;

--
-- Name: cf_menu_item; Type: TABLE; Schema: public; Owner: cafe
--

CREATE TABLE cf_menu_item (
    id integer NOT NULL,
    menu_id integer NOT NULL,
    food_id integer NOT NULL,
    kitchen_id integer NOT NULL,
    pos_id integer NOT NULL,
    qty real,
    qty_extra real,
    qty_returned real,
    notes character varying(256)
);


ALTER TABLE cf_menu_item OWNER TO cafe;

--
-- Name: cf_menu_item_id_seq; Type: SEQUENCE; Schema: public; Owner: cafe
--

CREATE SEQUENCE cf_menu_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cf_menu_item_id_seq OWNER TO cafe;

--
-- Name: cf_menu_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cafe
--

ALTER SEQUENCE cf_menu_item_id_seq OWNED BY cf_menu_item.id;


--
-- Name: cf_menu_type; Type: TABLE; Schema: public; Owner: cafe
--

CREATE TABLE cf_menu_type (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256)
);


ALTER TABLE cf_menu_type OWNER TO cafe;

--
-- Name: cf_menu_type_id_seq; Type: SEQUENCE; Schema: public; Owner: cafe
--

CREATE SEQUENCE cf_menu_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cf_menu_type_id_seq OWNER TO cafe;

--
-- Name: cf_menu_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cafe
--

ALTER SEQUENCE cf_menu_type_id_seq OWNED BY cf_menu_type.id;


--
-- Name: cf_pos; Type: TABLE; Schema: public; Owner: cafe
--

CREATE TABLE cf_pos (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256)
);


ALTER TABLE cf_pos OWNER TO cafe;

--
-- Name: cf_pos_display; Type: TABLE; Schema: public; Owner: cafe
--

CREATE TABLE cf_pos_display (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256),
    pos_id integer NOT NULL
);


ALTER TABLE cf_pos_display OWNER TO cafe;

--
-- Name: cf_pos_display_id_seq; Type: SEQUENCE; Schema: public; Owner: cafe
--

CREATE SEQUENCE cf_pos_display_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cf_pos_display_id_seq OWNER TO cafe;

--
-- Name: cf_pos_display_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cafe
--

ALTER SEQUENCE cf_pos_display_id_seq OWNED BY cf_pos_display.id;


--
-- Name: cf_pos_id_seq; Type: SEQUENCE; Schema: public; Owner: cafe
--

CREATE SEQUENCE cf_pos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cf_pos_id_seq OWNER TO cafe;

--
-- Name: cf_pos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cafe
--

ALTER SEQUENCE cf_pos_id_seq OWNED BY cf_pos.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_food ALTER COLUMN id SET DEFAULT nextval('cf_food_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_food_type ALTER COLUMN id SET DEFAULT nextval('cf_food_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_kitchen ALTER COLUMN id SET DEFAULT nextval('cf_kitchen_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_kitchen_display ALTER COLUMN id SET DEFAULT nextval('cf_kitchen_display_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_menu_item ALTER COLUMN id SET DEFAULT nextval('cf_menu_item_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_menu_type ALTER COLUMN id SET DEFAULT nextval('cf_menu_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_pos ALTER COLUMN id SET DEFAULT nextval('cf_pos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_pos_display ALTER COLUMN id SET DEFAULT nextval('cf_pos_display_id_seq'::regclass);


--
-- Data for Name: cf_food; Type: TABLE DATA; Schema: public; Owner: cafe
--

INSERT INTO cf_food (id, name, menu_title_pl, menu_title_en, menu_title_jp, menu_title_it, units, food_type_id, description, menu_title_uk, menu_title_ru) VALUES (1, 'Grochówka', 'Zupa Grochowa na Wędzonce', 'Split Peas Soup with Smoked Meat', NULL, NULL, 'Litry', 1, NULL, NULL, NULL);
INSERT INTO cf_food (id, name, menu_title_pl, menu_title_en, menu_title_jp, menu_title_it, units, food_type_id, description, menu_title_uk, menu_title_ru) VALUES (2, 'Schabowy', 'Kotlet Schabowy', NULL, NULL, NULL, 'porcje', 2, 'Kotlet Schabowy', NULL, NULL);
INSERT INTO cf_food (id, name, menu_title_pl, menu_title_en, menu_title_jp, menu_title_it, units, food_type_id, description, menu_title_uk, menu_title_ru) VALUES (3, 'Mielony', 'Kotlet Mielony', NULL, NULL, NULL, 'porcje', 2, 'Kotlet Mielony', NULL, NULL);


--
-- Name: cf_food_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cafe
--

SELECT pg_catalog.setval('cf_food_id_seq', 3, true);


--
-- Data for Name: cf_food_type; Type: TABLE DATA; Schema: public; Owner: cafe
--

INSERT INTO cf_food_type (id, name, description) VALUES (1, 'Zupa', 'Zupa');
INSERT INTO cf_food_type (id, name, description) VALUES (2, 'Danie Mięsne', 'Danie Mięsne');
INSERT INTO cf_food_type (id, name, description) VALUES (3, 'Danie Jarskie', 'Danie Jarskie');
INSERT INTO cf_food_type (id, name, description) VALUES (4, 'Dodatek', 'Dodatek');
INSERT INTO cf_food_type (id, name, description) VALUES (5, 'Surówka', 'Surówka');


--
-- Name: cf_food_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cafe
--

SELECT pg_catalog.setval('cf_food_type_id_seq', 5, true);


--
-- Data for Name: cf_kitchen; Type: TABLE DATA; Schema: public; Owner: cafe
--

INSERT INTO cf_kitchen (id, name, description) VALUES (1, 'Arkadia', 'Kuchnia Arkadia');
INSERT INTO cf_kitchen (id, name, description) VALUES (2, 'Autoliv', 'Kuchnia Autoliv');


--
-- Data for Name: cf_kitchen_display; Type: TABLE DATA; Schema: public; Owner: cafe
--

INSERT INTO cf_kitchen_display (id, name, description, kitchen_id) VALUES (1, 'Arkadia Kuchnia', 'Arkadia Kuchnia', 1);
INSERT INTO cf_kitchen_display (id, name, description, kitchen_id) VALUES (2, 'Autoliv Kuchnia', 'Autoliv Kuchnia', 2);


--
-- Name: cf_kitchen_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cafe
--

SELECT pg_catalog.setval('cf_kitchen_display_id_seq', 2, true);


--
-- Name: cf_kitchen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cafe
--

SELECT pg_catalog.setval('cf_kitchen_id_seq', 2, true);


--
-- Data for Name: cf_menu; Type: TABLE DATA; Schema: public; Owner: cafe
--

INSERT INTO cf_menu (id, dt, menu_type_id, notes) VALUES (2, '2016-08-02', 1, 'Test Day 2');
INSERT INTO cf_menu (id, dt, menu_type_id, notes) VALUES (3, '2016-08-03', 1, 'Test Day 3');
INSERT INTO cf_menu (id, dt, menu_type_id, notes) VALUES (6, '2016-11-08', 3, 'aaaa');
INSERT INTO cf_menu (id, dt, menu_type_id, notes) VALUES (8, '2016-12-06', 1, '');
INSERT INTO cf_menu (id, dt, menu_type_id, notes) VALUES (9, '2016-08-15', 1, 'pietnasty');
INSERT INTO cf_menu (id, dt, menu_type_id, notes) VALUES (10, '2016-08-14', 1, 'Notatki');
INSERT INTO cf_menu (id, dt, menu_type_id, notes) VALUES (1, '2016-08-11', 2, 'Lany poniedzialek');


--
-- Name: cf_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cafe
--

SELECT pg_catalog.setval('cf_menu_id_seq', 10, true);


--
-- Data for Name: cf_menu_item; Type: TABLE DATA; Schema: public; Owner: cafe
--

INSERT INTO cf_menu_item (id, menu_id, food_id, kitchen_id, pos_id, qty, qty_extra, qty_returned, notes) VALUES (29, 6, 1, 1, 1, 1, 'NaN', 'NaN', NULL);
INSERT INTO cf_menu_item (id, menu_id, food_id, kitchen_id, pos_id, qty, qty_extra, qty_returned, notes) VALUES (30, 8, 2, 1, 1, 111, 'NaN', 'NaN', NULL);
INSERT INTO cf_menu_item (id, menu_id, food_id, kitchen_id, pos_id, qty, qty_extra, qty_returned, notes) VALUES (90, 10, 2, 2, 3, 111, 'NaN', 'NaN', NULL);
INSERT INTO cf_menu_item (id, menu_id, food_id, kitchen_id, pos_id, qty, qty_extra, qty_returned, notes) VALUES (96, 1, 1, 1, 2, 44, 'NaN', 'NaN', NULL);
INSERT INTO cf_menu_item (id, menu_id, food_id, kitchen_id, pos_id, qty, qty_extra, qty_returned, notes) VALUES (97, 1, 2, 1, 2, 44, 'NaN', 'NaN', NULL);
INSERT INTO cf_menu_item (id, menu_id, food_id, kitchen_id, pos_id, qty, qty_extra, qty_returned, notes) VALUES (98, 1, 2, 2, 2, 33, 'NaN', 'NaN', NULL);
INSERT INTO cf_menu_item (id, menu_id, food_id, kitchen_id, pos_id, qty, qty_extra, qty_returned, notes) VALUES (99, 1, 3, 1, 1, 2, 'NaN', 'NaN', NULL);
INSERT INTO cf_menu_item (id, menu_id, food_id, kitchen_id, pos_id, qty, qty_extra, qty_returned, notes) VALUES (100, 1, 3, 1, 3, 2, 'NaN', 'NaN', NULL);
INSERT INTO cf_menu_item (id, menu_id, food_id, kitchen_id, pos_id, qty, qty_extra, qty_returned, notes) VALUES (101, 1, 1, 1, 1, 'NaN', 'NaN', 'NaN', NULL);


--
-- Name: cf_menu_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cafe
--

SELECT pg_catalog.setval('cf_menu_item_id_seq', 101, true);


--
-- Data for Name: cf_menu_type; Type: TABLE DATA; Schema: public; Owner: cafe
--

INSERT INTO cf_menu_type (id, name, description) VALUES (1, 'T1 Poniedzialek', 'Tydzien 1 Poniedzialek');
INSERT INTO cf_menu_type (id, name, description) VALUES (3, 'Czwartek Szwedzki', 'Czwartek Tematyczny Szwedzki');
INSERT INTO cf_menu_type (id, name, description) VALUES (2, 'T1 Wtorek', 'Tydzien 1 Wtorek');


--
-- Name: cf_menu_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cafe
--

SELECT pg_catalog.setval('cf_menu_type_id_seq', 3, true);


--
-- Data for Name: cf_pos; Type: TABLE DATA; Schema: public; Owner: cafe
--

INSERT INTO cf_pos (id, name, description) VALUES (1, 'Kantyna Autoliv', 'Kantyna Autoliv');
INSERT INTO cf_pos (id, name, description) VALUES (2, 'Kantyna SCA', 'Kantyna SCA');
INSERT INTO cf_pos (id, name, description) VALUES (3, 'Kantyna Elica', 'Kantyna Elica');


--
-- Data for Name: cf_pos_display; Type: TABLE DATA; Schema: public; Owner: cafe
--

INSERT INTO cf_pos_display (id, name, description, pos_id) VALUES (1, 'Autoliv Sala', 'Telewizor na Sali Autoliv', 1);
INSERT INTO cf_pos_display (id, name, description, pos_id) VALUES (2, 'SCA Sala', 'Telewizor na Sali SCA', 2);


--
-- Name: cf_pos_display_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cafe
--

SELECT pg_catalog.setval('cf_pos_display_id_seq', 2, true);


--
-- Name: cf_pos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cafe
--

SELECT pg_catalog.setval('cf_pos_id_seq', 3, true);


--
-- Name: cf_food_name; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_food
    ADD CONSTRAINT cf_food_name UNIQUE (name);


--
-- Name: cf_food_pkey; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_food
    ADD CONSTRAINT cf_food_pkey PRIMARY KEY (id);


--
-- Name: cf_food_type_name; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_food_type
    ADD CONSTRAINT cf_food_type_name UNIQUE (name);


--
-- Name: cf_food_type_pkey; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_food_type
    ADD CONSTRAINT cf_food_type_pkey PRIMARY KEY (id);


--
-- Name: cf_kitchen_display_name; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_kitchen_display
    ADD CONSTRAINT cf_kitchen_display_name UNIQUE (name);


--
-- Name: cf_kitchen_display_pkey; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_kitchen_display
    ADD CONSTRAINT cf_kitchen_display_pkey PRIMARY KEY (id);


--
-- Name: cf_kitchen_name; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_kitchen
    ADD CONSTRAINT cf_kitchen_name UNIQUE (name);


--
-- Name: cf_kitchen_pkey; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_kitchen
    ADD CONSTRAINT cf_kitchen_pkey PRIMARY KEY (id);


--
-- Name: cf_menu_dt; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_menu
    ADD CONSTRAINT cf_menu_dt UNIQUE (dt);


--
-- Name: cf_menu_item_pkey; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_menu_item
    ADD CONSTRAINT cf_menu_item_pkey PRIMARY KEY (id);


--
-- Name: cf_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_menu
    ADD CONSTRAINT cf_menu_pkey PRIMARY KEY (id);


--
-- Name: cf_menu_type_name; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_menu_type
    ADD CONSTRAINT cf_menu_type_name UNIQUE (name);


--
-- Name: cf_menu_type_pkey; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_menu_type
    ADD CONSTRAINT cf_menu_type_pkey PRIMARY KEY (id);


--
-- Name: cf_pos_display_name; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_pos_display
    ADD CONSTRAINT cf_pos_display_name UNIQUE (name);


--
-- Name: cf_pos_display_pkey; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_pos_display
    ADD CONSTRAINT cf_pos_display_pkey PRIMARY KEY (id);


--
-- Name: cf_pos_name; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_pos
    ADD CONSTRAINT cf_pos_name UNIQUE (name);


--
-- Name: cf_pos_pkey; Type: CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_pos
    ADD CONSTRAINT cf_pos_pkey PRIMARY KEY (id);


--
-- Name: cf_food_food_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_food
    ADD CONSTRAINT cf_food_food_type_fk FOREIGN KEY (food_type_id) REFERENCES cf_food_type(id) MATCH FULL;


--
-- Name: cf_kitchen_display_kitchen_fk; Type: FK CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_kitchen_display
    ADD CONSTRAINT cf_kitchen_display_kitchen_fk FOREIGN KEY (kitchen_id) REFERENCES cf_kitchen(id) MATCH FULL;


--
-- Name: cf_menu_item_food_fk; Type: FK CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_menu_item
    ADD CONSTRAINT cf_menu_item_food_fk FOREIGN KEY (food_id) REFERENCES cf_food(id) MATCH FULL;


--
-- Name: cf_menu_item_kitchen_fk; Type: FK CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_menu_item
    ADD CONSTRAINT cf_menu_item_kitchen_fk FOREIGN KEY (kitchen_id) REFERENCES cf_kitchen(id) MATCH FULL;


--
-- Name: cf_menu_item_menu_fk; Type: FK CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_menu_item
    ADD CONSTRAINT cf_menu_item_menu_fk FOREIGN KEY (menu_id) REFERENCES cf_menu(id) MATCH FULL;


--
-- Name: cf_menu_item_pos_fk; Type: FK CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_menu_item
    ADD CONSTRAINT cf_menu_item_pos_fk FOREIGN KEY (pos_id) REFERENCES cf_pos(id) MATCH FULL;


--
-- Name: cf_menu_menu_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_menu
    ADD CONSTRAINT cf_menu_menu_type_fk FOREIGN KEY (menu_type_id) REFERENCES cf_menu_type(id) MATCH FULL;


--
-- Name: cf_pos_display_pos_fk; Type: FK CONSTRAINT; Schema: public; Owner: cafe
--

ALTER TABLE ONLY cf_pos_display
    ADD CONSTRAINT cf_pos_display_pos_fk FOREIGN KEY (pos_id) REFERENCES cf_pos(id) MATCH FULL;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

