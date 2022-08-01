//
//  CacheType.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/31/22.
//

import Foundation

enum CacheType {
    case memoryCache
    case diskCache(dir: String)
}
