//
//  HomeViewModelTests.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/30/22.
//

import XCTest
import Combine
@testable import EmpApp

final class HomeViewModelTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        subscriptions.removeAll()
        super.tearDown()
    }
    
    func testFetchEmployeeResponseForLoadingIndicator() throws {
        let mockService: MockEmpService = MockEmpService()
        let sut = HomeViewModel(with: mockService)

        let expectation = XCTestExpectation()
                
        sut.fetchEmployeeList()

        sut.shouldShowLoadingIndicator
            .sink { val in
                XCTAssertFalse(val, "Indicator is not visible")
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchEmployeeError() throws {

        let mockService: MockEmpService = MockEmpService()
        mockService.shouldShowError = true
        
        let sut = HomeViewModel(with: mockService)
        
        let expectation = XCTestExpectation()
                
        sut.fetchEmployeeList()

        sut.errorText
            .sink { error in
                XCTAssertEqual(error, "Received malformed data from service with code 404, please try again later")
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchEmployeeResponse() throws {
        let mockService: MockEmpService = MockEmpService()
        mockService.shouldShowError = false
        
        let sut = HomeViewModel(with: mockService)
        
        let expectation = XCTestExpectation()
                
        sut.fetchEmployeeList()

        sut.employeeListPublisher
            .sink { result in
                guard let firstEmployee = result.first else {
                    XCTFail("Unable to receive employee value")
                    return
                }
                
                XCTAssertEqual(firstEmployee.fullName, "FULLNAME")
                XCTAssertEqual(firstEmployee.emailAddress, "EMAIL")
                XCTAssertEqual(firstEmployee.phoneNumber, "PHONENUMBER")
                XCTAssertEqual(firstEmployee.biography, "BIO")
                XCTAssertEqual(firstEmployee.photoURLSmall, "PHOTSMALLURL")
                XCTAssertEqual(firstEmployee.photoURLLarge, "PHOTOLARGEURL")
                XCTAssertEqual(firstEmployee.team, "TEAM")
                XCTAssertEqual(firstEmployee.employeeType, .fullTime)
                
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 10)
    }
}
