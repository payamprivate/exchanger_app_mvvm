//
//  Add_Currency_Cell.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/4/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import UIKit

class Add_Currency_Cell: UITableViewCell {

    var position : Int?
    var is_disable : Bool = false
    
    @IBAction func btn_selected(_ sender: Any) {
        if !is_disable{
            let notif = Notification(name: Notification.Name(rawValue: "currency_choosed"), object: position )
            NotificationCenter.default.post(notif)
        }
    }
    
    @IBOutlet weak var view_disable: UIView!
    @IBOutlet weak var label_nickname: UILabel!
    @IBOutlet weak var label_fullname: UILabel!
    @IBOutlet weak var image_flag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        image_flag.makeRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
