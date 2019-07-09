//
//  Main_Cell.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/4/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import UIKit

class Main_Cell: UITableViewCell {
    
    @IBOutlet weak var label_first_pair_rate: UILabel!
    @IBOutlet weak var label_first_pairname: UILabel!
    
    @IBOutlet weak var label_second_pairname: UILabel!
    @IBOutlet weak var label_second_pair_rate_1: UILabel!
    @IBOutlet weak var label_second_pair_rate_2: UILabel!
    
    func configurCell(pair : Currency_pair_view_model){
        label_second_pair_rate_1.text = "\(pair.rate_part1)"
        label_second_pair_rate_2.text = "\(pair.rate_part2)"
        
        label_first_pair_rate.text = pair.first_currency_nickname_with_one
        label_first_pairname.text = pair.first_currency_full_name
        label_second_pairname.text = pair.second_currency_full_name
    }
}
