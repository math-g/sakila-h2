CREATE USER IF NOT EXISTS SA SALT '193ac6689396ea85' HASH 'aa344c6e509350be9522487d3338c2618d3e891915ffb4a57108fddfb92a25a2' ADMIN;
CREATE CACHED TABLE PUBLIC.FILM_TEXT(
    FILM_ID SMALLINT NOT NULL,
    TITLE VARCHAR(255) NOT NULL,
    DESCRIPTION LONGVARCHAR
);
ALTER TABLE PUBLIC.FILM_TEXT ADD CONSTRAINT PUBLIC.CONSTRAINT_6 PRIMARY KEY(FILM_ID);
-- 1000 +/- SELECT COUNT(*) FROM PUBLIC.FILM_TEXT;
CREATE CACHED TABLE PUBLIC.ACTOR(
    ACTOR_ID SMALLINT NOT NULL,
    FIRST_NAME VARCHAR(45) NOT NULL,
    LAST_NAME VARCHAR(45) NOT NULL,
    LAST_UPDATE TIMESTAMP NOT NULL
);
ALTER TABLE PUBLIC.ACTOR ADD CONSTRAINT PUBLIC.CONSTRAINT_3 PRIMARY KEY(ACTOR_ID);
-- 200 +/- SELECT COUNT(*) FROM PUBLIC.ACTOR;
CREATE CACHED TABLE PUBLIC.ADDRESS(
    ADDRESS_ID SMALLINT NOT NULL,
    ADDRESS VARCHAR(50) NOT NULL,
    ADDRESS2 VARCHAR(50),
    DISTRICT VARCHAR(20) NOT NULL,
    CITY_ID SMALLINT NOT NULL,
    POSTAL_CODE VARCHAR(10),
    PHONE VARCHAR(20) NOT NULL,
    LAST_UPDATE TIMESTAMP NOT NULL
);
ALTER TABLE PUBLIC.ADDRESS ADD CONSTRAINT PUBLIC.CONSTRAINT_E PRIMARY KEY(ADDRESS_ID);
-- 603 +/- SELECT COUNT(*) FROM PUBLIC.ADDRESS;
CREATE INDEX PUBLIC.IDX_FK_CITY_ID ON PUBLIC.ADDRESS(ADDRESS_ID);
CREATE CACHED TABLE PUBLIC.CATEGORY(
    CATEGORY_ID TINYINT NOT NULL,
    NAME VARCHAR(25) NOT NULL,
    LAST_UPDATE TIMESTAMP NOT NULL
);
ALTER TABLE PUBLIC.CATEGORY ADD CONSTRAINT PUBLIC.CONSTRAINT_31 PRIMARY KEY(CATEGORY_ID);
-- 16 +/- SELECT COUNT(*) FROM PUBLIC.CATEGORY;
CREATE CACHED TABLE PUBLIC.COUNTRY(
    COUNTRY_ID SMALLINT NOT NULL,
    COUNTRY VARCHAR(50) NOT NULL,
    LAST_UPDATE TIMESTAMP NOT NULL
);
ALTER TABLE PUBLIC.COUNTRY ADD CONSTRAINT PUBLIC.CONSTRAINT_63 PRIMARY KEY(COUNTRY_ID);
-- 109 +/- SELECT COUNT(*) FROM PUBLIC.COUNTRY;
CREATE CACHED TABLE PUBLIC.LANGUAGE(
    LANGUAGE_ID TINYINT NOT NULL,
    NAME VARCHAR(20) NOT NULL,
    LAST_UPDATE TIMESTAMP NOT NULL
);
ALTER TABLE PUBLIC.LANGUAGE ADD CONSTRAINT PUBLIC.CONSTRAINT_C PRIMARY KEY(LANGUAGE_ID);
-- 6 +/- SELECT COUNT(*) FROM PUBLIC.LANGUAGE;
CREATE CACHED TABLE PUBLIC.CITY(
    CITY_ID SMALLINT NOT NULL,
    CITY VARCHAR(50) NOT NULL,
    COUNTRY_ID SMALLINT NOT NULL,
    LAST_UPDATE TIMESTAMP NOT NULL
);
ALTER TABLE PUBLIC.CITY ADD CONSTRAINT PUBLIC.CONSTRAINT_1 PRIMARY KEY(CITY_ID);
-- 600 +/- SELECT COUNT(*) FROM PUBLIC.CITY;
CREATE CACHED TABLE PUBLIC.CUSTOMER(
    CUSTOMER_ID SMALLINT NOT NULL,
    STORE_ID TINYINT NOT NULL,
    FIRST_NAME VARCHAR(45) NOT NULL,
    LAST_NAME VARCHAR(45) NOT NULL,
    EMAIL VARCHAR(50),
    ADDRESS_ID SMALLINT NOT NULL,
    ACTIVE BOOLEAN NOT NULL,
    CREATE_DATE TIMESTAMP NOT NULL,
    LAST_UPDATE TIMESTAMP NOT NULL
);
ALTER TABLE PUBLIC.CUSTOMER ADD CONSTRAINT PUBLIC.CONSTRAINT_5 PRIMARY KEY(CUSTOMER_ID);
-- 599 +/- SELECT COUNT(*) FROM PUBLIC.CUSTOMER;
CREATE CACHED TABLE PUBLIC.FILM(
    FILM_ID SMALLINT NOT NULL,
    TITLE VARCHAR(255) NOT NULL,
    DESCRIPTION LONGVARCHAR,
    RELEASE_YEAR DATE,
    LANGUAGE_ID TINYINT NOT NULL,
    ORIGINAL_LANGUAGE_ID TINYINT,
    RENTAL_DURATION TINYINT NOT NULL,
    RENTAL_RATE DECIMAL(4, 2) NOT NULL,
    LENGTH SMALLINT,
    REPLACEMENT_COST DECIMAL(5, 2) NOT NULL,
    RATING VARCHAR(5),
    SPECIAL_FEATURES VARCHAR(54),
    LAST_UPDATE TIMESTAMP NOT NULL
);
ALTER TABLE PUBLIC.FILM ADD CONSTRAINT PUBLIC.CONSTRAINT_2 PRIMARY KEY(FILM_ID);
-- 1000 +/- SELECT COUNT(*) FROM PUBLIC.FILM;
CREATE INDEX PUBLIC.IDX_TITLE ON PUBLIC.FILM(TITLE);
CREATE CACHED TABLE PUBLIC.STORE(
    STORE_ID TINYINT NOT NULL,
    MANAGER_STAFF_ID TINYINT NOT NULL,
    ADDRESS_ID SMALLINT NOT NULL,
    LAST_UPDATE TIMESTAMP NOT NULL
);
ALTER TABLE PUBLIC.STORE ADD CONSTRAINT PUBLIC.CONSTRAINT_4 PRIMARY KEY(STORE_ID);
-- 2 +/- SELECT COUNT(*) FROM PUBLIC.STORE;
CREATE CACHED TABLE PUBLIC.INVENTORY(
    INVENTORY_ID INTEGER NOT NULL SELECTIVITY 100,
    FILM_ID SMALLINT NOT NULL SELECTIVITY 20,
    STORE_ID TINYINT NOT NULL SELECTIVITY 1,
    LAST_UPDATE TIMESTAMP NOT NULL SELECTIVITY 1
);
ALTER TABLE PUBLIC.INVENTORY ADD CONSTRAINT PUBLIC.CONSTRAINT_2D PRIMARY KEY(INVENTORY_ID);
-- 4581 +/- SELECT COUNT(*) FROM PUBLIC.INVENTORY;
CREATE CACHED TABLE PUBLIC.STAFF(
    STAFF_ID TINYINT NOT NULL,
    FIRST_NAME VARCHAR(45) NOT NULL,
    LAST_NAME VARCHAR(45) NOT NULL,
    ADDRESS_ID SMALLINT NOT NULL,
    PICTURE LONGVARBINARY,
    EMAIL VARCHAR(50),
    STORE_ID TINYINT NOT NULL,
    ACTIVE BOOLEAN NOT NULL,
    USERNAME VARCHAR(16) NOT NULL,
    PASSWORD VARCHAR(40),
    LAST_UPDATE TIMESTAMP NOT NULL
);
ALTER TABLE PUBLIC.STAFF ADD CONSTRAINT PUBLIC.CONSTRAINT_4B PRIMARY KEY(STAFF_ID);
-- 2 +/- SELECT COUNT(*) FROM PUBLIC.STAFF;
CREATE CACHED TABLE PUBLIC.RENTAL(
    RENTAL_ID INTEGER NOT NULL SELECTIVITY 100,
    RENTAL_DATE TIMESTAMP NOT NULL SELECTIVITY 99,
    INVENTORY_ID INTEGER NOT NULL SELECTIVITY 100,
    CUSTOMER_ID SMALLINT NOT NULL SELECTIVITY 48,
    RETURN_DATE TIMESTAMP SELECTIVITY 99,
    STAFF_ID TINYINT NOT NULL SELECTIVITY 1,
    LAST_UPDATE TIMESTAMP NOT NULL SELECTIVITY 1
);
ALTER TABLE PUBLIC.RENTAL ADD CONSTRAINT PUBLIC.CONSTRAINT_8 PRIMARY KEY(RENTAL_ID);
-- 16044 +/- SELECT COUNT(*) FROM PUBLIC.RENTAL;
CREATE CACHED TABLE PUBLIC.FILM_ACTOR(
    ACTOR_ID SMALLINT NOT NULL SELECTIVITY 3,
    FILM_ID SMALLINT NOT NULL SELECTIVITY 61,
    LAST_UPDATE TIMESTAMP NOT NULL SELECTIVITY 1
);
ALTER TABLE PUBLIC.FILM_ACTOR ADD CONSTRAINT PUBLIC.CONSTRAINT_7 PRIMARY KEY(ACTOR_ID, FILM_ID);
-- 5462 +/- SELECT COUNT(*) FROM PUBLIC.FILM_ACTOR;
CREATE CACHED TABLE PUBLIC.FILM_CATEGORY(
    FILM_ID SMALLINT NOT NULL,
    CATEGORY_ID TINYINT NOT NULL,
    LAST_UPDATE TIMESTAMP NOT NULL
);
ALTER TABLE PUBLIC.FILM_CATEGORY ADD CONSTRAINT PUBLIC.CONSTRAINT_4E PRIMARY KEY(CATEGORY_ID, FILM_ID);
-- 1000 +/- SELECT COUNT(*) FROM PUBLIC.FILM_CATEGORY;
CREATE CACHED TABLE PUBLIC.PAYMENT(
    PAYMENT_ID SMALLINT NOT NULL SELECTIVITY 100,
    CUSTOMER_ID SMALLINT NOT NULL SELECTIVITY 3,
    STAFF_ID TINYINT NOT NULL SELECTIVITY 1,
    RENTAL_ID INTEGER SELECTIVITY 100,
    AMOUNT DECIMAL(5, 2) NOT NULL SELECTIVITY 1,
    PAYMENT_DATE TIMESTAMP NOT NULL SELECTIVITY 98,
    LAST_UPDATE TIMESTAMP NOT NULL SELECTIVITY 1
);
ALTER TABLE PUBLIC.PAYMENT ADD CONSTRAINT PUBLIC.CONSTRAINT_F PRIMARY KEY(PAYMENT_ID);
-- 16049 +/- SELECT COUNT(*) FROM PUBLIC.PAYMENT;
ALTER TABLE PUBLIC.FILM ADD CONSTRAINT PUBLIC.CONSTRAINT_20 FOREIGN KEY(LANGUAGE_ID) REFERENCES PUBLIC.LANGUAGE(LANGUAGE_ID) NOCHECK;
ALTER TABLE PUBLIC.FILM_ACTOR ADD CONSTRAINT PUBLIC.CONSTRAINT_798 FOREIGN KEY(ACTOR_ID) REFERENCES PUBLIC.ACTOR(ACTOR_ID) NOCHECK;
ALTER TABLE PUBLIC.INVENTORY ADD CONSTRAINT PUBLIC.CONSTRAINT_2DA8 FOREIGN KEY(FILM_ID) REFERENCES PUBLIC.FILM(FILM_ID) NOCHECK;
ALTER TABLE PUBLIC.PAYMENT ADD CONSTRAINT PUBLIC.CONSTRAINT_FBE7 FOREIGN KEY(RENTAL_ID) REFERENCES PUBLIC.RENTAL(RENTAL_ID) NOCHECK;
ALTER TABLE PUBLIC.CUSTOMER ADD CONSTRAINT PUBLIC.CONSTRAINT_52 FOREIGN KEY(ADDRESS_ID) REFERENCES PUBLIC.ADDRESS(ADDRESS_ID) NOCHECK;
ALTER TABLE PUBLIC.PAYMENT ADD CONSTRAINT PUBLIC.CONSTRAINT_FBE FOREIGN KEY(CUSTOMER_ID) REFERENCES PUBLIC.CUSTOMER(CUSTOMER_ID) NOCHECK;
ALTER TABLE PUBLIC.RENTAL ADD CONSTRAINT PUBLIC.CONSTRAINT_8F FOREIGN KEY(STAFF_ID) REFERENCES PUBLIC.STAFF(STAFF_ID) NOCHECK;
ALTER TABLE PUBLIC.ADDRESS ADD CONSTRAINT PUBLIC.CONSTRAINT_E6 FOREIGN KEY(CITY_ID) REFERENCES PUBLIC.CITY(CITY_ID) NOCHECK;
ALTER TABLE PUBLIC.CUSTOMER ADD CONSTRAINT PUBLIC.CONSTRAINT_52C FOREIGN KEY(STORE_ID) REFERENCES PUBLIC.STORE(STORE_ID) NOCHECK;
ALTER TABLE PUBLIC.FILM ADD CONSTRAINT PUBLIC.CONSTRAINT_20E FOREIGN KEY(ORIGINAL_LANGUAGE_ID) REFERENCES PUBLIC.LANGUAGE(LANGUAGE_ID) NOCHECK;
ALTER TABLE PUBLIC.FILM_CATEGORY ADD CONSTRAINT PUBLIC.CONSTRAINT_4E8 FOREIGN KEY(FILM_ID) REFERENCES PUBLIC.FILM(FILM_ID) NOCHECK;
ALTER TABLE PUBLIC.STORE ADD CONSTRAINT PUBLIC.CONSTRAINT_4B90 FOREIGN KEY(ADDRESS_ID) REFERENCES PUBLIC.ADDRESS(ADDRESS_ID) NOCHECK;
ALTER TABLE PUBLIC.STAFF ADD CONSTRAINT PUBLIC.CONSTRAINT_4B8C FOREIGN KEY(STORE_ID) REFERENCES PUBLIC.STORE(STORE_ID) NOCHECK;
ALTER TABLE PUBLIC.FILM_CATEGORY ADD CONSTRAINT PUBLIC.CONSTRAINT_4E85 FOREIGN KEY(CATEGORY_ID) REFERENCES PUBLIC.CATEGORY(CATEGORY_ID) NOCHECK;
ALTER TABLE PUBLIC.RENTAL ADD CONSTRAINT PUBLIC.CONSTRAINT_8FD FOREIGN KEY(CUSTOMER_ID) REFERENCES PUBLIC.CUSTOMER(CUSTOMER_ID) NOCHECK;
ALTER TABLE PUBLIC.RENTAL ADD CONSTRAINT PUBLIC.CONSTRAINT_8FDE FOREIGN KEY(INVENTORY_ID) REFERENCES PUBLIC.INVENTORY(INVENTORY_ID) NOCHECK;
ALTER TABLE PUBLIC.FILM_ACTOR ADD CONSTRAINT PUBLIC.CONSTRAINT_79 FOREIGN KEY(FILM_ID) REFERENCES PUBLIC.FILM(FILM_ID) NOCHECK;
ALTER TABLE PUBLIC.INVENTORY ADD CONSTRAINT PUBLIC.CONSTRAINT_2DA FOREIGN KEY(STORE_ID) REFERENCES PUBLIC.STORE(STORE_ID) NOCHECK;
ALTER TABLE PUBLIC.STAFF ADD CONSTRAINT PUBLIC.CONSTRAINT_4B8 FOREIGN KEY(ADDRESS_ID) REFERENCES PUBLIC.ADDRESS(ADDRESS_ID) NOCHECK;
ALTER TABLE PUBLIC.PAYMENT ADD CONSTRAINT PUBLIC.CONSTRAINT_FB FOREIGN KEY(STAFF_ID) REFERENCES PUBLIC.STAFF(STAFF_ID) NOCHECK;
ALTER TABLE PUBLIC.STORE ADD CONSTRAINT PUBLIC.CONSTRAINT_4B9 FOREIGN KEY(MANAGER_STAFF_ID) REFERENCES PUBLIC.STAFF(STAFF_ID) NOCHECK;
ALTER TABLE PUBLIC.CITY ADD CONSTRAINT PUBLIC.CONSTRAINT_1F FOREIGN KEY(COUNTRY_ID) REFERENCES PUBLIC.COUNTRY(COUNTRY_ID) NOCHECK;