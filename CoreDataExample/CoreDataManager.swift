//
//  CoreDataManager.swift
//  CoreDataExample
//
//  Created by Jesus Jaime Cano Terrazas on 04/09/21.
//

import Foundation
import CoreData

class CoreDataManager{
    
    static let sharedInstance = CoreDataManager()
    
    // Create the funcinality to make the correct consults
    func readData(className: String, key: String? = nil, value: String? = nil) -> [NSManagedObject] {
        let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: className)
        
        if let key = key, let value = value {
            // Define a condition for a specific filter informationn
            let predicate = NSPredicate(format: "%K == %@", key, value)
            request.predicate = predicate
        }
        
        var results: [NSManagedObject] = []
        
        do {
            // It sentence will return an array of any, and we need to parse it to a NSManageObject
            results = try persistentContainer.viewContext.fetch(request) as! [NSManagedObject]
        } catch let error {
            print("Read error: \(error.localizedDescription)")
        }
        
        return results
    }
    
    func readWithGeneric<T:NSFetchRequestResult>(className: T.Type, key: String? = nil, value: String? = nil) -> [T] {
        
        let className = String(describing: T.self)
        let request: NSFetchRequest = NSFetchRequest<T>(entityName: className)
        
        if let key = key, let value = value {
            // Define a condition for a specific filter informationn
            let predicate = NSPredicate(format: "%K == %@", key, value)
            request.predicate = predicate
        }
        
        var results: [T] = []
        
        do {
            // It sentence will return an array of any, and we need to parse it to a NSManageObject
            results = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Read error: \(error.localizedDescription)")
        }
        
        return results
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoreDataExample")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
