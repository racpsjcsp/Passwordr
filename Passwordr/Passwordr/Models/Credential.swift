//
//  Credential.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import Foundation
import SwiftData

@Model
class Credential {
    @Attribute(.allowsCloudEncryption) var name: String
    @Attribute(.allowsCloudEncryption) var username: String
    @Attribute(.allowsCloudEncryption) var password: String
    @Attribute(.allowsCloudEncryption) var oldPassword: String
    @Attribute(.allowsCloudEncryption) var creationDate: String
    @Attribute(.allowsCloudEncryption) var lastChanged: String

    init(name: String, username: String, password: String, oldPassword: String, creationDate: String, lastChanged: String) {
        self.name = name
        self.username = username
        self.password = password
        self.oldPassword = oldPassword
        self.creationDate = creationDate
        self.lastChanged = lastChanged
    }

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
}
