//
//  PowerSuitHeader.swift
//  PowerSuit
//
//  Created by Michael Teeuw on 29-07-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit

class PowerSuitHeader: UICollectionReusableView {
    let mainLabel = UILabel()
    let bgView = CellBackgroundView()
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    private func setup()
    {
        
        self.addSubview(bgView)
        self.addSubview(mainLabel)
        
        bgView.setTranslatesAutoresizingMaskIntoConstraints(false)
        mainLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: nil, metrics: nil, views: ["view":bgView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: nil, metrics: nil, views: ["view":bgView]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[view]|", options: nil, metrics: nil, views: ["view":mainLabel]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-3-[view]|", options: nil, metrics: nil, views: ["view":mainLabel]))
          
        bgView.hue = 0.20
        bgView.active = false
        mainLabel.textColor = UIColor(hue: CGFloat(bgView.hue), saturation: CGFloat(bgView.saturation), brightness: 1, alpha: 1)
        mainLabel.font = UIFont(name: "DINCondensed-Bold", size: 16)
        mainLabel.textAlignment = .Left
        mainLabel.numberOfLines = 0
        mainLabel.text = ""
        
    }
}
