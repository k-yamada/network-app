#!/usr/bin/ruby

require "socket"

udp = UDPSocket.open()
sockaddr = Socket.pack_sockaddr_in(9999, "192.168.100.25")

udp.send("HELLO", 0, sockaddr)

udp.close

