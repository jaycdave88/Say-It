//
//  NewSoundViewController.swift
//  My Sound Board
//
//  Created by DEV MODE on 6/7/15.
//  Copyright (c) 2015 DEV MODE. All rights reserved.
//

import UIKit

class newSoundViewContoller : UIViewController{
    
    @IBOutlet weak var soundTextName: UITextField!
    
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
        sound.name = self.soundTextName.text
        
        // add that sound to the sound array
        self.soundListViewController.sounds.append(sound)
        
        // dismiss this view controller 
        
        
        
        self.dismissViewControllerAnimated(true, completion: nil ) // dismiss
    }
}