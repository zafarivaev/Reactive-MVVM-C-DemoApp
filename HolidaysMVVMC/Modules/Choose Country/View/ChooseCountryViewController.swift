//
//  ChooseCountryViewController.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChooseCountryViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavItem()
        
        bindTableView()
        bindSearchBar()
        bindCloseItem()
        
        showProgress()
        viewModel.fetchCountries(onSuccess: {
            self.hideProgress()
        }) { (error) in
            self.hideProgress()
            self.showMessage(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    // MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel: ChooseCountryViewModel!
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a country"
        return searchBar
    }()
    
    lazy var closeItem: UIBarButtonItem = {
        let closeItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: nil)
        return closeItem
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView
            .translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
}

// MARK: - Binding
extension ChooseCountryViewController {
    func bindTableView() {
        viewModel.filteredCountries
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CountryItem.self)
            .map { $0.code }
            .bind(to: viewModel.selectedCountry)
            .disposed(by: disposeBag)
    }
    
    func bindCloseItem() {
        closeItem.rx.tap
            .bind(to: viewModel.close)
            .disposed(by: disposeBag)
    }
    
    func bindSearchBar() {
        searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
    }
}

// MARK: - UI Setup
extension ChooseCountryViewController {
    func setupUI() {
        overrideUserInterfaceStyle = .light
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)

        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
    }
    
    func setupNavBar() {
        self.navigationController?
            .navigationBar
            .tintColor = .white
    }
    
    func setupNavItem() {
        self.navigationItem.titleView = searchBar
        self.navigationItem.leftBarButtonItem = closeItem
    }
}

