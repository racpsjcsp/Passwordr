//
//  Credential.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import Foundation
import SwiftData
import CloudKit

@Model
class Credential: Codable { /// Codable was added to make it work with JSON data for Previewing in Canvas, so required init and encoded were also needed
    var title: String = "Title"
    var oldTitle: String = "Old Title"
    var username: String = "Username"
    var oldUsername: String = "Old Username"
    var password: String = "Password"
    var oldPassword: String = "Old Password"
    var creationDate: String = "Creation Date"
    var lastChanged: String = "Last Changed"

    enum CodingKeys: String, CodingKey {
        case title
        case oldTitle
        case username
        case oldUsername
        case password
        case oldPassword
        case creationDate
        case lastChanged
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.oldTitle = try container.decode(String.self, forKey: .oldTitle)
        self.username = try container.decode(String.self, forKey: .username)
        self.oldUsername = try container.decode(String.self, forKey: .oldUsername)
        self.password = try container.decode(String.self, forKey: .password)
        self.oldPassword = try container.decode(String.self, forKey: .oldPassword)
        self.creationDate = try container.decode(String.self, forKey: .creationDate)
        self.lastChanged = try container.decode(String.self, forKey: .lastChanged)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(title, forKey: .oldTitle)
        try container.encode(title, forKey: .username)
        try container.encode(title, forKey: .oldUsername)
        try container.encode(title, forKey: .password)
        try container.encode(title, forKey: .oldPassword)
        try container.encode(title, forKey: .creationDate)
        try container.encode(title, forKey: .lastChanged)
    }

    /// Without Previewing on Canvas, only this init is necessary
    init(title: String, oldTitle: String, username: String, oldUsername: String, password: String, oldPassword: String, creationDate: String, lastChanged: String) {
        self.title = title
        self.oldTitle = oldTitle
        self.username = username
        self.oldUsername = oldUsername
        self.password = password
        self.oldPassword = oldPassword
        self.creationDate = creationDate
        self.lastChanged = lastChanged
    }
}
