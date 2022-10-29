//
//  DetailLoadingView.swift
//  CryptoApp
//
//  Created by Шарап Бамматов on 26.10.2022.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLoadingView(coin: .constant(dev.coin))
    }
}
