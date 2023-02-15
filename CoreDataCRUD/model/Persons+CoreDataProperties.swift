//
//  Persons+CoreDataProperties.swift
//  CoreDataCRUD
//
//  Created by Filip Rutkowski on 15/02/2023.
//
//

import Foundation
import CoreData


extension Persons {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Persons> {
        return NSFetchRequest<Persons>(entityName: "Persons")
    }

    @NSManaged public var name: String?
    @NSManaged public var pesel: String?
    @NSManaged public var surname: String?

}

extension Persons : Identifiable {

}
