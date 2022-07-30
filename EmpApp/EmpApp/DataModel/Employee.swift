//
//  Employee.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/29/22.
//

import Foundation

// MARK: - Employee
struct Employees: Codable {
    let employees: [EmployeeElement]
}

// MARK: - EmployeeElement
struct EmployeeElement: Codable {
    let uuid, fullName, emailAddress: String
    let phoneNumber: String?
    let biography: String?
    let photoURLSmall, photoURLLarge: String?
    let team: String?
    let employeeType: EmployeeType?

    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }
}

// MARK: - EmployeeType
enum EmployeeType: String, Codable {
    case contractor = "CONTRACTOR"
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
}

