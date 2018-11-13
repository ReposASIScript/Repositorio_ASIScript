LOAD DATA
INFILE 'coll_nest2.dat'
TRUNCATE INTO TABLE feature_counts
   (
   county CHAR TERMINATED BY ',' ENCLOSED BY '"',
   array_count FILLER INTEGER EXTERNAL TERMINATED BY ',',
   array_file FILLER CHAR TERMINATED BY ',',
   feature_count VARRAY
      SDF (array_file) COUNT(array_count)
      (
      feature_counts COLUMN OBJECT
         (
         feature_type CHAR TERMINATED BY ':',
         occurs INTEGER EXTERNAL TERMINATED BY ':'
         )
      ),
   state CHAR TERMINATED BY ','
   )
