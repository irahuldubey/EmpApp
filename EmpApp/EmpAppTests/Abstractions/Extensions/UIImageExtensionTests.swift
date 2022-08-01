//
//  UIImageExtensionTests.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/31/22.
//

import XCTest

final class UIImageExtensionTests: XCTestCase {

    let sampleImage = UIImage(systemName: "heart.fill")

    func testDecodedImage() throws {
        XCTAssertNotNil(sampleImage?.decodedImage)
    }
    
    func testDiskSizeOfImage() throws {
        let size = sampleImage?.diskSize
        XCTAssertEqual(size, 4600)
    }
}
