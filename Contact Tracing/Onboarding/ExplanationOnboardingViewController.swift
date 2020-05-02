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
        let starAnimation = Animation.named("ContactTracing_Onboarding_1")
        
        animationView.animation = starAnimation
        animationView.play()
    }
    
}
