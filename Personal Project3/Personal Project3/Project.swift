//
//  Project.swift
//  Personal Project3
//
//  Created by Preeti Patel on 2015-12-31.
//  Copyright © 2015 Nick Patel. All rights reserved.
//

import Foundation
import UIKit

class Project: NSObject, NSCoding {

    // MARK: Properties
    var name: String
    var startDate: NSDate
    var dueDate: NSDate
    var notes: String
    var tasks = [Task]()

    // MARK: Initialization
    init?(name: String, startDate: NSDate, dueDate: NSDate) {
        // Initialize stored properties.
        self.name = name
        self.startDate = startDate
        self.dueDate = dueDate
        self.notes = ""
        super.init()
        // Initialization should fail if there is no name or if dueDate is before startDate.
        if name.isEmpty || startDate.compare(dueDate) != .OrderedAscending {
            return nil
        }
    }

    convenience init?(name: String, startDate: NSDate, dueDate: NSDate, notes: String) {
        self.init(name: name, startDate: startDate, dueDate: dueDate)
        self.notes = notes
    }

    func updateNotes(notes: String) {
        self.notes = notes
    }

    func addTask(name: String, startDate: NSDate, dueDate: NSDate) {
        tasks.append(Task(name: name, startDate: startDate, dueDate: dueDate)!)
    }

    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(startDate, forKey: "startDate")
        aCoder.encodeObject(dueDate, forKey: "dueDate")
        aCoder.encodeObject(notes, forKey: "notes")
        aCoder.encodeObject(tasks, forKey: "tasks")
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey("name") as! String
        let startDate = aDecoder.decodeObjectForKey("startDate") as! NSDate
        let dueDate = aDecoder.decodeObjectForKey("dueDate") as! NSDate
        let notes = aDecoder.decodeObjectForKey("notes") as! String
        // Must call designated initializer
        self.init(name: name, startDate: startDate, dueDate: dueDate, notes: notes)
        if let savedTasks = aDecoder.decodeObjectForKey("tasks") as? [Task] {
            tasks += savedTasks
        }
    }

}