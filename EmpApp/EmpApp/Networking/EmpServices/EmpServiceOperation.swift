//
//  EmpServiceOperation.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation
import RestServicePackage

struct EmpServiceOperation: RestServiceOperation {
    
    public typealias Components = RestServiceRequestConfiguration.PathComponents
    
    private let configService: AppConfigurationServiceProtocol
    
    init(with configService: AppConfigurationServiceProtocol = AppConfigurationService()) {
        self.configService = configService
    }
    
    public var configuration: RestServiceRequestConfiguration {
        let pathComponents = self.pathComponents
        return RestServiceRequestConfiguration(urlString: configService.empDomain,
                                               scheme: .https,
                                               method: .get,
                                               contentType: .json,
                                               urlComponents: pathComponents)
    }
    
    private var pathComponents: Components {
        return Components(path: configService.empPath, queryItems: nil)
    }
}
