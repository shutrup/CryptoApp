//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Шарап Бамматов on 27.10.2022.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetail: CoinDetailModel? = nil
    var cancellables = Set<AnyCancellable>()
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinsDetails()
    }
    
    func getCoinsDetails(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoin) in
                guard let self = self else {return}
                self.coinDetail = returnedCoin
            })
            .store(in: &cancellables)

    }
}
