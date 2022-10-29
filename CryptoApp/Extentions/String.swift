//
//  String.swift
//  CryptoApp
//
//  Created by Шарап Бамматов on 28.10.2022.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
