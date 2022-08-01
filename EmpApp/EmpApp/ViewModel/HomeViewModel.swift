//
//  HomeViewModel.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/29/22.
//

import Foundation
import Combine

protocol HomeViewModelProtocol {
    // Publishers
    var employeeListPublisher: PassthroughSubject<[EmployeeElement], Never> { get }
    var shouldShowLoadingIndicator: PassthroughSubject<Bool, Never> { get }
    var errorText: PassthroughSubject<String, Never> { get }
    // Methods
    func fetchEmployeeList()
}

final public class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Publishers
    let employeeListPublisher: PassthroughSubject<[EmployeeElement], Never> = .init()
    let shouldShowLoadingIndicator: PassthroughSubject<Bool, Never> = .init()
    let errorText: PassthroughSubject<String, Never> = .init()

    private var empService: EmpServiceProtocol
    
    // MARK: - Init
    init(with empService: EmpServiceProtocol = EmpService()) {
        self.empService = empService
    }

    // MARK: - ServiceMethods
    func fetchEmployeeList() {
            empService.fetchEmpList(modelType: Employees.self) { result in
            DispatchQueue.main.async {
                self.shouldShowLoadingIndicator.send(false)
            }
            switch result {
            case .success(let empObj):
                DispatchQueue.main.async {
                    let sortedByName = empObj.employees.sorted { $0.fullName < $1.fullName }
                    self.employeeListPublisher.send(sortedByName)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorText.send(error.localizedDescription)
                }
            }
        }
    }
}
