import XCTest
@testable import Segnify

final class SegnifyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Segnify().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
