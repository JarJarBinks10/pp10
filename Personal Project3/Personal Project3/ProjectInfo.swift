//
//  ProjectInfo.swift
//  Personal Project3
//
//  Created by Preeti Patel on 2015-12-31.
//  Copyright © 2015 Nick Patel. All rights reserved.
//

import UIKit

class ProjectInfo {

    // MARK: Properties
    var name: String
    var startDate: NSDate
    var dueDate: NSDate

    // MARK: Initialization
    init?(name: String, startDate: NSDate, dueDate: NSDate) {
        // Initialize stored properties.
        self.name = name
        self.startDate = startDate
        self.dueDate = dueDate
        // Initialization should fail if there is no name or if dueDate is before startDate.
        if name.isEmpty || startDate.compare(dueDate) != .OrderedAscending {
            return nil
        }
    }

}