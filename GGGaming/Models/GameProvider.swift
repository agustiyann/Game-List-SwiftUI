//
//  GameProvider.swift
//  GGGaming
//
//  Created by Agus Tiyansyah Syam on 15/03/21.
//

import Foundation
import CoreData

class GameProvider {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteGame")

        container.loadPersistentStores(completionHandler: { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil

        return container
    }()

    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }

    func getAllFavoriteGame(completion: @escaping(_ games: [Game]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteGame")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [Game] = []
                for result in results {
                    let game = Game(id: result.value(forKeyPath: "id") as? Int,
                                    name: result.value(forKeyPath: "name") as? String,
                                    released: result.value(forKeyPath: "released") as? Date,
                                    backgroundImage: result.value(forKeyPath: "image") as? String,
                                    rating: result.value(forKeyPath: "rating") as? Double,
                                    metaScore: result.value(forKeyPath: "metascore") as? Int,
                                    playtime: result.value(forKeyPath: "playtime") as? Int)
                    games.append(game)
                }
                completion(games)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }

    func getFavoriteGame(_ id: Int, completion: @escaping(_ game: Game) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteGame")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first {
                    let game = Game(id: result.value(forKeyPath: "id") as? Int,
                                    name: result.value(forKeyPath: "name") as? String,
                                    released: result.value(forKeyPath: "released") as? Date,
                                    backgroundImage: result.value(forKeyPath: "image") as? String,
                                    rating: result.value(forKeyPath: "rating") as? Double,
                                    metaScore: result.value(forKeyPath: "metascore") as? Int,
                                    playtime: result.value(forKeyPath: "playtime") as? Int)
                    completion(game)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }

    func addFavorite(_ id: Int, _ name: String, _ released: Date, _ image: String, _ rating: Double, _ metascore: Int, _ playtime: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "FavoriteGame", in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)

                game.setValue(id, forKey: "id")
                game.setValue(name, forKey: "name")
                game.setValue(released, forKey: "released")
                game.setValue(image, forKey: "image")
                game.setValue(rating, forKey: "rating")
                game.setValue(metascore, forKey: "metascore")
                game.setValue(playtime, forKey: "playtime")

                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }

    func deleteAllFavoriteGame(completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGame")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                batchDeleteResult.result != nil {
                completion()
            }
        }
    }

    func deleteFavoriteGame(_ id: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGame")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
               batchDeleteResult.result != nil {
                completion()
            }
        }
    }
}
