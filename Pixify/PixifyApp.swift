//
//  PixifyApp.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
//

import SwiftUI

@main
struct PixifyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
