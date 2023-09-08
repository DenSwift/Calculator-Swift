//
//  CalculatorUITests.swift
//  TurboCalculatorUITests
//
//  Created by kirill on 08.09.2023.
//

//  CalculatorUITests.swift
//  TurboCalculatorUITests
//
//  Created by kirill on 08.09.2023.
//

import XCTest

class CalculatorUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testAddition() {
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()

        let resultButton = app.buttons["ResultButton"]
        XCTAssertEqual(resultButton.staticTexts.element.label, "5")
    }

    func testSubtraction() {
        app.buttons["8"].tap()
        app.buttons["-"].tap()
        app.buttons["4"].tap()
        app.buttons["="].tap()

        let resultButton = app.buttons["ResultButton"]
        XCTAssertEqual(resultButton.staticTexts.element.label, "4")
    }

    func testMultiplication() {
        app.buttons["5"].tap()
        app.buttons["x"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()

        let resultButton = app.buttons["ResultButton"]
        XCTAssertEqual(resultButton.staticTexts.element.label, "30")
    }

    func testDivision() {
        app.buttons["9"].tap()
        app.buttons["÷"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()

        let resultButton = app.buttons["ResultButton"]
        XCTAssertEqual(resultButton.staticTexts.element.label, "3")
    }

    func testClear() {
        app.buttons["7"].tap()
        app.buttons["AC"].tap()

        let resultButton = app.buttons["ResultButton"]
        XCTAssertEqual(resultButton.staticTexts.element.label, "0")
    }

    func testDecimalPoint() {
        app.buttons["1"].tap()
        app.buttons["."].tap()
        app.buttons["4"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()

        let resultButton = app.buttons["ResultButton"]
        XCTAssertEqual(resultButton.staticTexts.element.label, "1.45")
    }

    func testPercentage() {
        app.buttons["7"].tap()
        app.buttons["%"].tap()
        app.buttons["="].tap()
        let resultButton = app.buttons["ResultButton"]
        XCTAssertEqual(resultButton.staticTexts.element.label, "0.07")
    }
}
