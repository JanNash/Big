import XCTest
@testable import Big


final class BigTests: XCTestCase {
    func testNumberDigitValueSet() {
        do {
            let _: Number.Digit.ValueSet = try .init(["a", "b", "c"])
        } catch {
            XCTFail("Init failed with error \(error)")
        }
    }

    static var allTests = [
        ("testNumberDigitValueSet", testNumberDigitValueSet),
    ]
}
