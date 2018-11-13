DECLARE
  l_file utl_file.file_type;
BEGIN
  l_file := utl_file.fopen( '&nombre_directorio', 'some_new_file_name.txt', 'W' );
  utl_file.put_line( l_file, 'Here is some text' );
  utl_file.fclose( l_file );
END;
/

DECLARE
  l_exists     boolean;
  l_size       integer;
  l_block_size integer;
BEGIN
  utl_file.fgetattr( '&nombre_directorio', 
                     'some_new_file_name.txt', 
                     l_exists, 
                     l_size, 
                     l_block_size );
   if( l_exists )
   then
     dbms_output.put_line( 'The file exists and has a size of ' || l_size );
   else
     dbms_output.put_line( 'The file does not exist or is not visible to Oracle' );
   end if;
END;
/