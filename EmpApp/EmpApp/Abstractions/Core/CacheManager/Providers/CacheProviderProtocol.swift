//
//  CacheProviderProtocol.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/31/22.
//

import Foundation

public protocol CacheProviderProtocol {
    
    func load(key: String) -> Data?
    
    func save(key: String, value: NSData?)
    
    func clearCache()
    
}
