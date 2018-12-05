//
//  MemberEntity+CoreDataProperties.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 06/12/18.
//  Copyright © 2018 Antony Raphel. All rights reserved.
//
//

import Foundation
import CoreData


extension MemberEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemberEntity> {
        return NSFetchRequest<MemberEntity>(entityName: "MemberEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var activity: ActivityEntity?

}
