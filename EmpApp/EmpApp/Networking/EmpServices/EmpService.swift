//
//  EmpService.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation
import Combine

protocol EmpServiceProtocol {
    func fetchEmpList<T: Codable>(modelType: T.Type, completionHandler: @escaping(Result<T>) -> Void)
}

final class EmpService: EmpServiceProtocol {
    
    private let restService: RestService<EmpServiceOperation>
    private let empServiceOperation: RestServiceOperation
    
    init(with service: RestService<EmpServiceOperation> = RestService(), operation: RestServiceOperation = EmpServiceOperation()) {
        self.restService = service
        self.empServiceOperation = operation
    }
    
    enum Error: Swift.Error, LocalizedError {
        case invalidResponse(Int)
        case parseError
        
        var errorDescription: String? {
            switch self {
            case .invalidResponse(let code):
                if code == 404 {
                    return "Received malformed data from service with code \(code), please try again later"
                }
            case .parseError:
                return "Unable to parse service response"
            }
            return nil
        }
    }

    func fetchEmpList<T: Codable>(modelType: T.Type, completionHandler: @escaping(Result<T>) -> Void) {
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
                            let empListResponse = try JSONDecoder().decode(T.self, from: data)
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
