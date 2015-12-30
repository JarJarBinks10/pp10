//
//  ViewController.swift
//  Personal Project3
//
//  Created by Nick Patel on 2015-09-13.
//  Copyright (c) 2015 Nick Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var countdown: UILabel!
    @IBOutlet weak var startdate: UIDatePicker!
    @IBOutlet weak var duedate: UIDatePicker!
    
    @IBAction func hello(sender: AnyObject) {
        println("startdate = \(startdate.date)")
        println("duedate = \(duedate.date)")
        var seconds:Int = Int(duedate.date.timeIntervalSinceDate(startdate.date))
        var minutes:Int = seconds/60
        seconds = seconds%60
        var hours:Int = minutes/60
        minutes = minutes%60
        var days:Int = hours/24
        hours = hours%24
        println("days = \(days)")
        println("hours = \(hours)")
        println("minutes = \(minutes)")
        println("seconds = \(seconds)")
        var datestring = String(days) + ":"
        datestring = datestring + String(hours)
        datestring = datestring + ":"
        datestring = datestring + String(minutes)
        datestring = datestring + ":"
        datestring = datestring + String(seconds)
        countdown.text = datestring
        println(textField.text)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueTest") {
            var DestViewController : Projects = segue.destinationViewController as! Projects
            var newproject = Project(name: textField.text, startDate: startdate.date, endDate: duedate.date)
            projectlist.append (newproject)
            var svc = segue.destinationViewController as! Projects;
            svc.toPass = textField.text
        }
    }
    
    // Text Feild Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true;
    }

}

