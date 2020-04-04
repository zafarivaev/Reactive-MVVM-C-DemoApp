//
//  HolidayDetailViewController.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HolidayDetailViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavItem()
        bindViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.didClose.onNext(())
    }

    // MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel: HolidayViewModel!
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22.0)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name:"
        return label
    }()
    
    lazy var holidayNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22.0)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22.0)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date:"
        return label
    }()
    
    lazy var holidayDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22.0)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22.0)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Country:"
        return label
    }()
    
    lazy var holidayCountryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22.0)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var isPublicLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22.0)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Is Public:"
        return label
    }()
    
    lazy var isHolidayPublicLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 22.0)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}

// MARK: - Binding
extension HolidayDetailViewController {
  
    func bindViewModel() {
        self.holidayNameLabel.text = viewModel.title
        self.holidayDateLabel.text = viewModel.date
        self.holidayCountryLabel.text = viewModel.country
        self.isHolidayPublicLabel.text = viewModel.isPublic ? "True" : "False"
    }
}

// MARK: - UI Setup
extension HolidayDetailViewController {
    func setupUI() {
        overrideUserInterfaceStyle = .light
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(nameLabel)
        self.view.addSubview(holidayNameLabel)
        self.view.addSubview(dateLabel)
        self.view.addSubview(holidayDateLabel)
        self.view.addSubview(countryLabel)
        self.view.addSubview(holidayCountryLabel)
        self.view.addSubview(isPublicLabel)
        self.view.addSubview(isHolidayPublicLabel)
        
        // Name
        nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30.0)
            .isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20.0)
            .isActive = true
        
        holidayNameLabel.topAnchor.constraint(equalTo: self.nameLabel.topAnchor).isActive = true
        
        holidayNameLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20.0).isActive = true
        
        // Date
        dateLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 20.0)
            .isActive = true
        
        dateLabel.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor)
            .isActive = true
        
        holidayDateLabel.topAnchor.constraint(equalTo: self.dateLabel.topAnchor).isActive = true
        
        holidayDateLabel.rightAnchor.constraint(equalTo: self.holidayNameLabel.rightAnchor).isActive = true
        
        // Country
        countryLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 20.0)
            .isActive = true
        
        countryLabel.leftAnchor.constraint(equalTo: self.dateLabel.leftAnchor)
            .isActive = true
        
        holidayCountryLabel.topAnchor.constraint(equalTo: self.countryLabel.topAnchor).isActive = true
        
        holidayCountryLabel.rightAnchor
            .constraint(equalTo: self.holidayDateLabel.rightAnchor).isActive = true
        
        // Public
        isPublicLabel.topAnchor.constraint(equalTo: self.countryLabel.bottomAnchor, constant: 20.0)
            .isActive = true
        
        isPublicLabel.leftAnchor.constraint(equalTo: self.countryLabel.leftAnchor)
            .isActive = true
        
        isHolidayPublicLabel.topAnchor
            .constraint(equalTo: self.isPublicLabel.topAnchor)
            .isActive = true
        
        isHolidayPublicLabel.rightAnchor
            .constraint(equalTo: self.holidayCountryLabel.rightAnchor).isActive = true
    }
    
    func setupNavItem() {
        self.navigationItem.title = "Holiday Detail"
    }
}
