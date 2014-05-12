module RedisLogstash
  class Socket

    @@socket = nil

    attr_accessor :redis, :redis_key, :options

    class << self
      def get
        @@socket ||= new
      end

      def write(json)
        get.push(json)
      end
    end


    def initialize
      self.options = ParseConfig.get[:redis]

      host = options[:host] || '127.0.0.1'
      port = options[:port] || 6379
      password = options[:password] || nil

      self.redis_key = options[:key] || 'logstash'
      self.redis = password ? ::Redis.new(host: host, port: port, password: password) : ::Redis.new(host: host, port: port)

    end

    def push(json)
      begin

        puts "#{{type: options[:type], message: json.to_json}.to_json}"

        unless redis.rpush(redis_key, {type: options[:type], message: json.to_json}.to_json)
          raise "could not send event to redis"
        end
      rescue ::Redis::InheritedError
        redis.client.connect
        retry
      end
    end

  end
end