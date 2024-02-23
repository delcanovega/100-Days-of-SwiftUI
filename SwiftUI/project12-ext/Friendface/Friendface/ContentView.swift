//
//  ContentView.swift
//  Friendface
//
//  Created by Juan Ramón del Caño Vega on 23/2/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var results = [User]()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(results) { user in
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
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        if (results.isEmpty) {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let decodedResponse = try? decoder.decode([User].self, from: data) {
                    results = decodedResponse
                }
            } catch {
                print("Invalid data")
            }
        }
    }
}

#Preview {
    ContentView()
}
