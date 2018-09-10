//
//  Song.swift
//  WebScrapping
//
//  Created by Felipe Alarcon on 09/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import Foundation

class Song {
    
    var uuid : String
    var title : String
    var itunesUrl : String
    var imageUrl : String
    var autor : String
    var imageDownload : Bool = false
    
    
    init(title: String, itunesUrl: String, imageUrl: String = "https://is5-ssl.mzstatic.com/image/thumb/Music115/v4/12/f2/0e/12f20e96-a7e8-22b2-abb2-cc761c63e33c/00602567862673.rgb.jpg/268x0w.jpg", autor: String) {
        
        self.uuid = UUID().uuidString
        self.title = title
        self.itunesUrl = itunesUrl
        self.imageUrl = imageUrl
        self.autor = autor
    }
    
}

