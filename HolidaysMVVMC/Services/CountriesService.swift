//
//  CountriesService.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import Foundation

class CountriesService {
    
    static let shared = { CountriesService() }()
    
    func getCountries(success: @escaping (Int, Countries) -> (), failure: @escaping (String) -> ()) {
        
        APIClient.shared.get(urlString: API_GET_COUNTRIES, success: { (code, countries) in
            success(code, countries)
        }) { (error) in
            failure(error)
        }
    }
}
