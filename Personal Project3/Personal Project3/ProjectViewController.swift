//
//  ProjectViewController.swift
//  Personal Project3
//
//  Created by Nick Patel on 2015-09-13.
//  Copyright (c) 2015 Nick Patel. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var totalDaysLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var createButton: UIBarButtonItem!

    var projectInfo: ProjectInfo?

    @IBAction func calculateProjectDuration(sender: AnyObject) {
        totalDaysLabel.text = String(NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: startDatePicker.date, toDate: dueDatePicker.date, options: NSCalendarOptions()).day) + " Days"

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
            //let name = projectNameTextField.text ?? ""
            projectInfo = ProjectInfo(name: projectNameTextField.text!, startDate: startDatePicker.date, dueDate: dueDatePicker.date)
        }
    }

    // Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

}

