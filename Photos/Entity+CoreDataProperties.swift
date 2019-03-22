//
//  Entity+CoreDataProperties.swift
//  Photos
//
//  Created by Ryan Rottmann on 3/22/19.
//  Copyright © 2019 Ryan Rottmann. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var photo: NSData?

}
