//
//  UserDefaultServices.swift
//  TodoListVIPER_CoreData
//
//  Created by admin on 29/1/2025.
//

import Foundation

class UserDefaultService {
    static let shared = UserDefaultService(); private init() {}
    
    private let firstLaunchKey = "isFirstLaunch"
    
    var isFirstLaunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: firstLaunchKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: firstLaunchKey)
        }
    }
}
