//
//  revolut_testTests_Entities.swift
//  revolut_testTests
//
//  Created by payam ghader kurehpaz on 7/9/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import Foundation
class revolut_testTests_DelegateMock: Main_viewModel_to_ViewController_protocol  {

    var test_showpopUp: (() -> Void)?
    var test_update_tableview: (() -> Void)?
    var test_delete_row_at: (() -> Void)?
    
    //delegations
    func update_tableview() {
        test_update_tableview?()
    }
    
    func show_popUp() {
        test_showpopUp?()
    }
    
    func delete_row_at(indexPath: IndexPath) {
        print("we got delete aciton")
        test_delete_row_at?()
    }

}
