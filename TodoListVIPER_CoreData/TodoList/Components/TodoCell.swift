//
//  TodoCell.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 30/1/2025.
//

import UIKit

final class TodoCell: UITableViewCell {
    static let reuseID: String = "TodoCell"
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    let buttonComplete = UIButton()
    var completionHandler: ((Int) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    private func setConstraints() {
        contentView.addSubview(buttonComplete)
        buttonComplete.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonComplete.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            buttonComplete.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            buttonComplete.widthAnchor.constraint(equalToConstant: 24),
            buttonComplete.heightAnchor.constraint(equalToConstant: 24)
        ])
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: buttonComplete.trailingAnchor,constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
        ])
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12)
        ])
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])

    }
    
    private func setupViews() {
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 2
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        buttonComplete.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
    }
    
    
    func setupCell(with todo: Todo, cellIndex: Int, completion: ((Int) -> Void)?) {
        self.titleLabel.text = todo.todo
        self.descriptionLabel.text = todo.desc
        self.dateLabel.text = DateHelper.toString(date: todo.date ?? .init())
        self.buttonComplete.setImage(UIImage(systemName: todo.completed ? "checkmark.circle" : "circle"),
                                     for: .normal)
        self.buttonComplete.tintColor = todo.completed ? UIColor(hex: "#FED702") : .gray
        self.buttonComplete.tag = cellIndex
        self.titleLabel.textColor = todo.completed ? .gray : UIColor.color(light: .black, dark: .white)
        self.descriptionLabel.textColor = todo.completed ? .gray : UIColor.color(light: .black, dark: .white)
        self.titleLabel.strikeThrough(todo: todo, color: todo.completed ? .gray : .clear)
        self.completionHandler = completion
    }
    
    @objc func didTapCompleteButton(_ sender: UIButton) {
        completionHandler?(sender.tag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
