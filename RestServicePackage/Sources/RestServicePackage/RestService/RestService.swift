//
//  NetworkClient.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/29/22.
//

import Foundation
import Combine

public class RestService<T: RestServiceOperation> {
        
    let urlSession: URLSession
    
    //MARK: Intializer
    
    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    private lazy var restServiceResponseHandler: RestServiceResponseHandler = {
        return RestServiceResponseHandler()
    }()
    
    public func performRestServiceOperation(_ operation: RestServiceOperation, completionHandler: @escaping (Result<RestServiceResponseParser>) -> Void) -> URLSessionTask? {
        do {
            let request = try operation.requestURL()
            let task = urlSession.dataTask(with: request) { (data, response, error) in
                let response = RestServiceResponseData.init(data: data, response: response, error: error as Error?)
                self.restServiceResponseHandler.handle(urlResponse: response, completion: completionHandler)
            }
            task.resume()
            return task
        } catch {
            completionHandler(.failure(RestError.unknownError))
            return nil
        }
    }
}
