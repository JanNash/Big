import XCTest
@testable import Big

final class BigTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Big().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
