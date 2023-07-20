//
//  CoreDataManager.swift
//  UIKitFundamental
//
//  Created by Muhammad Irfan on 11/07/23.
//

import CoreData
import UIKit

class MentorDataManager {
    
    let context: NSManagedObjectContext
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func saveMentor(_ mentor: MentorData) throws {
        try context.save()
    }
    
    func deleteMentor(_ mentor: MentorData) throws {
        mentor.deletedDate = Date()
        try context.save()
    }
    
    func updateMentor(_ mentor: MentorData, withName name: String?, city: String?) throws {
        mentor.name = name
        mentor.city = city
        try context.save()
    }
    
    func createMentor(withName name: String?, city: String?) -> MentorData {
        let mentor = MentorData(context: context)
        mentor.name = name
        mentor.city = city
        return mentor
    }
    
    func fetchAllMentors() throws -> [MentorData] {
        let request: NSFetchRequest<MentorData> = MentorData.fetchRequest()
        request.predicate = NSPredicate(format: "deletedDate == nil")
        let results = try context.fetch(request)
        
            //print(results.count)
        return results
    }
}
