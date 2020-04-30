//
//  RoundedCornerView.swift
//  Contact Tracing
//
//  Created by Nico du Plessis on 2020/04/30.
//  Copyright © 2020 Glucode (Pty) Ltd. All rights reserved.
//

import Foundation
import UIKit

class RoundedCornerView: UIView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
    }
}
