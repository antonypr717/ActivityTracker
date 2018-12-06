//
//  TaskEntity+CoreDataProperties.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 06/12/18.
//  Copyright © 2018 Antony Raphel. All rights reserved.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var activityId: String?
    @NSManaged public var index: Int32
    @NSManaged public var isChecked: Bool
    @NSManaged public var title: String?
    @NSManaged public var activity: ActivityEntity?

}
