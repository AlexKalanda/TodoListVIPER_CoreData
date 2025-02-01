//
//  TodoAddPresenter.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import Foundation

protocol TodoAddPresenterProtocol: AnyObject {
    func saveTodo(title: String, description: String?, date: Date?)
}

class TodoAddPresenter: TodoAddPresenterProtocol {
    weak var view: TodoAddViewProtocol?
    var interactor: TodoAddInteractorProtocol
    var router: AddTodoRouterProtocol
    
    init(interactor: TodoAddInteractorProtocol, router: AddTodoRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func saveTodo(title: String, description: String?, date: Date?) {
        interactor.saveTodo(title: title, description: description, date: date)
        router.dismiss()
    }
}
