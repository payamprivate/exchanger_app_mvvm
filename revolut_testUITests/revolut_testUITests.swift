//
//  revolut_testUITests.swift
//  revolut_testUITests
//
//  Created by payam ghader kurehpaz on 7/2/19.
//  Copyright © 2019 payam ghader kurehpaz. All rights reserved.
//

import XCTest

class revolut_testUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app.launchArguments = ["enable-testing"]
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        if ( XCUIApplication().staticTexts["Choose a currency pair to compare their live rates"].exists ){
            let app = XCUIApplication()
            app.buttons["Add currency pair"].tap()
            
            let tablesQuery = app.tables
            tablesQuery.cells.containing(.image, identifier:"CHF").children(matching: .button).element.tap()
            tablesQuery.cells.containing(.image, identifier:"GBP").children(matching: .button).element.tap()
            
            let tablesQuery2 = tablesQuery
            XCTAssertTrue(tablesQuery2.staticTexts["Swiss Franc"].exists)
            XCTAssertTrue(tablesQuery2.staticTexts["1 CHF"].exists)
            XCTAssertTrue(tablesQuery2.staticTexts["British Pound . GBP"].exists)
            
            sleep(2)
            
            let tablesQuery3 = XCUIApplication().tables
            tablesQuery3.cells.containing(.image, identifier:"pluse").children(matching: .button).element.tap()
            tablesQuery3.cells.containing(.image, identifier:"GBP").children(matching: .button).element.tap()
            tablesQuery3.cells.containing(.image, identifier:"EUR").children(matching: .button).element.tap()
            
            let tablesQuery4 = XCUIApplication().tables
            XCTAssertTrue(tablesQuery4.staticTexts["1 GBP"].exists)
            XCTAssertTrue(tablesQuery4.staticTexts["British Pound"].exists)
            XCTAssertTrue(tablesQuery4.staticTexts["Euro . EUR"].exists)
            
            sleep(3)

        }else{
            
            let tablesQuery = XCUIApplication().tables
            tablesQuery.cells.containing(.image, identifier:"pluse").children(matching: .button).element.tap()
            tablesQuery.cells.containing(.image, identifier:"CHF").children(matching: .button).element.tap()
            tablesQuery.cells.containing(.image, identifier:"EUR").children(matching: .button).element.tap()
            
            XCTAssertTrue(tablesQuery.cells.containing(.staticText, identifier:"Euro . EUR").staticTexts["1 CHF"].exists)
            XCTAssertTrue(tablesQuery.cells.containing(.staticText, identifier:"Euro . EUR").staticTexts["Swiss Franc"].exists)
            XCTAssertTrue(tablesQuery.staticTexts["Euro . EUR"].exists)
            
        }
        
    }

}
