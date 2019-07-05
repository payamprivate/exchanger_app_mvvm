//
//  helper.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/4/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import Foundation
import UIKit

func get_currency_list()->[Currency]{
    var currency_list = [Currency]()
    
    var currency = Currency(id: 1, nick_name: "GBP", full_name: "British Pound")
    currency_list.append(currency)
    
    currency = Currency(id: 2, nick_name: "EUR", full_name: "Euro")
    currency_list.append(currency)
    
    currency = Currency(id: 3, nick_name: "USD", full_name: "US Dollar")
    currency_list.append(currency)
    
    currency = Currency(id: 4, nick_name: "AUD", full_name: "Australian Dollar")
    currency_list.append(currency)
    
    currency = Currency(id: 5, nick_name: "CAD", full_name: "Canadian Dollar")
    currency_list.append(currency)
    
    currency = Currency(id: 6, nick_name: "CZK", full_name: "Czech Koruna")
    currency_list.append(currency)
    
    currency = Currency(id: 7, nick_name: "DKK", full_name: "Danish Krone")
    currency_list.append(currency)
    
    currency = Currency(id: 8, nick_name: "JPY", full_name: "Japanese Yen")
    currency_list.append(currency)
    
    currency = Currency(id: 9, nick_name: "PLN", full_name: "Polish Zloty")
    currency_list.append(currency)
    
    currency = Currency(id: 10, nick_name: "RON", full_name: "Romanian Leu")
    currency_list.append(currency)
    
    currency = Currency(id: 11, nick_name: "SEK", full_name: "Swedish Krona")
    currency_list.append(currency)
    
    currency = Currency(id: 12, nick_name: "CHF", full_name: "Swiss Franc")
    currency_list.append(currency)
    
    currency = Currency(id: 13, nick_name: "CNY", full_name: "Chinese yuan")
    currency_list.append(currency)
    
    currency = Currency(id: 14, nick_name: "BGN", full_name: "Bulgarian leva")
    currency_list.append(currency)
    
    currency = Currency(id: 15, nick_name: "BRL", full_name: "Brazilian reals")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "HKD", full_name: "Hong Kong dollars")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "HRK", full_name: "Croatian kunas")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "HUF", full_name: "Hungarian forints")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "IDR", full_name: "Indonesian rupiahs")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "ILS", full_name: "Israeli new sheqels")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "INR", full_name: "Indian rupees")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "ISK", full_name: "Icelandic krónur")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "KRW", full_name: "South Korean won")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "MXN", full_name: "Mexican pesos")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "MYR", full_name: "Malaysian ringgits")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "NOK", full_name: "Norwegian kroner")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "NZD", full_name: "New Zealand dollars")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "PHP", full_name: "Philippine pesos")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "RUB", full_name: "Russian rubles")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "SGD", full_name: "Singapore dollars")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "THB", full_name: "Thai baht")
    currency_list.append(currency)
    
    currency = Currency(id: 1, nick_name: "ZAR", full_name: "South African rand")
    currency_list.append(currency)

    return currency_list
}


extension UIImageView {
    func makeRounded() {
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
