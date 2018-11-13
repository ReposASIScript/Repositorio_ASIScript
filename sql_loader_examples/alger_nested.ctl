LOAD DATA
   INFILE 'alger_nested.dat'
   REPLACE INTO TABLE michigan_features
   (
   feature_name  POSITION (4:26) CHAR,
   lat_degrees   POSITION (29) INTEGER EXTERNAL TERMINATED BY '°',
   lat_minutes   INTEGER EXTERNAL TERMINATED BY "'",
   lat_seconds   INTEGER EXTERNAL TERMINATED BY "''",
   blank_space_1 FILLER CHAR(1),
   lat_direction CHAR(1) TERMINATED BY ',',
   lon_degrees   INTEGER EXTERNAL TERMINATED BY '°',
   lon_minutes   INTEGER EXTERNAL TERMINATED BY "'",
   lon_seconds   INTEGER EXTERNAL TERMINATED BY "''",
   blank_space_2 FILLER CHAR(1),
   lon_direction CHAR(1),
   feature_type  POSITION (61:66) CHAR,
   county        POSITION (68:72) CHAR
   )

