//
//  protocols.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/4/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import Foundation

// protocol to inform MainviewController that add_newCurrency is clicked from popup!
protocol Add_new_currency_clicked {
    func add_new_currency_clicked()
}

// protocol for sending new pairs from AddviewController to MainViewController
protocol Set_new_pairs {
    func set_new_pairs(pairs : [Currency_pair_view_model])
}

// informing viewcontroller for changes in tableview or showing popup
protocol Main_viewModel_to_ViewController_protocol {
    func update_tableview()
    func show_popUp()
    func delete_row_at(indexPath : IndexPath)
}

// informing viewmodel from viewController to do the needed changes
protocol ViewController_to_ViewModel_protocol {
    func syncView()
}
