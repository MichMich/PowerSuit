//
//  PowerSuitCell.swift
//  PowerSuit
//
//  Created by Michael Teeuw on 29-07-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit

class PowerSuitCell: UICollectionViewCell {
    
    let cornerSize:CGFloat = 15
    let mainLabel = UILabel()
    let bgView = CellBackgroundView(frame: CGRectZero)
    
    var hue:Float = 1.0 {
        didSet {
            updateUI()
        }
    }
    
    var saturation:Float = 1.0 {
        didSet {
            updateUI()
        }
    }
    
    var active:Bool = false {
        didSet {
            updateUI()
        }
    }
    
    required init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    override func prepareForReuse()
    {
        mainLabel.text = ""
        active = false
        updateUI()
    }
    
    
    func pulse()
    {
        bgView.active = true
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "unpulse", userInfo: nil, repeats: false)
    }
    func unpulse()
    {
        UIView.transitionWithView(bgView, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            self.bgView.active = false
        }, completion: nil)
    }
    
    
    
    
    private func setup()
    {
        

        self.addSubview(bgView)
        self.addSubview(mainLabel)

        bgView.setTranslatesAutoresizingMaskIntoConstraints(false)
        mainLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        

        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: nil, metrics: nil, views: ["view":bgView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: nil, metrics: nil, views: ["view":bgView]))

        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-3-[view]-3-|", options: nil, metrics: nil, views: ["view":mainLabel]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view]-5-|", options: nil, metrics: nil, views: ["view":mainLabel]))
        

        
        mainLabel.textColor = UIColor.whiteColor()
        mainLabel.font = UIFont(name: "DINCondensed-Bold", size: 12)
        mainLabel.textAlignment = .Center
        mainLabel.numberOfLines = 0


        updateUI()
    }
    
    func updateUI()
    {
        mainLabel.textColor = UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: 1, alpha: 1)
        bgView.hue = hue
        bgView.saturation = saturation
        bgView.active = active
    }


    
}
