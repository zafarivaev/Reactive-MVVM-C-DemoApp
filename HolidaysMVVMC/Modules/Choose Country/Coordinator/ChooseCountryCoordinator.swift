//
//  ChooseCountryCoordinator.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift
import ReactiveCoordinator

enum ChooseCountryCoordinationResult {
    case country(String)
    case cancel
}

class ChooseCountryCoordinator: ReactiveCoordinator<ChooseCountryCoordinationResult> {
    
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<CoordinationResult> {
        let viewController = ChooseCountryViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let viewModel = ChooseCountryViewModel()
        viewController.viewModel = viewModel
        
        let country = viewModel.selectedCountry.map { CoordinationResult.country($0) }
        let cancel = viewModel.didClose.map { _ in
            CoordinationResult.cancel
        }
        
        rootViewController.present(navigationController, animated: true, completion: nil)
        
        return Observable.merge(country, cancel)
            .take(1)
            .do(onNext: { _ in
                viewController.dismiss(animated: true, completion: nil)
            })
    }
    
}
