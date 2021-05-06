#!/usr/bin/ruby

require "socket"

PORT = 9999
BROADCAST_ADDR = "255.255.255.255"
UNICAST_ADDR = "192.168.100.25"

udp = UDPSocket.open()
udp.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, 1)
index = 0

while true do
    if index % 2 == 0
        # ブロードキャスト
        sockaddr = Socket.pack_sockaddr_in(PORT, BROADCAST_ADDR)
        type = "BROADCAST"
    else
        # ユニキャスト
        sockaddr = Socket.pack_sockaddr_in(PORT, UNICAST_ADDR)
        type = "UNICAST"
    end
    msg = "#{index},#{type}"
    udp.send(msg, 0, sockaddr)
    print "#{msg}\n"
    index += 1
    sleep 0.5
end

udp.close

