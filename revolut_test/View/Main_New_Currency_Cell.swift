//
//  Main_New_Currency_Cell.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/4/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import UIKit

class Main_New_Currency_Cell: UITableViewCell {
    
    @IBAction func btn_add_new(_ sender: Any) {
        let notif = Notification(name: Notification.Name(rawValue: "add_currency"), object: nil )
        NotificationCenter.default.post(notif)
    }
    
}
