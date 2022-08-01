//
//  MockAppConfigurationService.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/30/22.
//

@testable import EmpApp

final class MockAppConfigurationService: AppConfigurationServiceProtocol {
   
    private let domain: String
    private let path: String
    
    init(with domain: String = "", path: String = "") {
        self.domain = domain
        self.path = path
    }
    
    var empDomain: String {
        !domain.isEmpty ? domain : "DOMAIN"
    }
    
    var empPath: String {
        !path.isEmpty ? path : "EMP_PATH"
    }
    
    var empBadPath: String { "BAD_PATH"  }
    var empEmptyPath: String { "EMPTY_PATH"  }
    
}
