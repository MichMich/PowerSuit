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
    init(title:String) {
        self.title = title
    }
}

class PowerSuitActionItem:PowerSuitRowItem {
    var action:()->()
    init(title:String, action:()->()) {
        self.action = action
        super.init(title:title)
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
    init(title:String, sound:String, type:SoundType) {
        self.sound = sound
        self.type = type
        super.init(title:title)
    }
}
