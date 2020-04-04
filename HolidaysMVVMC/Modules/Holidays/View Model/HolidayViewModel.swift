//
//  HolidayViewModel.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift

struct HolidayViewModel {
    
    let didClose = PublishSubject<Void>()
    
    let title: String
    let date: String
    let country: String
    let isPublic: Bool
    
    init(holiday: Holiday) {
        
        self.title = holiday.name!
        self.date = holiday.date!
        self.country = holiday.country!
        self.isPublic = holiday.public!
    }
    
}
