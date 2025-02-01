//
//  TodoModel.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 30/1/2025.
//

import Foundation

struct TodoModel: Decodable {
    var id: Int
    var todo: String
    var completed: Bool
    var userId: Int
    var date: Date?
    var desc: String?
}
