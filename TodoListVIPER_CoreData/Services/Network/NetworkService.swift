//
//  NetworkServices.swift
//  TodoListVIPER_API_COREDATA
//
//  Created by admin on 28/1/2025.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared as URLSessionProtocol) {
        self.session = session
    }
    
    func fetchTodosResponse() async throws -> TodoListResponse {
        guard let url = URLManager.shared.createURL() else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await session.data(from: url)
        
        guard let todos = ParsingService.shared.todosFromJSON(data: data) else {
            throw HTTPError.invalidDecoding
        }
        
        return todos
    }
    
}

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
