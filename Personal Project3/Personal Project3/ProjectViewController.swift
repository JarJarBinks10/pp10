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

    var project: Project?
    let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)

    func updateTotalDaysLabel() {
        totalDaysLabel.text = String(NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: cal!.startOfDayForDate(startDatePicker.date), toDate: cal!.startOfDayForDate(dueDatePicker.date), options: NSCalendarOptions()).day) + " total days"
    }

    @IBAction func startDateChanged(sender: UIDatePicker) {
        startDatePicker.date = cal!.startOfDayForDate(sender.date)
        updateTotalDaysLabel()
    }

    @IBAction func dueDateChanged(sender: UIDatePicker) {
        dueDatePicker.date = cal!.startOfDayForDate(sender.date)
        updateTotalDaysLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field's user input via delegate callbacks.
        projectNameTextField.delegate = self
        if let project = project {
            navigationItem.title        = project.name
            projectNameTextField.text   = project.name
            startDatePicker.date        = cal!.startOfDayForDate(project.startDate)
            dueDatePicker.date          = cal!.startOfDayForDate(project.dueDate)
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
            project = Project(name: projectNameTextField.text!, startDate: cal!.startOfDayForDate(startDatePicker.date), dueDate: cal!.startOfDayForDate(dueDatePicker.date))
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