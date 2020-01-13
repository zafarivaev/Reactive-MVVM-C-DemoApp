//
//  HolidaysDataSource.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxDataSources

struct HolidayItem {
    let title: String
    let date: String
    let country: String
    let isPublic: Bool
    
    init(title: String,
         date: String,
         country: String,
         isPublic: Bool) {
        
        self.title = title
        self.date = date
        self.country = country
        self.isPublic = isPublic
    }
}

struct HolidaySection {
    let items: [HolidayItem]
    
    init(items: [HolidayItem]) {
        self.items = items
    }
}

extension HolidaySection: SectionModelType {
    typealias Item = HolidayItem
    
    init(original: Self, items: [Self.Item]) {
        self = original
    }
}

struct HolidayDataSource {
    
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    public static func dataSource() -> DataSource<HolidaySection> {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            
            let cell = HolidayTableViewCell()
            cell.viewModel =
                HolidayViewModel(title: item.title,
                                 date: item.date,
                                 country: item.country,
                                 isPublic: item.isPublic)
            cell.configure()
            
            return cell
        })
    }
}
