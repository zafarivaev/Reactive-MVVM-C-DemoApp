//
//  ChooseCountryViewModel.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift
import RxCocoa

struct CountryViewModel {
    let code: String
    let name: String
    let imageURL: String
    
    init(code: String,
         name: String,
         imageURL: String) {
        
        self.code = code
        self.name = name
        self.imageURL = imageURL
    }
}
