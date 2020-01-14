//
//  ChooseCountryViewModel.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift
import RxCocoa

final class ChooseCountryViewModel {
    private let disposeBag = DisposeBag()
    
    // MARK: - Actions
    let didClose = PublishSubject<Void>()
    let selectedCountry = PublishSubject<String>()
    
    let isLoading = BehaviorSubject<Bool>(value: false)
    let searchText = PublishSubject<String>()
    
    // MARK: - Table View Model & Data Source
    let fetchedCountries = BehaviorSubject<[CountryViewModel]>(value: [])
    let filteredCountries = BehaviorSubject<[CountryViewModel]>(value: [])
    
    // MARK: - API Call
    func fetchCountries(onError: @escaping (String) -> ()) {
        
        self.isLoading.onNext(true)
        CountriesService.shared.getCountries(success: { [weak self] (code, countries) in
            guard let `self` = self else { return }
            
            self.isLoading.onNext(false)
            
            let countryItems = countries.countries!.compactMap {
                CountryViewModel(country: $0)
            }
            
            self.fetchedCountries.onNext(countryItems)
            self.filteredCountries.onNext(countryItems)
            
            self.bindSearchToModel()
        }) { [weak self] (error) in
            guard let `self` = self else { return }
            
            self.isLoading.onNext(false)
            onError(error)
        }
    }
    
    func bindSearchToModel() {
        self.searchText.subscribe(onNext: { [weak self] (text) in
            guard let `self` = self else { return }
            
            switch text.isEmpty {
            case false:
                let countries = try! self.fetchedCountries.value().filter {
                    $0.name.range(of: text, options: .caseInsensitive) != nil
                }
                self.filteredCountries.onNext(countries)
            case true:
                self.filteredCountries.onNext(try! self.fetchedCountries.value())
            }
           
        })
            .disposed(by: disposeBag)
        
    }
}
