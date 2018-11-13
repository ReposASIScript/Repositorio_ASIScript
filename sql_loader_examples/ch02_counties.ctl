LOAD DATA
INFILE 'alger_county_fixed.dat'
INFILE 'keweenaw_county_fixed.dat'
INTO TABLE temp_gnis_county
   TRUNCATE
   (
   gc_state_abbr POSITION (1:2) CHAR,
   gc_county_name POSITION (65:80) CHAR
   )
INTO TABLE gfn_gnis_feature_names
   TRUNCATE
   (
   gfn_state_abbr POSITION (1:2) CHAR,
   gfn_feature_name POSITION (4:54) CHAR,
   gfn_feature_type POSITION (55:64) CHAR,
   gfn_county_name POSITION (65:80) CHAR
   )

