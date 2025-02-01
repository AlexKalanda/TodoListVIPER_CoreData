//
//  HTTPError.swift
//  TodoListVIPER_API_COREDATA
//
//  Created by admin on 28/1/2025.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
    case badResponse
    case badRequest
    case invalidDecoding
    case invalidEncoding
    case unknownError
}
