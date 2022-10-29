//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Шарап Бамматов on 24.10.2022.
//

import Foundation
import Combine

class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getData()
    }
    
    func getData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                guard let self = self else {return}
                self.marketData = returnedGlobalData.data
            })
            .store(in: &cancellables)

    }
}
