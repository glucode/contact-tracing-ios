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
    case bluetoothOff
    case bluetoothDisabled
}

class MainViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralManagerDelegate {

    
    let peripheralManager = CBPeripheralManager()
    let manager = ENManager()

    private var bluetoothManager: CBCentralManager?
    private var appState: AppState = .contactTracingOff
    private var stateContentViewController: UIViewController?
    
    @IBOutlet weak var statusContainerView: UIView!
    @IBOutlet weak var radarContainerView: RadarView!
    
    override func viewDidLoad() {
//        bluetoothManager = CBCentralManager(delegate: self, queue: nil, options: nil)
//        peripheralManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showOnboarding()
        configureManager()
        updateUI()
    }
    
    func showOnboarding() {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: false, completion: nil)
    }
    
    func configureManager() {

        manager.activate { error in
            guard error == nil else { return }

            self.manager.setExposureNotificationEnabled(true) { error in
                guard error == nil else { return }
            }
        }
    }
    
    
    func updateUI() {
        switch appState {
        case .contactTracingOn:
            showContactTracingOn(withDetections: false)
        case .bluetoothOff:
            showBluetoothOff()
        case .bluetoothDisabled:
            showBluetoothDisabled()
        default:
            showContactTracingOff()
        }
    }
    
    func showContactTracingOn(withDetections: Bool) {
        let storyboard = UIStoryboard.init(name: "ContactTracingEnabled", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        addStateContentController(controller)
        radarContainerView.enableTracing()
    }
    
    func showContactTracingOff() {
        let storyboard = UIStoryboard.init(name: "ContactTracingDisabled", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        addStateContentController(controller)
        radarContainerView.disableTracing()
    }
    
    func showBluetoothOff() {
        let storyboard = UIStoryboard.init(name: "BluetoothOff", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        addStateContentController(controller)
        radarContainerView.disableTracing()
    }
    
    func showBluetoothDisabled() {
        let storyboard = UIStoryboard.init(name: "BluetoothDisabled", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        addStateContentController(controller)
        radarContainerView.disableTracing()
    }
    
    func showBluetoothUnknown() {
        let storyboard = UIStoryboard.init(name: "BluetoothDisabled", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        addStateContentController(controller)
        radarContainerView.disableTracing()
    }
    
    private func addStateContentController(_ child: UIViewController) {
        if let currentChild = stateContentViewController {
            removeStateContentController(currentChild)
        }
        
        stateContentViewController = child
        
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
    
    // MARK: -
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch self.bluetoothManager?.state {
        case .poweredOn:
            switch ENManager.authorizationStatus {
            case .authorized:
                appState = .contactTracingOn
            default:
                appState = .contactTracingOff
            }
        case .poweredOff:
            appState = .bluetoothOff
        case .unauthorized:
            appState = .bluetoothDisabled
        default:
            #if targetEnvironment(simulator)
            appState = .contactTracingOn
            #else
            appState = .contactTracingOff
            #endif
        }
        
        updateUI()
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        switch peripheral.state {
        case .poweredOn:
            debugPrint("CB State: poweredOn")
//            var keyData = Data(count: 16)
//            let result = keyData.withUnsafeMutableBytes {
//                (mutableBytes: UnsafeMutablePointer<UInt8>) -> Int32 in
//                SecRandomCopyBytes(kSecRandomDefault, 16, mutableBytes)
//            }
//
//            // Contact Detection service UUID
//            let serviceUUID = CBUUID(string: "FD6F")
//
//            // Rolling Proximity Identifier
//            let identifier: Data = keyData// 16 bytes
//            let advertisementData: [String: Any] = [
//                CBAdvertisementDataServiceUUIDsKey: [serviceUUID],
//                CBAdvertisementDataServiceDataKey: identifier
//            ]
//
//            peripheralManager.startAdvertising(advertisementData)
            break
        case .unknown:
            debugPrint("CB State: unknown")
            break
        case .resetting:
            debugPrint("CB State: resetting")
            break
        case .unsupported:
            debugPrint("CB State: unsupported")
            break
        case .unauthorized:
            debugPrint("CB State: unauthorized")
            break
        case .poweredOff:
            debugPrint("CB State: poweredOff")
            break
        @unknown default:
            break
        }
    }
}
