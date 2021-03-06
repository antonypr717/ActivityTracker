//
//  ActivityEntity+CoreDataProperties.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 06/12/18.
//  Copyright © 2018 Antony Raphel. All rights reserved.
//
//

import Foundation
import CoreData


extension ActivityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityEntity> {
        return NSFetchRequest<ActivityEntity>(entityName: "ActivityEntity")
    }

    @NSManaged public var desc: String?
    @NSManaged public var dueDate: NSDate?
    @NSManaged public var image: NSData?
    @NSManaged public var timer: Double
    @NSManaged public var title: String?
    @NSManaged public var member: NSSet?
    @NSManaged public var task: NSSet?

}

// MARK: Generated accessors for member
extension ActivityEntity {

    @objc(addMemberObject:)
    @NSManaged public func addToMember(_ value: MemberEntity)

    @objc(removeMemberObject:)
    @NSManaged public func removeFromMember(_ value: MemberEntity)

    @objc(addMember:)
    @NSManaged public func addToMember(_ values: NSSet)

    @objc(removeMember:)
    @NSManaged public func removeFromMember(_ values: NSSet)

}

// MARK: Generated accessors for task
extension ActivityEntity {

    @objc(addTaskObject:)
    @NSManaged public func addToTask(_ value: TaskEntity)

    @objc(removeTaskObject:)
    @NSManaged public func removeFromTask(_ value: TaskEntity)

    @objc(addTask:)
    @NSManaged public func addToTask(_ values: NSSet)

    @objc(removeTask:)
    @NSManaged public func removeFromTask(_ values: NSSet)

}
