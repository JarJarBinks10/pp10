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
    var tasks = NSMutableArray()

    // MARK: Initialization
    init?(name: String, startDate: NSDate, dueDate: NSDate, notes: String = "", tasks: NSMutableArray = NSMutableArray()) {
        // Initialization should fail if there is no name or if dueDate is before startDate.
        if name.isEmpty || startDate.compare(dueDate) != .OrderedAscending {
            return nil
        }
        // Initialize stored properties.
        self.name = name
        self.startDate = startDate
        self.dueDate = dueDate
        self.notes = notes
        self.tasks = tasks
        super.init()
    }

    func updateNotes(notes: String) {
        self.notes = notes
    }

    func addTask(name: String, startDate: NSDate, dueDate: NSDate) {
        if let newTask = Task(name: name, startDate: startDate, dueDate: dueDate) {
            tasks.addObject(newTask)
            sortTasks()
        }
    }

    func removeTask(index: Int) {
        tasks.removeObjectAtIndex(index)
    }

    func updateTask(index: Int, task: Task) {
        tasks[index] = task;
        sortTasks()
    }

    func getTask(index: Int) -> Task {
        return tasks[index] as! Task
    }

    func countTasks() -> Int {
        return tasks.count
    }

    func sortTasks() {
        // Sort in this order:
        // 1. For all tasks that have already started, sort by due date (earliest to latest).
        // 2. For all tasks that haven't started yet, sort by start date (earliest to latest).
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
        let tasks = aDecoder.decodeObjectForKey("tasks") as! NSMutableArray
        self.init(name: name, startDate: startDate, dueDate: dueDate, notes: notes, tasks: tasks)
    }

}