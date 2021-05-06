//
//  UdpClientGCDAsync.swift
//  iosApp
//
//  Created by Kazuhiro Yamada on 2021/05/06.
//  Copyright © 2021 orgName. All rights reserved.
//

import Foundation
import Foundation
import CocoaAsyncSocket


class UdpClientGCDAsync: NSObject {
    private var socket: GCDAsyncUdpSocket!
    private var port: UInt16!
    private var lastIndex = -1

    func bind(port: Int) {
        self.port = UInt16(port)
        socket = GCDAsyncUdpSocket(delegate: self, delegateQueue: DispatchQueue.main)
        do {
            try socket.enableReusePort(true)
        } catch {
            print("Failed to setup socket: \(error)")
        }

        do {
            try socket.bind(toPort: UInt16(port))
            try socket.beginReceiving()
        } catch {
            print("Failed to receive: \(error)")
        }
    }    
}

extension UdpClientGCDAsync: GCDAsyncUdpSocketDelegate {
    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
        // データ受信時の処理
        let message = String(data: data, encoding: .utf8) ?? "-1,null"
        let components = message.components(separatedBy: ",")
        let index = Int(components[0])!
        let type = components[1]
        if lastIndex != -1 && lastIndex != index && lastIndex+1 != index {
            print("packet loss: index=\(index), type=\(type)")
        }

        lastIndex = index
        print("udpSocketDidRecieve: index=\(index), type=\(type)")
    }

    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotConnect error: Error?) {
        // 接続失敗時の処理
        print("udpSocketDidNotConnect: \(error.debugDescription)")
    }

    func udpSocketDidClose(_ sock: GCDAsyncUdpSocket, withError error: Error?) {
        // エラー発生時の処理
        print("udpSocketDidClose: \(error.debugDescription)")
    }
}
