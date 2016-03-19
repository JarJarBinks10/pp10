//
//  ProjectViewController.swift
//  Personal Project3
//
//  Created by Nick Patel on 2015-09-13.
//  Copyright (c) 2015 Nick Patel. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var countdown: UILabel!
    @IBOutlet weak var startdate: UIDatePicker!
    @IBOutlet weak var duedate: UIDatePicker!
    @IBOutlet weak var createButton: UIBarButtonItem!

    var projectInfo: ProjectInfo?

    @IBAction func calculateProjectDuration(sender: AnyObject) {
        print("startdate = \(startdate.date)")
        print("duedate = \(duedate.date)")
        var seconds:Int = Int(duedate.date.timeIntervalSinceDate(startdate.date))
        var minutes:Int = seconds/60
        seconds = seconds%60
        var hours:Int = minutes/60
        minutes = minutes%60
        let days:Int = hours/24
        hours = hours%24
        print("days = \(days)")
        print("hours = \(hours)")
        print("minutes = \(minutes)")
        print("seconds = \(seconds)")
        var datestring = String(days) + ":"
        datestring = datestring + String(hours)
        datestring = datestring + ":"
        datestring = datestring + String(minutes)
        datestring = datestring + ":"
        datestring = datestring + String(seconds)
        countdown.text = datestring
        print(textField.text)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if createButton === sender {
            let name = textField.text ?? ""
            let startDate = startdate.date
            let endDate = duedate.date
            projectInfo = ProjectInfo(name: name, startDate: startDate, endDate: endDate)
            //let newproject = ProjectInfo(name: textField.text!, startDate: startdate.date, endDate: duedate.date)
            //projectlist.append (newproject)
            //let svc = segue.destinationViewController as! ProjectTableviewController
            //svc.name = textField.text!
            //svc.startDate = startdate.date
            //svc.endDate = duedate.date
        }
    }

    // Text Feild Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true;
    }

}

