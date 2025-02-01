//
//  CoreDataManager.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 29/1/2025.
//

import CoreData

class CoreDataService {
    static let shared = CoreDataService(); private init() {fetchTodos() }
    var todos = [Todo]()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoListVIPER_CoreData")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Create
    
    func createTodo(todos: TodoModel) {
        context.perform {
            let todo = Todo(context: self.context)
            todo.id = String(todos.id)
            todo.userId = String(todos.userId)
            todo.todo = todos.todo
            todo.completed = todos.completed
            todo.desc = nil
            todo.date = nil
            do {
                try self.context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    //Read
    
    func fetchTodos() {
        let request = Todo.fetchRequest()
        do {
            self.todos = try context.fetch(request)
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    // Add
    
    func addTodo(title: String, description: String, date: Date) {
        let todo = Todo(context: context)
        todo.id = UUID().uuidString
        todo.desc = description
        todo.todo = title
        todo.date = date
        todo.completed = false
        saveContext()
        fetchTodos()
    }
    
   // Update
    
    func updateTodo(todo: Todo, newTitile: String? = nil, newDescription: String? = nil, newDate: Date? = nil, newCompleted: Bool? = nil) {
        if let newTitile = newTitile {
            todo.todo = newTitile
        }
        if let newDescription = newDescription {
            todo.desc = newDescription
        }
        if let newDate = newDate {
            todo.date = newDate
        }
        if let newCompleted = newCompleted {
            todo.completed = newCompleted
        }
        saveContext()
        fetchTodos()
    }
    
    // Delete
    
    func deleteTodo(todo: Todo) {
        context.delete(todo)
        saveContext()
        fetchTodos()
    }
    // Search
    
    func searchTodos(with searchText: String) -> [Todo] {
        let request = Todo.fetchRequest()
        let predicate = NSPredicate(format: "todo CONTAINS[cd] %@ OR desc CONTAINS[cd] %@", searchText, searchText)
        request.predicate = predicate
        do {
            return try context.fetch(request)
        } catch {
            print("Error searching data: \(error)")
            return []
        }
    }
    
}
