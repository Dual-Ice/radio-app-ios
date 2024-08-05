//
//  CoreDataManager.swift
//  radio-app-ios
//
//  Created by  Maksim Stogniy on 05.08.2024.
//
import CoreData
import UIKit

final class CoreDataManager {
    // MARK: - Core Data Stack
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Radio")
        container.loadPersistentStores { description, error in
            if let error = error {
                 fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }
    
    init() {}
    
    // MARK: - Core Data Saving Support
    func saveContext(completion: @escaping (Error?) -> Void) {
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        } else {
            completion(nil)
        }
    }
    
    // MARK: - User Management
    func addUser(id: String, username: String, email: String, image: String?, completion: @escaping (Error?) -> Void) {
        let user = RadioUser(context: context)
        user.id = id
        user.username = username
        user.email = email
        user.image = image
        
        
        saveContext { error in
            completion(error)
        }
    }
    
    func updateUser(id: String, username: String, email: String, image: String?, completion: @escaping (Error?) -> Void) {
        let request: NSFetchRequest<RadioUser> = RadioUser.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let users = try context.fetch(request)
            if let user = users.first {
                user.username = username
                user.email = email
                user.image = image
                
                saveContext { error in
                    completion(error)
                }
            } else {
                completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
            }
        } catch {
            completion(error)
        }
    }
    
    func getUser(id: String, completion: @escaping (RadioUser?, Error?) -> Void){
        let request: NSFetchRequest<RadioUser> = RadioUser.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let users = try context.fetch(request)
            completion(users.first, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    // MARK: - FavoriteStation Management
    func addStation(forUserId userId: String, stationData: Station, completion: @escaping (Error?) -> Void) {
        let station = FavoriteStation(context: context)
        station.name = stationData.name
        station.stationuuid = stationData.stationuuid
        station.url = stationData.url
        station.tags = stationData.tags
        station.favicon = stationData.favicon
        station.votes = Int64(stationData.votes ?? 0)
        station.country = stationData.country
        station.language = stationData.language
        station.geo_lat = stationData.geo_lat ?? 0
        station.user_id = userId
        
        saveContext { error in
            completion(error)
        }
    }
    
    func deleteStation(stationUUID: String, completion: @escaping (Error?) -> Void) {
        let request: NSFetchRequest<FavoriteStation> = FavoriteStation.fetchRequest()
        request.predicate = NSPredicate(format: "stationuuid == %@", stationUUID)
        
        do {
            let stations = try context.fetch(request)
            if let station = stations.first {
                context.delete(station)
                
                saveContext { error in
                    completion(error)
                }
            } else {
                completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Station not found"]))
            }
        } catch {
            completion(error)
        }
    }
    
    func getAllStations(forUserId userId: String, completion: @escaping ([FavoriteStation], Error?) -> Void) {
        let request: NSFetchRequest<FavoriteStation> = FavoriteStation.fetchRequest()
        request.predicate = NSPredicate(format: "user_id == %@", userId)
        
        do {
            let stations = try context.fetch(request)
            completion(stations, nil)
        } catch {
            completion([], error)
        }
    }
}

