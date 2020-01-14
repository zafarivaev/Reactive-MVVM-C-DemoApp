//
//  Extensions.swift
//  HolidaysMVVMC
//
//  Created by Zafar on 1/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import PKHUD

// MARK: - UIViewController
extension UIViewController {
    func showProgress() {
        HUD.show(.progress)
    }
    
    func hideProgress() {
        HUD.hide()
    }
    
    func showMessage(_ message: String) {
        HUD.flash(.labeledError(title: nil, subtitle: message), delay: 1.5)
    }
}

