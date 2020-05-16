import XCTest
@testable import BBAlert

final class BBAlertTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BBAlert().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
