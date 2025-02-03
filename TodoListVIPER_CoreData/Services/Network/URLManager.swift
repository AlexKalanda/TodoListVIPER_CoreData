//
//  URLManager.swift
//  TodoListVIPER_API_COREDATA
//
//  Created by admin on 28/1/2025.
//

import Foundation

 class URLManager {
    static let shared = URLManager(); private init() { }
    
    private let getaway = "https://"
    private let server = "dummyjson.com/todos"
    
    func createURL() -> URL? {
        let urlStr = getaway + server
        return URL(string: urlStr)
    }
}
