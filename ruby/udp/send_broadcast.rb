#!/usr/bin/ruby

require "socket"

udp = UDPSocket.open()
sockaddr = Socket.pack_sockaddr_in(9999, "255.255.255.255")
udp.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, 1)

udp.send("HELLO", 0, sockaddr)

udp.close

