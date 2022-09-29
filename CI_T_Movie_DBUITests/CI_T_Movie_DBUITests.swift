//
//  CI_T_Movie_DBUITests.swift
//  CI_T_Movie_DBUITests
//
//  Created by Ramon Queiroz dos Santos on 02/09/22.
//

import XCTest

class CI_T_Movie_DatabaseUITests: XCTestCase {
	var app: XCUIApplication!

	 override func setUpWithError() throws {
		  // Put setup code here. This method is called before the invocation of each test method in the class.
		 app = .init()
		 app.launch()
		  // In UI tests it is usually best to stop immediately when a failure occurs.
		  continueAfterFailure = false

		  // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
	 }

	 func testExample() throws {
		  // UI tests must launch the application that they test.
		  let app = XCUIApplication()

		 app/*@START_MENU_TOKEN@*/.buttons["Coming Soon"]/*[[".segmentedControls.buttons[\"Coming Soon\"]",".buttons[\"Coming Soon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		 app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Dragon Ball Super: Super Hero").element.tap()
		 
		 let scrollViewsQuery = app.scrollViews
		 scrollViewsQuery.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Show More"]/*[[".buttons[\"Show More\"].staticTexts[\"Show More\"]",".staticTexts[\"Show More\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		 
		 let elementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"ドラゴンボール超 スーパーヒーロー")
		 elementsQuery.children(matching: .button).matching(identifier: "View All").element(boundBy: 0).staticTexts["View All"].tap()
		 app.navigationBars["Cast & Crew"].buttons["Item"].tap()
		 elementsQuery.children(matching: .button).matching(identifier: "View All").element(boundBy: 1).staticTexts["View All"].tap()
		 app.navigationBars["Photos"].buttons["Item"].tap()
		  // Use XCTAssert and related functions to verify your tests produce the correct results.
	 }
}

