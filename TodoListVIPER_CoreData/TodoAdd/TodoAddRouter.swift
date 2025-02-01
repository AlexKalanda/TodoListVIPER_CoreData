//
//  TodoAddRouter.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import UIKit

protocol AddTodoRouterProtocol: AnyObject {
    func dismiss()
}

class TodoAddRouter: AddTodoRouterProtocol {
    weak var viewController: UIViewController?
    
    func dismiss() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
