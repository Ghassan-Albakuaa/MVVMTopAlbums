//
//  SongsListTableViewCell.swift
//  Music
//
//  Created by Ghassan  albakuaa  on 10/11/20.
//

import UIKit

class SongsListTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
  
    private var apiService = ApiService()
    private var urlString: String = ""
    
    //MARK: - Setup music values
  
    func setCellWithValuesOf(_ music:MusicEntity) {
        updateUI(title: music.title, artistName: music.artistName, releaseDate: music.relaseDate , artistUrl: music.artistUrl)
    }
 
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.backgroundImage.image = UIImage(data: data)
            }
        }
    }
     
    // MARK: - Update the UI Views
    private func updateUI(title:String?, artistName:String?, releaseDate:String? , artistUrl:String?) {
        
        self.songTitle.text = title
        self.artistName.text = artistName
        self.releaseDate.text = releaseDate
   
    //    print ("ggggggggg\(artistUrl)")
        let url = URL(string: artistUrl ?? "error" )!
         self.downloadImage(from: url)
       guard let backdropString = artistUrl else {return}
       urlString =  backdropString
        
        guard let backdropImageURL = URL(string: urlString) else {
           self.backgroundImage.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.backgroundImage.image = nil
        
        apiService.getImageDataFrom(url: backdropImageURL) { [weak self] (data: Data) in
           if let image = UIImage(data: data) {
               self?.backgroundImage.image = image
           } else {
               self?.backgroundImage.image = UIImage(named: "noImageAvailable")
         }
        }  }}
