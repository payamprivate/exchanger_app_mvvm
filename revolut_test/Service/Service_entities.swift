//
//  Service_entities.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/4/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import Foundation

typealias SuccessHandler = (_ result: Req_result, _ error: String? , _ result : [Currencypair])
    -> Void

enum Req_result {
    case success
    case failure
}

