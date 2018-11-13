LOAD DATA
INFILE 'coll_obj.dat'
TRUNCATE INTO TABLE features
   (
   feature_id SEQUENCE (COUNT,1),
   feature COLUMN OBJECT
      (
      feature_name POSITION (1:27) CHAR,
      feature_elevation POSITION (29:32) INTEGER EXTERNAL,
      feature_type POSITION (34:39) CHAR
      ),
   modification_date SYSDATE
   )
