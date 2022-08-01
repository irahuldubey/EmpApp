//
//  EmpServiceOperationTests.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/30/22.
//

import XCTest
@testable import EmpApp

final class EmpServiceOperationTests: XCTestCase {
    
    private var sut: EmpServiceOperation?

    override func setUp() {
        super.setUp()
        let mockAppConfiguration: AppConfigurationServiceProtocol = MockAppConfigurationService()
        sut = EmpServiceOperation(with: mockAppConfiguration)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testValidateEmpServiceConfiguration() throws {
        let sut = try XCTUnwrap(sut)
        let configuration = sut.configuration
        XCTAssertEqual(configuration.urlString, "DOMAIN")
        XCTAssertEqual(configuration.scheme, .https)
        XCTAssertEqual(configuration.method, .get)
        XCTAssertEqual(configuration.contentType, .json)
        XCTAssertNil(configuration.data)
        XCTAssertNotNil(configuration.urlComponents)
    }
}
