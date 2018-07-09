module Ranger::Events
  class Private < Base
    def self.subscribe!
      events_type 'market'

      watch('eurusd.order_created') do |payload, metadata|
        puts '[DEBUG] got a new order'
        SocketHandler.all.each do |s|
          s.send_payload payload
        end
      end

      watch('eurusd.order_canceled') do |payload, metadata|
        puts '[DEBUG] order canceled'
        SocketHandler.all.each do |s|
          s.send_payload payload
        end
      end

      watch('eurusd.trade_completed') do |payload, metadata|
        puts '[DEBUG] got a new trade'
        SocketHandler.all.each do |s|
          s.send_payload payload
        end
      end
    end
  end
end
