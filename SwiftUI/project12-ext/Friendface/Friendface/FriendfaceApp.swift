//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Juan Ramón del Caño Vega on 23/2/24.
//

import SwiftData
import SwiftUI

@main
struct FriendfaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: User.self)
        }
    }
}
