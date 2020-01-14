//
//  HolidaysViewModel.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift
import RxCocoa

class HolidaysViewModel {
    private let disposeBag = DisposeBag()
    
    // MARK: - Actions
    let isLoading = BehaviorSubject<Bool>(value: false)
    let selectedCountry = PublishSubject<String>()
    let selectedHoliday = PublishSubject<HolidayViewModel>()
    let chooseCountry = PublishSubject<Void>()
    
    // MARK: - Table View Model and Data Source
    var holidays = BehaviorSubject<[HolidayViewModel]>(
        value: []
    )
    
    // MARK: - API Call
    func fetchHolidays(onError: @escaping (String) -> ()) {
        
        self.selectedCountry
            .subscribe(onNext: { [weak self] (country) in
                guard let `self` = self else { return }
                
                self.isLoading.onNext(true)
                HolidaysService.shared.getHolidays(country: country, success: { (code, holidays) in
                    self.isLoading.onNext(false)
                    
                    let holidayItems = holidays.holidays!.compactMap { HolidayViewModel(holiday: $0)
                    }
                    self.holidays.onNext(holidayItems)
                    
                }) { (error) in
                    self.isLoading.onNext(false)
                    onError(error)
                }
            })
            .disposed(by: disposeBag)
        
    }
}
