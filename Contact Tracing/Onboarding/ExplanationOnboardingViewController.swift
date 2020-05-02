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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabelBottomConstraint: NSLayoutConstraint!

    private var interfaceStyle: String {
        let style = isDarkMode ? "dark" : "light"
        return style
    }

    private var stepCounter = 0
    private var _stepCounter: Int {
        get {
            return stepCounter
        } set {
            self.stepCounter = newValue
            showStep(for: newValue)
        }
    }

    @IBAction func onNextTap(_ sender: UIButton) {
        if stepCounter < 5 {
            self._stepCounter += 1
        } else {
            performSegue(withIdentifier: "explanationComplete", sender: nil)
        }
    }

    @IBAction func onBackTap(_ sender: UIButton) {
        if stepCounter > 0 && stepCounter < 5 {
            self._stepCounter -= 1
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    // TODO: Move to ViewModel perhaps?
    var steps = [
        "This app anonymously tracks if you have been nearby someone who tested positive for COVID-19.",
        "Your phone shares a unique number with phones around you. This happens anonymously.",
        "You also receive unique numbers from phones around you. They are stored securely.",
        "If someone tests positive for COVID-19, their unique number is shared with all phones in your country.",
        "Every phone that has been nearby this phone in the last 14 days will receive a notification.",
        "All data is anonymously shared, securely stored, and can’t be traced back to your identity."
    ]
}

// MARK: - Steps
extension ExplanationOnboardingViewController {
    func showStep(for step: Int) {
        changeTextAndAnimate(with: steps[step])
        animationView.animation = Animation.named("how-works-step\(step)-\(interfaceStyle)")
        animationView.play()
    }
}

// MARK: - Animations
extension ExplanationOnboardingViewController {
    func changeTextAndAnimate(with text: String) {
        UIView.animate(withDuration: 0.25, animations: {
            self.descriptionLabelBottomConstraint.constant -= 25
            self.descriptionLabel.alpha = 0
            self.view.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 0.25, animations: {
                self.descriptionLabelBottomConstraint.constant += 25
                self.descriptionLabel?.text = text
                self.descriptionLabel.alpha = 1
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}

extension UIViewController {
    var isDarkMode: Bool {
        return self.traitCollection.userInterfaceStyle == .dark
    }
}
