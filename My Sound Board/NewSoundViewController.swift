//
//  NewSoundViewController.swift
//  My Sound Board
//
//  Created by DEV MODE on 6/7/15.
//  Copyright (c) 2015 DEV MODE. All rights reserved.
//

import UIKit
import AVFoundation

class newSoundViewContoller : UIViewController{
    
    required init(coder aDecoder: NSCoder) {
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        
        var pathComponents = [baseString, "MyAudio.m4a"]
        
        self.audioURL = NSURL.fileURLWithPathComponents(pathComponents)!
        
        var session = AVAudioSession.sharedInstance()
        
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var recordSettings: [NSObject : AnyObject] = Dictionary()
        
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        
        recordSettings[AVSampleRateKey] = 44100.0
        
        recordSettings[AVNumberOfChannelsKey] = 2
        
        self.audioRecorder = AVAudioRecorder(URL: audioURL, settings: recordSettings, error: nil)
        
        self.audioRecorder.meteringEnabled = true
        
        self.audioRecorder.prepareToRecord()
        
        // super init is below
        super.init(coder: aDecoder )
    }
    
    @IBOutlet weak var soundTextName: UITextField!
    
    @IBOutlet weak var recordButton: UIButton! // record button
    
    var audioRecorder: AVAudioRecorder // creating a property that has the recorder
    
    var audioURL: NSURL
    
    var soundListViewController = SoundListViewController()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // go n code
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil )
        
    }
    
    @IBAction func save(sender: AnyObject) {
        
        // first create a sound object
        var sound = Sound()
        sound.name = self.soundTextName.text // display name
        sound.URL = self.audioURL
        
        // add that sound to the sound array
        self.soundListViewController.sounds.append(sound) // append to sounds array
        
        // dismiss this view controller
        self.dismissViewControllerAnimated(true, completion: nil ) // dismiss
    }
    @IBAction func record(sender: AnyObject) {
        if self.audioRecorder.recording{
            self.audioRecorder.stop() // if someone is already recording ... stop
            self.recordButton.setTitle("RECORD", forState: UIControlState.Normal) // changing text to record
        } else {
            var sessions = AVAudioSession.sharedInstance() // if no one is recording start recording
            sessions.setActive(true, error: nil)
            self.audioRecorder.record()
            self.recordButton.setTitle("Finished Recording", forState: UIControlState.Normal) // changing text to finished recording
        }

    }
}