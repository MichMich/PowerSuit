//
//  TableViewController.swift
//  PowerSuit
//
//  Created by Michael Teeuw on 29/07/14.
//  Copyright (c) 2014 Michael Teeuw. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    
    let CellIdentifier = "CellIdentifier"
    
    
    let soundVoicePlayer = SoundPlayer()
    let soundEffectPlayer = SoundPlayer()
    let soundBackgroundLoopPlayer = SoundPlayer()
    
    let sectionNames:[String] = ["Actions","Voices","Effects","Loops"]
    let sections:[[PowerSuitRowItem]] = [
        [
            PowerSuitActionItem(title: "Action 1", action: {
                println("Action 1")
            }),
            PowerSuitActionItem(title: "Action 2", action: {
                println("Action 2")
            }),
            PowerSuitActionItem(title: "Action 3", action: {
                println("Action 3")
            })
        ],
        [
            PowerSuitSoundItem(title: "Description", sound: "description.wav", type:SoundType.Voice),
            PowerSuitSoundItem(title: "Left wing up", sound: "left_wing_up.aiff", type:SoundType.Voice),
            PowerSuitSoundItem(title: "Left wing down", sound: "left_wing_down.aiff", type:SoundType.Voice),
            PowerSuitSoundItem(title: "Right wing up", sound: "right_wing_up.aiff", type:SoundType.Voice),
            PowerSuitSoundItem(title: "Right wing down", sound: "right_wing_down.aiff", type:SoundType.Voice),
            PowerSuitSoundItem(title: "Both wings up", sound: "both_wings_up.aiff", type:SoundType.Voice),
            PowerSuitSoundItem(title: "Both wings down", sound: "both_wings_down.aiff", type:SoundType.Voice),
        ],
        [
            PowerSuitSoundItem(title: "Transformers", sound: "transformers.wav", type:SoundType.Effect),
            PowerSuitSoundItem(title: "Robot", sound: "robot.wav", type:SoundType.Effect),
            PowerSuitSoundItem(title: "Swoosh", sound: "swoosh.wav", type:SoundType.Effect),
            PowerSuitSoundItem(title: "UFO", sound: "ufo.wav", type:SoundType.Effect)
        ],
        [
            PowerSuitSoundItem(title: "Hartbeat", sound: "beat.aiff", type:SoundType.BackgroundLoop),
            PowerSuitSoundItem(title: "Beep", sound: "beep.aif", type:SoundType.BackgroundLoop),
            PowerSuitSoundItem(title: "Radioscatter", sound: "radioscatter.wav", type:SoundType.BackgroundLoop)
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(PowerSuitCell.self, forCellReuseIdentifier: CellIdentifier)
        
        title = "Power Suit"
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return sections.count
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    override func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String!
    {
        return sectionNames[section]
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let rowItem = sections[indexPath.section][indexPath.row]
        cell.textLabel.text = rowItem.title
        

        switch sections[indexPath.section][indexPath.row] {


        case let item as PowerSuitSoundItem:
            
            /*
            switch item.type {
            case .Voice:
                cell.detailTextLabel.text = "Voice"
            case .Effect:
                cell.detailTextLabel.text = "Effect"
            case .BackgroundLoop:
                cell.detailTextLabel.text = "Loop"
            }
            */
            
            cell.detailTextLabel.text = (item.playing) ? "Playing" : ""
            
            
        default:
            println("Unknown item")
        }
 
        
        return cell
    }
    
    // MARK: - Table view delegate

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        
        
        switch sections[indexPath.section][indexPath.row] {
            case let item as PowerSuitActionItem:
                item.action()
            case let item as PowerSuitSoundItem:
                
                
                switch item.type {
                    case .Voice:
                        soundVoicePlayer.queueSound(item.sound)
                    case .Effect:
                        soundEffectPlayer.playSound(item.sound)
                    case .BackgroundLoop:
                        item.playing = soundBackgroundLoopPlayer.loopSound(item.sound)
                        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
                }
                
                
            
            default:
                println("Unknown item")
        }
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

}
