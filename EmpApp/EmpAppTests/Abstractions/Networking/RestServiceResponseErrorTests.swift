//
//  RestServiceResponseErrorTests.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/31/22.
//

import Foundation
import XCTest
@testable import EmpApp

final class RestServiceResponseErrorTests: XCTestCase {

    private var sut: RestServiceResponseParser?
    
    func testRestServiceResponseErrorInit() throws {
        let url = try XCTUnwrap(URL(string: "testProjectURL"))
        let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: "", headerFields: nil)
        let unwrappedResponse = try XCTUnwrap(response)
        sut = try RestServiceResponseParser(withResponse: unwrappedResponse, data: Data())
        XCTAssertNotNil(sut, "RestServiceResponseParser is not initialized")
        XCTAssert(sut?.data?.count == 0)
        XCTAssert(sut?.headers.count == 0)
    }
}
