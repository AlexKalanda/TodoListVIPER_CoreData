//
//  ViewController.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 29/1/2025.
//

import UIKit

protocol TodoListViewProtocol: AnyObject {
    func updateTodos()
}

final class TodoListView: UIViewController, TodoListViewProtocol {
    var presenter: TodoListPresenterProtocol?
    var tableView = UITableView()
    let footerView = UIView() // нижний колонтитул
    let lableCountTodo = UILabel()
    let addTodo = UIButton()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        setupSearchBar()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.refreshData()
    }

    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.reuseID)
        footerView.backgroundColor = UIColor.color(light: .systemBackground, dark: UIColor(hex: "#272729"))
        footerView.alpha = 0.8
        lableCountTodo.textColor = UIColor.color(light: .black, dark: .white)
        lableCountTodo.font = .systemFont(ofSize: 11)
        addTodo.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        addTodo.tintColor = UIColor(hex: "#FED702")
        addTodo.addTarget(self, action: #selector(addTapTodo), for: .touchUpInside)
        footerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1).isActive = true
        let stack = UIStackView(arrangedSubviews: [tableView, footerView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 0
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        footerView.addSubview(addTodo)
        addTodo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addTodo.rightAnchor.constraint(equalTo: footerView.rightAnchor , constant: -20),
            addTodo.centerYAnchor.constraint(equalTo: footerView.centerYAnchor,constant: -10)
            ])
        
        footerView.addSubview(lableCountTodo)
        lableCountTodo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lableCountTodo.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            lableCountTodo.centerYAnchor.constraint(equalTo: footerView.centerYAnchor,constant: -10)
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Задачи"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(hex: "#FED702")
        navigationItem.searchController = searchController
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "mic.fill"), for: .bookmark, state: .normal)
        searchController.searchBar.tintColor = UIColor(hex: "#FED702")
        searchController.searchBar.placeholder = "Поиск"
    }
    
    //обновляем список задач на экране
    func updateTodos() {
        tableView.reloadData()
        updateCountTodos(count: presenter?.numderOfRows() ?? 0)
    }
    
    // обновление нижнего колонтитула
    func updateCountTodos(count: Int) {
        if count > 0 {
            lableCountTodo.text = "\(count) Задач"
        } else {
            lableCountTodo.text = "Нет задач"
        }
    }
    
    @objc private func addTapTodo() {
        let addTodoVC = TodoAddBuilder.createModule()
        navigationController?.pushViewController(addTodoVC, animated: true)
    }
    
}

// MARK: - Расшерение для Delegat
extension TodoListView: UITableViewDelegate {
    // нажатие на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectTodo(at: indexPath.row)
    }
    
    //динамическая высота ячейки
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let todo = presenter?.todo(at: indexPath.row)
        let text = todo?.desc ?? ""
        let height = text.textHeight(frameWidth: view.frame.height, font: .systemFont(ofSize: 14))
        return height + 70
    }
    // контекстное меню
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            
            let  editAction = UIAction(title: "Редактирование", image: UIImage(systemName: "square.and.pencil")) { [weak self] _ in
               print("Edit")
                self?.presenter?.editTodo(at: indexPath.row)
            }
            
            let shareAction = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] _ in
                print("Share")
            }
            
            let deleteAction = UIAction(title: "Удалить", image: UIImage(systemName: "trash"),attributes: .destructive) { [weak self] _ in
                self?.presenter?.deleteTodo(at: indexPath.row)
            }
            
            return UIMenu(title: "",children: [editAction, shareAction, deleteAction])
        }
    }
}

// MARK: - Расшерение для DataSource
extension TodoListView: UITableViewDataSource {
    // колличество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numderOfRows() ?? 0
    }
    // вид ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.reuseID) as! TodoCell
        if let todo = presenter?.todo(at: indexPath.row) {
            cell.setupCell(with: todo, cellIndex: indexPath.row) { [weak self] index in
                self?.presenter?.toggleCompleted(at: index)
            }
            
        }
        return cell
    }
    // при вызове контекстного меню ячейка с закругленными углами
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.color(light: .systemBackground, dark: UIColor(hex: "#272729"))
        selectedBackgroundView.layer.cornerRadius = 12
        selectedBackgroundView.layer.masksToBounds = true
        cell.selectedBackgroundView = selectedBackgroundView
    }
    
}

//
extension TodoListView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter?.searchTodo(with: searchText)
    }
    
    
}
