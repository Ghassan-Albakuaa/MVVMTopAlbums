//
//  ModelListViewController.swift
//  Music
//
//  Created by Ghassan  albakuaa  on 10/11/20.
//

import UIKit
import CoreData

class MusicListViewController: UIViewController , UpdateTableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = MusicListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.tableView.dataSource = self
        loadData()
    }
    
    private func loadData() {
        viewModel.retrieveDataFromCoreData()
    }
    
    //Update the taable view if changes
    func reloadData(sender: MusicListViewModel) {
        self.tableView.reloadData()
    }
    
   
    private func setNavigationBar() {
      
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = .black
    }
}

extension MusicListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        
        let object = viewModel.object(indexPath: indexPath)
        
        if let albumCell = cell as? SongsListTableViewCell {
            if let album = object {
                albumCell.setCellWithValuesOf(album)
            }
        }
        return cell
    }
    
    
}
