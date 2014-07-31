//
//  PowerSuitItems.swift
//  PowerSuit
//
//  Created by Michael Teeuw on 29/07/14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import Foundation


class PowerSuitRowItem {
    var title:String
    var hue:Float = 1
    var saturation:Float = 1
    var active:Bool = false
    
    init(title:String, hue:Float, saturation:Float) {
        self.title = title
        self.hue = hue
        self.saturation = saturation
    }
}

class PowerSuitActionItem:PowerSuitRowItem {
    
    var action:(sectionItem:PowerSuitActionItem)->()
    init(title:String, hue:Float, saturation:Float, action:(sectionItem:PowerSuitActionItem)->())
    {
        self.action = action
        super.init(title:title, hue:hue, saturation:saturation)
    }
    
    convenience init(title:String, hue:Float, action:(sectionItem:PowerSuitActionItem)->())
    {
        self.init(title:title, hue:hue, saturation:1.0, action:action)
    }
    
}


enum SoundType {
    case Voice
    case Effect
    case BackgroundLoop
}

class PowerSuitSoundItem:PowerSuitRowItem {
    var sound:String
    var type:SoundType
    var playing = false
    init(title:String, hue:Float, saturation:Float, sound:String, type:SoundType)
    {
        self.sound = sound
        self.type = type
        super.init(title:title, hue:hue, saturation:saturation)
    }
    convenience init(title:String, hue:Float, sound:String, type:SoundType)
    {
        self.init(title:title, hue:hue, saturation:1, sound:sound, type:type)
    }
}

