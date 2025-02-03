//
//  TodoListVIPER_CoreDataTestss.swift
//  TodoListVIPER_CoreDataTestss
//
//  Created by admin on 3/2/2025.
//

import XCTest
@testable import TodoListVIPER_CoreData

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var error: Error?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return (data ?? Data(), URLResponse())
    }
}


final class NetworkServicesTest: XCTestCase {

    var networkService: NetworkService!
    var mockURLSession: MockURLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockURLSession = MockURLSession()
        networkService = NetworkService(session: mockURLSession)
    }
    
    func testFetchTodoResponseSuccess() async {
        let jsonData = """
{
"todos": [{"id": 1, "todo": "Test Todo", "completed": false, "userId": 12}],
"total": 153,
"skip": 0,
"limit": 30
}
""".data(using: .utf8)
        mockURLSession.data = jsonData
        
        do {
            let response = try await networkService.fetchTodosResponse()
            //XCTAssertEqual(response.todos.count, 1)
            XCTAssertEqual(response.todos.count, 1)
            XCTAssertEqual(response.todos[0].todo, "Test Todo")
        } catch {
            print("Errpr: \(error)")
            XCTFail("Expected succes,but got error: \(error)")
        }
    }
    
    func testFetchTodoResponseFailure() async {
        mockURLSession.error = NSError(domain: "TestError", code: -1, userInfo: nil)
        
        do {
            _ = try await networkService.fetchTodosResponse()
            XCTFail("Expected error,but got success")
        } catch {
            XCTAssertTrue(true)
        }
    }
}
