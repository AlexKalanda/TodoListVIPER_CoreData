//
//  TodoDetailView.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import UIKit

protocol TodoDetailViewProtocol: AnyObject {
    func update(with todo: Todo)
}

class TodoDetailView: UIViewController, TodoDetailViewProtocol {
    
    
    var presenter: TodoDetailPresenterProtocol?
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        setViews()
        presenter?.viewDidiLoad()
    }
    
    func setViews() {
        view.backgroundColor = UIColor.color(light: .white, dark: .black)
        titleLabel.textColor = UIColor.color(light: .black, dark: .white)
        descriptionLabel.textColor = UIColor.color(light: .black, dark: .white)
        dateLabel.textColor = UIColor.color(light: .black, dark: .white)
        dateLabel.alpha = 0.5
        titleLabel.font = .systemFont(ofSize: 34, weight: .bold)
        titleLabel.numberOfLines = 0
        dateLabel.font = .systemFont(ofSize: 12, weight: .light)
        descriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        descriptionLabel.numberOfLines = 0
    }
    
    func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel, descriptionLabel, UIView()])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -12),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 12)
        ])
    }
    
    func update(with todo: Todo) {
        titleLabel.text = todo.todo
        descriptionLabel.text = todo.desc
        dateLabel.text = DateHelper.toString(date: todo.date ?? .init())
    }
}
