//
//  FriendsView.swift
//  Friendface
//
//  Created by Juan Ramón del Caño Vega on 24/2/24.
//

import SwiftUI

struct FriendsView: View {
    
    var userName: String
    var friends: [Friend]
    
    var body: some View {
        List(friends) { friend in
            Text(friend.name)
        }
        .navigationTitle("\(userName)'s friends")
    }
}

#Preview {
    FriendsView(userName: "Ed", friends: [Friend(id: UUID(), name: "Edd"), Friend(id: UUID(), name: "Eddy")])
}
