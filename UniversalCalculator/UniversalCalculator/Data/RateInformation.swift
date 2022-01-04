//
//  RateInformation.swift
//  Calculator
//
//  Created by J_Min on 2022/01/01.
//

import Foundation

struct RateInformation: Codable {
    
    let result: Int                 // 조회결과
    let currencyUnit: String        // 통화코드
    let currencyName: String        // 국가 / 통화명
    let sendMoney: String           // 송금할때
    let recieveMoney: String        // 송금받을때
    let dealBaseRate: String        // 매매기준율
    let useless1: String
    let useless2: String
    let useless3: String
    let useless4: String
    let useless5: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case currencyUnit = "cur_unit"
        case currencyName = "cur_nm"
        case sendMoney = "tts"
        case recieveMoney = "ttb"
        case dealBaseRate = "deal_bas_r"
        case useless1 = "bkpr"
        case useless2 = "yy_efee_r"
        case useless3 = "ten_dd_efee_r"
        case useless4 = "kftc_bkpr"
        case useless5 = "kftc_deal_bas_r"
    }
    
}

typealias Rate = [RateInformation]
