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
    var projects = [Project]()

    // MARK: Intitialization
    init() {
        load()
    }

    // MARK: Add Project
    func add(project: Project) {
        projects.append(project)
        sort()
        save()
    }

    // MARK: Remove Project
    func remove(index: Int) {
        projects.removeAtIndex(index)
        save()
    }

    // MARK: Update Project
    func update(index: Int, project: Project) {
        projects[index] = project;
        sort()
        save()
    }

    // MARK: Get Project
    func get(index: Int) -> Project {
        return projects[index]
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
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(projects, toFile: ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }

    // MARK: Load
    func load() {
        // Load any saved projects.
        if let savedProjects = NSKeyedUnarchiver.unarchiveObjectWithFile(ArchiveURL.path!) as? [Project] {
            projects += savedProjects
        } else {
            print("No saved projects found.")
        }
    }
    
}

var projectList = ProjectList()