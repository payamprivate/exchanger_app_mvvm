//
//  Popup_add_Controller.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/4/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import UIKit

class Popup_add_Controller: UIViewController {

    var delegate : Add_new_currency_clicked?
    
    
    
    @IBAction func add_clicked(_ sender: Any) {
        if let delegate = delegate {
            delegate.add_new_currency_clicked()
        }
        close_popup()
    }
    
    func close_popup(){
        self.view.endEditing(true)
        self.view.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
