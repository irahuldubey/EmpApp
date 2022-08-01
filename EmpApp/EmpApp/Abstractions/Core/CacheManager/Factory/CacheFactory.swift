//
//  CacheFactory.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/31/22.
//

import Foundation

final class CacheFactory {
    
    static func cacheProvider(type: CacheType) -> CacheProviderProtocol {
        switch type {
        case .memoryCache:
            return MemoryCacheProvider()
        case .diskCache(let dir):
            return FileCacheProvider(cacheDir: dir)
        }
    }
}
