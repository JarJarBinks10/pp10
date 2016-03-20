//
//  Projects.swift
//  Personal Project3
//
//  Created by Nick Patel on 2015-09-13.
//  Copyright (c) 2015 Nick Patel. All rights reserved.
//

import UIKit

class ProjectTableviewController: UITableViewController {

    // MARK: Properties
    var projects = [ProjectInfo]()

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ProjectTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ProjectTableViewCell
        // Fetches the appropriate meal for the data source layout.
        let project = projects[indexPath.row]
        cell.nameLabel.text = project.name
        cell.totalDaysLabel.text = String(NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: project.startDate, toDate: project.dueDate, options: NSCalendarOptions()).day) + " days allocated"
        return cell
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            projects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        // Load the sample data.
        loadSampleProjects()
    }

    func loadSampleProjects () {
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let startDate1 = dateformatter.dateFromString("2016-03-01")!
        let dueDate1 = dateformatter.dateFromString("2016-04-03")!
        let project1 = ProjectInfo (name: "Read all Marvel comic books.", startDate: startDate1, dueDate: dueDate1)!
        let startDate2 = dateformatter.dateFromString("2016-04-07")!
        let dueDate2 = dateformatter.dateFromString("2016-05-09")!
        let project2 = ProjectInfo (name: "Read all DC comic books.", startDate: startDate2, dueDate: dueDate2)!
        let startDate3 = dateformatter.dateFromString("2016-06-01")!
        let dueDate3 = dateformatter.dateFromString("2016-06-05")!
        let project3 = ProjectInfo (name: "Watch all superhero movies.", startDate: startDate3, dueDate: dueDate3)!
        projects += [project1, project2, project3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToProjectList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ProjectViewController, projectInfo = sourceViewController.projectInfo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing project.
                projects[selectedIndexPath.row] = projectInfo
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new project.
                let newIndexPath = NSIndexPath(forRow: projects.count, inSection: 0)
                projects.append(projectInfo)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let projectDetailViewController = segue.destinationViewController as! ProjectViewController
            // Get the cell that generated this segue.
            if let selectedProjectCell = sender as? ProjectTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedProjectCell)!
                let selectedProject = projects[indexPath.row]
                projectDetailViewController.projectInfo = selectedProject
            }
        } else if segue.identifier == "AddItem" {
            print("Adding new project.")
        }
    }

}
