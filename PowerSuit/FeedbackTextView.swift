//
//  FeedbackTextView.swift
//  PowerSuit
//
//  Created by Michael Teeuw on 09-08-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit

class FeedbackTextView: UITextView {

    let formatter = NSDateFormatter()
    
    override init() {
        super.init()
        setup()
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder:aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer!) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    func setup()
    {
        editable = false
        selectable = false
        //userInteractionEnabled = false
        self.backgroundColor = UIColor.clearColor()
        
        //contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        textColor = UIColor.whiteColor()
        
  
        
        formatter.setLocalizedDateFormatFromTemplate("HH:mm:ss")
    }
    

    
    func addMessage(message:String, color: UIColor = UIColor.whiteColor())
    {
        
        
        
        addText("\n")
        addText(message, color: color)
        addText(" > ", color: UIColor(white: 0.5, alpha: 1))
        addText(formatter.stringFromDate(NSDate(timeIntervalSinceNow: 0)) , color: UIColor(white: 0.5, alpha: 1))
        
        
        
        //scrollRangeToVisible(NSMakeRange(countElements(text as String)-1, 1))
    }
    
    private func addText(textString:String, color: UIColor = UIColor.whiteColor())
    {
        
        let attrString = NSMutableAttributedString(string: textString)
        attrString.addAttribute(NSFontAttributeName, value: UIFont(name: "DINCondensed-Bold", size: 16), range: NSMakeRange(0,countElements(textString)))
        attrString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0,countElements(textString)))
        
        let currentText: NSAttributedString = attributedText as NSAttributedString
        
        let newAttributedText = NSMutableAttributedString(attributedString: attrString)
        newAttributedText.appendAttributedString(currentText)
        

        attributedText = newAttributedText.copy() as NSAttributedString

        
        
        
    }
    
    
    
 
 
    
}
