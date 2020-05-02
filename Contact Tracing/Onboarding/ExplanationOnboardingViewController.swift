//
//  ExplanationOnboardingViewController.swift
//  Contact Tracing
//
//  Created by Nico du Plessis on 2020/05/01.
//  Copyright © 2020 Glucode (Pty) Ltd. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class ExplanationOnboardingViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        showStepOne()
    }
    
    private func showStepOne() {
        if isDarkMode {
            animationView.animation = Animation.named("how-works-step1-dark")
        } else {
            animationView.animation = Animation.named("how-works-step1-light")
        }
        
        animationView.play()
    }
    
}

extension UIViewController {
    var isDarkMode: Bool {
        return self.traitCollection.userInterfaceStyle == .dark
    }
}
