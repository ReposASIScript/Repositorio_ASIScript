BEGIN
  DBMS_SCHEDULER.create_program
  (program_name        => 'Prueba',
   program_type        => 'EXECUTABLE',
   program_action      => '/u00/abanks9i/dandorra/PortafLinux.sh',
   number_of_arguments => 0,
   enabled             => TRUE,
   comments            => 'Creacion de carpeta por medio de script linux');
END;