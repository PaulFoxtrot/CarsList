//
//  Car+CoreDataProperties.swift
//  CarsList
//
//  Created by foxtrot on 26/05/2019.
//  Copyright © 2019 foxtrot. All rights reserved.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var model: String?
    @NSManaged public var year: Int16
    @NSManaged public var manufacturer: String?
    @NSManaged public var classOfCar: String?
    @NSManaged public var typeOfCar: String?
    @NSManaged public var name: String?

}
