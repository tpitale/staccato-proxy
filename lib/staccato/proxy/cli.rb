module Staccato::Proxy
  class CLI
    def initialize(args)
      @options = parse_options(args)
    end

    def run
      Staccato::Proxy::Supervisor.new(@options).run
    end

    private
    def parse_options(args)
      {}.tap do |options|
        OptionParser.new do |parser|
          parser.banner = [
            "Usage: #{@name} --help\n"
          ].compact.join

          parser.on('--debug') do
            options[:debug] = true
          end

          # parser.on('-c', '--config FILE') do |path|
          #   options[:config_path] = path
          # end

          # parser.on("-l", "--log FILE") do |path|
          #   options[:log_path] = path
          # end

          parser.on_tail("-?", "--help", "Display this usage information.") do
            puts "#{parser}\n"
            exit
          end
        end.parse!(args)
      end
    end
  end
end
