//
//  TodoRouterEdit.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import UIKit

protocol TodoEditRouterProtocol {
    func dismiss()
}

final class TodoEditRouter: TodoEditRouterProtocol {
    weak var viewController: UIViewController?
    
    func dismiss() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
