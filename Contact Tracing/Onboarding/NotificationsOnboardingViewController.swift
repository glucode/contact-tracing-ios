//
//  NotificationsOnboardingViewController.swift
//  Contact Tracing
//
//  Created by Nico du Plessis on 2020/05/01.
//  Copyright © 2020 Glucode (Pty) Ltd. All rights reserved.
//

import Foundation
import UIKit

class NotificationsOnboardingViewController: UIViewController {

    @IBOutlet weak var notificationBadgeView: DesignableView!
    @IBOutlet weak var notificationImageView: DesignableImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var openSettingsButton: UIButton!
    @IBOutlet weak var actionButton: PillButton!

    private var notificationPermissionState: NotificationPermissionState = .notDetermined

    override func viewDidLoad() {
        super.viewDidLoad()
        determineNotificationsPermissions()
    }

    @IBAction func onOpenSettingsTap(_ sender: UIButton) {
        UIApplication.shared.openAppSettings()
    }
    
    @IBAction func actionButtonPressed(_ sender: Any) {
        switch notificationPermissionState {
        case .authorized:
            continueToNextStep()
            break
        case .notDetermined:
            requestNotificationsPermission()
        case .denied:
            continueToNextStep()
        }
    }
}

// MARK: - UI
extension NotificationsOnboardingViewController {
    private func updateUIForRequestPermission() {
        DispatchQueue.main.async {
            self.notificationBadgeView.isHidden = false
            self.notificationImageView.image = UIImage(named: "notifications-bell-white")
            self.notificationImageView.backgroundColor = UIColor(named: "dark-card-background-color")
            self.titleLabel.text = "Enable notifications"
            self.messageLabel.isHidden = true
            self.openSettingsButton.isHidden = true
            self.actionButton.setTitle("Enable Notifications", for: .normal)
        }
    }

    private func updateUIForDeniedPermission() {
        DispatchQueue.main.async {
            self.notificationBadgeView.isHidden = true
            self.notificationImageView.tintColor = UIColor.label
            self.notificationImageView.image = UIImage(named: "notifications-bell-off")
            self.notificationImageView.backgroundColor = UIColor.secondarySystemBackground
            self.titleLabel.text = "Please enable notifications"
            self.messageLabel.isHidden = false
            self.openSettingsButton.isHidden = false
            self.actionButton.setTitle("Continue", for: .normal)
        }
    }
    
    private func updateUIForAuthorizedPermission() {
        DispatchQueue.main.async {
            self.notificationBadgeView.isHidden = false
            self.notificationImageView.image = UIImage(named: "notifications-bell-white")
            self.notificationImageView.backgroundColor = UIColor(named: "dark-card-background-color")
            self.titleLabel.text = "Notifications are enabled"
            self.messageLabel.isHidden = true
            self.openSettingsButton.isHidden = true
            self.actionButton.setTitle("Continue", for: .normal)
        }
    }
}

// MARK: - Permissions
extension NotificationsOnboardingViewController {
    private func requestNotificationsPermission() {
        NotificationManager.shared.requestAuthorisation { (granted, error) in
            self.determineNotificationsPermissions()
        }
    }

    private func determineNotificationsPermissions() {
        NotificationManager.shared.authorisationStatus { (status) in
            switch status {
            case .authorized:
                self.notificationPermissionState = .authorized
                self.updateUIForAuthorizedPermission()
            case .denied:
                self.notificationPermissionState = .denied
                self.updateUIForDeniedPermission()
            case .provisional, .notDetermined:
                self.updateUIForRequestPermission()
            @unknown default:
                break
            }
        }
    }
}

// MARK: - Presenting
extension NotificationsOnboardingViewController {
    func continueToNextStep() {
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: false, completion: nil)
        }
    }
}

public enum NotificationPermissionState {
    case authorized, notDetermined, denied
}
