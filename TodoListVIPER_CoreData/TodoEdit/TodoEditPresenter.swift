//
//  TodoPresenterEdit.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import Foundation

protocol TodoEditPresenterProtocol: AnyObject {
    func viewDidLoad()
    func saveTodo(title: String, description: String?, date: Date?)
}

class TodoEditPresenter: TodoEditPresenterProtocol {
    weak var view: TodoEditViewProtocol?
    var interactor: TodoInteractorEditProtocol
    var router: TodoEditRouterProtocol
    
    init(interactor: TodoInteractorEditProtocol, router: TodoEditRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        let todo = interactor.fetchTodo()
        view?.getTodo(todo)
    }
    
    func saveTodo(title: String, description: String?, date: Date?) {
        let todo = interactor.fetchTodo()
        todo.todo = title
        todo.desc = description
        todo.date = date
        interactor.updateTodo(todo)
        router.dismiss()
    }
}
