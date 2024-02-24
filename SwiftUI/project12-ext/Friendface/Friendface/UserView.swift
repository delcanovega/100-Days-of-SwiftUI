//
//  UserView.swift
//  Friendface
//
//  Created by Juan Ramón del Caño Vega on 23/2/24.
//

import SwiftUI

struct UserView: View {
    
    var user: User
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        Text(user.name)
                            .font(.largeTitle)
                        Text("Age: \(user.age) - \(user.company)")
                    }
                    Spacer()
                    VStack {
                        Button("", systemImage: "moonphase.full.moon") {}
                            .font(.title)
                            .disabled(true)
                            .foregroundStyle(user.isActive ? Color.green : Color.red)
                        Text(user.isActive ? "Active " : "Inactive")
                    }
                }
                .padding()
                
                Divider()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Address")
                            .bold()
                            .padding(2)
                        Text("\(user.address.replacingOccurrences(of: ", ", with: "\n"))")
                    }
                    .padding(.leading, 10)

                    Spacer()
                    
                    NavigationLink(destination: {
                        FriendsView(userName: user.name, friends: user.friends)
                    }) {
                        VStack {
                            Text("\(user.friends.count)")
                                .font(.largeTitle)
                            Text("Friends")
                        }
                        .padding(.trailing, 20)
                    }
                }
                
                Divider()
                
                Text(user.about)
                    .padding(.top)
                Text("\(user.tags.map{"#\($0)"}.joined(separator: ", "))")
                    .font(.subheadline)
                    .bold()
                    .padding(.top)
                
                Divider()
                
                Text("Registered on \(user.registered, style: .date)")
                    .font(.footnote)
                
            }
            .padding()
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    UserView(user: User(id: UUID(), name: "Max", age: 32, isActive: true, registered: .now, email: "max@harder.com", company: "Power Enterprises", about: "Oh, Max Power...", address: "Evergeen Terrace 123", tags: ["A", "B", "C"], friends: []))
}
