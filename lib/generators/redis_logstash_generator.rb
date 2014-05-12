class RedisLogstashGenerator < Rails::Generators::Base

  source_root File.expand_path("../templates", __FILE__)

  desc 'Creating config file for redis logstash'
  def config
    template "redis_logstash.yml", 'config/redis_logstash.yml'
  end

end