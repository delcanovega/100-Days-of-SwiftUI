//
//  User.swift
//  Friendface
//
//  Created by Juan Ramón del Caño Vega on 23/2/24.
//

import Foundation
import SwiftData

@Model
class User: Codable {
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case age
        case isActive
        case registered
        case email
        case company
        case about
        case address
        case tags
        case friends
    }
    
    var id: UUID
    
    var name: String
    var age: Int
    
    var isActive: Bool
    var registered: Date
    
    var email: String
    var company: String
    var about: String
    var address: String
    
    var tags: [String]
    var friends: [Friend]
    
    init(id: UUID, name: String, age: Int, isActive: Bool, registered: Date,
         email: String, company: String, about: String, address: String, tags: [String], friends: [Friend]) {
        self.id = id
        self.name = name
        self.age = age
        self.isActive = isActive
        self.registered = registered
        self.email = email
        self.company = company
        self.about = about
        self.address = address
        self.tags = tags
        self.friends = friends
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let idStr = try container.decode(String.self, forKey: .id)
        self.id = UUID(uuidString: idStr)!
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.email = try container.decode(String.self, forKey: .email)
        self.company = try container.decode(String.self, forKey: .company)
        self.about = try container.decode(String.self, forKey: .about)
        self.address = try container.decode(String.self, forKey: .address)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([Friend].self, forKey: .friends)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id.uuidString, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.isActive, forKey: .isActive)
        try container.encode(self.registered, forKey: .registered)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.company, forKey: .company)
        try container.encode(self.about, forKey: .about)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.tags, forKey: .tags)
        try container.encode(self.friends, forKey: .friends)

    }
    
}
