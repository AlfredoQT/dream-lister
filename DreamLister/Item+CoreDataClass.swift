//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Alfredo Quintero Tlacuilo on 1/25/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    //Everytime this object is inserted into the NSManagedObjectContext or create item from entity this function will be called
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
