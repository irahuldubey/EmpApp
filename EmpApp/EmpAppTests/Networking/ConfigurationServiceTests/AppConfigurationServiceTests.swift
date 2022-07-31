//
//  AppConfigurationServiceTests.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/30/22.
//

import XCTest
@testable import EmpApp

final class AppConfigurationServiceTests: XCTestCase {

    var sut: AppConfigurationServiceProtocol?
    
    override func setUp() {
        super.setUp()
        sut = AppConfigurationService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDomain() throws {
        let sut = try XCTUnwrap(sut)
        XCTAssertEqual(sut.empDomain, "s3.amazonaws.com")
    }
    
    func testEmpPath() throws {
        let sut = try XCTUnwrap(sut)
        XCTAssertEqual(sut.empPath, "/sq-mobile-interview/employees.json")
    }
    
    func testBadPath() throws {
        let sut = try XCTUnwrap(sut)
        XCTAssertEqual(sut.empBadPath, "/employees_malformed.json")
    }

    func testEmptyPath() throws {
        let sut = try XCTUnwrap(sut)
        XCTAssertEqual(sut.empEmptyPath, "/employees_empty.json")
    }
}
