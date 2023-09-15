//
//  allure.swift
//  TurboCalculatorUITests
//
//  Created by kirill on 15.09.2023.
//

import XCTest

public protocol Allure {}

extension XCTest: Allure {}

public extension Allure {
    func testOpsId(_ value: Int) {
        let stringValue = String(value)
        label(name: "ALLURE_ID", values: stringValue)
    }

    func testOpsId(_ value: String) {
        label(name: "ALLURE_ID", values: value)
    }

    func feature(_ value: String) {
        label(name: "feature", values: value)
    }

    func suite(_ level: Int32, _ value: String) {
        var name: String
        name = "suite" + String(level)
        label(name: name, values: value)
    }

    func label(name: String, values: [String]) {
        for value in values {
            XCTContext.runActivity(named: "allure.label." + name + ":" + value, block: { _ in })
        }
    }

    func label(name: String, values: String) {
        XCTContext.runActivity(named: "allure.label." + name + ":" + values, block: { _ in })
    }

    func step(_ name: String, step: () -> Void) {
        XCTContext.runActivity(named: name) { _ in
            step()
        }
    }

    // tearDown()
    func testName(_ value: String) {
        label(name: "test_name", values: value)
    }
    
}
