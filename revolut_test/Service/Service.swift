//
//  Service.swift
//  revolut_test
//
//  Created by payam ghader kurehpaz on 7/2/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import Foundation

//singleton
class Service {
    let url = "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios?"
    var is_loading = false
    
    static let instance = Service()
    
    func get_data(pairs : [Currency_pair_view_model],completion: @escaping SuccessHandler ){
        if !is_loading {
            is_loading = true
            
            var new_pairs = pairs
            
            if let url = URL(string: create_url(pairs: pairs)){
                URLSession.shared.dataTask(with: url) { (data, response, err) in
                    
                    if let err = err {
                        completion(Req_result.failure, "\(err)", pairs)
                        self.is_loading = false
                        return
                    }
                    
                    guard let data = data else { return }
                    
                    if let dataString = String(data: data, encoding: .utf8){
                        let data = dataString.data(using: .utf8)!
                        do {
                            if let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]{
                                for (index,pair) in new_pairs.enumerated() {
                                    if let the_rate = jsonData["\(pair.pair_name)"] as? Double {
                                        var new_pair = new_pairs[index]
                                        new_pair.rate =   Double(round(10000*the_rate)/10000)
                                        new_pairs[index] = new_pair
                                    }
                                }
                                self.is_loading = false
                                completion(Req_result.success, nil, pairs)
                            }
                        } catch let error as NSError {
                            self.is_loading = false
                            print(error)
                            completion(Req_result.failure, "\(error)", pairs)
                            return
                        }
                    }
                    self.is_loading = false
                    }.resume()
            }
        }else{
            completion(Req_result.failure, "is_loading", pairs)
        }
    }
    
    //creating url from pairs
    func create_url(pairs : [Currency_pair_view_model]) -> String {
        var url_string = url
        for (index,pair) in pairs.enumerated() {
            if index > 0 {
                url_string.append("&")
            }
            url_string.append("pairs=\(pair.pair_name)")
        }
        return url_string
    }
}


