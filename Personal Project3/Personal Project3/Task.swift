//
//  Task.swift
//  Personal Project3
//
//  Created by Preeti Patel on 2016-04-03.
//  Copyright © 2016 Nick Patel. All rights reserved.
//

import Foundation

func compareTasks(firstObject: AnyObject, secondObject: AnyObject, context: UnsafeMutablePointer<Void>) -> Int {
    let now = NSDate()
    var tasks = [firstObject as! Task,
                 secondObject as! Task]
    var startDates = [tasks[0].startDate,
                      tasks[1].startDate]
    var dueDates = [tasks[0].dueDate,
                    tasks[1].dueDate]
    var tasksStarted = [tasks[0].startDate.compare(now) == .OrderedAscending,
                        tasks[1].startDate.compare(now) == .OrderedAscending]
    var order: NSComparisonResult
    if tasksStarted[0] &&
       tasksStarted[1] {
        // Both tasks (should) have already started, sort by due dates.
        order = dueDates[0].compare(dueDates[1])
        if order == .OrderedSame {
            // If the due dates are identical, sort by the start date.
            order = startDates[0].compare(startDates[1])
        }
    } else if tasksStarted[0] && !tasksStarted[1] {
        // First task has started but second hasn't.
        order = .OrderedAscending
    } else if !tasksStarted[0] && tasksStarted[0] {
        // First task hasn't started but second has.
        order = .OrderedDescending
    } else {
        // Neither task has started, sort by start dates.
        order = startDates[0].compare(startDates[1])
        if order == .OrderedSame {
            // If the start dates are identical, sort by the due date.
            order = dueDates[0].compare(dueDates[1])
        }
    }
    if order == .OrderedAscending {
        return -1
    } else if order == .OrderedDescending {
        return 1
    } else {
        return 0
    }
}

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
        subTasks.sortUsingFunction(compareTasks, context: UnsafeMutablePointer<Void>(bitPattern: 0))
    }

}