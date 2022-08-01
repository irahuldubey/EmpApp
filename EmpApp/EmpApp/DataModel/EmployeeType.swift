//
//  EmployeeType.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/31/22.
//

// MARK: - EmployeeType
enum EmployeeType: String, Codable {
    case contractor = "CONTRACTOR"
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    
    // Shown on User Interface
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

