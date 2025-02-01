//
//  TodoAddInteractor.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import Foundation

protocol TodoAddInteractorProtocol: AnyObject {
    func saveTodo(title: String, description: String?, date: Date?)
}

class TodoAddInteractor: TodoAddInteractorProtocol {
    weak var presenter: TodoAddPresenterProtocol?
    let coreDataManager = CoreDataService.shared
    func saveTodo(title: String, description: String?, date: Date?) {
        coreDataManager.addTodo(title: title, description: description ?? "", date: date ?? Date())
    }
}
