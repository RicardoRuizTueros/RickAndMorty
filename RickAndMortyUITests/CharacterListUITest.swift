//
//  CharacterListUITest.swift
//  RickAndMortyUITests
//
//  Created by Ricardo Ruiz on 14/12/2019.
//  Copyright © 2019 Ricardo Ruiz. All rights reserved.
//

import XCTest

class CharacterListUITest: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launchArguments.append("--uitesting")
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadRickSanchezName() {
        app.launch()
        
        let rickName = app.collectionViews.staticTexts["Rick Sanchez"]
        
        XCTAssertTrue(rickName.exists)
    }
    
    func testSearchRick() {
        app.launch()
        
        app.collectionViews.searchFields["Search character"].tap()
        app.collectionViews.searchFields["Search character"].typeText("Rick")
        app.buttons["Done"].tap()
        
        let rickName = app.collectionViews.staticTexts["Rick Sanchez"]
        XCTAssertTrue(rickName.exists)
    }
    
    func testSearchMorty() {
        app.launch()
        
        app.collectionViews.searchFields["Search character"].tap()
        app.collectionViews.searchFields["Search character"].typeText("Rick")
        app.buttons["Done"].tap()
        
        let mortyName = app.collectionViews.staticTexts["Morty Smith"]
        XCTAssertFalse(mortyName.exists)
    }
}
