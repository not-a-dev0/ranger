require 'eventmachine'
require 'em-websocket'

require 'ranger/rabbit'
require 'ranger/events'

module Ranger
  def run!
    puts '[INFO] Starting the server'

    EM.run do
      Rabbit::Connection.new(host: '0.0.0.0')
      Events.subscribe!

      EM::WebSocket.start(host: '0.0.0.0', port: 8081) do |ws|
        ws.onopen do |id|
          ws.instance_variable_set(:@connection_handler, Events::SocketHandler.new(ws, id))
        end

        ws.onclose { puts "Connection closed" }

        ws.onmessage do |msg|
          puts "Recieved message: #{msg}"
          ws.send "Pong: #{msg}"
        end
      end
    end
  end

  module_function :run!
end