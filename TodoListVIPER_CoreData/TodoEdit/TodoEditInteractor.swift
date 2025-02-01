//
//  TodoInteractorEdit.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import Foundation

protocol TodoInteractorEditProtocol: AnyObject {
    func fetchTodo() -> Todo
    func updateTodo(_ todo: Todo)
}

class TodoEditInteractor: TodoInteractorEditProtocol {
    let coreDataManager = CoreDataService.shared
    weak var presenter: TodoEditPresenterProtocol?
    
    private let todo: Todo
    
    init(todo: Todo) {
        self.todo = todo
    }
    
    func fetchTodo() -> Todo {
        return todo
    }
    
    func updateTodo(_ todo: Todo) {
        coreDataManager.updateTodo(todo: todo)
    }
    
    
}
