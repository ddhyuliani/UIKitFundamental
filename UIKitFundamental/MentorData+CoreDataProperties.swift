//
//  MentorData+CoreDataProperties.swift
//  UIKitFundamental
//
//  Created by Dini on 11/07/23.
//
//

import Foundation
import CoreData


extension MentorData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MentorData> {
        return NSFetchRequest<MentorData>(entityName: "MentorData")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int32
    @NSManaged public var city: String?
    @NSManaged public var deletedDate: Date?

}

extension MentorData : Identifiable {

}
