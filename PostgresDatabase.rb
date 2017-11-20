=begin
  Se realiza la conexión a la base de datos PostgreSQL, la cual está la MV.
  Se tiene un método que recibe los string con los comandos SQL a ejecutar.
=end

require 'pg'

$connection

class PostgresDatabase

  def initialize(host, dbname, user, password)

    @host_address = host
    @db_name = dbname
    @db_user = user
    @db_password = password

  end

  def conn_database()

    $connection = PG::Connection.open(:host => @host_address, :dbname => @db_name,
                                      :user => @db_user, :password => @db_password)

    rescue PG::Error => e
      puts e.message

  end

  def query(the_query)
    command = $connection.exec(the_query)
    return command

  end

end
