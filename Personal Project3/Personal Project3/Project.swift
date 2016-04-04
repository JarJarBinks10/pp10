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
    }

    // MARK: Properties
    var name: String
    var startDate: NSDate
    var dueDate: NSDate
    var milestones = [Milestone]()

    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("projects")

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

    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(startDate, forKey: PropertyKey.startDateKey)
        aCoder.encodeObject(dueDate, forKey: PropertyKey.dueDateKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let startDate = aDecoder.decodeObjectForKey(PropertyKey.startDateKey) as! NSDate
        let dueDate = aDecoder.decodeObjectForKey(PropertyKey.dueDateKey) as! NSDate
        // Must call designated initializer
        self.init(name: name, startDate: startDate, dueDate: dueDate)
    }

}