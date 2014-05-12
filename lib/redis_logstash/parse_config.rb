module RedisLogstash
  class ParseConfig

    @@config = nil

    class << self

      def get
        @@config ||= YAML.load_file('config/redis_logstash.yml')[Rails.env].with_indifferent_access
      end

    end


  end
end