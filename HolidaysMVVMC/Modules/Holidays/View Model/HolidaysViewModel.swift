//
//  HolidaysViewModel.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift
import RxCocoa

struct HolidaysViewModel {
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Actions
    let isLoading = BehaviorSubject<Bool>(value: false)
    let selectedCountry = PublishSubject<String>()
    let selectedHoliday = PublishSubject<HolidayItem>()
    let chooseCountry = PublishSubject<Void>()
    
    // MARK: - Table View Model and Data Source
    var holidays = BehaviorRelay<[HolidaySection]>(
        value: []
    )
    let dataSource = HolidayDataSource.dataSource()
    
    // MARK: - API Call
    func fetchHolidays(onError: @escaping (String) -> ()) {
        
        self.selectedCountry
            .subscribe(onNext: { (country) in
                self.isLoading.onNext(true)
                HolidaysService.shared.getHolidays(country: country, year: "2019", success: { (code, holidays) in
                    self.isLoading.onNext(false)
                    
                    let holidayItems = holidays.holidays!.compactMap { HolidayItem(title: $0.name!,
                                    date: $0.date!,
                                    country: $0.country!,
                                    isPublic: $0.public!)
                    }
                    self.holidays.accept([HolidaySection(items: holidayItems)])
                    
                }) { (error) in
                    self.isLoading.onNext(false)
                    onError(error)
                }
            })
            .disposed(by: disposeBag)
        
    }
}
