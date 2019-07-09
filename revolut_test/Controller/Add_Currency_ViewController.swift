//
//  Add_Currency_ViewController.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/4/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import UIKit

class Add_Currency_ViewController: UITableViewController {
    
    var delegate : Set_new_pairs?
    
    var viewModel : AddCurrency_ctrl_viewModel?
    
    var added_currency_pairs : [Currency_pair_view_model] = [Currency_pair_view_model]()
    
    @objc func currency_choosed(_ notif : Notification){
        guard let viewModel = viewModel else {
            print("guard exception")
            return
        }
        if let position = notif.object as? Int{
            if viewModel.firstCurrency == nil {
                viewModel.firstCurrency = viewModel.currencies_viewModel[position].currency
                tableView.reloadData()
            }else{
                viewModel.secondCurrency = viewModel.currencies_viewModel[position].currency
                let newpair = Currencypair(firstCurrency: viewModel.firstCurrency!, secondCurrency: viewModel.secondCurrency!)
                let newpairViewModel = Currency_pair_view_model(pair: newpair)
                viewModel.added_currency_pairs.insert(newpairViewModel, at: 0)
                if let delegate = delegate {
                    delegate.set_new_pairs(pairs: viewModel.added_currency_pairs)
                }
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.currency_choosed(_:)) ,name: NSNotification.Name(rawValue: "currency_choosed"), object: nil)
        
        viewModel = AddCurrency_ctrl_viewModel(added_currency_pairs: added_currency_pairs)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.number_of_rows() ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currency_cell", for: indexPath) as! Add_Currency_Cell
        let currency = viewModel!.currencies_viewModel[indexPath.row]
        cell.configurCell(viewModel: currency, position: indexPath.row, is_hiden_view_disabled: viewModel!.is_hiden_viewDisabled(currency_vm : currency) )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.title_for_header()
    }
}
