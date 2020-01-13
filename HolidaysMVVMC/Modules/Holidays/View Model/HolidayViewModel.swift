//
//  HolidayViewModel.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import Foundation

struct HolidayViewModel {
    
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
