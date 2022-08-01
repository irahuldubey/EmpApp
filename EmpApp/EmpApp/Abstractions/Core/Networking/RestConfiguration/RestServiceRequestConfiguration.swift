//
//  RestServiceRequestConfiguration.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation

 enum RestServiceOperationError: Error {
    case urlStringError
}

// Defines the configuration for the RestServiceRequest
 struct RestServiceRequestConfiguration {
 
    // MARK: HTTPProtocol Type
     enum HttpProtocol: String {
        case http
        case https
    }
    
    // MARK: HTTP Method
     enum HttpMethod: String {
        case get = "GET"
    }
    
    // MARK: Content Type
     enum HttpContentType: String {
        case json = "application/json" //
    }
    
    // MARK: Path Compontents
     struct PathComponents {
        let path: String
        let queryItems: [String: String?]?
        
         init(path: String, queryItems:[String: String?]? = nil) {
            self.path = path
            self.queryItems = queryItems
        }
    }
    
    // MARK:  Properties
    
     let urlString: String
     let scheme: HttpProtocol
     let method: HttpMethod
     let contentType: HttpContentType
     let urlComponents: PathComponents
     let data: Data?
    
    // MARK: Initializer
     init(urlString: String,
                scheme: HttpProtocol,
                method: HttpMethod,
                contentType: HttpContentType,
                urlComponents: PathComponents,
                data: Data? = nil) {
        self.urlString = urlString
        self.scheme = scheme
        self.method = method
        self.contentType = contentType
        self.urlComponents = urlComponents
        self.data = data
    }
}
