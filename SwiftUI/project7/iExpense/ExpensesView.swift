//
//  ExpensesView.swift
//  iExpense
//
//  Created by Juan Ramón del Caño Vega on 23/2/24.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]

    var body: some View {
        List {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: "USD"))
                }
            }
            .onDelete(perform: removeItems)
        }
    }
    init(sortOrder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(sort: sortOrder)
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
    
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        let expense = ExpenseItem(name: "Food", type: "Personal", amount: 11.99)
        container.mainContext.insert(expense)
        
        return ExpensesView(sortOrder: [SortDescriptor(\ExpenseItem.name)])
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }}
