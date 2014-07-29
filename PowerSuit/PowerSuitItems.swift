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
    init(title:String, hue:Float) {
        self.title = title
        self.hue = hue
    }
}

class PowerSuitActionItem:PowerSuitRowItem {
    var action:()->()
    init(title:String, hue:Float, action:()->()) {
        self.action = action
        super.init(title:title, hue:hue)
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
    init(title:String, hue:Float, sound:String, type:SoundType) {
        self.sound = sound
        self.type = type
        super.init(title:title, hue:hue)
    }
}
