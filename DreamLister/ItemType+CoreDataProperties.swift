//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Alfredo Quintero Tlacuilo on 1/25/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
