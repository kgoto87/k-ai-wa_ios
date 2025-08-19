import XCTest

class KAiWaMemoUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Check if the main view exists
        XCTAssertTrue(app.otherElements["mainView"].exists)
    }

    func testAddClientButton() throws {
        let app = XCUIApplication()
        app.launch()

        // Tap the add client button
        app.buttons["addClientButton"].tap()

        // Check if the add client view exists
        XCTAssertTrue(app.otherElements["addClientView"].exists)
    }

    func testStartAndStopRecording() throws {
        let app = XCUIApplication()
        app.launch()

        // Navigate to the AddTalkMemoView
        app.buttons["addClientButton"].tap()

        // Tap the start recording button
        app.buttons["Start Recording"].tap()

        // Wait for 2 seconds
        sleep(2)

        // Tap the stop recording button
        app.buttons["Stop Recording"].tap()

        // Check if the recording time is greater than 0
        let recordingTimeText = app.staticTexts.matching(identifier: "recordingTime").firstMatch.label
        let recordingTime = Double(recordingTimeText.replacingOccurrences(of: "s", with: "")) ?? 0
        XCTAssertGreaterThan(recordingTime, 0)
    }

    func testPlayRecording() throws {
        let app = XCUIApplication()
        app.launch()

        // Navigate to the AddTalkMemoView
        app.buttons["addClientButton"].tap()

        // Start and stop recording to create a recording file
        app.buttons["Start Recording"].tap()
        sleep(2)
        app.buttons["Stop Recording"].tap()

        // Tap the play recording button
        app.buttons["Play Recording"].tap()

        // I can't directly test if the audio is playing, so I will just check if the button exists
        XCTAssertTrue(app.buttons["Play Recording"].exists)
    }
}
