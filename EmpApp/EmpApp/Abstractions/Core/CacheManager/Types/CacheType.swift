//
//  CacheType.swift
//  
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation

// We can add more cache type here and its encapsulated from clients
public enum CacheType {
    case memoryCache

    var cacheProvider: CacheProtocol {
        switch self {
        case .memoryCache:
            return MemoryCacheProvider()
        }
    }
}
