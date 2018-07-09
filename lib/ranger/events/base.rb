require 'ranger/rabbit'
require 'ranger/rabbit/connection'

module Ranger::Events
  class Base < EM::Connection
    class <<self
      def events_type(type)
        @events_type = ['peatio.events', type].join('.')
        @exchange = Ranger::Rabbit::Connection.channel.direct(@events_type)
      end

      def watch(route, &block)
        bind_queue_for(route).subscribe do |metadata, payload|
          puts "[DEBUG] #{JSON.parse(payload).to_json}"
          block.call(payload, metadata)
        end
      end

    protected

      def bind_queue_for(route)
        Ranger::Rabbit::Connection.channel.queue(name_for(route)).bind(@exchange, routing_key: route)
      end

      def name_for(route)
        [@events_type, route].join('.')
      end
    end
  end
end