//
//  Persistence.swift
//  WhoGame
//
//  Created by Иван Маришин on 05.12.2021.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "WhoGame")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
    
    func fetchGames(for gameId: String) -> [GameCD] {
        let request: NSFetchRequest<GameCD> = GameCD.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", gameId)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \GameCD.id, ascending: true)]
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func fetchGamCards(for gameId: String) -> [GameCardCD] {
        let request: NSFetchRequest<GameCardCD> = GameCardCD.fetchRequest()
        request.predicate = NSPredicate(format: "gameId == %@", gameId)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \GameCardCD.mark, ascending: true)]
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
