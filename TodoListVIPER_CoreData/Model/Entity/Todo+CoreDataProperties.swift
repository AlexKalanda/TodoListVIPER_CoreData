//
//  Todo+CoreDataProperties.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 29/1/2025.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var id: String
    @NSManaged public var todo: String
    @NSManaged public var completed: Bool
    @NSManaged public var userId: String
    @NSManaged public var date: Date?
    @NSManaged public var desc: String?

}

extension Todo : Identifiable {

}
