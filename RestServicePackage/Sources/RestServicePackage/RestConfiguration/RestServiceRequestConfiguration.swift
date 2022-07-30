//
//  RestServiceRequestConfiguration.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation

public enum RestServiceOperationError: Error {
    case urlStringError
}

// Defines the configuration for the RestServiceRequest
public struct RestServiceRequestConfiguration {
 
    // MARK: HTTPProtocol Type
    public enum HttpProtocol: String {
        case http
        case https
    }
    
    // MARK: HTTP Method
    public enum HttpMethod: String {
        case get = "GET"
    }
    
    // MARK: Content Type
    public enum HttpContentType: String {
        case json = "application/json" //
    }
    
    // MARK: Path Compontents
    public struct PathComponents {
        let path: String
        let queryItems: [String: String?]?
        
        public init(path: String, queryItems:[String: String?]? = nil) {
            self.path = path
            self.queryItems = queryItems
        }
    }
    
    // MARK: Public Properties
    
    public let urlString: String
    public let scheme: HttpProtocol
    public let method: HttpMethod
    public let contentType: HttpContentType
    public let urlComponents: PathComponents
    public let data: Data?
    
    // MARK: Initializer
    public init(urlString: String,
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
