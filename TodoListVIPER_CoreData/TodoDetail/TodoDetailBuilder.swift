//
//  TodoDetailBuilder.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import UIKit

class TodoDetailBuilder {
    static func createModule(with todo: Todo) -> UIViewController {
        let view = TodoDetailView()
        let interactor = TodoDetailInteractor(todo: todo)
        let router = TodoDetailRouter()
        let presenter = TodoDetailPresenter(interactor: interactor, router: router)
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
