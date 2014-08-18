//
//  CollectionViewController.swift
//  PowerSuit
//
//  Created by Michael Teeuw on 29-07-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit
import MediaPlayer

struct Section {
    var name:String
    var items:[PowerSuitRowItem]
}

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let CellIdentifier = "CellIdentifier"
    let HeaderIdentifier = "HeaderIdentifier"

    let moviePlayerController=MPMoviePlayerController(contentURL: NSBundle.mainBundle().URLForResource("bluefade_pixel", withExtension: "mp4"))

    var soundVoicePlayer = SoundPlayer()
    var soundEffectPlayer = SoundPlayer()
    var soundBackgroundLoopPlayer = SoundPlayer()
    
    var sectionNames:[String] = []
    var sections:[Section] = []
    
    var nrfManager: NRFManager!
    
    let feedbackTextViewHeight = 150.0
    var feedbackView = FeedbackView(frame: CGRectZero)
    var feedbackTextView = FeedbackTextView(frame: CGRectZero)
    
}



// MARK: - Subclassed functions
extension CollectionViewController:NRFManagerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.clearColor()
        
        
        moviePlayerController.controlStyle = MPMovieControlStyle.None
        moviePlayerController.repeatMode = MPMovieRepeatMode.One
        moviePlayerController.scalingMode = MPMovieScalingMode.AspectFill
        
        
        view.insertSubview(moviePlayerController.view, belowSubview: collectionView)
        moviePlayerController.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: nil, metrics: nil, views: ["view":moviePlayerController.view]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: nil, metrics: nil, views: ["view":moviePlayerController.view]))

        
        view.addSubview(feedbackView)
        feedbackView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        feedbackView.backgroundColor = UIColor(white: 0, alpha: 0.75)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: nil, metrics: nil, views: ["view":feedbackView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[view(height)]|", options: nil, metrics: ["height":feedbackTextViewHeight], views: ["view":feedbackView]))

        
        feedbackView.addSubview(feedbackTextView)
        
        collectionView.registerClass(PowerSuitCell.self, forCellWithReuseIdentifier: CellIdentifier)
        collectionView.registerClass(PowerSuitHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderIdentifier)
        

        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: CGFloat(10 + feedbackTextViewHeight), right: 20)
        
        
        sections = [
            Section(name: "Loops", items: [
                PowerSuitSoundItem(title: "Heartbeat", hue:0.4, sound: "beat.aiff", type:SoundType.BackgroundLoop),
                PowerSuitSoundItem(title: "Beep", hue:0.4, sound: "beep.aif", type:SoundType.BackgroundLoop),
                PowerSuitSoundItem(title: "Radioscatter", hue:0.4, sound: "radioscatter.wav", type:SoundType.BackgroundLoop)
            ]),
            Section(name: "Voice", items: [
                PowerSuitSoundItem(title: "Description", hue:0.45, sound: "description.wav", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Yes", hue:0.45, sound: "voice_yes.wav", type:SoundType.Voice),
                PowerSuitSoundItem(title: "No", hue:0.45, sound: "voice_no.wav", type:SoundType.Voice),
                PowerSuitSoundItem(title: "No Answer", hue:0.45, sound: "voice_no_answer.wav", type:SoundType.Voice),
            ]),
            Section(name: "System", items: [
                PowerSuitActionItem(title: "Randomize Effects", hue:1, saturation:0, action: {
                    (sectionItem:PowerSuitActionItem)->() in
                    
                    sectionItem.active = !sectionItem.active
                    if (sectionItem.active) {
                        self.soundVoicePlayer.startRandomPlaylist([
                            "voice_welcome_future.wav",
                            "2034.aiff",
                            "armour.aiff",
                            "connection.aiff",
                            "initializing.aiff",
                            "message.aiff",
                            "overloading.aiff",
                            "power.aiff",
                            "shields.aiff",
                            "upgrade.aiff",
                            "warp.aiff"
                            ], withMinimumInterval: 10, maximumInterval:20)
                    } else {
                        self.soundVoicePlayer.stopRandomPlaylist()
                    }
                }),
                PowerSuitSoundItem(title: "Future", hue:0.45, sound: "voice_welcome_future.wav", type:SoundType.Voice),
                PowerSuitSoundItem(title: "2034", hue:0.45, sound: "2034.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Armour", hue:0.45, sound: "armour.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Connection", hue:0.45, sound: "connection.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Initializing", hue:0.45, sound: "initializing.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Message", hue:0.45, sound: "message.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Overloading", hue:0.45, sound: "overloading.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Power", hue:0.45, sound: "power.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Shields", hue:0.45, sound: "shields.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Upgrade", hue:0.45, sound: "upgrade.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Warp", hue:0.45, sound: "warp.aiff", type:SoundType.Voice),
            ]),
            Section(name: "Effects", items: [
                PowerSuitActionItem(title: "Randomize Effects", hue:1, saturation:0, action: {
                        (sectionItem:PowerSuitActionItem)->() in
                    
                        sectionItem.active = !sectionItem.active
                        if (sectionItem.active) {
                            self.soundEffectPlayer.startRandomPlaylist([
                                "8bit.wav",
                                "cancel.wav",
                                "teleport.wav",
                                //"transformers.wav",
                                "robot.wav",
                                "swoosh.wav",
                                "ufo.wav",
                                //"8bit2.wav",
                                "activate_exit.wav",
                                //"activate.wav",
                                "feedback.wav",
                                "flyby.wav",
                                "glitch.wav",
                                "laser.wav",
                                //"levelup.wav",
                                "menu1.wav",
                                //"robotic.wav",
                                "runner.wav",
                                "siren.mp3",
                                "snes.wav",
                                "ui.wav"
                                
                            ], withMinimumInterval: 5, maximumInterval:10)
                        } else {
                            self.soundEffectPlayer.stopRandomPlaylist()
                        }
                }),
                PowerSuitSoundItem(title: "8bit", hue:0.5, sound: "8bit.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Cancel", hue:0.5, sound: "cancel.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Teleport", hue:0.5, sound: "teleport.wav", type:SoundType.Effect),
                
                PowerSuitSoundItem(title: "Robot", hue:0.5, sound: "robot.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Swoosh", hue:0.5, sound: "swoosh.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "UFO", hue:0.5, sound: "ufo.wav", type:SoundType.Effect),

               
                PowerSuitSoundItem(title: "Activate & Exit", hue:0.5, sound: "activate_exit.wav", type:SoundType.Effect),
                
                
                PowerSuitSoundItem(title: "Feedback", hue:0.5, sound: "feedback.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Flyby", hue:0.5, sound: "flyby.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Glitch", hue:0.5, sound: "glitch.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Laser", hue:0.5, sound: "laser.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Menu", hue:0.5, sound: "menu1.wav", type:SoundType.Effect),
                
                
                PowerSuitSoundItem(title: "Runner", hue:0.5, sound: "runner.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Siren", hue:0.5, sound: "siren.mp3", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Snes", hue:0.5, sound: "snes.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "UI", hue:0.5, sound: "ui.wav", type:SoundType.Effect),
                
                
                PowerSuitSoundItem(title: "Transformers", hue:0.55, sound: "transformers.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "8bit 2", hue:0.55, sound: "8bit2.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Activate", hue:0.55, sound: "activate.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Level up", hue:0.55, sound: "levelup.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Robotic", hue:0.55, sound: "robotic.wav", type:SoundType.Effect)

                
            ]),
            Section(name: "Actions", items: [
                PowerSuitActionItem(title: "Reconnect", hue:1, action: {
                    
                    (sectionItem:PowerSuitActionItem)->() in
                    self.nrfManager.disconnect();
                    
                }),
                PowerSuitActionItem(title: "Stop All Sounds", hue:1, action: {
                    
                    (sectionItem:PowerSuitActionItem)->() in
                    self.soundVoicePlayer.stopRandomPlaylist()
                    self.soundEffectPlayer.stopRandomPlaylist()
                    
                     self.soundVoicePlayer = SoundPlayer()
                     self.soundEffectPlayer = SoundPlayer()
                     self.soundBackgroundLoopPlayer = SoundPlayer()
                }),
                PowerSuitActionItem(title: "Stop Effects", hue:1, action: {
                    
                    (sectionItem:PowerSuitActionItem)->() in
                    self.soundVoicePlayer.stopRandomPlaylist()
                    self.soundEffectPlayer.stopRandomPlaylist()
                    
                    self.soundVoicePlayer = SoundPlayer()
                    self.soundEffectPlayer = SoundPlayer()
                })
               
            ]),
        ]

        
        nrfManager = NRFManager(delegate:self);
        nrfManager.verbose = true;
        
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        moviePlayerController.play()
        feedbackTextView.addMessage("PowerSuit Operating System Loaded!", color: UIColor.yellowColor())
        

        
        println(feedbackTextView.frame)
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        moviePlayerController.stop()
    }

    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        feedbackTextView.frame = CGRectInset(feedbackView.bounds, 15, 5)
        
    }
    
 
    
}

