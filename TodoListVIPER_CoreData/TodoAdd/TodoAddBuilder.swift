//
//  TodoAddBuilder.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import UIKit

class TodoAddBuilder {
    static func createModule() -> UIViewController {
        let view = TodoAddView()
        let interactor = TodoAddInteractor()
        let router = TodoAddRouter()
        let presenter = TodoAddPresenter(interactor: interactor, router: router)
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
