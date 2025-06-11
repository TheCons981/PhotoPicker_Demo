//
//  PhotoPickerDemoApp.swift
//  PhotoPickerDemo
//
//  Created by Andrea Consorti on 11/06/25.
//

import SwiftUI

@main
struct PhotoPickerDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
