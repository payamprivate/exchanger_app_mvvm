//
//  Currency_view_model.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/8/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import Foundation
import UIKit
class Currency_view_model {
    var currency : Currency
    
    lazy var name : String = {
        return currency.full_name
    }()
    
    lazy var nickname_uppedcased : String = {
        return currency.nick_name.uppercased()
    }()
    
    lazy var nickname : String = {
        return currency.nick_name
    }()
    
    lazy var flag : UIImage = {
        return UIImage(named: "\(currency.nick_name)")!
    }()
    
    
    init(currency : Currency) {
        self.currency = currency
    }
    
}
