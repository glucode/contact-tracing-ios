//
//  MainViewController.swift
//  Contact Tracing
//
//  Created by Nico du Plessis on 2020/04/29.
//  Copyright © 2020 Glucode (Pty) Ltd. All rights reserved.
//
import UIKit
import CoreBluetooth
import ExposureNotification

enum AppState {
    case onboardingRequired
    case contactTracingOn
    case contactTracingOff
}

class MainViewController: UIViewController, CBCentralManagerDelegate {
    private var bluetoothManager: CBCentralManager?
    private var appState: AppState = .contactTracingOff
    private var stateContentViewController: UIViewController?
    
    @IBOutlet weak var statusContainerView: UIView!
    @IBOutlet weak var radarContainerView: RadarView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bluetoothManager = CBCentralManager(delegate: self, queue: nil, options: nil)
        
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch self.bluetoothManager?.state {
        case .poweredOn:
            switch ENManager.authorizationStatus {
            case .authorized:
                appState = .contactTracingOn
                showContactTracingOn(withDetections: false)
            default:
                appState = .contactTracingOff
                showContactTracingOff()
            }
        case .poweredOff:
            appState = .contactTracingOff
            showBluetoothOff()
        case .unauthorized:
            appState = .contactTracingOff
            showBluetoothDisabled()
        default:
            #if targetEnvironment(simulator)
            appState = .contactTracingOff
            showContactTracingOn(withDetections: false)
            #else
            appState = .contactTracingOff
            showBluetoothUnknown()
            #endif
        }
        
        if appState == .contactTracingOn {
            radarContainerView.enableTracing()
        } else {
            radarContainerView.disableTracing()
        }
    }
    
    func showContactTracingOn(withDetections: Bool) {
        let storyboard = UIStoryboard.init(name: "ContactTracingEnabled", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        addStateContentController(controller)
    }
    
    func showContactTracingOff() {
        let storyboard = UIStoryboard.init(name: "ContactTracingDisabled", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        addStateContentController(controller)
    }
    
    func showBluetoothOff() {
        let storyboard = UIStoryboard.init(name: "BluetoothOff", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        addStateContentController(controller)
    }
    
    func showBluetoothDisabled() {
        let storyboard = UIStoryboard.init(name: "BluetoothDisabled", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        addStateContentController(controller)
    }
    
    func showBluetoothUnknown() {
        let storyboard = UIStoryboard.init(name: "BluetoothDisabled", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        addStateContentController(controller)
    }
    
    private func addStateContentController(_ child: UIViewController) {
        if let currentChild = stateContentViewController {
            removeStateContentController(currentChild)
        }
        
        addChild(child)
        statusContainerView.addSubview(child.view)
        child.didMove(toParent: self)
        
        guard let superView = child.view.superview else { return }
        child.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            child.view.leftAnchor.constraint(equalTo: superView.leftAnchor),
            child.view.rightAnchor.constraint(equalTo: superView.rightAnchor),
            child.view.topAnchor.constraint(equalTo: superView.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func removeStateContentController(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
