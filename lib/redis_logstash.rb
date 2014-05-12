require 'redis'
require 'zlib'
require 'stringio'
require 'json'

require "redis_logstash/version"
require 'redis_logstash/logger'
require 'redis_logstash/socket'
require 'redis_logstash/parse_config'
require 'redis_logstash/action_controller_ext'


ActionController::Base.send :include, RedisLogstash::ActionControllerExt
ActionController::Base.send :around_filter, :redis_logstash