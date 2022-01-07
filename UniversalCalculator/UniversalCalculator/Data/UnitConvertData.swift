//
//  UnitConvertData.swift
//  UniversalCalculator
//
//  Created by J_Min on 2022/01/06.
//

import Foundation
import Collections

struct UnitConvertElement: Codable {
    let unitName: String
    let type: [String: Double]
}

enum UnitConvertToKorean: String {
    
    case length
    case area
    case weight
    case volume
    case temperature
    case speed
    case data
    // 길이
    case mm
    case cm
    case m
    case km
    case inch
    case ft
    // 넓이
    case ㎡
    case ㎢
    case ft2
    case ha
    case pyeong
    // 무게
    case mg
    case g
    case kg
    case t
    case lb
    case oz
    // 부피
    case cc
    case ㎖
    case ㎗
    case ℓ
    case ㎤
    case ㎥
    case inch3
    case ft3
    case gal
    case bbl
    case hop
    // 온도
    case ℃
    case ℉
    case k
    
    








    var description: String {
        switch self {
        case .length: return "길이"
        case .area: return "넓이"
        case .weight: return "무게"
        case .volume: return "부피"
        case .temperature: return "온도"
        case .speed: return "속도"
        case .data: return "데이터양"
        }
    }

}
