//
//  TaskList.Swift
//  Personal Project3
//
//  Created by Nick Patel on 2016-04-26.
//  Copyright © 2016 Nick Patel. All rights reserved.
//

import Foundation

class TaskList {
    
    // MARK: Properties
    var tasks = NSMutableArray()
    
    // MARK: Intitialization
    init() {
        //load()
    }
    
    // MARK: Add Task
    func add(task: Task) {
        tasks.addObject(task)
        sort()
        //save()
    }
    
    // MARK: Remove Task
    func remove(index: Int) {
        tasks.removeObjectAtIndex(index)
        //save()
    }
    
    // MARK: Update Task
    func update(index: Int, task: Task) {
        tasks.replaceObjectAtIndex(index, withObject: task)
        sort()
        //save()
    }
    
    // MARK: Get Task
    func getTask(index: Int) -> Task {
        return tasks[index] as! Task
    }
    
    // MARK: Indiciate the number of task
    func count() -> Int {
        return tasks.count
    }
    
    // MARK: Sort Entries
    func sort() {
        tasks.sortUsingFunction(compareTasks, context: UnsafeMutablePointer<Void>(bitPattern: 0))
    }
    
    /*
     // MARK: Archiving Paths
     let ArchiveURL = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!.URLByAppendingPathComponent("projects")
     
     // MARK: Save
     func save() {
     NSKeyedArchiver.archiveRootObject(tasks, toFile: ArchiveURL.path!)
     }
     
     // MARK: Load
     func load() {
     // Load any saved projects.
     if let savedProjects = NSKeyedUnarchiver.unarchiveObjectWithFile(ArchiveURL.path!) as? NSMutableArray {
     tasks.addObjectsFromArray(savedProjects as [AnyObject])
     }
     }
     */
    
}

var taskList = TaskList()
