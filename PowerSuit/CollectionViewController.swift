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

    let soundVoicePlayer = SoundPlayer()
    let soundEffectPlayer = SoundPlayer()
    let soundBackgroundLoopPlayer = SoundPlayer()
    
    var sectionNames:[String] = []
    var sections:[Section] = []
    
}



// MARK: - Subclassed functions
extension CollectionViewController {
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


        
        
        collectionView.registerClass(PowerSuitCell.self, forCellWithReuseIdentifier: CellIdentifier)
        collectionView.registerClass(PowerSuitHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderIdentifier)
        
        
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        
        
        sections = [
            Section(name: "Loops", items: [
                PowerSuitSoundItem(title: "Heartbeat", hue:0.4, sound: "beat.aiff", type:SoundType.BackgroundLoop),
                PowerSuitSoundItem(title: "Beep", hue:0.4, sound: "beep.aif", type:SoundType.BackgroundLoop),
                PowerSuitSoundItem(title: "Radioscatter", hue:0.4, sound: "radioscatter.wav", type:SoundType.BackgroundLoop)
            ]),
            Section(name: "Voices", items: [
                PowerSuitActionItem(title: "Randomize Effects", hue:1, saturation:0, action: {
                    (sectionItem:PowerSuitActionItem)->() in
                    
                    sectionItem.active = !sectionItem.active
                    if (sectionItem.active) {
                        self.soundVoicePlayer.startRandomPlaylist([
                            "voice_welcome_future.wav",
                            "left_wing_up.aiff",
                            "left_wing_down.aiff",
                            "right_wing_up.aiff",
                            "right_wing_down.aiff",
                            "both_wings_up.aiff",
                            "both_wings_down.aiff"
                        ], withMinimumInterval: 10, maximumInterval:20)
                    } else {
                        self.soundVoicePlayer.stopRandomPlaylist()
                    }
                }),
                PowerSuitSoundItem(title: "Description", hue:0.45, sound: "description.wav", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Future", hue:0.45, sound: "voice_welcome_future.wav", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Connected", hue:0.45, sound: "voice_connected.wav", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Disconnected", hue:0.45, sound: "voice_disconnected.wav", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Description", hue:0.45, sound: "description.wav", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Left wing up", hue:0.45, sound: "left_wing_up.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Left wing down", hue:0.45, sound: "left_wing_down.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Right wing up", hue:0.45, sound: "right_wing_up.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Right wing down", hue:0.45, sound: "right_wing_down.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Both wings up", hue:0.45, sound: "both_wings_up.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Both wings down", hue:0.45, sound: "both_wings_down.aiff", type:SoundType.Voice),
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
                                "transformers.wav",
                                "robot.wav",
                                "swoosh.wav",
                                "ufo.wav",
                                
                            ], withMinimumInterval: 5, maximumInterval:10)
                        } else {
                            self.soundEffectPlayer.stopRandomPlaylist()
                        }
                }),
                PowerSuitSoundItem(title: "8bit", hue:0.5, sound: "8bit.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Cancel", hue:0.5, sound: "cancel.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Teleport", hue:0.5, sound: "teleport.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Transformers", hue:0.5, sound: "transformers.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Robot", hue:0.5, sound: "robot.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Swoosh", hue:0.5, sound: "swoosh.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "UFO", hue:0.5, sound: "ufo.wav", type:SoundType.Effect)
            ]),
            Section(name: "Actions", items: [
                PowerSuitActionItem(title: "Clear Sound Queue", hue:1, action: {
                    
                    (sectionItem:PowerSuitActionItem)->() in
                    self.soundVoicePlayer.clearQueue()
                    
                }),
                PowerSuitActionItem(title: "Stop All Sounds", hue:1, action: {
                    
                    (sectionItem:PowerSuitActionItem)->() in
                    self.soundVoicePlayer.clearQueue()
                    
                    self.soundVoicePlayer.stop()
                    self.soundEffectPlayer.stop()
                    self.soundBackgroundLoopPlayer.stop()
                })
            ]),
        ]

    }
    
    override func viewDidAppear(animated: Bool)
    {
        moviePlayerController.play()
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        moviePlayerController.stop()
    }

    override func prefersStatusBarHidden() -> Bool
    {
        return true
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
                    case .Effect:
                        cell.pulse()
                        soundEffectPlayer.playSound(item.sound)
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





