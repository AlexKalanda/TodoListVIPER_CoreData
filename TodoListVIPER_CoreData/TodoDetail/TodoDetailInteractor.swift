//
//  TodoDetailInteractor.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import Foundation

protocol TodoDetailInteractorProtocol {
    func fetchTodo() -> Todo
}

final class TodoDetailInteractor: TodoDetailInteractorProtocol {
    weak var presenter: TodoDetailPresenterProtocol?
    
    private let todo: Todo
    
    init(todo: Todo) {
        self.todo = todo
    }
    
    func fetchTodo() -> Todo {
        return todo
    }
    
}
