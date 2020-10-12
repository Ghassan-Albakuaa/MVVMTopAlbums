//
//  MusicListViewModel.swift
//  Music
//
//  Created by Ghassan  albakuaa  on 10/11/20.
//

import Foundation
import UIKit
import CoreData

protocol UpdateTableViewDelegate: NSObjectProtocol {
    func reloadData(sender: MusicListViewModel)
}

class MusicListViewModel: NSObject, NSFetchedResultsControllerDelegate {
    
    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private var fetchedResultsController: NSFetchedResultsController<MusicEntity>?
    
    weak var delegate: UpdateTableViewDelegate?
    
    //MARK: - Fetched Results Controller - Retrieve data from Core Data
    func retrieveDataFromCoreData() {
        
        if let context = self.container?.viewContext {
            let request: NSFetchRequest<MusicEntity> = MusicEntity.fetchRequest()
            
           
            request.sortDescriptors = [NSSortDescriptor(key: #keyPath(MusicEntity.artistId), ascending: false)]
            
            self.fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            
            // Notifies the tableView when any changes have occurred to the data
            fetchedResultsController?.delegate = self
            
            // Fetch data
            do {
                try self.fetchedResultsController?.performFetch()
            } catch {
                print("Failed to initialize FetchedResultsController: \(error)")
            }
        }
    }
    
    // Changes have happened in fetchedResultsController so we need to notify the tableView
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // Update the tableView
        self.delegate?.reloadData(sender: self)
    }
    
    //MARK: - TableView DataSource functions
    func numberOfRowsInSection (section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    func object (indexPath: IndexPath) -> MusicEntity? {
        return fetchedResultsController?.object(at: indexPath)
    }
}
