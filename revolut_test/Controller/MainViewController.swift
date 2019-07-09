//
//  ViewController.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/2/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    
    var main_ViewModel : Main_view_model?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        main_ViewModel?.is_showing_popup = false
        main_ViewModel?.sync_view()
    }
    
    deinit {
        main_ViewModel?.stopservice()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.add_new_currency(_:)) ,name: NSNotification.Name(rawValue: "add_currency"), object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.isHidden = true
        
        main_ViewModel = Main_view_model(delegate: self)
    }
    
    @objc func add_new_currency(_ notif : Notification) {
        add_new_currency_clicked()
    }
    
    //going to add new currencies
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addcurrency" {
            if let add_currency_page = segue.destination as? Add_Currency_ViewController{
                if let pairs = main_ViewModel?.pairs_viewModel {
                    add_currency_page.added_currency_pairs = pairs
                }
                add_currency_page.delegate = self
            }
        }
    }
}

extension MainViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return main_ViewModel?.get_number_of_rows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : Main_New_Currency_Cell
            cell = tableView.dequeueReusableCell(withIdentifier: "main_add", for: indexPath) as! Main_New_Currency_Cell
            return cell
        }else{
            let cell : Main_Cell
            cell = tableView.dequeueReusableCell(withIdentifier: "currency_cell", for: indexPath) as! Main_Cell
            
            if let  pairs = main_ViewModel?.pairs_viewModel {
                let pair = pairs[indexPath.row-1]
                cell.configurCell(pair: pair)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        main_ViewModel?.is_editing = true
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        main_ViewModel?.is_editing = false
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return main_ViewModel!.can_edit_row_at(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if let delete = main_ViewModel?.deleteAction(at: indexPath) {
            return UISwipeActionsConfiguration(actions: [delete])
        }
        return nil
    }
}

extension MainViewController :Add_new_currency_clicked{
    func add_new_currency_clicked() {
        performSegue(withIdentifier: "addcurrency", sender: nil)
    }
}

extension MainViewController : Set_new_pairs {
    func set_new_pairs(pairs: [Currency_pair_view_model]) {
        self.main_ViewModel?.pairs_viewModel = pairs
        self.main_ViewModel?.save_ViewModels()
        self.tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .none)
    }
}



extension MainViewController : Main_viewModel_to_ViewController_protocol {
    func delete_row_at(indexPath: IndexPath) {
        self.tableView.deleteRows(at: [indexPath], with: .none)
    }
    
    
    func update_tableview() {
        tableView.reloadData()
    }
    
    
    
    func show_popUp(){
        guard let main_ViewModel = main_ViewModel else {
            show_popup_view()
            return
        }
        
        if !main_ViewModel.is_showing_popup {
            show_popup_view()
        }
    }
    
    func show_popup_view(){
        //showin popup when there was no popup
        if main_ViewModel?.is_showing_popup == false {
            if let pop_over = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popup_add") as? Popup_add_Controller{
                self.addChild(pop_over)
                pop_over.view.frame = self.view.frame
                self.view.addSubview(pop_over.view)
                pop_over.didMove(toParent: self)
                pop_over.delegate = self
                main_ViewModel?.is_showing_popup = true
            }
        }
    }
}
