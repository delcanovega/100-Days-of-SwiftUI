//
//  User.swift
//  Friendface
//
//  Created by Juan Ramón del Caño Vega on 23/2/24.
//

import Foundation

struct User: Identifiable, Codable {
    
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
    
}
