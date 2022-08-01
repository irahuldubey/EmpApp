//
//  MockFileManager.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/31/22.
//

import Foundation

final class MockFileManager: FileManager {
    
    var itemRemoved: Bool = false
    
    private let testURL: String
    
    init(testURL: String) {
        self.testURL = testURL
    }
    
    override func removeItem(at URL: URL) throws {
        itemRemoved = true
    }
    
    override func url(for directory: FileManager.SearchPathDirectory, in domain: FileManager.SearchPathDomainMask, appropriateFor url: URL?, create shouldCreate: Bool) throws -> URL {
        return URL(string: testURL)!
    }
    
}
