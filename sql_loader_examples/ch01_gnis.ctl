LOAD DATA
   APPEND INTO TABLE gfn_gnis_feature_names
   (
   gfn_state_abbr CHAR TERMINATED BY "," ENCLOSED BY '"',
   gfn_feature_name CHAR TERMINATED BY "," ENCLOSED BY '"',
   gfn_feature_type CHAR TERMINATED BY "," ENCLOSED BY '"',
   gfn_county_name CHAR TERMINATED BY "," ENCLOSED BY '"',
   gfn_fips_state_code FILLER INTEGER EXTERNAL
      TERMINATED BY "," ENCLOSED BY '"',
   gfn_fips_county_code FILLER INTEGER EXTERNAL
      TERMINATED BY "," ENCLOSED BY '"',
   gfn_primary_latitude_dms CHAR TERMINATED BY "," ENCLOSED BY '"',
   gfn_primary_longitude_dms CHAR TERMINATED BY "," ENCLOSED BY '"',
   gfn_primary_latitude_dec FILLER DECIMAL EXTERNAL
      TERMINATED BY "," ENCLOSED BY '"',
   gfn_primary_longitude_dec FILLER DECIMAL EXTERNAL
      TERMINATED BY "," ENCLOSED BY '"',
   gfn_source_latitude_dms FILLER CHAR
      TERMINATED BY "," ENCLOSED BY '"',
   gfn_source_longitude_dms FILLER CHAR
      TERMINATED BY "," ENCLOSED BY '"',
   gfn_source_latitude_dec FILLER DECIMAL EXTERNAL
      TERMINATED BY "," ENCLOSED BY '"',
   gfn_source_longitude_dec FILLER DECIMAL EXTERNAL
      TERMINATED BY "," ENCLOSED BY '"',
   gfn_elevation DECIMAL EXTERNAL
      TERMINATED BY "," ENCLOSED BY '"',
   gfn_population INTEGER EXTERNAL
      TERMINATED BY "," ENCLOSED BY '"',
   gfn_cell_name CHAR TERMINATED BY "," ENCLOSED BY '"'
   )

