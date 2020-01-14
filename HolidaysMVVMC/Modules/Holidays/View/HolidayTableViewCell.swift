//
//  HolidayTableViewCell.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

class HolidayTableViewCell: UITableViewCell {
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    // MARK: - Properties
    var viewModel: HolidayViewModel! {
        didSet {
            self.configure()
        }
    }
    
    lazy var holidayTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
}

// MARK: - Configuration
extension HolidayTableViewCell {
    private func configure() {
        holidayTitleLabel.text = viewModel.title
    }
}

// MARK: - UI Setup
extension HolidayTableViewCell {
    func setupUI() {
        self.contentView.addSubview(holidayTitleLabel)
        
        holidayTitleLabel
            .translatesAutoresizingMaskIntoConstraints = false
        holidayTitleLabel.centerXAnchor
            .constraint(equalTo: self.contentView.centerXAnchor)
            .isActive = true
        
        holidayTitleLabel.centerYAnchor
            .constraint(equalTo: self.contentView.centerYAnchor)
            .isActive = true
    }
}
