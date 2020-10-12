//
//  MusicViewController.swift
//  Music
//
//  Created by Ghassan  albakuaa  on 10/10/20.
//

import UIKit

class MusicViewController: UIViewController {
    private var apiService = ApiService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadTpoSongsData()
    }
    
    private func loadTpoSongsData() {
        
        // Fetch data from the server
        apiService.getTopSongsData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                print(result)
                // Save data to Core Data
                CoreData.sharedInstance.saveDataOf(songs: listOf.feed.results)
              self?.perform(#selector(self?.mainScreen))
            case .failure(let error):
                // Show alert message in case of error
                self?.showAlertWith(title: "Could Not Connect!", message: "Please check your internet connection \n or try again later")
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
    
    // MARK: - Alert message
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Perform a transition to the main screen (MusicListViewController)
    @objc func mainScreen() {
        performSegue(withIdentifier: "musicList", sender: self)
    }
}

