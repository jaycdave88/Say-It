//
//  SoundListViewController.swift
//  My Sound Board
//
//  Created by DEV MODE on 6/7/15.
//  Copyright (c) 2015 DEV MODE. All rights reserved.
//

import UIKit // apples code for all UI related code
import AVFoundation // apple's code for audio and video

class SoundListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer = AVAudioPlayer() // creating an audio player property as the variable audioplayer
    
    var sounds : [Sound] = [] // creating an array to hold all sounds, in swift you need to tell the array what it will be holding, this is done by ": [Sound]" this tells the array that it will contain Sound objects 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self // added to make the Table view work
        self.tableView.delegate = self // added to make the Table view work
        
        var soundPath = NSBundle.mainBundle().pathForResource("testing", ofType: "m4a")// where the file is located
        
        var soundURL = NSURL.fileURLWithPath(soundPath!) // creates a url based on the path provided via sound path var
        
        var sound1 = Sound() // creating a new sound object 
        sound1.name = "testing" // providing a name
        sound1.URL = soundURL! // providing a sound URl
        
        self.sounds.append(sound1)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounds.count // # of rows we want the table view to have based on the contents of sounds array
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell() // each cell on the table
        cell.textLabel!.text = "Testing" // added text to the each cell
        return cell // printing the new data into each cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var soundPath = NSBundle.mainBundle().pathForResource("testing", ofType: "m4a")// where the file is located
        
        var soundURL = NSURL.fileURLWithPath(soundPath!) // creates a url based on the path provided via sound path var
        
        self.audioPlayer = AVAudioPlayer(contentsOfURL: soundURL , error: nil) // play command while asking for where the audio lives
        
        self.audioPlayer.play() // play audio command on click
        
    }

}

