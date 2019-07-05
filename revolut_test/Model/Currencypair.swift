//
//  Currencypair.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/2/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import Foundation

class Currencypair {
    var firstCurrency : Currency
    var secondCurrency : Currency
    var rate : Double?
    
    init(firstCurrency : Currency ,secondCurrency : Currency , rate : Double?) {
        self.firstCurrency = firstCurrency
        self.secondCurrency = secondCurrency
        self.rate = rate
    }
    
    func get_pair_name()->String{
//        if (firstCurrency != nil && secondCurrency != nil){
        return "\(firstCurrency.nick_name)\(secondCurrency.nick_name)"
//        }else{
//            return ""
//        }
    }
    
}
