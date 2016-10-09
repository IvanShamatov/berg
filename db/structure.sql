--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: set_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION set_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        NEW.updated_at = (now() at time zone 'utc');
        RETURN NEW;
      END;
      $$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: about_page_people; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE about_page_people (
    "position" integer NOT NULL,
    person_id integer NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    slug text NOT NULL,
    name text NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: categorisations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categorisations (
    id integer NOT NULL,
    post_id integer NOT NULL,
    category_id integer NOT NULL
);


--
-- Name: categorisations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categorisations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categorisations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categorisations_id_seq OWNED BY categorisations.id;


--
-- Name: curated_posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE curated_posts (
    id integer NOT NULL,
    title text,
    link_url text,
    image_url text,
    image_upload json DEFAULT '{}'::json,
    status text DEFAULT 'draft'::text,
    published_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    link_title text DEFAULT ''::text NOT NULL,
    body text
);


--
-- Name: curated_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE curated_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: curated_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE curated_posts_id_seq OWNED BY curated_posts.id;


--
-- Name: home_page_featured_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE home_page_featured_items (
    id integer NOT NULL,
    "position" integer NOT NULL,
    title text NOT NULL,
    url text NOT NULL,
    cover_image json DEFAULT '{}'::json NOT NULL,
    highlight_color text DEFAULT ''::text NOT NULL,
    teaser text
);


--
-- Name: home_page_featured_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE home_page_featured_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: home_page_featured_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE home_page_featured_items_id_seq OWNED BY home_page_featured_items.id;


--
-- Name: office_contact_details; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE office_contact_details (
    id integer NOT NULL,
    "position" integer NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    phone_number text NOT NULL,
    latitude text DEFAULT ''::text NOT NULL,
    longitude text DEFAULT ''::text NOT NULL
);


--
-- Name: office_contact_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE office_contact_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: office_contact_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE office_contact_details_id_seq OWNED BY office_contact_details.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE people (
    id integer NOT NULL,
    twitter_handle text,
    bio text NOT NULL,
    website_url text,
    avatar_image json,
    job_title text,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    short_bio text DEFAULT ''::text NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    city text NOT NULL,
    slug text DEFAULT ''::text
);


--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE people_id_seq OWNED BY people.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE posts (
    id integer NOT NULL,
    title text NOT NULL,
    body text NOT NULL,
    slug text,
    status text DEFAULT 'draft'::text,
    person_id integer NOT NULL,
    published_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    teaser text DEFAULT ''::text NOT NULL,
    color text DEFAULT ''::text NOT NULL,
    cover_image json,
    assets json
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    title text NOT NULL,
    client text NOT NULL,
    url text,
    summary text NOT NULL,
    body text,
    slug text NOT NULL,
    status text DEFAULT 'draft'::text,
    published_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    case_study boolean DEFAULT false NOT NULL,
    cover_image json,
    assets json,
    color text DEFAULT ''::text NOT NULL,
    intro text
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: que_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE que_jobs (
    priority smallint DEFAULT 100 NOT NULL,
    run_at timestamp with time zone DEFAULT now() NOT NULL,
    job_id bigint NOT NULL,
    job_class text NOT NULL,
    args json DEFAULT '[]'::json NOT NULL,
    error_count integer DEFAULT 0 NOT NULL,
    last_error text,
    queue text DEFAULT ''::text NOT NULL
);


--
-- Name: TABLE que_jobs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE que_jobs IS '3';


--
-- Name: que_jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE que_jobs_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: que_jobs_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE que_jobs_job_id_seq OWNED BY que_jobs.job_id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    filename text NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email text NOT NULL,
    encrypted_password text,
    access_token text,
    access_token_expiration timestamp without time zone,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    name text DEFAULT ''::text NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: work_page_featured_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE work_page_featured_items (
    id integer NOT NULL,
    "position" integer NOT NULL,
    title text NOT NULL,
    url text NOT NULL,
    cover_image json DEFAULT '{}'::json NOT NULL,
    highlight_color text DEFAULT ''::text NOT NULL,
    teaser text
);


--
-- Name: work_page_featured_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE work_page_featured_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_page_featured_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE work_page_featured_items_id_seq OWNED BY work_page_featured_items.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categorisations ALTER COLUMN id SET DEFAULT nextval('categorisations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY curated_posts ALTER COLUMN id SET DEFAULT nextval('curated_posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY home_page_featured_items ALTER COLUMN id SET DEFAULT nextval('home_page_featured_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY office_contact_details ALTER COLUMN id SET DEFAULT nextval('office_contact_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY people ALTER COLUMN id SET DEFAULT nextval('people_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: job_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY que_jobs ALTER COLUMN job_id SET DEFAULT nextval('que_jobs_job_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_page_featured_items ALTER COLUMN id SET DEFAULT nextval('work_page_featured_items_id_seq'::regclass);


--
-- Name: about_page_people_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY about_page_people
    ADD CONSTRAINT about_page_people_pkey PRIMARY KEY (person_id, "position");


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categorisations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categorisations
    ADD CONSTRAINT categorisations_pkey PRIMARY KEY (id);


--
-- Name: curated_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY curated_posts
    ADD CONSTRAINT curated_posts_pkey PRIMARY KEY (id);


--
-- Name: home_page_featured_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY home_page_featured_items
    ADD CONSTRAINT home_page_featured_items_pkey PRIMARY KEY (id);


--
-- Name: office_contact_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY office_contact_details
    ADD CONSTRAINT office_contact_details_pkey PRIMARY KEY (id);


--
-- Name: people_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: people_slug_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_slug_key UNIQUE (slug);


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: posts_slug_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_slug_key UNIQUE (slug);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: projects_slug_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_slug_key UNIQUE (slug);


--
-- Name: que_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY que_jobs
    ADD CONSTRAINT que_jobs_pkey PRIMARY KEY (queue, priority, run_at, job_id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (filename);


--
-- Name: users_email_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: work_page_featured_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY work_page_featured_items
    ADD CONSTRAINT work_page_featured_items_pkey PRIMARY KEY (id);


--
-- Name: set_updated_at_on_curated_posts; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_updated_at_on_curated_posts BEFORE UPDATE ON curated_posts FOR EACH ROW EXECUTE PROCEDURE set_updated_at_column();


--
-- Name: set_updated_at_on_people; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_updated_at_on_people BEFORE UPDATE ON people FOR EACH ROW EXECUTE PROCEDURE set_updated_at_column();


--
-- Name: set_updated_at_on_posts; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_updated_at_on_posts BEFORE UPDATE ON posts FOR EACH ROW EXECUTE PROCEDURE set_updated_at_column();


--
-- Name: set_updated_at_on_projects; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_updated_at_on_projects BEFORE UPDATE ON projects FOR EACH ROW EXECUTE PROCEDURE set_updated_at_column();


--
-- Name: set_updated_at_on_users; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_updated_at_on_users BEFORE UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE set_updated_at_column();


--
-- PostgreSQL database dump complete
--

