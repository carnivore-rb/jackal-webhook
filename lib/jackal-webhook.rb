require 'jackal'
require 'carnivore-http'

module Jackal
  module Webhook
    autoload :Hook, 'jackal-webhook/hook'
  end
end

require 'jackal-webhook/version'
