require 'amqp'

module Ranger
  module Rabbit
    class Connection
      class <<self
        attr_reader :channel

        def new(options = {})
          @connection = AMQP.connect(options)
          @channel = AMQP::Channel.new(@connection)
        end
      end
    end
  end
end