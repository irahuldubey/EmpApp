//
//  EmployeeTests.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/31/22.
//

import XCTest

final class EmployeeTests: XCTestCase {

    func testEmployeeElementTests() {
        
        let stubElement = EmployeeElement(uuid: "UUID",
                                          fullName: "FULLNAME",
                                          emailAddress: "EMAIL",
                                          phoneNumber: "PHONENUMBER",
                                          biography: "BIO",
                                          photoURLSmall: "PHOTOSMALL",
                                          photoURLLarge: "PHOTOLARGE",
                                          team: "TEAM",
                                          employeeType: .contractor)
        
        XCTAssertEqual(stubElement.employeeType, .contractor)
        XCTAssertEqual(stubElement.uuid, "UUID")
        XCTAssertEqual(stubElement.fullName, "FULLNAME")
        XCTAssertEqual(stubElement.phoneNumber, "PHONENUMBER")
        XCTAssertEqual(stubElement.biography, "BIO")
        XCTAssertEqual(stubElement.photoURLSmall, "PHOTOSMALL")
        XCTAssertEqual(stubElement.photoURLLarge, "PHOTOLARGE")
        XCTAssertEqual(stubElement.team, "TEAM")
    }
}
