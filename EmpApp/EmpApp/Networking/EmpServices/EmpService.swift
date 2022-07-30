//
//  EmpService.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation
import Combine
import RestServicePackage

// If we want to cancel the request from our application layer.
public protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {}

protocol EmpServiceProtocol {
    func fetchEmpList<T: Codable>(modelType: T.Type, completionHandler: @escaping(Result<T>) -> Void) -> Cancellable?
}

final class EmpService: EmpServiceProtocol{
    
    private let restService: RestService<EmpServiceOperation> = RestService()
    
    enum Error: Swift.Error {
        case invalidResponse(Int)
        case parseError
    }
    
    private lazy var decoder: JSONDecoder = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    @discardableResult
    func fetchEmpList<T: Codable>(modelType: T.Type, completionHandler: @escaping(Result<T>) -> Void) -> Cancellable? {
        let empServiceOperation = EmpServiceOperation()
        return restService.performRestServiceOperation(empServiceOperation) { (result) in
            switch result {
            case .success(let response):
                switch response.status {
                case .informational(let code),
                     .redirection(let code),
                     .clientError(let code),
                     .serverError(let code):
                    let error = Error.invalidResponse(code)
                    completionHandler(.failure(error))
                case .success:
                    if let data = response.data {
                        do {
                            let empListResponse = try self.decoder.decode(T.self, from: data)
                            completionHandler(.success(empListResponse))
                        } catch {
                            completionHandler(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
