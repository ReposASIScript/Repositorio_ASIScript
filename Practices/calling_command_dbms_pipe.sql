declare
    status number;
BEGIN
    --dbms_pipe.pack_message( 'cmd' );
    dbms_pipe.pack_message( '/u00/abanks9i/dandorra/portafolios/PortafLinux.sh /u00/abanks9i/dandorra/portafolios prueba' );
    status := dbms_pipe.send_message( 'HOST_PIPE' );
    IF ( status <> 0 ) THEN
      raise_application_error( -20001, 'Pipe error' );
    ELSE
      dbms_output.put_line(status);
    END IF;
end;