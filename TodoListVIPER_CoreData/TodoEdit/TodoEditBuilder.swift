//
//  TodoEditBuilder.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import UIKit

class TodoEditBuilder {
    static func createModule(with todo: Todo) -> UIViewController {
        let view = TodoEditView()
        let interactor = TodoEditInteractor(todo: todo)
        let router = TodoEditRouter()
        let presenter = TodoEditPresenter(interactor: interactor, router: router)
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
