//
//  SongsFactory.swift
//  WebScrapping
//
//  Created by Felipe Alarcon on 09/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import Foundation
import Alamofire
import Kanna


class SongsFactory {
    
    var songs = [Song]()
    
    var songsUrl : String
    
    var copletedSongs = 0
    
    var totalDownloadedSongs = 0
    
    
    
    init(songsUrl: String) {
        
        self.songsUrl = songsUrl
        scrapeUrl()
        
        
        
    }
    
    
    
    func scrapeUrl() {
        
        Alamofire.request(self.songsUrl).responseString { (response) in
            if response.result.isSuccess{
                if let htmlString = response.result.value{
                    print("1")
                    self.parseHTML(html: htmlString)
                    
                    
                    
                }
            }
        }
    }
    
    func parseHTML(html: String) {
        
        do {
            
            let doc = try Kanna.HTML(html: html, encoding: String.Encoding.utf8)
            
            for div in doc.css("div"){
                if div["class"] == "section-content"{
                    for ul in div.css("ul"){
                        for li in ul.css("li"){
                            var title : String = ""
                            var autor : String = ""
                            
                            var url : String = ""
//                        Obtencion de la url
                            for h3 in li.css("h3"){
                                title = h3.text!
                            }
                            for h4 in li.css("h4"){
                                autor = h4.text!
                            }
                            for a in li.css("a"){
                                if a["class"] == "more"{
                                    url = a["href"]!
                                    break
                                    
                                }
                            }
                            
                            let song = Song(title: title, itunesUrl: url, autor: autor)
                            self.songs.append(song)
                            
                            NotificationCenter.default.post(name: NSNotification.Name("SongsUpdated"), object: nil)
                        }
                    }
                    
                    
                }
                
            }
            downloadStaticsFiles()
            
        } catch  {
            print(error)
        }
        
    }
    
    //    Conseguir la imagen de una url del titulo
    
    func downloadStaticsFiles() {
        
        self.totalDownloadedSongs = 11
        for i in 0..<totalDownloadedSongs{
            DispatchQueue.main.async {
                self.getImageForSong(self.songs[i])
            }
            
        }
        
        
        
    }
    
    func getImageForSong(_ song: Song) {
        
        Alamofire.request(song.itunesUrl).responseString { (response) in
            if response.result.isSuccess{
                if let htmlString = response.result.value{
                    self.parseImageForHTML(htmlString, forSongn: song.uuid)
                    
                }
            }
        }
    }
    
    func parseImageForHTML(_ html: String, forSongn id: String) {
        do {
            
            let doc = try Kanna.HTML(html: html, encoding: .utf8)
            
//            print("conexion")
            
            let regex = "^we-artwork__image ember[0-9]+$"
            
            for img in doc.css("img"){
                if img["class"]?.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil {
//                    print("imagenencontrada")
                    for song in songs{
                        if song.uuid == id{
                            
                            song.imageUrl = img["src"]!
                            song.imageDownload = true
                            NotificationCenter.default.post(name: NSNotification.Name("SongsUpdated"), object: nil)
//                            print(img["src"]!)
//                            checkCompletedSong(forSong: id)
                            
                            break
                        }
                    }
                    
                    break
                }
            }
            
        } catch  {
            print(error)
        }
    }
    
    
    func checkCompletedSong(forSong id: String){
//        print("5")
        self.copletedSongs += 1
        print("Estado de completado: \(self.copletedSongs)/\(self.songs.count)")
        
    }
    
    func downloadMoreItems(){
        if self.copletedSongs < self.songs.count{
            self.totalDownloadedSongs += 10
            for i in self.totalDownloadedSongs-10..<self.totalDownloadedSongs{
                DispatchQueue.main.async {
                    self.getImageForSong(self.songs[i])
                }
            }
        }
    }
    
    
    
    //   Scrapping con expresion regular
    func parseHTMLRegular(html: String) {
        do {
            
            let doc = try Kanna.HTML(html: html, encoding: String.Encoding.utf8)
            let regex = "^[0-9]+\\.(\\w|\\s|\\W)+iTunes$"
            for li in doc.css("li"){
                if li.text?.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil{
                
                }
                
            }
            
        } catch  {
            print(error)
        }
    }
    
    
}
