//
//  AlbumsDetailsViewModel.swift
//  Music
//
//  Created by Ghassan  albakuaa  on 10/12/20.
//

import Foundation
class AlbumsDetailsViewModel {
    
    let albumDetails: MusicEntity?
    
    let name: String?
    let artist: String?
  //  let year: String?
    let posterImage: String?
    
    init(musicDetails: MusicEntity?) {
        self.albumDetails = musicDetails
        
        self.name = musicDetails?.name
        self.artist = musicDetails?.artistName
        self.posterImage =  musicDetails?.artistUrl
    }
    
    //MARK: - Convert date format
    private static func convertDataFormat(_ date: String?) -> String {
        var dateOutput = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        if let dateInput = date {
            if let newDate = dateFormatter.date(from: dateInput) {
                dateFormatter.dateFormat = "MMM d, yyyy"
                dateOutput = dateFormatter.string(from: newDate)
            }
        }
        return dateOutput
    }
}
