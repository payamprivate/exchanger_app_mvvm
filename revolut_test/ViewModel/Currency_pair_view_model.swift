//
//  Currency_pair_view_model.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/8/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import Foundation

class Currency_pair_view_model {
    
    var pair : Currencypair
    var rate : Double?
    
    init(pair : Currencypair) {
        self.pair = pair
    }
    
    var first_currency_nickname_with_one : String {
        return "1 \(pair.firstCurrency.nick_name)"
    }
    
    var first_currency_nickname_simple : String {
        return "\(pair.firstCurrency.nick_name)"
    }
    
    var first_currency_full_name : String {
        return "\(pair.firstCurrency.full_name)"
    }
    
    var second_currency_full_name : String {
        return "\(pair.secondCurrency.full_name) . \(pair.secondCurrency.nick_name)"
    }
    
    var pair_name : String {
        return "\(pair.firstCurrency.nick_name)\(pair.secondCurrency.nick_name)"
    }
    
    var rate_part1 : String {
        return get_rate_string_parts(value: rate, part: Rate_section.big)
    }
    
    var rate_part2 : String {
        return get_rate_string_parts(value: rate, part: Rate_section.little)
    }
    
    //generating rate parts , first part is the big part , and second part is the litle part
    func get_rate_string_parts(value : Double?,part : Rate_section)->String{
        guard let value = value else {
            return ""
        }
        
        let str = "\(value)"
        let separator = Character(NSLocale.current.decimalSeparator ?? ".")
        var posOfPoint = 0
        for (i, val) in str.enumerated() {
            if val == separator {
                posOfPoint = i
                break
            }
        }
        
        if(str.count-posOfPoint>3){
            let index = str.index(str.startIndex, offsetBy: posOfPoint + 3)
            if part == Rate_section.big {
                return str.substring(to: index)
            }else{
                return str.substring(with: index..<str.endIndex)
            }
        }else{
            if part == Rate_section.big {
                return str
            }else{
                return ""
            }
        }
    }
}
