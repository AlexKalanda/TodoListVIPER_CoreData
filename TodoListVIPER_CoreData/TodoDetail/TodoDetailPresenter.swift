//
//  TodoDetailPresenter.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import Foundation

protocol TodoDetailPresenterProtocol: AnyObject {
    func viewDidiLoad()
}

final class TodoDetailPresenter: TodoDetailPresenterProtocol {
    weak var view: TodoDetailViewProtocol?
    var interactor: TodoDetailInteractorProtocol
    var router: TodoDetailRouterProtocol
    
    init(interactor: TodoDetailInteractorProtocol, router: TodoDetailRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidiLoad() {
        let todo = interactor.fetchTodo()
        view?.update(with: todo)
    }
    

}
