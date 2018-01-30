//
//  Le_PlannerUITests.swift
//  Le PlannerUITests
//
//  Created by Abubakar Khan on 24/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import XCTest

class Le_PlannerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    
    
    func testDeleteEvent() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        app.tables["Empty list"].swipeDown()
        app.tabBars.buttons["Events"].tap()
        
        let tablesQuery = app.tables
        let meetupWithTheTeamMemberToDiscuessTheFutureApproachStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Meetup with the team member to discuess the future approach"]/*[[".cells.staticTexts[\"Meetup with the team member to discuess the future approach\"]",".staticTexts[\"Meetup with the team member to discuess the future approach\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        meetupWithTheTeamMemberToDiscuessTheFutureApproachStaticText.swipeDown()
        meetupWithTheTeamMemberToDiscuessTheFutureApproachStaticText.swipeLeft()
        tablesQuery.buttons["Delete"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Meeting John for coffe"]/*[[".cells.staticTexts[\"Meeting John for coffe\"]",".staticTexts[\"Meeting John for coffe\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        
        
        // Use check to see if event was deleted
        XCTAssert(tablesQuery.cells.count == 5)
    }
    
    func testDeleteNote() {
        
        let app = XCUIApplication()
        app.tabBars.buttons["Notes"].tap()
        
        let tablesQuery = app.tables
        let noteEntry = tablesQuery.staticTexts["Pick up egss,milk and break."]
        noteEntry.swipeLeft()
        tablesQuery.buttons["Delete"].tap()
        
        // Use check to see if note was deleted
        XCTAssert(tablesQuery.cells.count == 3)
       
    }
    
    func testAddNote(){
        
        let app = XCUIApplication()
        app.tabBars.buttons["Notes"].tap()
        app.navigationBars["Notes"].buttons["Add"].tap()
        
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("This is a test")
        
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .textView).element
        textView.tap()
        textView.typeText("This is a test description")
        app.navigationBars["Add Note"].buttons["Add"].tap()
        app.alerts["Note Added"].buttons["OK"].tap()
        
        let tablesQuery = app.tables
        let noteEntry = tablesQuery.staticTexts["This is a test description"]
        noteEntry.swipeLeft()
        
        
        // Use check to see if note was added
        XCTAssert(tablesQuery.cells.count == 5)
    }
    
    func testNavigation(){
        
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Notes"].tap()
        tabBarsQuery.buttons["Events"].tap()
        tabBarsQuery.buttons["Home"].tap()
        
        //Test to see if landed back on the home dashboard
        let app = XCUIApplication()
        XCTAssert(app.staticTexts["  Quote of the day"].isEnabled)
        
        
    }
    
    
    override func tearDown() {
        super.tearDown()
    }
}
