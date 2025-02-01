//
//  TodoListRouter.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 29/1/2025.
//

import Foundation
import UIKit

protocol TodoListRouterProtocol: AnyObject {
    func navigateToTodoDetail(with todo: Todo)
    func navigateToEditTodo(with todo: Todo)
}


final class TodoListRouter: TodoListRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToTodoDetail(with todo: Todo) {
        let todoDetailVC = TodoDetailBuilder.createModule(with: todo)
        viewController?.navigationController?.pushViewController(todoDetailVC, animated: true)
    }
    
    func navigateToEditTodo(with todo: Todo) {
        let todoEditVC = TodoEditBuilder.createModule(with: todo)
        viewController?.navigationController?.pushViewController(todoEditVC, animated: true)
    }
}
