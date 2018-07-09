require 'json'

require 'ranger/events/base'
require 'ranger/events/private'

module Ranger
  module Events
    def self.subscribe!
      puts '[INFO] Starting to listen the queues...'
      Private.subscribe!
    end

    class SocketHandler
      @@all = []

      class <<self
        def all
          pp @@all
        end
      end

      def initialize(socket, id)
        @socket = socket
        @id = id
        @@all << self
      end

      def send_payload(message)
        @socket.send message
      end
    end
  end
end