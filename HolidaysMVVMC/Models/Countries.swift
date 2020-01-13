//
//  Countries.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import ObjectMapper

struct Countries: Mappable {
    var countries: [Country]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        countries <- map["countries"]
    }
}

struct Country: Mappable {
    var code: String?
    var name: String?
    var flag: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        name <- map["name"]
        flag <- map["flag"]
    }
}
