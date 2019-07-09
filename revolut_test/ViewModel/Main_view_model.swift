//
//  Main_view_model.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/6/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import Foundation
import UIKit

class Main_view_model {
    
    var delegate : Main_viewModel_to_ViewController_protocol?
    
    // pairs saved name on Disk for recovering or saving new pairs
    let saved_name = "pairs"
    
    var is_showing_popup = false
    
    let userDefaults = UserDefaults.standard
    
    var is_editing = false
    
    var serviceTimer: Timer?
    
    var pairs_viewModel : [Currency_pair_view_model]? = []{
        didSet{
            sync_view()
        }
    }
    
    var pairs : [Currencypair]? = []{
        didSet{
            sync_viewModel()
            
            guard let pairs = pairs else {return}
            if let encoded = try? JSONEncoder().encode(pairs) {
                UserDefaults.standard.set(encoded, forKey: saved_name)
            }else{
                print("there was error")
            }
        }
    }
    
    init(delegate : Main_viewModel_to_ViewController_protocol) {
        self.delegate = delegate
        
        if let blogData = UserDefaults.standard.data(forKey: saved_name),
            let saved_pairs = try? JSONDecoder().decode([Currencypair].self, from: blogData) {
            //because didset is not working without writing defer!
            defer {
                self.pairs = saved_pairs
            }
        }else{
            sync_view()
            print("there is no saved data!")
        }
    }
    
    // free initialization is for testing issues
    init() {
        
    }
    
    func save_ViewModels(){
        var new_pairs = [Currencypair]()
        guard let pairs_viewModel = pairs_viewModel else {
            pairs = new_pairs
            return
        }
        for p_viewModel in pairs_viewModel {
            let newPair = Currencypair(firstCurrency: p_viewModel.pair.firstCurrency, secondCurrency: p_viewModel.pair.secondCurrency)
            new_pairs.append(newPair)
        }
        pairs = new_pairs
    }
    
    func sync_viewModel(){
        //creating viewModels from pairs
        var the_pairs_viewModel = [Currency_pair_view_model]()
        guard let pairs = pairs else { return }
        
        for pair in pairs {
            let pairViewModel = Currency_pair_view_model(pair: pair)
            the_pairs_viewModel.append(pairViewModel)
        }
        pairs_viewModel = the_pairs_viewModel
    }
    
    func get_number_of_rows()->Int{
        if let pairs = pairs{
            return pairs.count + 1
        }else{
            return 1
        }
    }
    
    func can_edit_row_at(indexPath : IndexPath)->Bool{
        if indexPath.row > 0{
            return true
        }else{
            return false
        }
    }
    
    func deleteAction(at indexPath: IndexPath)-> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            if indexPath.row>0{
                self.delete_action_completed(at: indexPath)
                completion(true)
            }else{
                print("cant delete")
            }
        }
        action.backgroundColor = .red
        
        return action
    }
    
    func delete_action_completed(at indexPath: IndexPath){
        self.pairs?.remove(at: (indexPath.row-1))
        self.delegate?.delete_row_at(indexPath: indexPath)
    }
    
    func start_service(){
        if serviceTimer == nil{
            serviceTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(get_data), userInfo: nil, repeats: true)
        }
    }
    
    func stopservice(){
        if serviceTimer != nil{
            serviceTimer?.invalidate()
            serviceTimer = nil
        }
    }
    
    //getting data from server for our pairs and updating the rates
    @objc func get_data (){
        guard let the_pairs = self.pairs_viewModel, the_pairs.count>0 else{
            return
        }
        let service = Service.instance
        service.get_data(pairs: the_pairs,completion: {result,error,the_pairs in
            if result == Req_result.success{
                if self.pairs?.count == the_pairs.count{
                    DispatchQueue.main.async {
                        self.pairs_viewModel = the_pairs
                        if !self.is_editing {
                            self.delegate?.update_tableview()
                        }
                    }
                }
            }
        })
    }
    
    // checking the pairs if there was only 0 pairs or nil ,we want to show popup( Add new Currency Page )
    func sync_view(){
        start_service()
        guard let pairs = pairs , pairs.count>0 else {
            self.delegate?.show_popUp()
            return
        }
    }
}
