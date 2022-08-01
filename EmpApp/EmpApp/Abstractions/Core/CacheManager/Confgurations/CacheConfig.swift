//
//  CacheConfig.swift
//  
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation

 struct CacheConfig {
    
    let countLimit: Int
    let memoryLimit: Int
    
    // 100 Photos and 100 MB is default configuration
     static let defaultConfig = CacheConfig(countLimit: 100, memoryLimit: 1024 * 1024 * 100)
}
