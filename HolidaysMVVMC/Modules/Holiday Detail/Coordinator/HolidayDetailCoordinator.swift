//
//  HolidayDetailCoordinator.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import RxSwift
import ReactiveCoordinator

class HolidayDetailCoordinator: ReactiveCoordinator<Void> {
    
    private let rootViewController: UIViewController
    public var viewModel: HolidayViewModel!
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = HolidayDetailViewController()
        viewController.viewModel = viewModel
        
        let didClose = viewModel.didClose
        
        rootViewController.navigationController?
            .pushViewController(viewController, animated: true)
        
        return didClose
            .take(1)
    }
    
}
