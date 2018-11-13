DECLARE
  TYPE population_type IS TABLE OF NUMBER INDEX BY VARCHAR2(64);
  country_population population_type;
  continent_population population_type;
  HOWMANY NUMBER;
  which VARCHAR2(64);

BEGIN
  country_population('Greenland') := 100000;
  country_population('Iceland') := 750000;
  howmany := country_population('Greenland');

  continent_population('Australia') := 30000000;
  continent_population('Antarctica') := 1000; -- Creates new entry
  CONTINENT_POPULATION('Antarctica') := 1001; -- Replaces previous 
--value
  WHICH := CONTINENT_POPULATION.FIRST; -- Returns 'Antarctica'
  dbms_output.put_line('which1 = '||which);
-- as that comes first alphabetically.
  WHICH := CONTINENT_POPULATION.LAST; -- Returns 'Australia'
  dbms_output.put_line('which2 = '||which);  
  HOWMANY := CONTINENT_POPULATION(CONTINENT_POPULATION.LAST);
  dbms_output.put_line('howmany = '||HOWMANY);  
-- Returns the value corresponding to the last key, in this
-- case the population of Australia.
EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm);
END;
/