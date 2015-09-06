module Staccato::Proxy
  class Supervisor
    attr_reader :options

    def initialize(options)
      @options = options
      @group = Celluloid::SupervisionGroup.run!
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
      @group.supervise_as(:staccato_proxy_listener, Staccato::Proxy::Listener, host, port, debug?)
      @group.supervise_as(:staccato_proxy_sender, Staccato::Proxy::Sender, url, debug?)
      self
    end

    def terminate
      @group.terminate
    end
  end
end
