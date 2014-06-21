module Staccato::Proxy
  class Sender
    include Celluloid

    def initialize(url)
      @url = url
    end

    def submit(data)
      ::HTTP.post(@url, :body => data, socket_class: Celluloid::IO::TCPSocket)
    end
  end
end
