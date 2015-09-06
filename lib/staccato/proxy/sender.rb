module Staccato::Proxy
  class Sender
    include Celluloid

    def initialize(url)
      @url = url
    end

    def submit(data)
      # data should already be form encoded with `URI.encode_www_form`
      ::HTTP.post(@url, :body => data, socket_class: Celluloid::IO::TCPSocket)
    end
  end
end
