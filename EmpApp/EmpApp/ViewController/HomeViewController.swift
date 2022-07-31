//
//  HomeViewController.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/29/22.
//

import UIKit
import Combine
import CorePackage

final class HomeViewController: UIViewController, ActivityIndicatorProtocol {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorView: UIView!
    
    @IBOutlet weak var listTableView: UITableView!
    
    let viewModel: HomeViewModel = HomeViewModel()
    
    private var allEmployees: [EmployeeElement] = [EmployeeElement]()
    private var cancellables = Set<AnyCancellable>()
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureListeners()
        fetchEmployeeList()
        setupNavigationTitle()
        setupActivityIndicator()
        setupPullToRefresh()
        setupErrorView()
    }
    
    private func setupPullToRefresh() {
        listTableView.refreshControl = UIRefreshControl()
        listTableView.refreshControl?.attributedTitle = NSAttributedString(string: Constants.Text.pullToRefresh)
        listTableView.refreshControl?.addTarget(self, action: #selector(fetchEmployeeList), for: .valueChanged)
    }
 
    private func setupNavigationTitle() {
        navigationItem.title = Constants.NavigationBarTitle.home
    }
    
    private func setupErrorView() {
        errorLabel.text = Constants.Text.error
    }
    
    private func setupActivityIndicator() {
        showLoadingIndicator(withSize: CGSize.init(width: 100, height: 100))
        activityIndicator.color = .black
    }
    
    private func configureListeners() {
        viewModel
            .employeeListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] empList in
                guard let self = self else { return }
                print(empList.employees)
                self.allEmployees = empList.employees
                self.listTableView.refreshControl?.endRefreshing()
                self.shouldShowError(show: false)
                self.listTableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel
            .shouldShowLoadingIndicator
            .receive(on: DispatchQueue.main)
            .sink { shouldShowLoadingIndicator in
                self.removeLoadingIndicator()
            }
            .store(in: &cancellables)
        
        viewModel
            .errorText
            .receive(on: DispatchQueue.main)
            .sink { errorText in
                self.errorLabel.text = errorText
                self.shouldShowError(show: true)
            }
            .store(in: &cancellables)
        
    }
    
    private func shouldShowError(show: Bool) {
        if show {
            self.view.bringSubviewToFront(self.errorView)
            self.view.sendSubviewToBack(self.listTableView)
        } else {
            self.view.bringSubviewToFront(self.listTableView)
            self.view.sendSubviewToBack(self.errorView)
        }
    }
    
    @objc
    private func fetchEmployeeList() {
        allEmployees.removeAll()
        viewModel.fetchEmployeeList()
    }
    
    deinit {
        cancellables.removeAll()
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.homeCell, for: indexPath) as? HomeTableViewCell
        cell?.configureListCell(with: allEmployees[indexPath.row])
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees.count
    }
}

