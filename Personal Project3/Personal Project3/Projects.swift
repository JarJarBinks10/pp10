//
//  Projects.swift
//  Personal Project3
//
//  Created by Nick Patel on 2015-09-13.
//  Copyright (c) 2015 Nick Patel. All rights reserved.
//

import UIKit

struct Project {
    var name: String
    var startDate: NSDate
    var endDate: NSDate
}
var projectlist = [Project]()


class Projects: UIViewController {

// MARK: Properties
    @IBOutlet weak var labelPassedData: UILabel!
    
    var toPass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelPassedData.text = toPass
        
        print("List of all projects:")
        for proj in projectlist {
            print("name=\(proj.name)")
            print("startdate=\(proj.startDate)")
            print("enddate=\(proj.endDate)")
        }
        
        // Do any additional setup after loading the view.
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
