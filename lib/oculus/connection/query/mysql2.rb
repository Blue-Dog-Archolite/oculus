require 'mysql2'

module Oculus
  module Connection
    module Query
      class Mysql2
        def initialize(options = {})
          @connection = ::Mysql2::Client.new(options)
        end

        def execute(sql)
          results = @connection.query(sql)
          [results.fields] + results.map(&:values) if results
        rescue ::Mysql2::Error => e
          raise Connection::Error.new(e.message)
        end

        def kill(id)
          execute("KILL QUERY #{id}")
        end

        def thread_id
          @connection.thread_id
        end
      end
    end
  end
end
