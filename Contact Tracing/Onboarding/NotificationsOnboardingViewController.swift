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

    @IBOutlet weak var enableNotificationsView: UIView!
    @IBOutlet weak var notificationsNotEnabledView: UIView!
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
            break
        case .notDetermined:
            requestNotificationsPermission()
        case .denied:
            self.navigationController?.dismiss(animated: false, completion: nil)
        }
    }
}

// MARK: - UI
extension NotificationsOnboardingViewController {
    private func updateUI() {
        DispatchQueue.main.async {
            self.enableNotificationsView.isHidden = true
            self.notificationsNotEnabledView.isHidden = false
            self.actionButton.setTitle("Continue", for: .normal)
        }
    }
}

// MARK: - Permissions
extension NotificationsOnboardingViewController {
    private func requestNotificationsPermission() {
        NotificationManager.shared.requestAuthorisation { (granted, error) in
            if granted {
                // TODO: Move to next screen
                return
            } else {
                self.updateUI()
            }
        }
    }

    private func determineNotificationsPermissions() {
        NotificationManager.shared.authorisationStatus { (status) in
            switch status {
            case .authorized:
                self.notificationPermissionState = .authorized
            case .denied:
                self.notificationPermissionState = .denied
                self.updateUI()
            case .provisional, .notDetermined:
                break
            @unknown default:
                break
            }
        }
    }
}

public enum NotificationPermissionState {
    case authorized, notDetermined, denied
}
