//
//  Results.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/30/22.
//

import Foundation

 enum Result<T> {
    case success(T)
    case failure(Error)
}

 extension Result {
    func resolve() throws -> T {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}

 extension Result where T == Data {
    func decoded<T: Decodable>(decoder: JSONDecoder = JSONDecoder()) throws -> T {
        let data = try resolve()
        return try decoder.decode(T.self, from: data)
    }
}
