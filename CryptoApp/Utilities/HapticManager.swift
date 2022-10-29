//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Шарап Бамматов on 25.10.2022.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
