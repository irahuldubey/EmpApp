//
//  MemoryCacheProvider.swift
//  
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation
import UIKit

public class MemoryCacheProvider: CacheProviderProtocol {
    
    private let cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()
    
    public func load(key: String) -> Data? {
        return cache.object(forKey: NSString(string: key)) as Data?
    }
    
    public func save(key: String, value: NSData?) {
        if let new = value {
            self.cache.setObject(new, forKey: NSString(string: key))
        } else {
            self.cache.removeObject(forKey: NSString(string: key))
        }
    }
    
    public func clearCache() {
        cache.removeAllObjects()
    }
}
