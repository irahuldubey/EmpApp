//
//  HomeViewController.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/29/22.
//

import UIKit
import Combine

final class HomeViewController: UIViewController, ActivityIndicatorProtocol {
    
    // MARK: Outlets
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var listTableView: UITableView!
    
    // MARK: Properties
    var viewModel: HomeViewModelProtocol?
    private var allEmployees: [EmployeeElement] = [EmployeeElement]()
    private var cancellables = Set<AnyCancellable>()
    internal var activityIndicator = UIActivityIndicatorView()

    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewModel()
        configureListeners()
        fetchEmployeeList()
        setupNavigationTitle()
        setupPullToRefresh()
        setupErrorView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        ImageDownloadManager.shared.clearCache()
    }
    
    // MARK: Private Functions
    
    private func initViewModel() {
        viewModel = HomeViewModel()
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
        
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel
            .employeeListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] empList in
                guard let self = self else { return }
                self.allEmployees = empList
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
        self.view.bringSubviewToFront(show ? errorView : listTableView)
        self.view.sendSubviewToBack(show ? listTableView: errorView)
    }
    
    @objc
    private func fetchEmployeeList() {
        guard let viewModel = viewModel else {
            return
        }
        allEmployees.removeAll()
        setupActivityIndicator()
        viewModel.fetchEmployeeList()
    }
    
    deinit {
        cancellables.removeAll()
    }
}

// MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.homeCell, for: indexPath) as? HomeTableViewCell
        
        if let cell = cell, !allEmployees.isEmpty {
            cell.configureListCell(with: allEmployees[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees.count
    }
}

