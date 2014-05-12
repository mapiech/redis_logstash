module RedisLogstash
  class Logger
    class << self

      def write(hash)
        Socket.write(hash)
      end

    end
  end
end

