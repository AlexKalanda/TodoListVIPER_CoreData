//
//  TodoListResponse.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 30/1/2025.
//

import Foundation

struct TodoListResponse: Decodable {
    var total: Int
    var skip: Int
    var limit: Int
    var todos: [TodoModel]
}
