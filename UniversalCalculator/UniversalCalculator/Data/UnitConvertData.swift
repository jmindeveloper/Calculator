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

struct UnitType {
    let type: String
    let figure: Double
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
    // 속도
    case ms
    case mh
    case kms
    case kmh
    case mach
    // 데이터양
    case bit
    case byte
    case kb
    case mb
    case gb
    case tb
   
    var description: String {
        switch self {
        case .length: return "길이"
        case .area: return "넓이"
        case .weight: return "무게"
        case .volume: return "부피"
        case .temperature: return "온도"
        case .speed: return "속도"
        case .data: return "데이터양"
        case .mm: return "밀리미터(mm)"
        case .cm: return "센티미터(cm)"
        case .m: return "미터(m)"
        case .km: return "킬로미터(km)"
        case .inch: return "인치(in)"
        case .ft: return "피트(ft)"
        case .㎡: return "제곱미터(㎡)"
        case .㎢: return "제곱킬로미터(㎢)"
        case .ft2: return "제곱피트"
        case .ha: return "헥타르(ha)"
        case .pyeong: return "평"
        case .mg: return "밀리그램(mg)"
        case .g: return "그램(g)"
        case .kg: return "킬로그램(kg)"
        case .t: return "톤(t)"
        case .lb: return "파운드(lb)"
        case .oz: return "온스(oz)"
        case .cc: return "시시(cc)"
        case .㎖: return "밀리리터(㎖)"
        case .㎗: return "데시리터(㎗)"
        case .ℓ: return "리터(ℓ)"
        case .㎤: return "세제곱센티미터(㎤)"
        case .㎥: return "세제곱미터(㎥)"
        case .inch3: return "세제곱인치"
        case .ft3: return "세제곱피트"
        case .gal: return "갤런(gal)"
        case .bbl: return "배럴(bbl)"
        case .hop: return "홉"
        case .℃: return "섭씨온도(℃)"
        case .℉: return "화씨온도(℉)"
        case .k: return "절대온도(K)"
        case .ms: return "m/s"
        case .mh: return "m/h"
        case .kms: return "km/s"
        case .kmh: return "km/h"
        case .mach: return "마하(mach)"
        case .bit: return "비트(bit)"
        case .byte: return "바이트(B)"
        case .kb: return "킬로바이트(KB)"
        case .mb: return "메가바이트(MB)"
        case .gb: return "기가바이트(GB)"
        case .tb: return "테라바이트(PB)"
        }
    }

}
