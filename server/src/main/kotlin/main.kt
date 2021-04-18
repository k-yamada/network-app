import io.ktor.network.selector.*
import io.ktor.network.sockets.*
import io.ktor.util.network.*
import io.ktor.utils.io.core.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.runBlocking
import java.net.InetSocketAddress

fun main(args: Array<String>) {
    //unicast()
    broadcast()
}

fun broadcast() {
    runBlocking {
        while (true) {
            val clientSocket = aSocket(ActorSelectorManager(Dispatchers.IO))
                .udp()
                .bind {
                    broadcast = true
                }
            println("1")
            clientSocket.use { socket ->
                println("2")
                socket.send(
                    Datagram(
                        packet = buildPacket { writeText("0123456789") },
                        address = NetworkAddress("255.255.255.255", 2323)
                    )
                )
                println("3")
            }
            delay(1000)
        }
    }
}

fun unicast() {
    runBlocking {
        val server = aSocket(ActorSelectorManager(Dispatchers.IO)).udp().bind(InetSocketAddress("127.0.0.1", 2323))
        println("Started echo udp server at ${server.localAddress}")

        while (true) {
            val input = server.receive()
            val address = input.address

            // read
            val read = input.packet.readText()
            println(read)

            // send
            val bytePacketBuilder = BytePacketBuilder()
            bytePacketBuilder.writeText(read)
            val bytePacket = bytePacketBuilder.build()
            server.outgoing.send(Datagram(bytePacket, address))
        }
    }
}
