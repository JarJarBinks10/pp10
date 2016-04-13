//
//  Task.swift
//  Personal Project3
//
//  Created by Preeti Patel on 2016-04-03.
//  Copyright © 2016 Nick Patel. All rights reserved.
//

import Foundation

class Task: NSObject {

    // MARK: Properties
    var name: String
    var startDate: NSDate
    var dueDate: NSDate
    var tasks = [Task]()
    
    // MARK: Initialization
    init?(name: String, startDate: NSDate, dueDate: NSDate) {
        // Initialize stored properties.
        self.name = name
        self.startDate = startDate
        self.dueDate = dueDate
        super.init()
        // Initialization should fail if there is no name or if dueDate is before startDate.
        if name.isEmpty || startDate.compare(dueDate) != .OrderedAscending {
            return nil
        }
    }

    func addTask(name: String, startDate: NSDate, dueDate: NSDate) {
        tasks.append(Task(name: name, startDate: startDate, dueDate: dueDate)!)
    }

}