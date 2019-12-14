//
//  CharacterListUITest.swift
//  RickAndMortyUITests
//
//  Created by Ricardo Ruiz on 14/12/2019.
//  Copyright © 2019 Ricardo Ruiz. All rights reserved.
//

import XCTest

class CharacterDetailsUITest: XCTestCase {
    
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
    
    func testMortyName() {
        app.launch()
        
        XCUIApplication().collectionViews.staticTexts["Morty Smith"].tap()
        
        let mortyName = app.staticTexts["Morty Smith"]
        XCTAssertTrue(mortyName.exists)
    }
    
    func testRickIsAlive() {
        app.launch()
        
        XCUIApplication().collectionViews.staticTexts["Rick Sanchez"].tap()
        
        let rickAlive = app.staticTexts["Alive"]
        XCTAssertTrue(rickAlive.exists)
    }
    
    func testSummerIsFemale() {
        app.launch()
        
        XCUIApplication().collectionViews.staticTexts["Summer Smith"].tap()
        
        let summerFemale = app.staticTexts["Female"]
        XCTAssertTrue(summerFemale.exists)
    }
}
