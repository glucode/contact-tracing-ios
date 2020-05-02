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

    private var stepCounter = 0
    private var _stepCounter: Int {
        get {
            return stepCounter
        } set {
            self.stepCounter = newValue
            updateUIBasedOnStep()
        }
    }

    @IBAction func onNextTap(_ sender: UIButton) {
        if stepCounter < 6 {
            self._stepCounter += 1
        } else {
            performSegue(withIdentifier: "onboardingStepComplete", sender: nil)
        }
    }

    @IBAction func onBackTap(_ sender: UIButton) {
        if stepCounter > 0 && stepCounter < 7 {
            self._stepCounter -= 1
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    private var interfaceStyle: String {
        let style = isDarkMode ? "dark" : "light"
        return style
    }
    
    private func showStepOne() {
        animationView.animation = Animation.named("how-works-step1-\(interfaceStyle)")
        animationView.play()
    }

    func updateUIBasedOnStep() {
        switch stepCounter {
        case 1:
            showStepOne()
        case 2:
            print(stepCounter)
        case 3:
            print(stepCounter)
        case 4:
            print(stepCounter)
        case 5:
            print(stepCounter)
        case 6:
            print(stepCounter)
        default:
            break
        }
    }
    
}

extension UIViewController {
    var isDarkMode: Bool {
        return self.traitCollection.userInterfaceStyle == .dark
    }
}
