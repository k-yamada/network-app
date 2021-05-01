//
//  TopView.swift
//  iosApp
//
//  Created by Kazuhiro Yamada on 2021/05/01.
//  Copyright © 2021 orgName. All rights reserved.
//

import SwiftUI

struct TopView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: TcpClientView()) {
                    Text("TCP")
                }
                NavigationLink(destination: UdpClientView()) {
                    Text("UDP")
                }
            }
            .navigationTitle("Protocols")
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
