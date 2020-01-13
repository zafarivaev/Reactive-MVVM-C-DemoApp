//
//  ChooseCountryDataSource.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxDataSources

struct CountryItem {
    let code: String
    let name: String
    let flag: String
    
    init(code: String,
         name: String,
         flag: String) {
        
        self.code = code
        self.name = name
        self.flag = flag
    }
}

struct CountrySection {
    let items: [CountryItem]
    
    init(items: [CountryItem]) {
        self.items = items
    }
}

extension CountrySection: SectionModelType {
    typealias Item = CountryItem
    
    init(original: Self, items: [Self.Item]) {
        self = original
    }
}

struct CountriesDataSource {
    
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<CountrySection> {
        return .init(configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            
            let cell = CountryTableViewCell()
            cell.viewModel = CountryViewModel(
                code: item.code,
                name: item.name,
                imageURL: item.flag
            )
            cell.configure()
            
            return cell
        })
    }
}
