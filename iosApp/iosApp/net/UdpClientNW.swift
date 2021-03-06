//
//  UdpClientNW.swift
//  iosApp
//


import Foundation
import Network

class UdpClientNW {
    private var nwListener: NWListener!
    private let queue = DispatchQueue(label: "UdpClient")

    func bind(port: Int) {
        let nwPort = NWEndpoint.Port(rawValue: UInt16(port))!
        let listener = try! NWListener(using: .udp, on: nwPort)
        nwListener = listener
        listener.newConnectionHandler = { [unowned self] (connection: NWConnection) in
            connection.start(queue: queue)
            self.receive(on: connection)
        }
        listener.start(queue: queue)
    }

    func close() {
        nwListener.cancel()
    }

    private func receive(on connection: NWConnection) {
        connection.receiveMessage(completion: {(data, context, isComplete, error) in
            if let error = error {
                print("error: \(error)")
                return
            }
            if let data = data {
                print("data: \(data)")
            }
        })
    }
}
