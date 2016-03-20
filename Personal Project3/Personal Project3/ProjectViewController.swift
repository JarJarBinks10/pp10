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

    func updateTotalDaysLabel() {
        totalDaysLabel.text = String(NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: startDatePicker.date, toDate: dueDatePicker.date, options: NSCalendarOptions()).day) + " Days"
    }

    @IBAction func startDateChanged(sender: UIDatePicker) {
        updateTotalDaysLabel()
    }

    @IBAction func dueDateChanged(sender: UIDatePicker) {
        updateTotalDaysLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field's user input through delegate callbacks.
        projectNameTextField.delegate = self
        // Enable the Create button only if the text field has a valid Project name.
        checkValidProjectName()
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
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Create button while editing.
        createButton.enabled = false
    }

    func textFieldDidEndEditing(textField: UITextField) {
        checkValidProjectName()
        navigationItem.title = textField.text
    }

    func checkValidProjectName() {
        // Disable the Create button if the text field is empty.
        let text = projectNameTextField.text ?? ""
        createButton.enabled = !text.isEmpty
    }

}

