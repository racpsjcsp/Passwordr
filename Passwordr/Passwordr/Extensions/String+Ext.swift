//
//  String+Ext.swift
//  Passwordr
//
//  Created by Rafael Plinio on 25/11/23.
//

import Foundation
import SwiftUI

extension String {
    public func getCurrentDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        var fullHour = "\(hour)"
        if fullHour.count == 1 {
            fullHour = "0\(hour)"
        }

        var fullMinute = "\(minute)"
        if fullMinute.count == 1 {
            fullMinute = "0\(minute)"
        }

        let currentDate = "\(day)/\(month)/\(year) at \(fullHour):\(fullMinute)"
        return currentDate
    }

    public func copyToClipboard(string: String) {
        let expireDate = Date().addingTimeInterval(TimeInterval(60))
        
        UIPasteboard.general.setItems([[UIPasteboard.typeAutomatic: string]],
                                      options: [UIPasteboard.OptionsKey.expirationDate: expireDate])
    }

    func containsEmoji() -> Bool {
        contains { $0.isEmoji }
    }
}
