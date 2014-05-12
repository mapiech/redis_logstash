# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'redis_logstash/version'

Gem::Specification.new do |spec|
  spec.name          = "redis_logstash"
  spec.version       = RedisLogstash::VERSION
  spec.authors       = ["Marek Piechocki"]
  spec.email         = ["work@marek-piechocki.pl"]
  spec.summary       = "Ruby logger that writes directly to LogStash via redis server"
  spec.description   = "LogStash Logger for ruby"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_dependency "redis"

end
