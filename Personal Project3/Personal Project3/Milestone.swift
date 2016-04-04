//
//  Milestone.swift
//  Personal Project3
//
//  Created by Preeti Patel on 2016-04-03.
//  Copyright © 2016 Nick Patel. All rights reserved.
//

import Foundation

class Milestone {

    // MARK: Properties
    var name: String
    var dueDate: NSDate

    // MARK: Initialization
    init?(name: String, dueDate: NSDate) {
        self.name = name
        self.dueDate = dueDate
        if name.isEmpty {
            return nil
        }
    }

}