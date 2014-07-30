//
//  CollectionViewController.swift
//  PowerSuit
//
//  Created by Michael Teeuw on 29-07-14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit
import AVFoundation


struct Section {
    var name:String
    var items:[PowerSuitRowItem]
}

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    
    
    
    let CellIdentifier = "CellIdentifier"
    let HeaderIdentifier = "HeaderIdentifier"
    
    
    
    let movieView = UIView()
    
    let soundVoicePlayer = SoundPlayer()
    let soundEffectPlayer = SoundPlayer()
    let soundBackgroundLoopPlayer = SoundPlayer()
    

    

    
    var sectionNames:[String] = []
    var sections:[Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.clearColor()
        
        

        
        
        
        view.insertSubview(movieView, belowSubview: collectionView)
        movieView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: nil, metrics: nil, views: ["view":movieView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: nil, metrics: nil, views: ["view":movieView]))
        movieView.backgroundColor = UIColor.redColor()

        
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
                PowerSuitSoundItem(title: "Description", hue:0.45, sound: "description.wav", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Left wing up", hue:0.45, sound: "left_wing_up.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Left wing down", hue:0.45, sound: "left_wing_down.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Right wing up", hue:0.45, sound: "right_wing_up.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Right wing down", hue:0.45, sound: "right_wing_down.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Both wings up", hue:0.45, sound: "both_wings_up.aiff", type:SoundType.Voice),
                PowerSuitSoundItem(title: "Both wings down", hue:0.45, sound: "both_wings_down.aiff", type:SoundType.Voice),
            ]),
            Section(name: "Effects", items: [
                PowerSuitSoundItem(title: "Transformers", hue:0.5, sound: "transformers.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Robot", hue:0.5, sound: "robot.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "Swoosh", hue:0.5, sound: "swoosh.wav", type:SoundType.Effect),
                PowerSuitSoundItem(title: "UFO", hue:0.5, sound: "ufo.wav", type:SoundType.Effect)
            ]),
            Section(name: "Actions", items: [
                PowerSuitActionItem(title: "Clear Sound Queue", hue:1, action: {
                    self.soundVoicePlayer.clearQueue()
                    
                }),
                PowerSuitActionItem(title: "Stop All Sounds", hue:1, action: {
                    self.soundVoicePlayer.clearQueue()
                    
                    self.soundVoicePlayer.stop()
                    self.soundEffectPlayer.stop()
                    self.soundBackgroundLoopPlayer.stop()
                })
            ]),
        ]

    }

    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    
    // MARK: - Collection View Data Source Methods
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
        return CGSize(width: view.bounds.size.width, height: 40)
    }
    
    // MARK: - Collection View Delegate Methods
    override func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as PowerSuitCell
        
        switch sections[indexPath.section].items[indexPath.row] {
        case let item as PowerSuitActionItem:
            item.action()
            cell.pulse()
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
