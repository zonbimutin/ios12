//
//  ViewController.swift
//  WebScrapping
//
//  Created by Felipe Alarcon on 08/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit
import Alamofire
import Kanna
import youtube_ios_player_helper


class ViewController: UIViewController {
    
   
    
    
    let urlName = "https://www.apple.com/itunes/charts/songs"
    let imageSong = "https://itunes.apple.com/us/album/on-my-way-to-you/1419602744?i=1419602748&v0=WWW-NAUS-ITSTOP100-SONGS&l=en&ign-mpt=uo%3D4"
    
    
    
    var factory : SongsFactory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.factory = SongsFactory(songsUrl: urlName)
//        getImageForUrl(imageSong)
        
       
        
    }
    
    @IBAction func actulizedSongs(_ sender: UIButton) {
        factory.downloadMoreItems()
        
    }
    
    
//    METHODS
    
    
    
    

}

