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
    var projects = [Project]()

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
        cell.totalDaysLabel.text = String(NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: project.startDate, toDate: project.dueDate, options: NSCalendarOptions()).day) + " total days"
        let now = NSDate()
        cell.remainingDaysLabel.text = String(NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: now, toDate: project.dueDate, options: NSCalendarOptions()).day) + " days left"
        return cell
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            projects.removeAtIndex(indexPath.row)
            saveProjects()
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
        // Load any saved projects, otherwise load sample data.
        if let savedProjects = loadProjects() {
            projects += savedProjects
        } else {
            print("No saved projects found.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToProjectList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ProjectViewController, project = sourceViewController.project {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing project.
                projects[selectedIndexPath.row] = project
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new project.
                let newIndexPath = NSIndexPath(forRow: projects.count, inSection: 0)
                projects.append(project)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the projects.
            saveProjects()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let projectDetailViewController = segue.destinationViewController as! ProjectViewController
            // Get the cell that generated this segue.
            if let selectedProjectCell = sender as? ProjectTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedProjectCell)!
                let selectedProject = projects[indexPath.row]
                projectDetailViewController.project = selectedProject
            }
        } else if segue.identifier == "AddItem" {
            print("Adding new project.")
        }
    }

    // MARK: NSCoding
    func saveProjects() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(projects, toFile: Project.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }

    func loadProjects() -> [Project]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Project.ArchiveURL.path!) as? [Project]
    }

}
