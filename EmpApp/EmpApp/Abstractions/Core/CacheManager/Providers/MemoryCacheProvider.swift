//
//  MemoryCacheProvider.swift
//  
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation
import UIKit

 class MemoryCacheProvider: CacheProviderProtocol {
    
    private let cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()
    
     func loadData(key: String) -> Data? {
        return cache.object(forKey: NSString(string: key)) as Data?
    }
    
     func saveData(key: String, value: NSData?) {
        if let new = value {
            self.cache.setObject(new, forKey: NSString(string: key))
        } else {
            self.cache.removeObject(forKey: NSString(string: key))
        }
    }
    
     func burstCache() {
        cache.removeAllObjects()
    }
}
