//
//  APIManager.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import Foundation

class APIManager {
    
    static let shared = { APIManager() }()
  
    lazy var baseURL: String = {
        return "https://holidayapi.com/v1/"
    }()
    
    lazy var apiKey: String = {
        return "PASTE YOUR API KEY HERE"
    }()
    
}
