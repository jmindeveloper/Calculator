//
//  GradeData.swift
//  Calculator
//
//  Created by J_Min on 2021/12/25.
//

import Foundation

struct Grade {
    var grade: String
    var score: String
    var isMasor: Bool
    
    init(grade: String, score: String, isMasor: Bool) {
        self.score = score
        self.grade = grade
        self.isMasor = isMasor
    }
}
