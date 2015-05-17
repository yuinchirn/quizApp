//
//  Question.swift
//  quizApp
//
//  Created by Yuta Chiba on 2015/05/14.
//  Copyright (c) 2015年 yuinchirn. All rights reserved.
//

import RealmSwift

class Question: Object {
    dynamic var id = 0
    dynamic var questionText = ""
    dynamic var choice1 = ""
    dynamic var choice2 = ""
    dynamic var choice3 = ""
    dynamic var choice4 = ""
    dynamic var answerText = ""
    dynamic var answerNum = 0
    dynamic var explanationText = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
