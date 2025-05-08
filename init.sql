CREATE USER myuser;
ALTER USER myuser WITH PASSWORD '123';
CREATE DATABASE mydb;
GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;
\connect mydb;
CREATE SEQUENCE clients_clave_seq
	INCREMENT 1
	START 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE 1;
CREATE TABLE IF NOT EXISTS clients_id
(
    id integer NOT NULL DEFAULT nextval('clients_clave_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT clients_pkey PRIMARY KEY (id)
)

CREATE SEQUENCE products_clave_seq
	INCREMENT 1
	START 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE 1;
CREATE TABLE IF NOT EXISTS products_id
(
    id integer NOT NULL DEFAULT nextval('products_clave_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default",
    price numeric(9,6),
    CONSTRAINT products_pkey PRIMARY KEY (id)
)

CREATE SEQUENCE sales_clave_seq
	INCREMENT 1
	START 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE 1;
CREATE TABLE IF NOT EXISTS sales_id
(
    id integer NOT NULL DEFAULT nextval('sales_clave_seq'::regclass),
    amount numeric(9,6),
    date date,
    client_id bigint,
    CONSTRAINT sales_pkey PRIMARY KEY (id),
    CONSTRAINT fkbbif9cb3ecyusyms54yvwlhd5 FOREIGN KEY (client_id)
        REFERENCES public.clients (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE SEQUENCE sales_detail_clave_seq
	INCREMENT 1
	START 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE 1;
CREATE TABLE IF NOT EXISTS sales_detail_id
(
    row_id integer NOT NULL DEFAULT nextval('sales_detail_clave_seq'::regclass),
    description character varying(255) COLLATE pg_catalog."default",
    price numeric(9,6),
    quantity integer,
    product_id bigint NOT NULL,
    sale_id bigint,
    CONSTRAINT sales_detail_pkey PRIMARY KEY (row_id),
    CONSTRAINT sales_fkey FOREIGN KEY (sale_id)
        REFERENCES public.sales (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT products_fkey FOREIGN KEY (product_id)
        REFERENCES public.products (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
