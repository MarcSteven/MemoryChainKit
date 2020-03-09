//
//  ManagedObjectType.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2018/9/29.
//  Copyright © 2018 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


import CoreData


public protocol ManagedObjectType:NSFetchRequestResult {}
public extension ManagedObjectType where Self:NSManagedObject {
    static var entityName:String {
        return String(describing: self)
    }
    static func entity(in context:NSManagedObjectContext)->NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
    func updateMatchingValues(from object:Self){
        let attributeNames = object.entity.attributesByName.map {$0.key}
        for key in attributeNames {
            setValue(object.value(forKey: key), forKey: key)
            
        }
    }
    static func fetch<T>(property: String, context: NSManagedObjectContext, predicate: NSPredicate? = nil) -> Set<T> {
        let entity = Self.entity(in: context)
        
        let fetchRequest = NSFetchRequest<NSDictionary>(entityName: Self.entityName)
        fetchRequest.predicate = predicate
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.returnsDistinctResults = true
        fetchRequest.propertiesToFetch = [entity.attributesByName[property] as Any]
        
        guard let results = try? context.fetch(fetchRequest) else { return [] }
        
        let arr = results.compactMap( { $0[property] as? T } )
        return Set<T>(arr)
    }
    static func fetchRequest(in context: NSManagedObjectContext,
                                    includePending: Bool = true,
                                    returnsObjectsAsFaults: Bool = true,
                                    predicate: NSPredicate? = nil,
                                    sortedWith sortDescriptors: [NSSortDescriptor]? = nil
        ) -> NSFetchRequest<Self> {
        
        let fetchRequest = NSFetchRequest<Self>(entityName: entityName)
        fetchRequest.includesPendingChanges = includePending
        fetchRequest.returnsObjectsAsFaults = returnsObjectsAsFaults
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        return fetchRequest
    }
    static func count(in context: NSManagedObjectContext,
                             includePending: Bool = true,
                             predicate: NSPredicate? = nil
        ) -> Int {
        
        let fetchRequest = NSFetchRequest<NSNumber>(entityName: Self.entityName)
        fetchRequest.predicate = predicate
        fetchRequest.includesPendingChanges = includePending
        fetchRequest.resultType = .countResultType
        fetchRequest.returnsDistinctResults = true
        guard let num = try? context.count(for: fetchRequest) else { return 0 }
        return num
    }
    static func fetch(in context: NSManagedObjectContext,
                             includePending: Bool = true,
                             returnsObjectsAsFaults: Bool = true,
                             predicate: NSPredicate? = nil,
                             sortedWith sortDescriptors: [NSSortDescriptor]? = nil
        ) -> [Self] {
        
        let fr = fetchRequest(in: context,
                              includePending: includePending,
                              returnsObjectsAsFaults: returnsObjectsAsFaults,
                              predicate: predicate,
                              sortedWith: sortDescriptors)
        guard let results = try? context.fetch(fr) else { return [] }
        return results
    }
    static func find(in context: NSManagedObjectContext, predicate: NSPredicate) -> Self? {
        for obj in context.registeredObjects where !obj.isFault {
            guard let res = obj as? Self, predicate.evaluate(with: res) else { continue }
            return res
        }
        return nil
    }
    static func findOrFetch(in context: NSManagedObjectContext, predicate: NSPredicate) -> Self? {
        if let obj = find(in: context, predicate: predicate) { return obj }
        
        let fr = fetchRequest(in: context, predicate: predicate)
        fr.returnsObjectsAsFaults = false
        fr.fetchLimit = 1
        guard let objects = try? context.fetch(fr) else { return nil }
        return objects.first
    }
    static func fetchedResultsController(in context: NSManagedObjectContext,
                                                includePending: Bool = true,
                                                sectionNameKeyPath: String? = nil,
                                                predicate: NSPredicate? = nil,
                                                sortedWith sortDescriptors: [NSSortDescriptor]? = nil
        ) -> NSFetchedResultsController<Self> {
        
        let fr = fetchRequest(in: context, includePending: includePending, predicate: predicate, sortedWith: sortDescriptors)
        let frc: NSFetchedResultsController<Self> = NSFetchedResultsController(fetchRequest: fr,
                                                                               managedObjectContext: context,
                                                                               sectionNameKeyPath: sectionNameKeyPath,
                                                                               cacheName: nil)
        return frc
    }
    static func delete(in context: NSManagedObjectContext,
                       predicate: NSPredicate? = nil,
                       completion: (Int, CoreDataError?) -> Void = {_, _ in}) {
        
        let fr = fetchRequest(in: context, predicate: predicate)
        fr.includesPropertyValues = false
        
        do {
            let objectsToDelete: [Self] = try context.fetch(fr)
            let count = objectsToDelete.count
            if count == 0 {
                completion(0, nil)
                return
            }
            
            objectsToDelete.forEach({ context.delete($0) })
            completion(count, nil)
        } catch let error {
            completion(0, CoreDataError.deleteFailed(error))
        }
    }

}
