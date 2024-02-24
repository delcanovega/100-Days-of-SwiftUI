//
//  Friend.swift
//  Friendface
//
//  Created by Juan Ramón del Caño Vega on 23/2/24.
//

import Foundation
import SwiftData

@Model
class Friend: Codable {
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let idStr = try container.decode(String.self, forKey: .id)
        self.id = UUID(uuidString: idStr)!
        self.name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id.uuidString, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
    
}
