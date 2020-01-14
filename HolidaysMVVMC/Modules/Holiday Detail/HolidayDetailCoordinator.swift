//
//  HolidayDetailCoordinator.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift

class HolidayDetailCoordinator: BaseCoordinator<Void> {
    
    private let rootViewController: UIViewController
    public var viewModel: HolidayViewModel!
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = HolidayDetailViewController()
        viewController.viewModel = viewModel
        
        rootViewController.navigationController?
            .pushViewController(viewController, animated: true)
        return Observable.empty()
    }
    
}
