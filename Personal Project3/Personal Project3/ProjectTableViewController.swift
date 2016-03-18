//
//  Projects.swift
//  Personal Project3
//
//  Created by Nick Patel on 2015-09-13.
//  Copyright (c) 2015 Nick Patel. All rights reserved.
//

import UIKit

//struct Project {
//    var name: String
//    var startDate: NSDate
//    var endDate: NSDate
//}

class ProjectTableviewController: UITableViewController {


    // MARK: Properties
    var projects = [ProjectInfo]()
    //@IBOutlet weak var labelPassedData: UILabel!
    
    var toPass: String!

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
        cell.remainingTimeLabel.text = String(format: "%f", project.endDate.timeIntervalSinceNow / 60 / 60 / 24)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample data.
        loadSampleProjects()

        //labelPassedData.text = toPass
        
        print("List of all projects:")
        for proj in projects {
            print("name=\(proj.name)")
            print("startdate=\(proj.startDate)")
            print("enddate=\(proj.endDate)")
        }
        
        // Do any additional setup after loading the view.
    }

    func loadSampleProjects () {
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let startdate1 = dateformatter.dateFromString("2016-03-01")!
        let enddate1 = dateformatter.dateFromString("2016-04-03")!
        let project1 = ProjectInfo (name: "Read all Marvel comic books.", startDate: startdate1, endDate: enddate1)!
        let startdate2 = dateformatter.dateFromString("2016-04-07")!
        let enddate2 = dateformatter.dateFromString("2016-05-09")!
        let project2 = ProjectInfo (name: "Read all DC comic books.", startDate: startdate2, endDate: enddate2)!
        let startdate3 = dateformatter.dateFromString("2016-06-01")!
        let enddate3 = dateformatter.dateFromString("2016-06-05")!
        let project3 = ProjectInfo (name: "Watch all superhero movies.", startDate: startdate3, endDate: enddate3)!
        projects += [project1, project2, project3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}