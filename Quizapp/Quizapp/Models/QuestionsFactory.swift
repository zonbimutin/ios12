//
//  questionsFactory.swift
//  Quizapp
//
//  Created by Felipe Alarcon on 06/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import Foundation


class QuestionsFactory {

    var questionsBank : QuestionsBank!
    
    
    init() {
        
        // Prosesado automatico con codable
        
        do {
            if let url = Bundle.main.url(forResource: "QuestionsBank", withExtension: "plist"){
            let data = try Data(contentsOf: url)
                // datos en bytes
            self.questionsBank = try PropertyListDecoder().decode(QuestionsBank.self, from: data)
            self.questionsBank.questions.shuffle()
            
            }
            
        } catch {
            print(error)
        }
        
        
        /* prosesado manual de plist
         
        if let path = Bundle.main.path(forResource: "QuestionsBanck" , ofType: "plist"){
            if let plist = NSDictionary(contentsOfFile: path){
                let questionsData = plist["questions"] as! [AnyObject]
                
                for question in questionsData{
                    if let text = question["question"], let ans = question["answer"], let expl = question["explanation"]{
                        let q = Question(text: text as! String, correctAnswer: ans as! Bool, expl: expl as! String)
                        questions.append(q)
                    }
                }
            }
        }
         */
    }
    
    
    
    func getQuestion(index : Int) -> Question? {
        if index < 10{
            return self.questionsBank.questions[index]
        }else{
            return nil
        }
    }
    
    
    
    
    
}


