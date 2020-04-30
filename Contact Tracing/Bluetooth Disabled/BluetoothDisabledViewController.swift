//
//  BluetoothDisabledViewController.swift
//  Contact Tracing
//
//  Created by Nico du Plessis on 2020/04/30.
//  Copyright © 2020 Glucode (Pty) Ltd. All rights reserved.
//

import Foundation
import UIKit

class BluetoothDisabledViewController: UIViewController {
    
    
    @IBAction func openBluetoothSettings(_ sender: Any) {
        guard let url = URL(string: "App-Prefs:root=Bluetooth") else { return }
        let app = UIApplication.shared
        
        
        app.open(url, options: [:], completionHandler: nil)
    }
    
}
