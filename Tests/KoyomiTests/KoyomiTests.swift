import XCTest
@testable import Koyomi

final class KoyomiTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Koyomi().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
