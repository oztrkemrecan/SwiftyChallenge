//
//  PopularUITests.swift
//  PopularUITests
//
//  Created by Zodiac on 30.04.2018.
//  Copyright © 2018 senfonico. All rights reserved.
//

import XCTest

class PopularUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        app.scrollViews.children(matching: .image).element.swipeUp()
        app.buttons["Close"].tap()
        collectionViewsQuery.children(matching: .other).element.swipeUp()
        

    }
    
}
