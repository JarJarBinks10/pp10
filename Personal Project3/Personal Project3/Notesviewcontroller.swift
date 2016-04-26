//
//  Notesviewcontroller.swift
//  Personal Project3
//
//  Created by Nick Patel on 2016-04-24.
//  Copyright © 2016 Nick Patel. All rights reserved.
//

import UIKit

class Notesviewcontroller: UIViewController {
    
    
    @IBOutlet weak var notesview: UITextView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from the nib
        
        let stringKey = NSUserDefaults.standardUserDefaults()
        notesview.text = stringKey.stringForKey("savedStringKey")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    @IBAction func saveText(sender: AnyObject) {
        
        let myText = notesview.text;
        NSUserDefaults.standardUserDefaults().setObject(myText, forKey: "savedStringKey")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let alert = UIAlertController(title: "Saved", message: "Your notes have been saved", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}