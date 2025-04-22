//
//  Todo+CoreDataProperties.swift
//  TodolistApps
//
//  Created by irfan wahendra on 20/04/25.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var status: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?

}

extension Todo : Identifiable {

}
