//
//  RestServiceOperation.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation

public protocol RestServiceOperation {
    var configuration: RestServiceRequestConfiguration { get }
}

// MARK: - Default Implementation
extension RestServiceOperation {

    public func requestURL() throws -> URL {
        let components = urlComponents(scheme: scheme, host: host, path: path, queryItems: urlQueryItems)
        if let url = components?.url {
            return url
        } else {
            throw RestServiceOperationError.urlStringError
        }
    }
    
    // MARK: Helpers to create the request url else throw an error
    
    private var path: String {
        return configuration.urlComponents.path
    }
    
    private var scheme: String {
        return configuration.scheme.rawValue
    }
    
    private var host: String {
        return configuration.urlString
    }
    
    private var urlQueryItems: [URLQueryItem]? {
        let items = configuration.urlComponents.queryItems
        var queryItems: [URLQueryItem] = []
        _ = items?.reduce(into: queryItems) {
           queryItems.append(URLQueryItem(name: $1.0, value: $1.1))
        }
        return queryItems
    }
    
    private func urlComponents(scheme: String?, host: String?, path: String, queryItems: [URLQueryItem]?) -> URLComponents? {
        var components = URLComponents()
        components.path = path
        components.host = host
        components.scheme = scheme
        components.queryItems = queryItems
        return components
    }
}
