//
//  TodoListInteractor.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 29/1/2025.
//

import Foundation

protocol TodoListInteractorProtocol: AnyObject {
    func fetchTodos()
    func numberOfTodos() -> Int
    func todo(at index: Int) -> Todo?
    func deleteTodo(at index: Int)
    func toggleCompleted(at index: Int) //
    func refreshData()
    func searchTodo(with searchText: String)
}


final class TodoListInteractor: TodoListInteractorProtocol {
    let networkService = NetworkService.shared
    let coreDataService = CoreDataService.shared
    weak var presenter: TodoListPresenterProtocol?
    
    // загрузка задач и сохранение в coredata
    func fetchTodos() {
        if !UserDefaultService.shared.isFirstLaunch {
            print("first pusk")
            Task {
                do {
                    let req = try await networkService.fetchTodosResponse()
                    for todo in req.todos {
                        coreDataService.createTodo(todos: todo)
                        print("first pusk: \(todo.userId)")
                    }
                    await MainActor.run {
                        self.coreDataService.fetchTodos()
                        self.presenter?.didFetchTodos()
                    }
                    UserDefaultService.shared.isFirstLaunch = true
                } catch {
                    print("Error fetching todos: \(error)")
                }
            }
        } else {
            print("not first launch")
            coreDataService.fetchTodos()
            for t in coreDataService.todos {
                print("not first launch: \(t.userId)")
            }
            presenter?.didFetchTodos()
        }
    }
    
    func numberOfTodos() -> Int {
        return coreDataService.todos.count
    }
    
    func todo(at index: Int) -> Todo? {
        guard index < coreDataService.todos.count else { return nil }
        return coreDataService.todos[index]
    }
    
    func deleteTodo(at index: Int) {
        guard let todo = todo(at: index) else { return }
        coreDataService.deleteTodo(todo: todo)
    }
    
    func toggleCompleted(at index: Int) {
        guard let todo = todo(at: index) else { return }
        let newValue = !todo.completed
        coreDataService.updateTodo(todo:todo , newCompleted: newValue)
    }
    
    func refreshData() {
        coreDataService.fetchTodos()
        presenter?.didFetchTodos()
    }
    
    func searchTodo(with searchText: String) {
        if searchText.isEmpty {
            coreDataService.fetchTodos()
        } else {
            let searchTodos = coreDataService.searchTodos(with: searchText)
            coreDataService.todos = searchTodos
        }
        presenter?.didFetchTodos()
    }
    
}

