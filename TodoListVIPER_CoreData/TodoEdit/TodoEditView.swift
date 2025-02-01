//
//  TodoEditView.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 31/1/2025.
//

import UIKit

protocol TodoEditViewProtocol: AnyObject {
    func getTodo(_ todo: Todo)
}

class TodoEditView: UIViewController, TodoEditViewProtocol {
    var presenter: TodoEditPresenterProtocol?
    
    let titleTF = UITextField()
    let commentLabel = UILabel()
    let descriptionTF = UITextView()
    let dateLabel = UILabel()
    let datePicer = UIDatePicker()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        setupNavigationBar()
        presenter?.viewDidLoad()
        
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово",style: .plain,target: self, action: #selector(saveAction))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: "#FED702")
    }
    
    @objc func saveAction() {
        print("save")
        guard let title = titleTF.text, !title.isEmpty else { return }
        let descriptionText = descriptionTF.text ?? ""
        let data = datePicer.date
        presenter?.saveTodo(title: title, description: descriptionText, date: data)
        
    }
    func setViews() {
        view.backgroundColor = UIColor.color(light: .white, dark: .black)
        titleTF.placeholder = "Задача"
        titleTF.textColor = UIColor.color(light: .black, dark: .white)
        titleTF.backgroundColor = .systemBackground
        titleTF.layer.borderWidth = 1
        titleTF.layer.borderColor = UIColor.placeholderText.cgColor
        titleTF.layer.cornerRadius = 10
        titleTF.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        titleTF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleTF.setLeftPaddingPoints(10)
        titleTF.setRightPaddingPoints(10)
        
        commentLabel.text = "Комментарий"
        commentLabel.textColor = .placeholderText
        
        descriptionTF.isEditable = true
        descriptionTF.layer.borderWidth = 1
        descriptionTF.layer.borderColor = UIColor.placeholderText.cgColor
        descriptionTF.layer.cornerRadius = 10
        descriptionTF.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1).isActive = true
        descriptionTF.textColor = UIColor.color(light: .black, dark: .white)
        dateLabel.text = "Дата"
        dateLabel.textColor = .placeholderText
        
        datePicer.preferredDatePickerStyle = .wheels
        datePicer.datePickerMode = .date
        datePicer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        datePicer.minimumDate = .now
        
    }
    
    func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [
            titleTF,
            commentLabel,
            descriptionTF,
            dateLabel,
            datePicer
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 12),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -12)
        ])
    }
    
    func getTodo(_ todo: Todo) {
        titleTF.text = todo.todo
        descriptionTF.text = todo.desc
        datePicer.date = todo.date ?? .init()
    }
    
}
