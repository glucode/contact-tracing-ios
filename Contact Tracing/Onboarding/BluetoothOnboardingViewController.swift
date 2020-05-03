import Foundation
import UIKit
import CoreBluetooth

class BluetoothOnboardingViewController: UIViewController, CBCentralManagerDelegate {
    private var bluetoothManager: CBCentralManager?
    private var state: BluetoothOnboardingState = .requestPermission
    
    @IBOutlet weak var continueButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bluetoothStateImageView: DesignableImageView!
    @IBOutlet weak var actionButton: PillButton!
    

    private enum BluetoothOnboardingState {
        case requestPermission
        case bluetoothOff
        case bluetoothUnauthorized
        case complete
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            state = .complete
            break
        case .unknown:
            state = .bluetoothOff
            break
        case .resetting:
            break
        case .unsupported:
            state = .bluetoothOff
            break
        case .unauthorized:
            state = .bluetoothUnauthorized
            break
        case .poweredOff:
            state = .bluetoothOff
            break
        @unknown default:
            state = .bluetoothOff
            break
        }
        
        DispatchQueue.main.async {
            self.updateUI()
        }
    }

    
    func startMonitoringBluetoothState() {
        bluetoothManager = CBCentralManager(delegate: self, queue: .main, options: nil)
    }
    
    private func updateUI() {
        switch state {
        case .requestPermission, .bluetoothOff:
            updateUIForBluetoothOff()
            break
        case .complete:
            updateUIForBluetoothOn()
            break
        case .bluetoothUnauthorized:
            updateUIForBluetoothUnauthorized()
            break
        }
    }
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        switch state {
        case .requestPermission:
            startMonitoringBluetoothState()
            break
        case .complete:
            self.performSegue(withIdentifier: "showNotificationsOnboarding", sender: self)
            break
        case .bluetoothOff:
            break
        case .bluetoothUnauthorized:
            break
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateContinueButtonWidth()
        startMonitoringBluetoothState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    func animateContinueButtonWidth() {
        UIView.animate(withDuration: 10.25, animations: {
            self.continueButtonWidthConstraint.constant = self.view.bounds.width - 48
//            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func updateUIForBluetoothOn() {
        titleLabel.text = NSLocalizedString("ONBOARDING_BLUETOOTH_ON_TITLE", comment: "")
        actionButton.setTitle(NSLocalizedString("CONTINUE_BUTTON_TITLE", comment: ""), for: .normal)
        bluetoothStateImageView.backgroundColor = .systemBlue
        bluetoothStateImageView.image = UIImage(named: "bluetooth-on")
    }
    
    private func updateUIForBluetoothOff() {
        titleLabel.text = NSLocalizedString("ONBOARDING_BLUETOOTH_OFF_TITLE", comment: "")
        actionButton.setTitle(NSLocalizedString("SETTINGS_DEEPLINK_BUTTON_TITLE", comment: ""), for: .normal)
        bluetoothStateImageView.backgroundColor = .secondarySystemBackground
        bluetoothStateImageView.image = UIImage(named: "bluetooth-disabled-dark")
    }
    
    private func updateUIForBluetoothUnauthorized() {
        titleLabel.text = NSLocalizedString("ONBOARDING_BLUETOOTH_UNAUTHORIZED_TITLE", comment: "")
        actionButton.setTitle(NSLocalizedString("SETTINGS_DEEPLINK_BUTTON_TITLE", comment: ""), for: .normal)
        bluetoothStateImageView.backgroundColor = .secondarySystemBackground
        bluetoothStateImageView.image = UIImage(named: "bluetooth-disabled-dark")
    }
}
