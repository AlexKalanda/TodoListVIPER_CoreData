//
//  TodoListPresenter.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 29/1/2025.
//

import Foundation

protocol TodoListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didFetchTodos()
    func numderOfRows() -> Int
    func todo(at index: Int) -> Todo?
    func didSelectTodo(at index: Int)
    func deleteTodo(at index: Int)
    func toggleCompleted(at index: Int)
    func editTodo(at index: Int)
    func refreshData()
    func searchTodo(with searchText: String)
}


final class TodoListPresenter: TodoListPresenterProtocol {
    weak var view: TodoListViewProtocol?
    var interactor: TodoListInteractorProtocol
    var router: TodoListRouterProtocol
    
    
    init(interactor: TodoListInteractorProtocol, router: TodoListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.fetchTodos()
        view?.updateTodos()
    }
    
    func didFetchTodos() {
        view?.updateTodos()
    }
    
    func numderOfRows() -> Int {
        return interactor.numberOfTodos()
    }
    
    func todo(at index: Int) -> Todo? {
        return interactor.todo(at: index)
    }
    
    func didSelectTodo(at index: Int) {
        guard let todo = todo(at: index) else { return }
        router.navigateToTodoDetail(with: todo)
    }
    func deleteTodo(at index: Int) {
        interactor.deleteTodo(at: index)
        view?.updateTodos()
    }
    
    func toggleCompleted(at index: Int) {
        interactor.toggleCompleted(at: index)
        view?.updateTodos()
    }
    
    func editTodo(at index: Int) {
        guard let todo = todo(at: index) else { return }
        router.navigateToEditTodo(with: todo)
    }
    
    func refreshData() {
        interactor.refreshData()
        view?.updateTodos()
    }
    
    func searchTodo(with searchText: String) {
        interactor.searchTodo(with: searchText)
        view?.updateTodos()
    }
}


