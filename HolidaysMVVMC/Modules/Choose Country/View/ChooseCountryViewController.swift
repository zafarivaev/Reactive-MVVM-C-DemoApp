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
        bindHUD()
        
        viewModel.fetchCountries { [weak self] (errorMessage) in
            self?.showMessage(errorMessage)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.didClose.onNext(())
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
        closeItem.tintColor = .systemBlue
        return closeItem
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView
            .translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryTableViewCell")
        tableView.tableFooterView = UIView()
        return tableView
    }()
}

// MARK: - Binding
extension ChooseCountryViewController {
    func bindTableView() {
        viewModel.filteredCountries
            .bind(to: tableView.rx.items(cellIdentifier: "CountryTableViewCell", cellType: CountryTableViewCell.self)) { (index, viewModel, cell) in
                cell.viewModel = viewModel
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CountryViewModel.self)
            .map { $0.code }
            .bind(to: viewModel.selectedCountry)
            .disposed(by: disposeBag)
    }
    
    func bindCloseItem() {
        closeItem.rx.tap
            .bind(to: viewModel.didClose)
            .disposed(by: disposeBag)
    }
    
    func bindSearchBar() {
        searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
    }
    
    func bindHUD() {
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.showProgress() : self?.hideProgress()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UI Setup
extension ChooseCountryViewController {
    func setupUI() {
        overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)

        tableView.widthAnchor
            .constraint(equalTo: self.view.widthAnchor)
            .isActive = true
        tableView.heightAnchor
            .constraint(equalTo: self.view.heightAnchor)
            .isActive = true
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

