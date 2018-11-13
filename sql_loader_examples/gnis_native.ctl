LOAD DATA
   INFILE gnis_native.dat "FIX 326"
   TRUNCATE INTO TABLE gnis   (
   gfn_state_abbr POSITION (1) VARCHAR,
   gfn_feature_name POSITION (5) VARCHAR,
   gfn_feature_type POSITION (67) VARCHAR,
   gfn_county_name POSITION (109) VARCHAR,
   gfn_fips_state_code POSITION (151) INTEGER,
   gfn_fips_county_code POSITION (155) SMALLINT,
   gfn_primary_latitude_dms POSITION (157) VARCHAR,
   gfn_primary_longitude_dms POSITION (179) VARCHAR,
   gfn_primary_latitude_dec POSITION (201) FLOAT,
   gfn_primary_longitude_dec POSITION (205) DOUBLE,
   gfn_source_latitude_dms FILLER POSITION (213) VARCHAR,
   gfn_source_longitude_dms FILLER POSITION (235) VARCHAR,
   gfn_source_latitude_dec FILLER POSITION (257) DOUBLE,
   gfn_source_longitude_dec FILLER POSITION (265) DOUBLE,
   gfn_elevation POSITION (273) DOUBLE,
   gfn_population POSITION (281) INTEGER,
   gfn_cell_name POSITION (285) VARCHAR
   )
