LOAD DATA
INFILE 'coll_inline.dat'
TRUNCATE INTO TABLE feature_counts
   (
   county CHAR TERMINATED BY ',' ENCLOSED BY '"',
   feature_count VARRAY TERMINATED BY ','
      (
      dummy_name COLUMN OBJECT
         (
         feature_type CHAR TERMINATED BY ':',
         occurs INTEGER EXTERNAL TERMINATED BY ':'
         )
      ),
   state CHAR TERMINATED BY ','
   )
