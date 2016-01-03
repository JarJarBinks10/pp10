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
    var endDate: NSDate

    // MARK: Initialization
    init?(name: String, startDate: NSDate, endDate: NSDate) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        // Initialization should fail if there is no name or if endDate is before startDate.
        if name.isEmpty || startDate.compare(endDate) != .OrderedAscending {
            return nil
        }
    }

}