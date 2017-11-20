require 'net/http'
require 'json'

class Main
  require_relative 'PostgresDatabase'
  require_relative 'UbuntuServer'

  database = PostgresDatabase.new('192.168.0.20', 'postgres', 'sysadmin', 'admin')
  database.conn_database

  server = UbuntuServer.new('192.168.0.20', 'diana', 'root')

  APIKEY = "2e18b33adc5e65668fccb54ab1c63fdc"
  url = "http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=#{APIKEY}"
  uri = URI(url)

  call_api = true

  while call_api do

    second_start = Time.now.to_i
    data_local = `syslog`
    insert_data_local = "INSERT INTO DATABASE (data) VALUES ('#{data_local.gsub("'","")}');"
    database.query(insert_data_local)
    insert_log_local = "INSERT INTO LOG (ACTION) VALUES ('Dato de máquina insertado');"
    database.query(insert_log_local)

    second_review = Time.now.to_i
    if second_start < second_review
      response = Net::HTTP.get(uri)
      data_api = JSON.parse(response)
      insert_data_api = "INSERT INTO DATABASE (data) VALUES ('#{data_api}');"
      database.query(insert_data_api)
      insert_log_api = "INSERT INTO LOG (ACTION) VALUES ('Dato de API insertado');"
      database.query(insert_log_api)
    end

  time = Time.now
  server.conn_server(time)

  end

end