//
//  Currencypair.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/2/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import Foundation

class Currencypair : Codable {
    var firstCurrency : Currency
    var secondCurrency : Currency
    
    init(firstCurrency : Currency ,secondCurrency : Currency ) {
        self.firstCurrency = firstCurrency
        self.secondCurrency = secondCurrency
    }
}
