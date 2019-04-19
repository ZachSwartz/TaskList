//
//  Task+CoreDataProperties.swift
//  TaskList
//
//  Created by Zach Swartz on 4/19/19.
//  Copyright © 2019 Zach Swartz. All rights reserved.
//

import Foundation
import CoreData


extension Task {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }
    
    @NSManaged public var details: String?
    @NSManaged public var priority: String?
    @NSManaged public var title: String?
    
}
