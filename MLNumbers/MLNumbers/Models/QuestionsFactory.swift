//
//  QuestionsFactory.swift
//  MLNumbers
//
//  Created by Felipe Alarcon on 13/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import Foundation
import Vision

class QuestionFactory {
    
    var questions = [Question]()
    private(set) var score = 0
//    public private(set) var maxQuestions: Int = 5
    
    var mnisttModel = MnistModel()
    
    init() {
        
        addNewQuestion()
        
    }
    
    func resetData(){
        self.score = 0
        self.questions.removeAll()
        addNewQuestion()
    }
    
    func addNewQuestion() {
        questions.insert(createQuestion(), at: 0)
    }
    
    
/*
     recuperar el valor cuando la variable es privada
     
     func getScore() -> Int {
     return self.score
     }
*/
    
    
    func getQuestion(_ position: Int) -> Question? {
        if (position < 0 || position >= self.questions.count){
            return nil
        }
        return self.questions[position]
    }
    
    func getNumberOfQuestions() -> Int {
        return questions.count
    }
    
    func updateQuestion(at index: Int, with answer: Int) {
        questions[index].userAnswer = answer
        
    }
    
    func validateQuestion(at index:Int) {
        if self.questions[index].answer == self.questions[index].userAnswer{
            self.score += 100
        }
    }
    
    func createQuestion() -> Question {
        var question = ""
        var correctAnswer = 0
        
        while true {
            let firstNumber = Int.random(in: 0...9)
            let secondNumber = Int.random(in: 0...9)
            
            if Bool.random(){
//                si es true se realiza una suma
                let result = firstNumber + secondNumber
                if  result < 10{
                    question = "\(firstNumber) + \(secondNumber)"
                    correctAnswer = result
                    break
                }
                
            }else{
//                si es false se realiza una resta
                let result = firstNumber - secondNumber
                if result >= 0 {
                    question = "\(firstNumber) - \(secondNumber)"
                    correctAnswer = result
                    break
                }
            }
            
        }
        return Question(text: question, answer: correctAnswer, userAnswer: nil)
        
    }
    
}
