//
//  Project.swift
//  Personal Project3
//
//  Created by Preeti Patel on 2015-12-31.
//  Copyright © 2015 Nick Patel. All rights reserved.
//

import Foundation
import UIKit

func compareProjects(firstObject: AnyObject, secondObject: AnyObject, context: UnsafeMutablePointer<Void>) -> Int {
    let now = NSDate()
    var projects = [firstObject as! Project,
                    secondObject as! Project]
    var startDates = [projects[0].startDate,
                      projects[1].startDate]
    var dueDates = [projects[0].dueDate,
                    projects[1].dueDate]
    var projectsStarted = [projects[0].startDate.compare(now) == .OrderedAscending,
                           projects[1].startDate.compare(now) == .OrderedAscending]
    var order: NSComparisonResult
    if projectsStarted[0] &&
        projectsStarted[1] {
        // Both projects (should) have already started, sort by due dates.
        order = dueDates[0].compare(dueDates[1])
        if order == .OrderedSame {
            // If the due dates are identical, sort by the start date.
            order = startDates[0].compare(startDates[1])
        }
    } else if projectsStarted[0] && !projectsStarted[1] {
        // First project has started but second hasn't.
        order = .OrderedAscending
    } else if !projectsStarted[0] && projectsStarted[0] {
        // First project hasn't started but second has.
        order = .OrderedDescending
    } else {
        // Neither project has started, sort by start dates.
        order = startDates[0].compare(startDates[1])
        if order == .OrderedSame {
            // If the start dates are identical, sort by the due date.
            order = dueDates[0].compare(dueDates[1])
        }
    }
    if order == .OrderedAscending {
        return 1
    } else if order == .OrderedDescending {
        return -1
    } else {
        return 0
    }
}

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
        tasks.sortUsingFunction(compareTasks, context: UnsafeMutablePointer<Void>(bitPattern: 0))
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