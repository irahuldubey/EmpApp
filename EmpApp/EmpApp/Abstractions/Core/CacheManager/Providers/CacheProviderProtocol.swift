//
//  CacheProviderProtocol.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/31/22.
//

import Foundation

public protocol CacheProviderProtocol {
    
    func loadData(key: String) -> Data?
    
    func saveData(key: String, value: NSData?)
    
    func burstCache()
    
}