// MARK: - Collection View Data Source Methods
extension CollectionViewController {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int
    {
        return sections.count
    }
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return sections[section].items.count
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
   
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier, forIndexPath: indexPath) as PowerSuitCell
        


        
        
        let rowItem = sections[indexPath.section].items[indexPath.row]
        cell.mainLabel.text = rowItem.title
        cell.hue = rowItem.hue
        cell.saturation = rowItem.saturation
        cell.active = rowItem.active
        
        switch sections[indexPath.section].items[indexPath.row] {
            
            
            case let item as PowerSuitSoundItem:
                
                cell.active = item.playing
                
            default:
                println("Unknown item")
        }
        
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView!, viewForSupplementaryElementOfKind kind: String!, atIndexPath indexPath: NSIndexPath!) -> UICollectionReusableView!
    {
        if (kind == UICollectionElementKindSectionHeader) {
            let reusableview = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderIdentifier, forIndexPath: indexPath) as PowerSuitHeader
            let section = sections[indexPath.section]

            reusableview.mainLabel.text = section.name.uppercaseString
            
            return reusableview;
        }
        
        println(kind)
        return nil;
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize
    {
        return CGSize(width: 80, height: 80)
    }
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }

    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 10
    }

    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSize(width: view.bounds.size.width, height: 30)
    }
    
    
    
}

