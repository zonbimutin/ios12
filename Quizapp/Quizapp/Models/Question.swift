//
//  Question.swift
//  Quizapp
//
//  Created by Felipe Alarcon on 06/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import Foundation


class Question {
    
    let questionText : String
    let answer : Bool
    
    
    init(text : String, correctAnswer : Bool) {
        self.questionText = text
        self.answer = correctAnswer
    }
    
}

