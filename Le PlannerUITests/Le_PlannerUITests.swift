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
    
    func testAddNote(){
        
        let app = XCUIApplication()
        app.tabBars.buttons["Notes"].tap()
        
        let rowsBeforeAdding = app.tables.cells.count
        
        app.navigationBars["Notes"].buttons["Add"].tap()
        
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("This is a test")
        
        
        let elementsQuery = app.scrollViews.otherElements
        let textView = elementsQuery.children(matching: .textView).element
        textView.tap()
        textView.typeText("This is a test description")
        app.navigationBars["Add Note"].buttons["Add"].tap()
        app.alerts["Note Added"].buttons["OK"].tap()
        
        let tablesQuery = app.tables
        let noteEntry = tablesQuery.staticTexts["This is a test description"]
        noteEntry.swipeLeft()
        
        
        // Use check to see if note was added
        XCTAssert(tablesQuery.cells.count == (rowsBeforeAdding + 1))
    }
    
    func testAddEvent() {
        
        
        let app = XCUIApplication()
        app.tabBars.buttons["Events"].tap()
        
        let rowsBeforeAdding = app.tables.cells.count
        
        app.navigationBars["Events"].buttons["Add"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let titleTextField = elementsQuery.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("Meeting")
        
        let descriptionTextField = elementsQuery.textFields["Description"]
        descriptionTextField.tap()
        descriptionTextField.typeText("Meeting John")
        
        let dateTextField = elementsQuery.textFields["Date"]
        dateTextField.tap()
        dateTextField.typeText("Today")
        
        let chooseEventTypeTextField = elementsQuery.textFields["Choose event type"]
        chooseEventTypeTextField.tap()
        chooseEventTypeTextField.typeText("Other")
        
        
        app.navigationBars["Add Event"].buttons["Add"].tap()
        app.alerts["Event Added"].buttons["OK"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.swipeDown()
        
        // Use check to see if event was added
        let rowsAfterAdding = app.tables.cells.count
        XCTAssert(rowsAfterAdding == (rowsBeforeAdding + 1))
    }
    
    
    func testDeleteEvent() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        
        app.tabBars.buttons["Events"].tap()
        
        let tablesQuery = app.tables
        if tablesQuery.cells.count == 0 {
            XCTAssert(true)
        } else {
            let rowsBeforeDeleting = tablesQuery.cells.count
            let cell = tablesQuery.cells.allElementsBoundByIndex[0]
            cell.swipeLeft()
            tablesQuery.buttons["Delete"].tap()
            
            // Use check to see if event was deleted
            XCTAssert(tablesQuery.cells.count == (rowsBeforeDeleting - 1))
        }
    }
    
    func testDeleteNote() {
        
        let app = XCUIApplication()
        app.tabBars.buttons["Notes"].tap()
        
        let tablesQuery = app.tables
        if tablesQuery.cells.count == 0 {
            XCTAssert(true)
        }
        else {
            let rowsBeforeDeleting = tablesQuery.cells.count
            let noteEntry = tablesQuery.cells.allElementsBoundByIndex[0]
            noteEntry.swipeLeft()
            tablesQuery.buttons["Delete"].tap()
            
            // Use check to see if note was deleted
            XCTAssert(tablesQuery.cells.count == (rowsBeforeDeleting - 1))
        }
        
    }
    
    
    
    func testNavigation(){
        
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Notes"].tap()
        tabBarsQuery.buttons["Events"].tap()
        tabBarsQuery.buttons["Home"].tap()
        
        //Test to see if landed back on the home dashboard
        let app = XCUIApplication()
        XCTAssert(app.staticTexts["Quote of the day"].isEnabled)
        
        
    }
    
    
    override func tearDown() {
        super.tearDown()
    }
}
