//
//  RestServiceTests.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 8/1/22.
//

import Foundation
import XCTest
@testable import EmpApp

class RestServiceTests: XCTestCase {
    
    var sut: RestService<MockEmpServiceOperation>?
    var urlSession: URLSession!
        
    override func setUp() {
        super.setUp()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }
   
    func testFetchService() {

        let restService = RestService<MockEmpServiceOperation>(urlSession: urlSession)
        
        let testEmployee = Employees.init(employees: [EmployeeElement.init(uuid: "UUID", fullName: "FNAME", emailAddress: "EMAIL", phoneNumber: "PHONE", biography: "BIO", photoURLSmall: "PSMALL", photoURLLarge: "PLARGE", team: "TEAM", employeeType: .contractor)])
        
        let mockData = try! JSONEncoder().encode(testEmployee)
        
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        let mockService = MockAppConfigurationService(with: "s3.amazonaws.com", path: "/sq-mobile-interview/employees.json")
        let mockServiceOperation = MockEmpServiceOperation(with: mockService)
        
        restService.performRestServiceOperation(mockServiceOperation) { response in
            switch response {
            case .success(let parser):
                XCTAssertNotNil(parser.status)
                let decodedData = try! JSONDecoder().decode(Employees.self, from: parser.data!)
                XCTAssertTrue(decodedData.employees.count != 0)
                
                if let firstEmployee = decodedData.employees.first {
                    XCTAssertEqual(firstEmployee.biography, "BIO")
                    XCTAssertEqual(firstEmployee.fullName, "FNAME")
                    XCTAssertEqual(firstEmployee.uuid, "UUID")
                    XCTAssertEqual(firstEmployee.team, "TEAM")
                    XCTAssertEqual(firstEmployee.employeeType, .contractor)
                    XCTAssertEqual(firstEmployee.emailAddress, "EMAIL")
                    XCTAssertEqual(firstEmployee.phoneNumber, "PHONE")
                    XCTAssertEqual(firstEmployee.photoURLSmall, "PSMALL")
                    XCTAssertEqual(firstEmployee.photoURLLarge, "PLARGE")
                }
                
            case .failure(_):
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
