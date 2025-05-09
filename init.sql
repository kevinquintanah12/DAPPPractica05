-- 1. Crear usuario y base de datos
CREATE USER myuser;
ALTER USER myuser WITH PASSWORD '123';
CREATE DATABASE mydb;
GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;

-- 2. Conectarse a la BD recién creada
\connect mydb;

-- 3. Tabla clients
CREATE SEQUENCE clients_clave_seq
    INCREMENT 1
    START    1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE    1;

CREATE TABLE IF NOT EXISTS clients
(
    id   integer NOT NULL DEFAULT nextval('clients_clave_seq'::regclass),
    name varchar(255),
    CONSTRAINT clients_pkey PRIMARY KEY (id)
);

-- 4. Tabla products
CREATE SEQUENCE products_clave_seq
    INCREMENT 1
    START    1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE    1;

CREATE TABLE IF NOT EXISTS products
(
    id    integer NOT NULL DEFAULT nextval('products_clave_seq'::regclass),
    name  varchar(255),
    price numeric(9,6),
    CONSTRAINT products_pkey PRIMARY KEY (id)
);

-- 5. Tabla sales
CREATE SEQUENCE sales_clave_seq
    INCREMENT 1
    START    1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE    1;

CREATE TABLE IF NOT EXISTS sales
(
    id        integer NOT NULL DEFAULT nextval('sales_clave_seq'::regclass),
    amount    numeric(9,6),
    date      date,
    client_id integer,
    CONSTRAINT sales_pkey PRIMARY KEY (id),
    CONSTRAINT sales_client_fk FOREIGN KEY (client_id)
        REFERENCES clients (id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- 6. Tabla sales_detail
CREATE SEQUENCE sales_detail_clave_seq
    INCREMENT 1
    START    1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE    1;

CREATE TABLE IF NOT EXISTS sales_detail
(
    row_id      integer NOT NULL DEFAULT nextval('sales_detail_clave_seq'::regclass),
    description varchar(255),
    price       numeric(9,6),
    quantity    integer,
    product_id  integer NOT NULL,
    sale_id     integer,
    CONSTRAINT sales_detail_pkey PRIMARY KEY (row_id),
    CONSTRAINT sales_detail_sale_fk FOREIGN KEY (sale_id)
        REFERENCES sales (id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sales_detail_product_fk FOREIGN KEY (product_id)
        REFERENCES products (id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
