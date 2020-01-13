//
//  ChooseCountryCoordinator.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift

enum ChooseCountryCoordinationResult {
    case country(String)
    case cancel
}

class ChooseCountryCoordinator: BaseCoordinator<ChooseCountryCoordinationResult> {
    
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<CoordinationResult> {
        
        
        let viewController = ChooseCountryViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let viewModel = ChooseCountryViewModel()
        viewController.viewModel = viewModel
        
//        viewModel.close
//            .subscribe({ _ in
//                viewController.dismiss(animated: true, completion: nil)
//            })
//            .disposed(by: disposeBag)
        
        let country = viewModel.selectedCountry.map { CoordinationResult.country($0)
        }
        
        let cancel = viewModel.close.map { _ in
            CoordinationResult.cancel
        }
        
        bindLifecycle(for: viewController)
        
        rootViewController.present(navigationController, animated: true, completion: nil)
        
        return Observable.merge(country, cancel)
            .take(1)
            .do(onNext: { _ in
                viewController.dismiss(animated: true, completion: nil)
            })
    }
    
    func bindLifecycle(for viewController: ChooseCountryViewController) {
        
        viewController.rx.viewWillAppear
            .subscribe(onNext: { _ in
                viewController.navigationItem.title = "Choose Your Country"
            })
            .disposed(by: disposeBag)
    }
}
