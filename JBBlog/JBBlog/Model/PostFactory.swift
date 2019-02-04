//
//  PostFactory.swift
//  JBBlog
//
//  Created by Felipe Alarcon on 10/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import Foundation

import Alamofire
import Kanna

class PostFactory {
    
    var posts = [Post]()
    var postsUrl: String
    var countPosts = 0
    var pageCount = 2
    var page = 0
    
    init(_ postsUrl: String) {
        self.postsUrl = postsUrl
        getMainBlog(self.postsUrl)
    }
    
    
    func getMainBlog(_ postsUrl: String){
        print(postsUrl)
        
        Alamofire.request(postsUrl).responseString { (response) in
            print(response.result.isSuccess)
            if response.result.isSuccess{
                
                if let httpString = response.result.value{
                    
                    self.parseMainPosts(httpString)
                    
                }
            }
        }
        
    }
    
    func parseMainPosts(_ html: String){
        
        do {
            let doc = try Kanna.HTML(html: html, encoding: .utf8)
            
            for article in doc.css("article"){
                
                var title : String = ""
                var text : String = ""
                var imageUrl : String = ""
                var urlPost : String = ""
                
                for a in article.css("a"){
                    urlPost = a["href"]!
                    break
                }
                
                for h2 in article.css("h2"){
                    title = h2.text!
                    break
                }
                for p in article.css("p"){
                    text = p.text!
                    break
                }
                for a in article.css("a"){
                    if a["class"] == "more-link"{
                        urlPost = a["href"]!
                        break
                    }
                }
                for img in article.css("img"){
                    imageUrl = img["src"]!
                    break
                }
                
//                print(title)
                let post = Post(title: title, text: text, imageUrl: imageUrl, urlPost: urlPost)
                self.posts.append(post)
                NotificationCenter.default.post(name: NSNotification.Name("PostUpdated"), object: nil)
                self.countPosts += 1
                
                
                
                
            }
            
            parseNextPage(doc: doc)
            
            
           
            
        } catch  {
            print(error)
        }
        
    }
    
    func parseNextPage(doc: HTMLDocument){
        
        let regex = "single_page"
        for a in doc.css("a"){
            if a["class"]?.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil{
//                print(a["href"]!)
                self.page = Int(a.text!)!
//                print(self.page,self.pageCount)
                if self.page >= self.pageCount{
                    self.pageCount += 1
                    let next : String = a["href"]!
//                    print(next)
                    getMainBlog(next)
                }else{
//                    print(self.page, self.countPosts)
                }
            }
        }
    }
    
    
    
}
