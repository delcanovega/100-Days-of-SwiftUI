//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Juan Ramón del Caño Vega on 23/2/24.
//

import Foundation
import SwiftData

@Model
class ExpenseItem {
    
    let name: String
    let type: String
    let amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
    
}
