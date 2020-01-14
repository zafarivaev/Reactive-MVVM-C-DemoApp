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
    
    init(country: Country) {
        self.code = country.code!
        self.name = country.name!
    }
}
