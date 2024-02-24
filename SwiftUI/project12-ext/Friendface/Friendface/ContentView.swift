//
//  ContentView.swift
//  Friendface
//
//  Created by Juan Ramón del Caño Vega on 23/2/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    HStack {
                        Button("", systemImage: "moonphase.full.moon") {}
                            .font(.footnote)
                            .foregroundStyle(user.isActive ? Color.green : Color.red)
                        
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .bold()
                            Text(user.company)
                        }
                    }
                }
            }
            .navigationTitle("Friendface")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: User.self) { user in
                UserView(user: user)
            }
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        if (users.isEmpty) {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let decodedResponse = try? decoder.decode([User].self, from: data) {
                    decodedResponse.forEach({ modelContext.insert($0) })
                }
            } catch {
                print("Invalid data")
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let expense = User(id: UUID(), name: "Max", age: 32, isActive: true, registered: Date.now, email: "max@harder.com", company: "Power Enterprises", about: "Oh, Max Power...", address: "Evergeen Terrace 123", tags: ["A", "B", "C"], friends: [])
        container.mainContext.insert(expense)
        
        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
