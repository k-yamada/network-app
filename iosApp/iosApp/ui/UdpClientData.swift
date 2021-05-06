//
//  UdpClientData.swift
//  iosApp
//
//  Created by Kazuhiro Yamada on 2021/05/06.
//  Copyright © 2021 orgName. All rights reserved.
//

import Foundation

class UdpClientData: ObservableObject {
    let client = UdpClientGCDAsync()
    
    func onAppear() {
        client.bind(port: 9999)
    }
}
