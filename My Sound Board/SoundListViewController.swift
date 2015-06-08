//
//  SoundListViewController.swift
//  My Sound Board
//
//  Created by DEV MODE on 6/7/15.
//  Copyright (c) 2015 DEV MODE. All rights reserved.
//

import UIKit // apples code for all UI related code
import AVFoundation // apple's code for audio and videw
import CoreData


class SoundListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer = AVAudioPlayer() // creating an audio player property as the variable audioplayer
    
    var sounds : [Sound] = [] // creating an array to hold all sounds, in swift you need to tell the array what it will be holding, this is done by ": [Sound]" this tells the array that it will contain Sound objects

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // comment
        self.tableView.dataSource = self // added to make the Table view work
        self.tableView.delegate = self // added to make the Table view work
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // comment
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var request = NSFetchRequest(entityName: "Sound") // allows to go get all the objects stored in core data
        self.sounds = context.executeFetchRequest(request, error: nil)! as! [Sound]
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounds.count // # of rows we want the table view to have based on the contents of sounds array
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var sound = self.sounds[indexPath.row] // searches the index path of each row from the array of sounds and stores to the varibale sounds once it has the correct object
        var cell = UITableViewCell() // each cell on the table
        cell.textLabel!.text = sound.name // adds the correct name from each object to the correct row
        
        if(indexPath.row % 2 == 0){ // adding color to each cell
            cell.backgroundColor = UIColor.lightGrayColor()
            cell.textLabel?.textColor = UIColor.whiteColor()
        }else if (indexPath.row % 2 != 0){
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        return cell // printing the new data into each cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       
        var sound = self.sounds[indexPath.row]
        
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        
        var pathComponents = [baseString, sound.url]
        
        var audioNSURL = NSURL.fileURLWithPathComponents(pathComponents)
        
        self.audioPlayer = AVAudioPlayer(contentsOfURL: audioNSURL, error: nil) // play command while asking for where the audio lives
        
        self.audioPlayer.play() // play audio command on click
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var nextViewController = segue.destinationViewController as! newSoundViewContoller
        nextViewController.soundListViewController = self
    }
    

}

