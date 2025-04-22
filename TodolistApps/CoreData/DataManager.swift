//
//  DataManagerClass.swift
//  TodolistApps
//
//  Created by irfan wahendra on 20/04/25.
//

import Foundation
import CoreData

class DataManager: ObservableObject {
  @Published var todos: [Todo] = [Todo]()
  
  let container: NSPersistentContainer = NSPersistentContainer(name: "Todolist")
  
  init() {
    container.loadPersistentStores { _, _ in }
  }
}
