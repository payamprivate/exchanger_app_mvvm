//
//  revolut_testTests.swift
//  revolut_testTests
//
//  Created by payam ghader kurehpaz on 7/2/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import XCTest
import Foundation
@testable import revolut_test

class revolut_testTests: XCTestCase {
    
    var mainViewModel : Main_view_model!
    var pairs = [Currencypair]()
    let delegate = revolut_testTests_DelegateMock()
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mainViewModel = Main_view_model()
        
        let br_currency = Currency(id: 1, nick_name: "GBP", full_name: "British Pound")
        let eu_currency = Currency(id: 2, nick_name: "EUR", full_name: "Euro")
        
        let currency_pair_euro_usd = Currencypair(firstCurrency: br_currency, secondCurrency: eu_currency)
        pairs.append(currency_pair_euro_usd)
        
        let us_currency = Currency(id: 3, nick_name: "USD", full_name: "US Dollar")
        let currency_pair_gbp_usd = Currencypair(firstCurrency: br_currency, secondCurrency: us_currency)
        
        pairs.append(currency_pair_euro_usd)
        
        mainViewModel.pairs = pairs
    }
    
    override func tearDown() {
        // RESETING VALUES
        var new_pairs = [Currencypair]()
        
        let br_currency = Currency(id: 1, nick_name: "GBP", full_name: "British Pound")
        let eu_currency = Currency(id: 2, nick_name: "EUR", full_name: "Euro")
        
        let currency_pair_euro_usd = Currencypair(firstCurrency: br_currency, secondCurrency: eu_currency)
        new_pairs.append(currency_pair_euro_usd)
        
        let us_currency = Currency(id: 3, nick_name: "USD", full_name: "US Dollar")
        let currency_pair_gbp_usd = Currencypair(firstCurrency: br_currency, secondCurrency: us_currency)
        
        new_pairs.append(currency_pair_euro_usd)
        
        mainViewModel.pairs = new_pairs
    }
    
    func testMainViewModel_pairs_and_updating_rates(){
        mainViewModel.delegate = delegate
        XCTAssertEqual(mainViewModel.pairs?.count, pairs.count)
        XCTAssertEqual(mainViewModel.pairs_viewModel?.count, pairs.count)
        
        if let model_pairs = mainViewModel.pairs {
            XCTAssertEqual("\(model_pairs[0].firstCurrency.id)", "1")
            XCTAssertEqual("\(model_pairs[0].firstCurrency.nick_name)", "GBP")
            XCTAssertEqual("\(model_pairs[0].firstCurrency.full_name)", "British Pound")
            
            XCTAssertEqual("\(model_pairs[0].secondCurrency.id)", "2")
            XCTAssertEqual("\(model_pairs[0].secondCurrency.nick_name)", "EUR")
            XCTAssertEqual("\(model_pairs[0].secondCurrency.full_name)", "Euro")
            
            let update = expectation(description: "update")
            delegate.test_update_tableview = {
                print("we got update")
                update.fulfill()
                XCTAssertNotNil(self.mainViewModel.pairs_viewModel?[0], "Model at 0 index is nill")
                XCTAssertNotNil(self.mainViewModel.pairs_viewModel?[0].rate , "rate after update is nil")
            }
            
            waitForExpectations(timeout: 10, handler: nil)
        }else{
            //test fails
            XCTFail("model pairs are null")
        }
    }
    
    func testDeleting_a_currencyPair(){
        sleep(5)
        mainViewModel.delegate = delegate
        
        XCTAssertEqual(mainViewModel.pairs?.count, pairs.count)
        XCTAssertEqual(mainViewModel.pairs_viewModel?.count, pairs.count)
        if let model_pairs = mainViewModel.pairs {
            XCTAssertEqual("\(model_pairs[0].firstCurrency.id)", "1")
            XCTAssertEqual("\(model_pairs[0].firstCurrency.nick_name)", "GBP")
            XCTAssertEqual("\(model_pairs[0].firstCurrency.full_name)", "British Pound")
            
            XCTAssertEqual("\(model_pairs[0].secondCurrency.id)", "2")
            XCTAssertEqual("\(model_pairs[0].secondCurrency.nick_name)", "EUR")
            XCTAssertEqual("\(model_pairs[0].secondCurrency.full_name)", "Euro")
            
            let indexpath = IndexPath(row: 1, section: 0)
            let delete = expectation(description: "delete")
            delegate.test_delete_row_at = {
                delete.fulfill()
                self.mainViewModel.pairs = self.pairs
            }
            mainViewModel.delete_action_completed(at: indexpath)
            waitForExpectations(timeout: 5, handler: nil)
        }else{
            //test fails
            XCTAssertEqual(1,2)
        }
    }
    
    func test_showing_popup_by_removingAll_pairs(){
        sleep(5)
        mainViewModel.delegate = delegate
        
        XCTAssertEqual(mainViewModel.pairs?.count, pairs.count)
        XCTAssertEqual(mainViewModel.pairs_viewModel?.count, pairs.count)
        if let model_pairs = mainViewModel.pairs {
            XCTAssertEqual("\(model_pairs[0].firstCurrency.id)", "1")
            XCTAssertEqual("\(model_pairs[0].firstCurrency.nick_name)", "GBP")
            XCTAssertEqual("\(model_pairs[0].firstCurrency.full_name)", "British Pound")
            
            XCTAssertEqual("\(model_pairs[0].secondCurrency.id)", "2")
            XCTAssertEqual("\(model_pairs[0].secondCurrency.nick_name)", "EUR")
            XCTAssertEqual("\(model_pairs[0].secondCurrency.full_name)", "Euro")
            
            let popup = expectation(description: "popup")
            delegate.test_showpopUp = {
                popup.fulfill()
                self.mainViewModel.pairs = self.pairs
            }
            let emptypairs = [Currencypair]()
            mainViewModel.pairs = emptypairs
            
            
            waitForExpectations(timeout: 5, handler: nil)
        }else{
            //test fails
            XCTAssertEqual(1,2)
        }
    }
    
    
    
    
}
