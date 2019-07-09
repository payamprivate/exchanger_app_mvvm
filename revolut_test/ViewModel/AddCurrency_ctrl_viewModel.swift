//
//  AddCurrency_ctrl_viewModel.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/8/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import Foundation

class AddCurrency_ctrl_viewModel {
    
    lazy var exclude_Currencies : [Currency] = {
        return exclude_currencies()
    }()
    
    // currency pairs that are added from prevue times !
    var added_currency_pairs = [Currency_pair_view_model]()
    
    var currencies_viewModel = [Currency_view_model]()
    
    var firstCurrency : Currency?
    
    var secondCurrency : Currency?
    
    init(added_currency_pairs : [Currency_pair_view_model]) {
        for the_currency in get_currency_list(){
            let currency_vm = Currency_view_model(currency: the_currency)
            currencies_viewModel.append(currency_vm)
        }
        
        self.added_currency_pairs = added_currency_pairs
    }
    
    // if viewDisable be hiden user can choose that Currency , if not user cant choose that currency
    func is_hiden_viewDisabled(currency_vm : Currency_view_model )->Bool {
        var result = true
        if let firscurrency = firstCurrency {
            if is_cell_disabled(currency: currency_vm.currency){
                result = false
            }
        }
        
        return result
    }
    
    // it's a helper function for this func -> is_hiden_viewDisabled
    func is_cell_disabled(currency : Currency)->Bool{
        for the_currency in exclude_Currencies {
            print("the currency nick name : \(the_currency.full_name)")
            if the_currency.nick_name == currency.nick_name {
                print("\(the_currency.nick_name) == \(currency.nick_name)")
                return true
            }
        }
        return false
    }
    
    func title_for_header()->String{
        if let firscurrency = firstCurrency {
            return "Second Currency"
        }else{
            return "First Currency"
        }
    }
    
    func number_of_rows()->Int{
        return currencies_viewModel.count
    }
    
    //exclude currencies include the first currency and currencies added from prevue times that their first currency is similar to our first currency
    func exclude_currencies() -> [Currency] {
        var excludes = [Currency]()

        if let firstCurrency = firstCurrency {
            excludes.append(firstCurrency)
    
            for currency_vm in added_currency_pairs {
                if currency_vm.first_currency_nickname_simple == firstCurrency.nick_name {
                    print("\(currency_vm.first_currency_nickname_with_one) added")
                    excludes.append(currency_vm.pair.secondCurrency)
                }
            }
        }
        
        return excludes
    }
}
