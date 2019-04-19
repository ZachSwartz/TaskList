//
//  Task+CoreDataClass.swift
//  TaskList
//
//  Created by Zach Swartz on 4/19/19.
//  Copyright © 2019 Zach Swartz. All rights reserved.
//

import UIKit
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    convenience init?(title: String?, priority: String?, details: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            print("Error: Could not get app delegate context.")
            return nil
        }
        
        self.init(entity: Task.entity(), insertInto: managedContext)
        self.title = title
        self.priority = priority
        self.details = details
        
    }
}
