require 'optparse'
require 'http'
require 'celluloid/current'
require 'celluloid/io'

require "staccato/proxy/version"

module Staccato
  module Proxy
    GA_COLLECTION_URL = 'http://www.google-analytics.com/collect'
  end
end

require 'staccato/proxy/listener'
require 'staccato/proxy/sender'
require 'staccato/proxy/supervisor'
