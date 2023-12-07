//
//  PixifyApp.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
//

import SwiftUI

@main
struct PixifyApp: App {

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, dataManagerInstance.persistentContainer.viewContext)
        }
    }
}
