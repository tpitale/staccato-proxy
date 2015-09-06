module Staccato::Proxy
  class Listener
    include Celluloid::IO

    FRAME_SIZE = 4096

    def initialize(host, port, debug = false)
      @socket = UDPSocket.new.tap {|s| s.bind(host, port)}
      @debug = debug

      async.run
    end

    def finalize
      @socket.close if @socket
    end

    def run
      loop {async.receive(@socket.recvfrom(FRAME_SIZE))}
    end

    def receive(data)
      debug data
      sender.async.submit(data[0])
    end

    def sender
      Celluloid::Actor[:staccato_proxy_sender]
    end

    def log(msg)
      Celluloid.logger.info(msg)
    end

    def debug(msg)
      log(msg) if @debug
    end
  end
end
