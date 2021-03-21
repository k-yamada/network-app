import io.ktor.network.selector.*
import io.ktor.network.sockets.*
import io.ktor.utils.io.core.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import java.net.InetSocketAddress

fun main(args: Array<String>) {
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
