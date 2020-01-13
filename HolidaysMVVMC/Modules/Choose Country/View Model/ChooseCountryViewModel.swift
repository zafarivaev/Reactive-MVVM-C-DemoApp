//
//  ChooseCountryViewModel.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift
import RxCocoa

struct ChooseCountryViewModel {
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Actions
    let selectedCountry = PublishSubject<String>()
    let close = PublishSubject<Void>()
    let searchText = PublishSubject<String>()
    
    // MARK: - Table View Model & Data Source
    let fetchedCountries = BehaviorRelay<[CountrySection]>(value: [])
    let filteredCountries = BehaviorRelay<[CountrySection]>(value: [])
    
    let dataSource = CountriesDataSource.dataSource()
    
    // MARK: - API Call
    func fetchCountries(onSuccess: @escaping () -> (),
                        onError: @escaping (String) -> ()) {
        
        CountriesService.shared.getCountries(success: { (code, countries) in
            
            let countryItems = countries.countries!.compactMap { CountryItem(code: $0.code!, name: $0.name!, flag: $0.flag!)
            }
            self.fetchedCountries.accept([CountrySection(items: countryItems)])
            self.filteredCountries.accept([CountrySection(items: countryItems)])
            
            self.bindFilter()
            onSuccess()
            
        }) { (error) in
            onError(error)
        }
    }
    
    func bindFilter() {

        self.searchText.subscribe(onNext: { (text) in
            
            if !text.isEmpty {
                let items = self.fetchedCountries.value[0].items.filter {
                    $0.name.range(of: text,
                                  options: .caseInsensitive,
                                  range: nil, locale: nil) != nil
                }
                
                self.filteredCountries.accept([CountrySection(items: items)])
            } else {
                self.filteredCountries.accept(self.fetchedCountries.value)
            }
        })
            .disposed(by: disposeBag)
        
    }
}
