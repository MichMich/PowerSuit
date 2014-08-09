//
//  FeedbackView.swift
//  PowerSuit
//
//  Created by Michael Teeuw on 09-08-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit

class FeedbackView: UIView {

    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: bounds.size.width, y: 0))
        
        UIColor(hue: 0.3, saturation: 1, brightness: 1, alpha: 1).setStroke()
        
        path.stroke()
    }
    
}
