//
//  FileCacheProviderTests.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/31/22.
//

import XCTest

final class FileCacheProviderTests: XCTestCase {
    
    var sut: FileCacheProvider?

    override func setUp() {
        super.setUp()
        let mockFileManager = MockFileManager(testURL: "file://path")
        sut = FileCacheProvider(cacheDir: "TEST_DIR", manager: mockFileManager)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFileCacheProviderInit() {
      XCTAssertNotNil(sut, "FileCacheProvider init is nil")
    }    
}
