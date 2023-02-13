//
//  Entity+CoreDataProperties.swift
//  CoreDataCRUD
//
//  Created by Filip Rutkowski on 13/02/2023.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }


}

extension Entity : Identifiable {

}
