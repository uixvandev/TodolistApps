//
//  TodolistAppsApp.swift
//  TodolistApps
//
//  Created by irfan wahendra on 19/04/25.
//

import SwiftUI

@main
struct TodolistAppsApp: App {
  @StateObject private var manager: DataManager = DataManager()
  
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(manager)
            .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
