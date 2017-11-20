Proyecto II: Administración de Base de datos

Nombre: Diana Camacho Mendoza
Profesor: Maikol Arguedas

Tecnologías utilizadas

    - Base de datos: PostgreSQL
    - Máquina virtual (en virtualBox)
    - Sistema operativo VM: Ubuntu server
    - Lenguaje: Ruby
    - GCI

Proceso

    - La máquina virtual tiene Ubuntu server como sistema operativo.
    - En dicha máquina se tiene instalada la base de datos PostgreSQL.
    - En la base de datos existe una tabla llamada DATABASE, la cual contiene un
      identificador, fecha del registro, y el dato.
    - También existe una tabla llamada LOG, en donde se registran las actividades
      llevadas a cabo en la base de datos (insert, y movimiento de datos).
    - El programa encargado de gestionar el sistema está hecho con Ruby.
    - Este programa revisa constantemente el tamaño del disco, cuando se ha utilizado
      un 90% se procede a mover los primeros datos insertados a un archivo de texto plano;
      para liberar espacios para los nuevos datos entrantes.
    - Los datos provienen de un API de clima y del syslog de la máquina local.
    - En el servidor, se habilita en CGI con el fin de mostrar el LOG e información sobre
      el tamaño del disco, en el dashboard.
