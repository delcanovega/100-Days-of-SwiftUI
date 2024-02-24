//
//  Friend.swift
//  Friendface
//
//  Created by Juan Ramón del Caño Vega on 23/2/24.
//

import Foundation

struct Friend: Identifiable, Codable, Hashable {
    
    var id: UUID
    var name: String
    
}
