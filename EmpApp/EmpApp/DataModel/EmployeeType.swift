//
//  EmployeeType.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/31/22.
//

import Foundation

// MARK: - EmployeeType
enum EmployeeType: String, Codable {
    case contractor = "CONTRACTOR"
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    
    var shortDescription: String {
        switch self {
        case .contractor:
            return "C"
        case .fullTime:
            return "FTE"
        case .partTime:
            return "PT"
        }
    }
}

