//
//  UdpClientView.swift
//  iosApp
//
//  Created by Kazuhiro Yamada on 2021/05/01.
//  Copyright © 2021 orgName. All rights reserved.
//

import SwiftUI

struct UdpClientView: View {
    @StateObject var data = UdpClientData()

    var body: some View {
        ZStack {
            Text("UDP Client)
        }
        .onAppear() {
            data.onAppear()
        }
    }
}

struct UdpClientView_Previews: PreviewProvider {
    static var previews: some View {
        UdpClientView()
    }
}
