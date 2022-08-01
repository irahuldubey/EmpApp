//
//  NetworkError.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/29/22.
//

import Foundation

// Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
enum RestError: LocalizedError, Equatable {
    
    case informational(code: Int)
    case redirection(code: Int)
    case clientError(code: Int)
    case serverError(code: Int)
    
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    
    case decodingError
    case urlSessionFailed(_ error: URLError)
    
    case unknownError
}
