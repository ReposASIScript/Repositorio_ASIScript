 LOAD DATA
   INFILE 'keweenaw_county_fixed.dat'
      BADFILE 'keweenaw_county_fixed.bad'
      DISCARDFILE 'keweenaw_county_fixed.dsc'
   INFILE 'alger_county_fixed.dat'
      BADFILE 'alger_county_fixed.bad'
      DISCARDFILE 'alger_county_fixed.dsc'
   APPEND INTO TABLE school
      WHEN (feature_type='school')
   (
   state POSITION(1) CHAR(2),
   school_name POSITION(4) CHAR(50),
   feature_type FILLER POSITION(55) CHAR(9),
   county POSITION(65) CHAR(15)
   )
   INTO TABLE airport
      WHEN (feature_type='airport')
   (
   state POSITION(1) CHAR(2),
   airport_name POSITION(4) CHAR(50),
   feature_type FILLER POSITION(55) CHAR(9),
   county POSITION(65) CHAR(15)
   )

