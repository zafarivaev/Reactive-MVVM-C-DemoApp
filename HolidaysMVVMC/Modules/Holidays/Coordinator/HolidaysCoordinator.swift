//
//  HolidaysCoordinator.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift
import RxViewController

class HolidaysCoordinator: BaseCoordinator<Void> {
    
    let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        
        let viewController = rootViewController as! HolidaysViewController
        let viewModel = HolidaysViewModel()
        viewController.viewModel = viewModel
        
        viewModel.selectedHoliday
            .subscribe({ [weak self] holidayItem in
                
                if let holiday = holidayItem.element {
                    
                    let holidayViewModel = HolidayViewModel(
                        title: holiday.title,
                        date: holiday.date,
                        country: holiday.country,
                        isPublic: holiday.isPublic)
                    
                    self?.coordinateToHolidayDetail(with: holidayViewModel)
                }
                
            })
            .disposed(by: disposeBag)
        
        viewModel.chooseCountry
            .flatMap { [weak self] _ -> Observable<String?> in
                guard let `self` = self else { return .empty() }
                return self.coordinateToChooseCountry()
        }
        .filter { $0 != nil }
        .map { $0! }
        .bind(to: viewModel.selectedCountry)
        .disposed(by: disposeBag)
        
        bindLifeCycle(for: viewController)
        
        return Observable.never()
    }
    
    private func bindLifeCycle(for viewController: UIViewController) {
        viewController.rx.viewWillAppear
            .subscribe({ _ in
                viewController.navigationItem.title = "Holidays"
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Coordination
    private func coordinateToHolidayDetail(with holidayViewModel: HolidayViewModel) {
        let holidayDetailCoordinator = HolidayDetailCoordinator(rootViewController: rootViewController)
        holidayDetailCoordinator.viewModel = holidayViewModel
        coordinate(to: holidayDetailCoordinator)
    }
    
    private func coordinateToChooseCountry() -> Observable<String?> {
        let chooseCountryCoordinator = ChooseCountryCoordinator(rootViewController: rootViewController)
        return coordinate(to: chooseCountryCoordinator)
            .map { result in
                switch result {
                case .country(let country): return country
                case .cancel: return nil
                }
        }
    }
    
}