// MARK: - Collection View Delegate Methods
extension CollectionViewController {
    
    override func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as PowerSuitCell
        
        switch sections[indexPath.section].items[indexPath.row] {
            case let item as PowerSuitActionItem:
                item.action(sectionItem: item)
                if (item.active) {
                    cell.active = item.active
                } else {
                    cell.active = item.active
                    cell.pulse()
                }
            case let item as PowerSuitSoundItem:
                
                switch item.type {
                    case .Voice:
                        cell.pulse()
                        soundVoicePlayer.queueSound(item.sound)
                        feedbackTextView.addMessage("Sound queued: \(item.title)")

                    case .Effect:
                        cell.pulse()
                        soundEffectPlayer.playSound(item.sound)
                        feedbackTextView.addMessage("Effect played: \(item.title)")

                    case .BackgroundLoop:
                        item.playing = soundBackgroundLoopPlayer.loopSound(item.sound)
                        //collectionView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
                        collectionView.reloadItemsAtIndexPaths([indexPath])
                }
                
            default:
                println("Unknown item")
        }
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
    }
}

// MARK: - NRFManagerDelegate Methods
extension CollectionViewController {
    
    func nrfDidConnect(nrfManager:NRFManager)
    {
        println("PowerSuit Connected")
        self.soundVoicePlayer.queueSound("voice_connected.wav")
        feedbackTextView.addMessage("Connected", color: UIColor.greenColor())
    }
    
    func nrfDidDisconnect(nrfManager:NRFManager)
    {
        println("PowerSuit Disconnected")
        self.soundVoicePlayer.queueSound("voice_disconnected.wav")
        feedbackTextView.addMessage("Disconnected", color: UIColor.redColor())

    }
    
    func nrfReceivedData(nrfManager:NRFManager, data:NSData, string:String)
    {
        switch string {
            case "WINGS_ENABLED":
                self.soundVoicePlayer.queueSound("voice_wings_enabled.wav")
                feedbackTextView.addMessage("Wings Enabled", color: UIColor.yellowColor())

            case "WINGS_DISABLED":
                self.soundVoicePlayer.queueSound("voice_wings_disabled.wav")
                feedbackTextView.addMessage("Wings Disabled", color: UIColor.yellowColor())
     
            case "WINGS_BOTH_UP":
                self.soundVoicePlayer.queueSound("voice_both_wings_up.wav")
                feedbackTextView.addMessage("Both Wings Up", color: UIColor.yellowColor())

            case "EFFECT_MODE_LOOP":
                self.soundVoicePlayer.queueSound("voice_scanning.wav")
                feedbackTextView.addMessage("Scanning", color: UIColor.yellowColor())

            case "EFFECT_MODE_SPARKLE":
                self.soundVoicePlayer.queueSound("voice_sparkle.wav")
                feedbackTextView.addMessage("Measuring Radiation", color: UIColor.yellowColor())

            case "EFFECT_MODE_VU":
                self.soundVoicePlayer.queueSound("voice_vu.wav")
                feedbackTextView.addMessage("Spectrum Analyzer", color: UIColor.yellowColor())
            
            case "EFFECT_MODE_PLASMA":
                self.soundVoicePlayer.queueSound("voice_plasma.wav")
                feedbackTextView.addMessage("Plasma mode initiated", color: UIColor.yellowColor())
                
            case "EFFECT_MODE_NONE":
                self.soundVoicePlayer.queueSound("voice_laser_power_off.wav")
                feedbackTextView.addMessage("Lasers Powered Off", color: UIColor.yellowColor())
                
            
            default:
                println("PowerSuit Data: \(string)")
                feedbackTextView.addMessage(string, color: UIColor(white: 0.75, alpha: 1))
        }
        
    }
}


