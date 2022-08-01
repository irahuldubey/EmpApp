//
//  EmployeeTypeTests.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/31/22.
//

import XCTest

final class EmployeeTypeTests: XCTestCase {

    func testEmployeeTypes() throws {
        XCTAssertEqual(EmployeeType.partTime.rawValue, "PART_TIME")
        XCTAssertEqual(EmployeeType.fullTime.rawValue, "FULL_TIME")
        XCTAssertEqual(EmployeeType.contractor.rawValue, "CONTRACTOR")
    }
    
    func testEmployeeTypesShortDescription() throws {
        XCTAssertEqual(EmployeeType.contractor.shortDescription, "C")
        XCTAssertEqual(EmployeeType.fullTime.shortDescription, "FTE")
        XCTAssertEqual(EmployeeType.partTime.shortDescription, "PT")
    }
}
