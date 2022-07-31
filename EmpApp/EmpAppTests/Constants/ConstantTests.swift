//
//  EmpAppTests.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/31/22.
//

import XCTest
@testable import EmpApp

final class ConstantTests: XCTestCase {
    
    func testIndentifiers() throws {
        XCTAssertEqual(Constants.CellIdentifiers.homeCell, "HomeCellIdentifier")
    }
    
    func testNavigationTitle() throws {
        XCTAssertEqual(Constants.NavigationBarTitle.home, "Employee Directory")
    }
    
    func testTexts() throws {
        XCTAssertEqual(Constants.Text.pullToRefresh, "Pull to refresh")
        XCTAssertEqual(Constants.Text.error, "We are unable to load the content right now, please try again later.")
    }
}
