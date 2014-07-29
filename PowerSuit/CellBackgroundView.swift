//
//  CellBackgroundView.swift
//  PowerSuit
//
//  Created by Michael Teeuw on 29-07-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit

class CellBackgroundView: UIView {
    

    var hue:Float = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var active:Bool = true{
        didSet {
            setNeedsDisplay()
        }
    }
    
    var cornerSize:CGFloat = 15{
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect)
    {
        
        var context = UIGraphicsGetCurrentContext();
        CGContextClearRect(context, self.bounds);
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointZero)
        path.addLineToPoint(CGPoint(x: self.bounds.size.width - cornerSize, y: 0))
        path.addLineToPoint(CGPoint(x: self.bounds.size.width, y: cornerSize))
        path.addLineToPoint(CGPoint(x: self.bounds.size.width, y: self.bounds.size.height))
        path.addLineToPoint(CGPoint(x: 0, y: self.bounds.size.height))
        path.addLineToPoint(CGPoint(x: 0, y: 0))
        
        
        UIColor(hue: CGFloat(hue), saturation: 1, brightness: 1, alpha: 1).setStroke()
        path.stroke()
        
        if (active) {
            UIColor(hue: CGFloat(hue), saturation: 1, brightness: 1, alpha: 0.5).setFill()
        } else {
            UIColor(hue: CGFloat(hue), saturation: 1, brightness: 1, alpha: 0.1).setFill()
        }
        
        path.fill()
    }
}
