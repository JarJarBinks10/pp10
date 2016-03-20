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
    @IBOutlet weak var saveButton: UIBarButtonItem!

    var projectInfo: ProjectInfo?

    func updateTotalDaysLabel() {
        totalDaysLabel.text = String(NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: startDatePicker.date, toDate: dueDatePicker.date, options: NSCalendarOptions()).day) + " days allocated"
    }

    @IBAction func startDateChanged(sender: UIDatePicker) {
        updateTotalDaysLabel()
    }

    @IBAction func dueDateChanged(sender: UIDatePicker) {
        updateTotalDaysLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field's user input via delegate callbacks.
        projectNameTextField.delegate = self
        if let projectInfo = projectInfo {
            navigationItem.title        = projectInfo.name
            projectNameTextField.text   = projectInfo.name
            startDatePicker.date        = projectInfo.startDate
            dueDatePicker.date          = projectInfo.dueDate
        }
        // Enable the Save button only if the text field has a valid Project name.
        checkValidProjectName()
        updateTotalDaysLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            //let name = projectNameTextField.text ?? ""
            projectInfo = ProjectInfo(name: projectNameTextField.text!, startDate: startDatePicker.date, dueDate: dueDatePicker.date)
        }
    }

    // Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }

    func textFieldDidEndEditing(textField: UITextField) {
        checkValidProjectName()
        navigationItem.title = textField.text
    }

    func checkValidProjectName() {
        // Disable the Save button if the text field is empty.
        let text = projectNameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }

}

