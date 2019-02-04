//
//  CellViewController.swift
//  JBBlog
//
//  Created by Felipe Alarcon on 10/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit

class CellViewController: UIViewController {
    
    @IBOutlet weak var labelText: UITextView!
    @IBOutlet weak var labelImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UITextView!
    
    
    var factory : Post!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.titleLabel.text = factory.title
//        print(factory.title)
        self.labelText.text = factory.text
//        print(labelText.text)
        self.labelImage.downloadedFrom(link: factory.imageUrl)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func readMoreButton(_ sender: UIButton) {
        
        if let url = URL(string: factory.urlPost){
            UIApplication.shared.open(url, options: [:]) { (success) in
                print("Hemos ido al post \(self.factory.title)")
            }
        }
    }
    

}
