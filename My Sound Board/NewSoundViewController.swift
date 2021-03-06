//
//  NewSoundViewController.swift
//  My Sound Board
//
//  Created by DEV MODE on 6/7/15.
//  Copyright (c) 2015 DEV MODE. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData


class newSoundViewContoller : UIViewController{
    
    required init(coder aDecoder: NSCoder) {
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        
        self.audioURL = NSUUID().UUIDString + ".m4a"
        var pathComponents = [baseString, self.audioURL]
        var audioNSURL = NSURL.fileURLWithPathComponents(pathComponents)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var recordSettings: [NSObject : AnyObject] = Dictionary()
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        recordSettings[AVSampleRateKey] = 44100.0
        recordSettings[AVNumberOfChannelsKey] = 2
        
        self.audioRecorder = AVAudioRecorder(URL: audioNSURL, settings: recordSettings, error: nil)
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.prepareToRecord()
        
        // super init is below
        super.init(coder: aDecoder )
    }
    
    @IBOutlet weak var soundTextName: UITextField!
    @IBOutlet weak var recordButton: UIButton! // record button
    @IBOutlet weak var textWord: UILabel! // label for user knowing
    
    var audioRecorder: AVAudioRecorder // creating a property that has the recorder
    var audioURL: String
    var soundListViewController = SoundListViewController()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // go n code
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil )
        
    }
    
    @IBAction func save(sender: AnyObject) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext! // finding the core data

        
        // first create a sound object
        var sound = NSEntityDescription.insertNewObjectForEntityForName("Sound", inManagedObjectContext: context) as! Sound
        sound.name = self.soundTextName.text // display name
        sound.url = self.audioURL
        
        // save sound to coredata

        if (sound.name == ""){
            alertMessage()
            
        }else {
            context.save(nil)
            // dismiss this view controller
        self.dismissViewControllerAnimated(true, completion: nil ) // dismiss
        }

    }
    @IBAction func record(sender: AnyObject) {
        
        if self.audioRecorder.recording{
            self.textWord.text = "Finished Recording!" // prints message to textWord label
            self.audioRecorder.stop() // if someone is already recording ... stop
//            self.recordButton.setTitle("RECORD", forState: UIControlState.Normal)// changing text to record
            
           
        } else {
            var sessions = AVAudioSession.sharedInstance() // if no one is recording start recording
            sessions.setActive(true, error: nil)
            self.textWord.text = "Recording ..."
            self.audioRecorder.record()
          
        }

    }

    func alertMessage(){
        let title = "Oops!"
        let message = "Looks like you didn't add a name for your sound!"
        let okayText = "OK"

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okayButton = UIAlertAction(title: okayText, style: UIAlertActionStyle.Cancel, handler: nil)

        alert.addAction(okayButton)
        presentViewController(alert, animated: true, completion: nil)
    }
}