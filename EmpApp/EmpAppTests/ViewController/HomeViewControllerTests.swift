//
//  HomeViewControllerTests.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/31/22.
//

import XCTest
@testable import EmpApp

final class HomeViewControllerTests: XCTestCase {
    
    private var sut: HomeViewController?

    override func setUp() {
        super.setUp()
    }
    
    // Testing properties of HomeViewController
    func testViewControllerIsInitialized() throws {
        sut = HomeViewController()
        XCTAssertNotNil(sut?.viewModel, "ViewModel is nil")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
