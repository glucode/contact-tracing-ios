//
//  RadarView.swift
//  Contact Tracing
//
//  Created by Nico du Plessis on 2020/04/30.
//  Copyright © 2020 Glucode (Pty) Ltd. All rights reserved.
//

import Foundation
import UIKit

class RadarView: UIView {
    private var userImageView: UIImageView?
    
    override func awakeFromNib() {
        configureUserImage()
        enableTracing()
    }
    
    func configureUserImage()  {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        userImageView = imageView
        disableTracing()
    }
    
    func enableTracing() {
        userImageView?.image = UIImage(named: "user-beacon-active")
    }
    
    func disableTracing() {
        userImageView?.image = UIImage(named: "user-beacon")
    }
}
