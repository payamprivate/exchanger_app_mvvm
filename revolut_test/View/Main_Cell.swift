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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
