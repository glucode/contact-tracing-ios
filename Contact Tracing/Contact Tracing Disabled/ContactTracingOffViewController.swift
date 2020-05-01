//
//  ContactTracingOffViewController.swift
//  Contact Tracing
//
//  Created by Nico du Plessis on 2020/04/30.
//  Copyright © 2020 Glucode (Pty) Ltd. All rights reserved.
//

import Foundation
import UIKit
import ExposureNotification

class ContactTracingOffViewController: UIViewController {
    var exposureManager: ENManager?
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func enableContactTracing(_ sender: Any) {
//        let manager = ENManager()
//        manager.activate { error in
//            guard error == nil else { return }
//
//            manager.setExposureNotificationEnabled(true) { error in
//                guard error == nil else { return }
//
//                // app is now advertising and monitoring for tracing identifiers
//            }
//            
//            self.exposureManager = manager
//        }
    }
    
    deinit {
//        manager.invalidate()
    }
}
