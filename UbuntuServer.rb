=begin
  Se realiza la conexión al servidor (Ubuntu server).
  Se revisa el porcentaje de utilización del disco,
  si este ha llegado a 90%, se seleccionan los datos
  que se insertaron de primero, se guardan en un archivo de texto en la máquina local
  y se eliminan de la base de datos, dejando sólo los últimos archivos insertados.
=end


require 'net/ssh'
require_relative 'PostgresDatabase'

class UbuntuServer

  def initialize(host, user, password)

    @host_server = host
    @user_server = user
    @password_server = password

  end

  def conn_server(id_txt)

    Net::SSH.start(@host_server, @user_server, :password => @password_server) do |ssh|

      size = ssh.exec!("df -h /dev/mapper/serverDatabase--vg-root | tr -dc '0-9'")
      percent_used = size[-2,2]

      puts "Percent used: #{percent_used}%"

      result_array = []
      if percent_used.to_i > 90

          query_sql = PostgresDatabase.new('192.168.1.28', 'postgres', 'sysadmin', 'admin')

          result = query_sql.query("SELECT * FROM DATABASE ORDER BY ID ASC LIMIT 5000")
          result.each do |row|
            result_array.push(row)
          end
          File.open("/Users/DianaCM/Documents/dataAdmin/data#{id_txt}.txt", "w") { |file| file.write(result_array) }
          query_sql.query("DELETE FROM DATABASE WHERE ID IN (SELECT ID FROM DATABASE ORDER BY ID ASC LIMIT 5000)")
          ssh.exec!("sudo du -sh /var/cache/apt/archives")
          move_data = "INSERT INTO LOG (ACTION) VALUES ('Se han movido los datos para liberar espacio');"
          database.query(move_data)
      end

    end

  end

end