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
    var subTasks = NSMutableArray()
    
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

    func addSubTask(task: Task) {
        subTasks.addObject(task)
        sortSubTasks()
    }

    func removeSubTask(index: Int) {
        subTasks.removeObjectAtIndex(index)
    }

    func updateSubTask(index: Int, task: Task) {
        subTasks.replaceObjectAtIndex(index, withObject: task)
        sortSubTasks()
    }

    func getSubTask(index: Int) -> Task {
        return subTasks[index] as! Task
    }

    func count() -> Int {
        return subTasks.count
    }

    func sortSubTasks() {
        // Sort in this order:
        // 1. For all tasks that have already started, sort by due date (earliest to latest).
        // 2. For all tasks that haven't started yet, sort by start date (earliest to latest).
    }

}