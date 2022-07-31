//
//  HomeViewModel.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/29/22.
//

import Foundation
import Combine

final public class HomeViewModel {
    
    let employeeListPublisher: PassthroughSubject<Employees, Never> = .init()
    let shouldShowLoadingIndicator: CurrentValueSubject<Bool, Never> = .init(true)
    let errorText: PassthroughSubject<String, Never> = .init()

    private var empService: EmpServiceProtocol
    
    init(with empService: EmpServiceProtocol = EmpService()) {
        self.empService = empService
    }

    func fetchEmployeeList() {
        empService.fetchEmpList(modelType: Employees.self) { result in
            switch result {
            case .success(let employees):
                DispatchQueue.main.async {
                    self.employeeListPublisher.send(employees)
                    self.shouldShowLoadingIndicator.send(false)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorText.send(error.localizedDescription)
                }
            }
        }
    }
}
