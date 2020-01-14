//
//  CountryTableViewCell.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    var viewModel: CountryViewModel! {
        didSet {
            self.configure()
        }
    }
    
    lazy var countryNameLabel: UILabel = {
        let label = UILabel()
        label
            .translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
        label.textColor = .darkGray
        return label
    }()
    
}

// MARK: - Configuration
extension CountryTableViewCell {
    func configure() {
        countryNameLabel.text = viewModel.name
    }
}


// MARK: - UI Setup
extension CountryTableViewCell {
    func setupUI() {
        self.contentView.addSubview(countryNameLabel)
        
        countryNameLabel
            .centerXAnchor
            .constraint(equalTo: self.contentView.centerXAnchor)
            .isActive = true
        
        countryNameLabel
            .centerYAnchor
            .constraint(equalTo: self.contentView.centerYAnchor)
            .isActive = true
    }
}
