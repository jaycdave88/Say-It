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
        
        var sound2 = Sound() // second object
        sound2.name = "Bang"
        sound2.URL = soundURL!
        
        self.sounds.append(sound1) // appending the first sound to list 
        self.sounds.append(sound2) // appending the second sound to the list
    }
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData() // always reloads
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounds.count // # of rows we want the table view to have based on the contents of sounds array
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var sound = self.sounds[indexPath.row] // searches the index path of each row from the array of sounds and stores to the varibale sounds once it has the correct object
        var cell = UITableViewCell() // each cell on the table
        cell.textLabel!.text = sound.name // adds the correct name from each object to the correct row
        return cell // printing the new data into each cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var sound = self.sounds[indexPath.row]
        
        self.audioPlayer = AVAudioPlayer(contentsOfURL: sound.URL, error: nil) // play command while asking for where the audio lives
        
        self.audioPlayer.play() // play audio command on click
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var nextViewController = segue.destinationViewController as! newSoundViewContoller
       nextViewController.soundListViewController = self
    }

}

