require "socket"

udps = UDPSocket.open()

udps.bind("0.0.0.0", 3162)

p udps.recv(65535)

udps.close
