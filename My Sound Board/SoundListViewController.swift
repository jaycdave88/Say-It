//
//  SoundListViewController.swift
//  My Sound Board
//
//  Created by DEV MODE on 6/7/15.
//  Copyright (c) 2015 DEV MODE. All rights reserved.
//

import UIKit
import AVFoundation

class SoundListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self // added to make the Table view work
        self.tableView.delegate = self // added to make the Table view work
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // # of rows we want the table view to have
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

