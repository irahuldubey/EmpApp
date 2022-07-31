//
//  CacheConfigTests.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/31/22.
//

import XCTest

final class CacheConfigTests: XCTestCase {

    func testCacheConfig() {
        let config = CacheConfig(countLimit: 100, memoryLimit: 1024)
        XCTAssertEqual(config.countLimit, 100)
        XCTAssertEqual(config.memoryLimit, 1024)
    }
    
    func testDefaultConfig() {
        let defaultConfig = CacheConfig.defaultConfig
        XCTAssertEqual(defaultConfig.memoryLimit, 104857600)
        XCTAssertEqual(defaultConfig.countLimit, 100)
    }
}
