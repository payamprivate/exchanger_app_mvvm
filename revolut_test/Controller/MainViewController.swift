//
//  ViewController.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/2/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import UIKit
import Foundation
class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,Add_new_currency_clicked {
    
    var pairs : [Currencypair]? = []{
        didSet{
            sync_view()
        }
    }
    
    var serviceTimer: Timer?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        print("view Appeared")
        sync_view()
    }
    
    deinit {
        stopservice()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.add_new_currency(_:)) ,name: NSNotification.Name(rawValue: "add_currency"), object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.isHidden = true
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : Main_New_Currency_Cell
            cell = tableView.dequeueReusableCell(withIdentifier: "main_add", for: indexPath) as! Main_New_Currency_Cell
            return cell
        }else{
            let cell : Main_Cell
            cell = tableView.dequeueReusableCell(withIdentifier: "currency_cell", for: indexPath) as! Main_Cell
            
            if let pairs = pairs {
                let pair = pairs[indexPath.row-1]
                cell.label_first_pair_rate.text = "1 \(pair.firstCurrency.nick_name)"
                
                if let rate = pair.rate {
                    let strs = get_rate_string_parts(value: rate)
                    cell.label_second_pair_rate_1.text = "\(strs[0])"
                    cell.label_second_pair_rate_2.text = "\(strs[1])"
//                    cell.label_second_pair_rate_1.text = "\(String(format: "%.2f", rate))"
                }else{
                    cell.label_second_pair_rate_1.text = ""
                    cell.label_second_pair_rate_2.text = ""
                }
                
                
                cell.label_first_pairname.text = "\(pair.firstCurrency.full_name)"
                cell.label_second_pairname.text = "\(pair.secondCurrency.full_name) . \(pair.secondCurrency.nick_name)"
            }
            
            return cell
        }
    }
    
    func get_rate_string_parts(value : Double)->[String]{
        var str_array = [String]()
        
        let str = "\(value)"
        let separator = Character(NSLocale.current.decimalSeparator ?? ".")
        var posOfPoint = 0
        for (i, val) in str.enumerated() {
            if val == separator {
                posOfPoint = i
                break
            }
        }
        let index = str.index(str.startIndex, offsetBy: posOfPoint + 3)
        str_array.append(str.substring(to: index))
        
        str_array.append(str.substring(with: index..<str.endIndex))
        
        return str_array
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pairs = pairs{
            return pairs.count + 1
        }else{
            return 1
        }
    }
    
    func add_new_currency_clicked() {
        performSegue(withIdentifier: "addcurrency", sender: nil)
    }
    
    @objc func add_new_currency(_ notif : Notification) {
        add_new_currency_clicked()
    }
    
    func sync_view(){
        if let pairs = pairs {
            if pairs.count>0{
                tableView.reloadData()
                start_service()
                return
            }else{
                stopservice()
                show_popUp()
            }
        }else{
            show_popUp()
        }
    }
    
    func show_popUp(){
        if let pop_over = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popup_add") as? Popup_add_Controller{
            self.addChild(pop_over)
            pop_over.view.frame = self.view.frame
            self.view.addSubview(pop_over.view)
            pop_over.didMove(toParent: self)
            pop_over.delegate = self
        }
    }
    
    
    func start_service(){
        if serviceTimer == nil{
            serviceTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(get_data), userInfo: nil, repeats: true)
        }
    }
    
    func stopservice(){
        if serviceTimer != nil{
            serviceTimer?.invalidate()
            serviceTimer = nil
        }
    }
    
    @objc func get_data (){
        if let the_pairs = self.pairs{
            let service = Service.instance
            service.get_data(pairs: the_pairs,completion: {result,error,the_pairs in
                if result == Req_result.success{
                    
                    if self.pairs?.count == the_pairs.count{
                        DispatchQueue.main.async {
                            self.pairs = the_pairs
                            self.tableView.reloadData()
                        }
                    }
                    
                }
                //                else if result == Req_result.failure {
                //                print("error: \(error)")
                //                }
            })
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addcurrency" {
            let add_currency_page = segue.destination as! Add_Currency_ViewController
            if let pairs = pairs {
                add_currency_page.all_currency_pairs = pairs
            }
            add_currency_page.mainController = self
        }
    }
}

