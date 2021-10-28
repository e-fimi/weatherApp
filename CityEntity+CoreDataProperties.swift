//
//  CityEntity+CoreDataProperties.swift
//  
//
//  Created by Георгий on 28.10.2021.
//
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var dateUpdated: String?
    @NSManaged public var temperature: String?
    @NSManaged public var title: String?
    @NSManaged public var firstDescription: String?
    @NSManaged public var secondDescription: String?

}
