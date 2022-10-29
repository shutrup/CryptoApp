//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Шарап Бамматов on 20.10.2022.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getCoins()
    }
    
    func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoin) in
                guard let self = self else {return}
                self.allCoins = returnedCoin
            })
            .store(in: &cancellables)

    }
}
