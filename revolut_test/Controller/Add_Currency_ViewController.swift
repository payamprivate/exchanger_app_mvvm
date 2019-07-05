//
//  Add_Currency_ViewController.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/4/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import UIKit

class Add_Currency_ViewController: UITableViewController {
    
    var delegate : Get_new_pairs?
    
    lazy var exclude_Currencies : [Currency] = {
        return exclude_currencies()
    }()
    
    var all_currency_pairs : [Currencypair] = [Currencypair]()
    
    let currencies = get_currency_list()
    var firstCurrency : Currency?
    var secondCurrency : Currency?
    
    
    
    
    
    @objc func currency_choosed(_ notif : Notification){
        if let position = notif.object as? Int{
            if firstCurrency == nil {
                self.firstCurrency = currencies[position]
                tableView.reloadData()
            }else{
                self.secondCurrency = currencies[position]
                let newpair = Currencypair(firstCurrency: firstCurrency!, secondCurrency: secondCurrency!, rate: nil)
                all_currency_pairs.insert(newpair, at: 0)
                if let delegate = delegate {
                    delegate.get_new_pairs(pairs: all_currency_pairs)
                }
//                print("pairs choosed")
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.currency_choosed(_:)) ,name: NSNotification.Name(rawValue: "currency_choosed"), object: nil)

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currencies.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currency_cell", for: indexPath) as! Add_Currency_Cell
        let currency = currencies[indexPath.row]
        cell.label_fullname.text = currency.full_name
        cell.label_nickname.text = currency.nick_name.uppercased()
        cell.image_flag.image = UIImage(named: "\(currency.nick_name)")
        cell.position = indexPath.row
        // if currency exists in exclude_Currencies we should disable it
        cell.view_disable.isHidden = true
        if let firscurrency = firstCurrency {
            if is_cell_disabled(currency: currency){
                cell.view_disable.isHidden = false
            }
        }
        
        // Configure the cell...
        return cell
    }
    
    func is_cell_disabled(currency : Currency)->Bool{
        for the_currency in exclude_Currencies {
            if the_currency.nick_name == currency.nick_name {
                return true
            }
        }
        return false
    }
    
    func exclude_currencies() -> [Currency] {
        var excludes = [Currency]()
        if let firstCurrency = firstCurrency {
            excludes.append(firstCurrency)
            
            for currency in all_currency_pairs {
                if currency.firstCurrency.nick_name == firstCurrency.nick_name {
                    excludes.append(currency.secondCurrency)
                }
            }
        }
        return excludes
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let firscurrency = firstCurrency {
            return "Second Currency"
        }else{
            return "First Currency"
        }
    }


}
