//
//  ParsingService.swift
//  TodoListVIPER_API_COREDATA
//
//  Created by admin on 28/1/2025.
//

import Foundation

 class ParsingService {
    static let shared = ParsingService(); private init() { }
    private let decoder = JSONDecoder()
    
    func todosFromJSON(data: Data) -> TodoListResponse? {
        guard let newsResponse = try? decoder.decode(TodoListResponse.self, from: data) else { return nil }
        return newsResponse
    }
}
