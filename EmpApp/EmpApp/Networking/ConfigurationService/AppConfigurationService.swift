//
//  AppConfigurationService.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation

public protocol AppConfigurationServiceProtocol {
    var empDomain: String { get }
    var empPath: String { get }
    var empBadPath: String { get  }
    var empEmptyPath: String { get  }
}

struct AppConfigurationService: AppConfigurationServiceProtocol {
   
    enum Keys: String {
        case domain
        case path
        case badPath
        case emptyPath
    }
    
    var empDomain: String {
        if loadRemoteConfiguration().isEmpty {
            return loadLocalConfiguration()[Keys.domain.rawValue] ?? ""
        } else {
            return  loadRemoteConfiguration()[Keys.domain.rawValue] ?? ""
        }
    }
    
    var empPath: String {
        if loadRemoteConfiguration().isEmpty {
            return loadLocalConfiguration()[Keys.path.rawValue] ?? ""
        } else {
            return loadRemoteConfiguration()[Keys.path.rawValue] ?? ""
        }
    }

    var empBadPath: String {
        if loadRemoteConfiguration().isEmpty {
            return loadLocalConfiguration()[Keys.badPath.rawValue] ?? ""
        } else {
            return loadRemoteConfiguration()[Keys.badPath.rawValue] ?? ""
        }
    }
    
    var empEmptyPath: String {
        if loadRemoteConfiguration().isEmpty {
            return loadLocalConfiguration()[Keys.emptyPath.rawValue] ?? ""
        } else {
            return loadRemoteConfiguration()[Keys.emptyPath.rawValue] ?? ""
        }

    }
    
    // Call the local cache get the configuration
    func loadLocalConfiguration() -> [String: String] {
        var configDictionary = [String: String]()
        configDictionary[Keys.domain.rawValue] = "s3.amazonaws.com"
        configDictionary[Keys.path.rawValue] = "/sq-mobile-interview/employees.json"
        configDictionary[Keys.badPath.rawValue] = "/employees_malformed.json"
        configDictionary[Keys.emptyPath.rawValue] = "/employees_empty.json"
        return configDictionary
    }
    
    // Call the remote service and get the configuration
    func loadRemoteConfiguration() -> [String: String] {
        return [:]
    }
}
