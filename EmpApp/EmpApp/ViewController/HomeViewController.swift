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
    }
    
    private func setupPullToRefresh() {
        listTableView.refreshControl = UIRefreshControl()
        listTableView.refreshControl?.attributedTitle = NSAttributedString(string: Constants.Text.pullToRefresh)
        listTableView.refreshControl?.addTarget(self, action: #selector(fetchEmployeeList), for: .valueChanged)
    }
 
    private func setupNavigationTitle() {
        self.navigationItem.title = Constants.NavigationBarTitle.home
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
    }
    
    @objc
    private func fetchEmployeeList() {
        allEmployees.removeAll()
        viewModel.fetchEmployeeList()
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

