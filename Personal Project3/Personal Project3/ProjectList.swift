//
//  ProjectList.swift
//  Personal Project3
//
//  Created by Preeti Patel on 2016-03-26.
//  Copyright © 2016 Nick Patel. All rights reserved.
//

import Foundation

class ProjectList {

    // MARK: Properties
    var projects = NSMutableArray()

    // MARK: Intitialization
    init() {
        load()
    }

    // MARK: Add Project
    func add(project: Project) {
        projects.addObject(project)
        sort()
        save()
    }

    // MARK: Remove Project
    func remove(index: Int) {
        projects.removeObjectAtIndex(index)
        save()
    }

    // MARK: Update Project
    func update(index: Int, project: Project) {
        projects.replaceObjectAtIndex(index, withObject: project)
        sort()
        save()
    }

    // MARK: Get Project
    func getProject(index: Int) -> Project {
        return projects[index] as! Project
    }

    // MARK: Indiciate the number of projects
    func count() -> Int {
        return projects.count
    }

    // MARK: Sort Entries
    func sort() {
        // Sort in this order:
        // 1. For all projects that have already started, sort by due date (earliest to latest).
        // 2. For all projects that haven't started yet, sort by start date (earliest to latest).
    }

    // MARK: Archiving Paths
    let ArchiveURL = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!.URLByAppendingPathComponent("projects")

    // MARK: Save
    func save() {
        NSKeyedArchiver.archiveRootObject(projects, toFile: ArchiveURL.path!)
    }

    // MARK: Load
    func load() {
        // Load any saved projects.
        if let savedProjects = NSKeyedUnarchiver.unarchiveObjectWithFile(ArchiveURL.path!) as? NSMutableArray {
            projects.addObjectsFromArray(savedProjects as [AnyObject])
        }
    }
    
}

var projectList = ProjectList()