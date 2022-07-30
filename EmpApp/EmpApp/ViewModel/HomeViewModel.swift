//
//  HomeViewModel.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/29/22.
//

import Foundation
import Combine

final public class HomeViewModel {
    
    @Published var isLoading: Bool = false
    @Published var empListResponse: Employees?
    
    
    private var empService: EmpServiceProtocol
    
    init(with empService: EmpServiceProtocol = EmpService()) {
        self.empService = empService
    }

    func fetchEmployeeList() {
        self.empService.fetchEmpList(modelType: Employees.self) { result in
            switch result {
            case .success(let employees):
                debugPrint("EMP", employees)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
