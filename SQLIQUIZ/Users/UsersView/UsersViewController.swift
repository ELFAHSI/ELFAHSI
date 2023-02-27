//
//  UsersViewController.swift
//  SQLIQUIZ
//
//  Created by OUSSAMA BENNOUR EL FAHSI on 02/1/2023.
//


import UIKit
import Combine

class UsersViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // ViewModel
    var vm = UsersViewModel()
    
    // Variables
    var usersDataSource = [UsersCellViewModel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadTableView()
            }
        }
    }
    
    var page = 1
    var totalPages = 1
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()
    }
    
    // MARK: - Private Methods
    
    private func configView() {
        title = "Quiz SQLi"
        setupTableView()
    }
    
    private func bindViewModel() {
        vm.users.bind { [weak self] users in
            guard let self = self, let users = users else {
                return
            }
            self.usersDataSource.append(contentsOf: users)
            self.totalPages = self.vm.dataSource.totalPages
        }
    }
    
    private func fetchData() {
        let request = UsersModel.Fetch.Request(page: "\(page)")
        vm.getContents(request: request)
    }
    
    // MARK: - TableView Methods
    
    private enum TableSection: Int {
        case users
        case loader
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(UsersViewCell.register(), forCellReuseIdentifier: UsersViewCell.identifier)
    }
    
    private func reloadTableView() {
        tableView.reloadData()
    }
    
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        vm.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        switch listSection {
        case .users:
            return usersDataSource.count
        case .loader:
            return totalPages > page ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersViewCell.identifier, for: indexPath) as? UsersViewCell else {
            return UITableViewCell()
        }
        
        switch section {
        case .users:
            cell.setupCell(viewModel: usersDataSource[indexPath.row])
        case .loader:
            cell.showLoader()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        
        if section == .loader && totalPages > page {
            page += 1
            fetchData()
        }
    }
    
}
