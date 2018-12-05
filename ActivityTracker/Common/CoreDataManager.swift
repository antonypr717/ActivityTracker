//
//  CoreDataManager.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 04/12/18.
//  Copyright © 2018 Antony Raphel. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static var shared = CoreDataManager()
    
    var mainContext: NSManagedObjectContext?
    var privateContext: NSManagedObjectContext?
    
    private init() {
        guard let modelURL = Bundle.main.url(forResource: "ActivityTracker", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext?.persistentStoreCoordinator = psc
        privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext?.persistentStoreCoordinator = psc
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex-1]
        
        let storeURL = docURL.appendingPathComponent("ActivityTracker.sqlite")
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
    
    func saveMainContext(){
        if self.mainContext != nil && self.mainContext!.hasChanges {
            do {
                try self.mainContext!.save()
            }
            catch{
                print("could not save main context")
            }
        }
    }
    
    func savePrivateContext(){
        if self.privateContext != nil && self.privateContext!.hasChanges {
            privateContext?.perform {
                do {
                    try self.mainContext!.save()
                }
                catch{
                    print("could not save main context")
                }
            }
        }
    }
}
