//
//  CoreDataManager.swift
//  testWeatherApp
//
//  Created by Георгий on 23.10.2021.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    private let dataBaseName: String = "CityCoreDataModel"
    public let storeContainer: NSPersistentContainer
    private var isReady: Bool = false
    
    private var mainQueueContext: NSManagedObjectContext {
        return storeContainer.viewContext
    }
    
    static let shared = CoreDataManager()
    
    private init() {
        self.storeContainer = NSPersistentContainer(name: dataBaseName)
    }
}

extension CoreDataManager {
    
    func initializeCoreDataIfNeeded(success: (() -> Void)?, failure: @escaping (Error) -> Void) {
        
        guard !isReady else {
            return
        }
        
        storeContainer.loadPersistentStores {[weak self] (_, error) in
            if let error = error {
                failure(error)
                return
            }
            self?.isReady = true
            success?()
        }
    }
    
    func fetch<T>(with request: NSFetchRequest<T>) -> [T] {
        
        let sortDescriptor = NSSortDescriptor(key: #keyPath(CityEntity.title), ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        let objects: [T]? = try? mainQueueContext.fetch(request)
        
        return objects ?? []
    }
    
    func createObject<T: NSManagedObject>(for entity: T.Type, configurationBlock: ((T) -> Void)?) {
        let entityName: String = String(describing: entity)
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: entityName, into: mainQueueContext) as? T else {
            return
        }

        configurationBlock?(obj)
        
        try? mainQueueContext.save()
    }
    
    func deleteObject(city: CityEntity) {
        let object = city
        mainQueueContext.delete(object)
        try? mainQueueContext.save()
    }
}
