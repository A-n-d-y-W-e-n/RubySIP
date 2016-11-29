#!/usr/bin/env ruby
require './sip'
require 'socket'

class SIPServer
	def initialize port
		sockfd = UDPSocket.new
		sockfd.bind('', port)
		while true
			(msg, addr) = sockfd.recvfrom MAXLEN
			response = Request.new.parse(msg).process
			sockfd.send(response, 0, addr[3], addr[1]) if response != nil
			$usertable.each {|user| puts user.inspect}
			puts ''
		end
	end
end

SIPServer.new 5060
