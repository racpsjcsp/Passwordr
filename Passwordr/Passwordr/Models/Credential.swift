//
//  Credential.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import Foundation
import SwiftData

@Model
class Credential: Codable { /// Codable was added to make it work with JSON data for Previewing in Canvas, so required init and encoded were also needed
    var name: String
    var oldName: String
    var username: String
    var oldUsername: String
    var password: String
    var oldPassword: String
    var creationDate: String
    var lastChanged: String

    enum CodingKeys: String, CodingKey {
        case name
        case oldName
        case username
        case oldUsername
        case password
        case oldPassword
        case creationDate
        case lastChanged
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.oldName = try container.decode(String.self, forKey: .oldName)
        self.username = try container.decode(String.self, forKey: .username)
        self.oldUsername = try container.decode(String.self, forKey: .oldUsername)
        self.password = try container.decode(String.self, forKey: .password)
        self.oldPassword = try container.decode(String.self, forKey: .oldPassword)
        self.creationDate = try container.decode(String.self, forKey: .creationDate)
        self.lastChanged = try container.decode(String.self, forKey: .lastChanged)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(name, forKey: .oldName)
        try container.encode(name, forKey: .username)
        try container.encode(name, forKey: .oldUsername)
        try container.encode(name, forKey: .password)
        try container.encode(name, forKey: .oldPassword)
        try container.encode(name, forKey: .creationDate)
        try container.encode(name, forKey: .lastChanged)
    }

    /// Without Previewing on Canvas, only this init is necessary
    init(name: String, oldName: String, username: String, oldUsername: String, password: String, oldPassword: String, creationDate: String, lastChanged: String) {
        self.name = name
        self.oldName = oldName
        self.username = username
        self.oldUsername = oldUsername
        self.password = password
        self.oldPassword = oldPassword
        self.creationDate = creationDate
        self.lastChanged = lastChanged
    }
}
