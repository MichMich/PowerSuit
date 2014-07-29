//
//  SoundPlayer.swift
//  PowerSuit
//
//  Created by Michael Teeuw on 29/07/14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import Foundation
import AVFoundation

class SoundPlayer: NSObject, AVAudioPlayerDelegate {
    var audioPlayer:AVAudioPlayer!
    
    var audioPlayers:[AVAudioPlayer] = []
    var queuedSounds:[String] = []
    var playing = false
    
    var loopPlayers = [String:AVAudioPlayer]()
    
    class var sharedInstance : SoundPlayer {
        struct Static {
            static let instance : SoundPlayer = SoundPlayer()
        }
        return Static.instance
    }
    
    init () {
        
    }
    

    func playSound(sound:String) {
        if let audioPlayer = createPlayer(sound) {
            self.audioPlayer = audioPlayer
            audioPlayers.append(audioPlayer)
            audioPlayer.play()
        } else {
            
            println("Could not create player ...")
        }
    }
    
    func loopSound(sound:String) -> Bool {
        if let player = loopPlayers[sound] {
            player.stop()
            loopPlayers.removeValueForKey(sound)
            return false
            
        } else {
            if let audioPlayer = createPlayer(sound) {
                
                
                audioPlayer.numberOfLoops = -1;
                audioPlayer.play()
                
                
                loopPlayers[sound] = audioPlayer
                
            } else {
                
                println("Could not create player ...")
            }
            
            return true
        }
        
    }
    
    func queueSound(sound:String) {
        queuedSounds.append(sound)
        
        if !playing {
            playQueue()
        }
    }
    
    func stop() {
        audioPlayer.stop()
    }
    
    func clearQueue() {
        queuedSounds = []
    }
    
    func playQueue() {
        
        if queuedSounds.count > 0 {
            let sound = queuedSounds[0]
            audioPlayer = createPlayer(sound)
            playing = true
            audioPlayer.play()
            
            queuedSounds.removeAtIndex(0)
        }
    }
    
    
    
    func soundURL(sound:String)->NSURL
    {
        return NSURL.fileURLWithPath("\(NSBundle.mainBundle().resourcePath)/\(sound)")
    }
    
    func createPlayer(sound:String)->AVAudioPlayer?
    {
        var error:NSError?
        
        let soundData = NSData(contentsOfURL: soundURL(sound))
        let audioPlayer = AVAudioPlayer(data: soundData, error: &error)
        if error {
            println("There was an error opening the file: \(error)")
        } else {
            audioPlayer.delegate = self
            return audioPlayer
        }
        return nil
    }
    
    
    // MARK: AVAudioPlayer Delegate Methods
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool)
    {
        playing = false
        
        audioPlayers = audioPlayers.filter( {$0 != player})
        
        playQueue()
    }
}