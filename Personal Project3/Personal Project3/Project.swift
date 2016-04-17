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

    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let startDateKey = "startDate"
        static let dueDateKey = "dueDate"
        static let notesKey = "notes"
        static let tasksKey = "tasks"
    }

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
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(startDate, forKey: PropertyKey.startDateKey)
        aCoder.encodeObject(dueDate, forKey: PropertyKey.dueDateKey)
        aCoder.encodeObject(notes, forKey: PropertyKey.notesKey)
        //aCoder.encodeObject(tasks, forKey: PropertyKey.tasksKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let startDate = aDecoder.decodeObjectForKey(PropertyKey.startDateKey) as! NSDate
        let dueDate = aDecoder.decodeObjectForKey(PropertyKey.dueDateKey) as! NSDate
        let notes = aDecoder.decodeObjectForKey(PropertyKey.notesKey) as! String
        //let tasks = aDecoder.decodeObjectForKey(PropertyKey.tasksKey) as! [Task]
        // Must call designated initializer
        self.init(name: name, startDate: startDate, dueDate: dueDate, notes: notes)
    }

}