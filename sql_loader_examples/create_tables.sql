SET ECHO ON

CREATE TABLE gfn_gnis_feature_names (
    gfn_state_abbr            CHAR(2),
    gfn_feature_name          VARCHAR2(80),
    gfn_feature_type          VARCHAR2(9),
    gfn_county_name           VARCHAR2(60),
    gfn_primary_latitude_dms  VARCHAR2(7),
    gfn_primary_longitude_dms VARCHAR2(8),
    gfn_elevation             NUMBER,
    gfn_population            NUMBER,
    gfn_cell_name             VARCHAR2(60)
    );

CREATE TABLE temp_gnis_county (
    gc_state_abbr            CHAR(2),
    gc_county_name           VARCHAR2(60)
    );

CREATE TABLE gc_gnis_county (
    gc_state_abbr            CHAR(2),
    gc_county_name           VARCHAR2(60)
    );

CREATE TABLE numeric_external_test (
    a NUMBER,
    b NUMBER,
    c NUMBER,
    d NUMBER
    );

CREATE TABLE book_prices (
    book_title VARCHAR2(30),
    book_price NUMBER(4,2)
    );

CREATE TABLE michigan_features (
   feature_name VARCHAR2(44),
   elevation NUMBER,
   feature_type VARCHAR2(10),
   county VARCHAR2(5),
   short_feature_name VARCHAR2(10),
   lat_degrees NUMBER,
   lat_minutes NUMBER,
   lat_seconds NUMBER,
   lat_direction CHAR,
   lon_degrees NUMBER,
   lon_minutes NUMBER,
   lon_seconds NUMBER,
   lon_direction CHAR
);

CREATE TABLE michigan_feature_names (
   feature_name VARCHAR2(44),
   elevation NUMBER,
   population NUMBER,
   feature_type VARCHAR2(10),
   county VARCHAR2(15),
   short_feature_name VARCHAR2(10),
   latitude VARCHAR2(15),
   longitude VARCHAR2(15),
   update_time DATE
);

CREATE TABLE school (
   state CHAR(2),
   school_name VARCHAR2(80),
   county VARCHAR2(60)
   );

CREATE TABLE airport (
   state CHAR(2),
   airport_name VARCHAR2(80),
   county VARCHAR2(60)
   );

CREATE TABLE book (
   book_id NUMBER,
   book_title VARCHAR2(35),
   book_price NUMBER,
   book_pages NUMBER,
   CONSTRAINT book_pk
      PRIMARY KEY (book_id)
   );

CREATE SEQUENCE book_seq
   START WITH 1
   INCREMENT BY 1
   NOMAXVALUE
   NOCYCLE;

CREATE TABLE waterfalls (
   state CHAR(2),
   county VARCHAR2(60),
   falls_name VARCHAR2(80),
   falls_description CLOB,
   falls_photo BLOB,
   falls_directions CLOB,
   falls_web_page BFILE
);

CREATE OR REPLACE TYPE feature_type AS OBJECT (
   feature_name VARCHAR2(60),
   feature_type VARCHAR2(12),
   feature_elevation NUMBER
   );
/
CREATE TABLE features (
   feature_id NUMBER,
   feature feature_type,
   modification_date DATE
   );

CREATE OR REPLACE TYPE feature_count_type AS OBJECT (
   feature_type VARCHAR2(60),
   occurs INTEGER
   );
/

CREATE OR REPLACE TYPE feature_count_array
   AS VARRAY(10) of feature_count_type;
/

CREATE TABLE feature_counts (
   state VARCHAR2(2),
   county VARCHAR2(20),
   feature_count feature_count_array
   );

CREATE TABLE gnis (
    gfn_state_abbr      CHAR(2),
    gfn_feature_name    VARCHAR2(80),
    gfn_feature_type    VARCHAR2(9),
    gfn_county_name     VARCHAR2(60),
    gfn_fips_state_code NUMBER,
    gfn_fips_county_code NUMBER,
    gfn_primary_latitude_dms    CHAR(7),
    gfn_primary_longitude_dms   CHAR(8),
    gfn_primary_latitude_dec NUMBER,
    gfn_primary_longitude_dec NUMBER,
    gfn_elevation        NUMBER(7,2),
    gfn_population       NUMBER(10),
    gfn_cell_name        VARCHAR2(30)
    );

