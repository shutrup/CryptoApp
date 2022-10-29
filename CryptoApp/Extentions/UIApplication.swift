//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Шарап Бамматов on 22.10.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
