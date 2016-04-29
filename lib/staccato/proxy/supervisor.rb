module Staccato::Proxy
  class Supervisor
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def host
      options.fetch(:host, '0.0.0.0')
    end

    def port
      options.fetch(:port, 9090)
    end

    def url
      options.fetch(:url, GA_COLLECTION_URL)
    end

    def debug?
      options.fetch(:debug, false)
    end

    def run
      config.deploy
      self
    end

    def terminate
      config.shutdown
    end

    private
    def config
      @config ||= Celluloid::Supervision::Configuration.define([
        {
          type: Staccato::Proxy::Listener, as: :staccato_proxy_listener, args: [host, port, debug?]
        },
        {
          type: Staccato::Proxy::Sender, as: :staccato_proxy_sender, args: [url, debug?]
        }
      ])
    end
  end
end
