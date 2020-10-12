//
//  CoreData.swift
//  Music
//
//  Created by Ghassan  albakuaa  on 10/11/20.
//

import UIKit
import CoreData

class CoreData {
    
    static let sharedInstance = CoreData()
    private init(){}
    
    private let continer: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private let fetchRequest = NSFetchRequest<MusicEntity>(entityName: "MusicEntity")
    
    func saveDataOf(songs:[Result2]) {
        
        // Updates CoreData with the new data from the server - Off the main thread
        self.continer?.performBackgroundTask{ [weak self] (context) in
            self?.deleteObjectsfromCoreData(context: context)
            self?.saveDataToCoreData(songs: songs, context: context)
        }
    }
    
    // MARK: - Delete Core Data objects before saving new data
    private func deleteObjectsfromCoreData(context: NSManagedObjectContext) {
        do {
            // Fetch Data
            let objects = try context.fetch(fetchRequest)
            
            // Delete Data
            _ = objects.map({context.delete($0)})
            
            // Save Data
            try context.save()
        } catch {
            print("Deleting Error: \(error)")
        }
    }
  
    // MARK: - Save new data from the server to Core Data
    private func saveDataToCoreData(songs: [Result2], context: NSManagedObjectContext) {
      
        context.perform {
            
            for song in songs {
                let musicEntity = MusicEntity(context: context)
                musicEntity.title = song.name
                musicEntity.artistName = song.artistName
                musicEntity.artistUrl = song.artworkUrl100
                print("log = \(song.artworkUrl100)")
            }
       
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}

