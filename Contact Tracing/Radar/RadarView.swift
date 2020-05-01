//
//  RadarView.swift
//  Contact Tracing
//
//  Created by Nico du Plessis on 2020/04/30.
//  Copyright © 2020 Glucode (Pty) Ltd. All rights reserved.
//

import Foundation
import UIKit
import HGRippleRadarView

class RadarView: UIView {
    private var userBeaconImageView: UIImageView?
    private var userBeaconBackgroundImageView: UIImageView?
    private var userBeaconRippleView: RippleView?
    
    override func awakeFromNib() {
        configureRippleView()
        configureUserBeaconImageView()
        configureUserImage()
        enableTracing()
    }
    
    func configureUserBeaconImageView()  {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        userBeaconBackgroundImageView = imageView
        userBeaconBackgroundImageView?.image = UIImage(named: "user-beacon-background-active")
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
        
        userBeaconImageView = imageView
        disableTracing()
    }
    
    func configureRippleView() {
        let rippleView = RippleView(frame: bounds)
        addSubview(rippleView)
        
        rippleView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            rippleView.leftAnchor.constraint(equalTo: leftAnchor),
            rippleView.rightAnchor.constraint(equalTo: rightAnchor),
            rippleView.topAnchor.constraint(equalTo: topAnchor),
            rippleView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        
        let color = UIColor(red: 47/255.0, green: 128/255.0, blue: 237/255.0, alpha: 0.12)
        rippleView.circleOnColor = color
        rippleView.circleOffColor = color
        rippleView.diskColor = UIColor(red: 47/255.0, green: 128/255.0, blue: 237/255.0, alpha: 1.0)
        rippleView.animationDuration = 1.3
        
        userBeaconRippleView = rippleView
    }
    
    func enableTracing() {
        userBeaconImageView?.image = UIImage(named: "user-beacon-active")
        userBeaconRippleView?.isHidden = false
        userBeaconBackgroundImageView?.isHidden = false
    }
    
    func disableTracing() {
        userBeaconImageView?.image = UIImage(named: "user-beacon")
        userBeaconRippleView?.isHidden = true
        userBeaconBackgroundImageView?.isHidden = true
    }
}
