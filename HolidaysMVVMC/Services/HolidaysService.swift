//
//  HolidaysService.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import Foundation

class HolidaysService {
    
    static let shared = { HolidaysService() }()
    
    func getHolidays(country: String, year: String, success: @escaping (Int, Holidays) -> (), failure: @escaping (String) -> ()) {
        
        typealias Parameters = [String : Any]
        
        let parameters: Parameters = ["country": country,
                                      "year": year]
        
        APIClient.shared.get(urlString: API_GET_HOLIDAYS, parameters: parameters, success: { (code, holidays) in
            
            success(code, holidays)
            
        }) { (error) in
            failure(error)
        }
    }
}
