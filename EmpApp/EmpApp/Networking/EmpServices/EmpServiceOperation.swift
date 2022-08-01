//
//  EmpServiceOperation.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation

struct EmpServiceOperation {
    
    typealias Components = RestServiceRequestConfiguration.PathComponents
    
    // MARK: - Private Properties
    private let configService: AppConfigurationServiceProtocol
    
    // MARK: - Init
    init(with configService: AppConfigurationServiceProtocol = AppConfigurationService()) {
        self.configService = configService
    }
    
    private var pathComponents: Components {
        return Components(path: configService.empPath, queryItems: nil)
    }
}

extension EmpServiceOperation: RestServiceOperation {
    var configuration: RestServiceRequestConfiguration {
        let pathComponents = self.pathComponents
        return RestServiceRequestConfiguration(urlString: configService.empDomain,
                                               scheme: .https,
                                               method: .get,
                                               contentType: .json,
                                               urlComponents: pathComponents)
    }
}
