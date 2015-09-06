module Staccato::Proxy
  class Supervisor
    attr_reader :options

    def initialize(options)
      @options = options
      @group = Celluloid::Supervision::Container.run!
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
      @group.supervise(as: :staccato_proxy_listener, type: Staccato::Proxy::Listener, args: [host, port, debug?])
      @group.supervise(as: :staccato_proxy_sender, type: Staccato::Proxy::Sender, args: [url, debug?])
      self
    end

    def terminate
      @group.terminate
    end
  end
end
