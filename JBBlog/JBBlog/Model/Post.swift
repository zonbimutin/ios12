//
//  Post.swift
//  JBBlog
//
//  Created by Felipe Alarcon on 10/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import Foundation

class Post {
    
    var uuid : String
    var title : String
    var text : String
    var imageUrl : String
    var urlPost : String
    
    init(title: String, text: String, imageUrl: String, urlPost: String) {
        
        self.uuid = UUID().uuidString
        self.title = title
        self.text = text
        self.imageUrl = imageUrl
        self.urlPost = urlPost
    }
    
}
