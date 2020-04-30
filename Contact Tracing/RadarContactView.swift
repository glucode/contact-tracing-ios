//
//  RadarContactView.swift
//  Contact Tracing
//
//  Created by Nico du Plessis on 2020/04/30.
//  Copyright © 2020 Glucode (Pty) Ltd. All rights reserved.
//

import Foundation
import UIKit

class RadarContactView: UIButton {
    
    override func awakeFromNib() {

    self.layoutIfNeeded()
    layer.cornerRadius = self.frame.height / 2.0
    layer.masksToBounds = true

    }
    
}
