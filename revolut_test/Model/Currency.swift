//
//  Currency.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/2/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import Foundation

class Currency : Codable {
    var id = -1
    var nick_name : String
    var full_name : String
    
    init(id : Int,nick_name : String,full_name : String) {
        self.id = id
        self.nick_name = nick_name
        self.full_name = full_name
    }
}
