//
//  RestServiceResponseHandler.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation

public struct RestServiceResponseData {
    let data: Data?
    let response: URLResponse?
    let error: Error?
}

public class RestServiceResponseHandler {

    func handle(urlResponse serviceResponse: RestServiceResponseData, completion: @escaping (Result<RestServiceResponseParser>) -> Void) {
        if let error = serviceResponse.error {
            handle(error, completion: completion)
        } else if let unwrappedResponse = serviceResponse.response as? HTTPURLResponse {
            handle(unwrappedResponse, data: serviceResponse.data, completion: completion)
        } else {
            handle(RestServiceError.unknown, completion: completion)
        }
    }
    
    //MARK: Private helper methods
    private func handle(_ error: Error, completion: @escaping (Result<RestServiceResponseParser>) -> Void) {
        completion(.failure(error))
    }
    
    private func handle(_ response: HTTPURLResponse, data: Data?, completion: @escaping (Result<RestServiceResponseParser>) -> Void) {
        do {
            let serviceResponse = try RestServiceResponseParser(withResponse: response, data: data)
            completion(.success(serviceResponse))
        } catch {
            handle(error, completion: completion)
        }
    }
}
