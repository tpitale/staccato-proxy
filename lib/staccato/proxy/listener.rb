module Staccato::Proxy
  class Listener
    include Celluloid::IO

    FRAME_SIZE = 4096

    def initialize(host, port)
      @socket = UDPSocket.new.tap {|s| s.bind(host, port)}
      async.run
    end

    def finalize
      @socket.close if @socket
    end

    def run
      loop {receive!(@socket.recvfrom(FRAME_SIZE))}
    end

    def receive(data)
      sender.async.submit(data)
    end

    def sender
      Celluloid::Actor[:staccato_proxy_sender]
    end

    def log(msg)
      Celluloid.logger.info(msg)
    end
  end
end
