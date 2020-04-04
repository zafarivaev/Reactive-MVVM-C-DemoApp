//
//  HolidaysViewController.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit
import PKHUD

import RxSwift
import RxCocoa
import RxDataSources

class HolidaysViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavItem()
        
        bindTableView()
        bindNavItem()
        bindHUD()
        bindVisibilityState()
        
        viewModel.fetchHolidays{ (errorMessage) in
            self.showMessage(errorMessage)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel: HolidaysViewModel!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(HolidayTableViewCell.self,
                           forCellReuseIdentifier: "HolidayTableViewCell")
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var chooseCountryLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 24.0)
        label.textColor = .lightGray
        label.text = "Choose a country first"
        return label
    }()
    
    lazy var chooseCountryItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Choose Country",
                                   style: .plain,
                                   target: self,
                                   action: nil)
        item.tintColor = .systemBlue
        return item
    }()
    
}

// MARK: - Binding
extension HolidaysViewController {
    func bindTableView() {

        viewModel.holidays
            .bind(to: tableView.rx.items(cellIdentifier: "HolidayTableViewCell", cellType: HolidayTableViewCell.self)) { index, viewModel, cell in
                cell.viewModel = viewModel
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(HolidayViewModel.self)
            .bind(to: viewModel.selectedHoliday)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { (indexPath) in
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func bindHUD() {
        
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.showProgress() : self?.hideProgress()
            })
            .disposed(by: disposeBag)
    }
    
    func bindNavItem() {
        chooseCountryItem.rx.tap
            .bind(to: viewModel.chooseCountry)
            .disposed(by: disposeBag)
        
        viewModel.selectedCountry
            .subscribe(onNext: { (country) in
                self.chooseCountryItem.title = country
            })
            .disposed(by: disposeBag)
    }
    
    func bindVisibilityState() {
        viewModel.selectedCountry
            .subscribe(onNext: { _ in
                self.tableView.isHidden = false
                self.chooseCountryLabel.isHidden = true
            })
            .disposed(by: disposeBag)
    }
    

}

// MARK: - UI Setup
extension HolidaysViewController {
    func setupUI() {
        overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        self.view.addSubview(chooseCountryLabel)
        
        tableView
            .translatesAutoresizingMaskIntoConstraints = false

        tableView.widthAnchor
            .constraint(equalTo: self.view.widthAnchor)
            .isActive = true
        tableView.heightAnchor
            .constraint(equalTo: self.view.heightAnchor)
            .isActive = true
        
        chooseCountryLabel
            .translatesAutoresizingMaskIntoConstraints = false
        
        chooseCountryLabel.centerXAnchor
            .constraint(equalTo: self.view.centerXAnchor)
            .isActive = true
        chooseCountryLabel.centerYAnchor
            .constraint(equalTo: self.view.centerYAnchor)
            .isActive = true
    }
    
    func setupNavItem() {
        self.navigationItem.title = "Holidays"
        self.navigationItem.rightBarButtonItem = chooseCountryItem
    }
    
    func setupNavBar() {
        self.navigationController?
            .navigationBar
            .tintColor = .white
    }
}
