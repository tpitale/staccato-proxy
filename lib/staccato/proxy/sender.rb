module Staccato::Proxy
  class Sender
    include Celluloid

    def initialize(url, debug = false)
      @url = url
      @debug = debug
    end

    def submit(data)
      debug data
      # data should already be form encoded with `URI.encode_www_form`
      ::HTTP.post(@url, :body => data, socket_class: Celluloid::IO::TCPSocket)
    end

    def log(msg)
      Celluloid.logger.info(msg)
    end

    def debug(msg)
      log(msg) if @debug
    end
  end
end
