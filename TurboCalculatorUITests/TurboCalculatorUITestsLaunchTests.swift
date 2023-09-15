//
//  TurboCalculatorUITestsLaunchTests.swift
//  TurboCalculatorUITests
//
//  Created by kirill on 08.09.2023.
//

import XCTest

final class TurboCalculatorUITestsLaunchTests: XCTestCase {

    let app = XCUIApplication()

      override func setUpWithError() throws {
          continueAfterFailure = false
      }
      
      func attachScreenshotToReport() {
          XCTContext.runActivity(named: "Attach Screenshot to Report") { activity in
              activity.add(takeFullScreenshot())
          }
      }
      
      func takeFullScreenshot() -> XCTAttachment {
          let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
          attachment.lifetime = .keepAlways
          return attachment
      }

      func testApp() throws {
          app.launch()

          let attachment = XCTAttachment(screenshot: app.screenshot())
          attachment.name = "Launch Screen"
          attachment.lifetime = .keepAlways
          add(attachment)
          
          app.buttons["AC"].tap()
          
      }
      
      func testActivites() throws {

          XCTContext.runActivity(named: "Launch App") { activity in
              app.launch()
          }
          
          XCTContext.runActivity(named: "Launch App") { activity in
              app.buttons["AC"].tap()
          }
          
      }
      
      func testFail() throws {
          app.launch()
          XCTFail("Failure from test")
      }
      
      func testExampleTestops() throws {
          testOpsId(1)
          
          step("Запуск приложения") {
              app.launch()
          }

      }
}
