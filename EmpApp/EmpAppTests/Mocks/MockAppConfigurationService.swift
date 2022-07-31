//
//  MockAppConfigurationService.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/30/22.
//

@testable import EmpApp

final class MockAppConfigurationService: AppConfigurationServiceProtocol {
    var empDomain: String { "DOMAIN" }
    var empPath: String { "EMP_PATH" }
    var empBadPath: String { "BAD_PATH"  }
    var empEmptyPath: String { "EMPTY_PATH"  }
}
