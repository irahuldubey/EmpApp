//
//  MockEmpService.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation
@testable import EmpApp

final class MockEmpService: EmpServiceProtocol {
 
    let employees: Employees = Employees(employees: [EmployeeElement(uuid: "UUID", fullName: "FULLNAME", emailAddress: "EMAIL", phoneNumber: "PHONENUMBER", biography: "BIO", photoURLSmall: "PHOTSMALLURL", photoURLLarge: "PHOTOLARGEURL", team: "TEAM", employeeType: .fullTime)])
    
    var shouldShowError: Bool = true
    
    func fetchEmpList<T: Codable>(modelType: T.Type, completionHandler: @escaping(Result<T>) -> Void) {
        if shouldShowError {
            let error = EmpService.Error.invalidResponse(404)
            completionHandler(.failure(error))
        } else {
            completionHandler(.success(employees as! T))
        }
    }
}
