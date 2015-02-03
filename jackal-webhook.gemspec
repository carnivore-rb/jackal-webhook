$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'jackal-webhook/version'
Gem::Specification.new do |s|
  s.name = 'jackal-webhook'
  s.version = Jackal::Webhook::VERSION.version
  s.summary = 'Message processing helper'
  s.author = 'Chris Roberts'
  s.email = 'code@chrisroberts.org'
  s.homepage = 'https://github.com/carnivore-rb/jackal-webhook'
  s.description = 'Webhook injection point'
  s.require_path = 'lib'
  s.license = 'Apache 2.0'
  s.add_dependency 'jackal'
  s.add_dependency 'carnivore-http'
  s.files = Dir['lib/**/*'] + %w(jackal-webhook.gemspec README.md CHANGELOG.md CONTRIBUTING.md LICENSE)
end
