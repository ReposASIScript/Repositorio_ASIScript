LOAD DATA
   INFILE 'csv.dat'
   REPLACE INTO TABLE michigan_feature_names
   FIELDS TERMINATED BY ','
   (
   feature_name CHAR OPTIONALLY ENCLOSED BY '"',
   feature_type CHAR,
   county CHAR,
   latitude CHAR,
   longitude CHAR,
   elevation INTEGER EXTERNAL,
   update_time DATE "YYYYMMDDHH24MI"
   )
