require 'socket'
require 'net/http'
require 'webrick'
require 'test/unit'
require_relative 'handle_client'


# MAIN
def main
  if ARGV[0].nil?
    abort 'Usage: ruby web_server.rb [port_number]'
  else
    puts "Web server starting on port #{ARGV[0]}"
  end

  server = TCPServer.open(ARGV[0])

  loop {
    Thread.start(server.accept) do |client|
      handle_client(client)
    end
  }
end

main