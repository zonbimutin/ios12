//
//  Question.swift
//  Quizapp
//
//  Created by Felipe Alarcon on 06/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import Foundation


class Question : CustomStringConvertible, Codable {
    
    let question : String
    let answer : Bool
    let explanation : String
    
    /* se utiliza cuando las variables no tienen el mismo formato que la plist 
    enum CodingKeys : String, CodingKey {
        case questionText = "Question"
        case answer = "Answer"
        case explanation = "Explanation"
    }
     */
    
    
    
    
    var description: String{
        return """
        - Qestion:
        \(question)
        - Answer: \(answer)
        - Explanation:
        \(explanation)
        
        """
    }
    
    
    init(text : String, correctAnswer : Bool, expl : String) {
        self.question = text
        self.answer = correctAnswer
        self.explanation = expl
        
    }
    
}

struct QuestionsBank : Codable {
    var questions : [Question]
    
}


