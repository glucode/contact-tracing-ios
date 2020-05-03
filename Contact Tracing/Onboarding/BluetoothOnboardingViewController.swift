//
//  BluetoothOnboardingViewController.swift
//  Contact Tracing
//
//  Created by Nico du Plessis on 2020/05/01.
//  Copyright © 2020 Glucode (Pty) Ltd. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

class BluetoothOnboardingViewController: UIViewController {
    
    @IBOutlet weak var continueButtonWidthConstraint: NSLayoutConstraint!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateContinueButtonWidth()
    }

    func animateContinueButtonWidth() {
        UIView.animate(withDuration: 0.25, animations: {
            self.continueButtonWidthConstraint.constant = self.view.frame.width - 48
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
