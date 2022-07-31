//
//  MockEmpServiceConfiguration.swift
//  EmpAppTests
//
//  Created by Rahul Dubey on 7/30/22.
//

import XCTest
@testable import EmpApp

final class MockEmpServiceOperation: RestServiceOperation {

    public typealias Components = RestServiceRequestConfiguration.PathComponents
    
    private let configService: AppConfigurationServiceProtocol

    init(with configService: AppConfigurationServiceProtocol = MockAppConfigurationService()) {
        self.configService = configService
    }

    private var pathComponents: Components {
        return Components(path: configService.empPath, queryItems: nil)
    }
    
    public var configuration: RestServiceRequestConfiguration {
        let pathComponents = self.pathComponents
        return RestServiceRequestConfiguration(urlString: configService.empDomain,
                                               scheme: .https,
                                               method: .get,
                                               contentType: .json,
                                               urlComponents: pathComponents)
    }
}
