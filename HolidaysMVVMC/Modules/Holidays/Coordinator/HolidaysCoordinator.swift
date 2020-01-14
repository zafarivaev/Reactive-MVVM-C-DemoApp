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
                    self?.coordinateToHolidayDetail(with: holiday)
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
        
        return Observable.never()
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
