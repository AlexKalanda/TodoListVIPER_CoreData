//
//  TodoListBuilder.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 29/1/2025.
//

import UIKit

final class TodoListBuilder {
    static func createModule() -> UIViewController {
        let view = TodoListView()
        let interactor = TodoListInteractor()
        let router = TodoListRouter()
        let presenter = TodoListPresenter(interactor: interactor, router: router)
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
