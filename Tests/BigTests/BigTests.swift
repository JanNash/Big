import XCTest
@testable import Big


final class BigTests: XCTestCase {
    func testValueSetInit() {
        do {
            let _ = try Number.Digit.ValueSet(["a", "b", "c"])
        } catch {
            XCTFail("Init failed with error '\(error)'")
        }
    }
    
    func testValueSetInitValues() {
        do {
            let representations = ["a", "b", "c"]
            let valueSet = try Number.Digit.ValueSet(representations)
            let expectedValues = representations.enumerated().map({
                Number.Digit.Value(representation: $0.element, offset: Number.Digit.Value.Offset($0.offset))
            })
            XCTAssertEqual(valueSet.values, expectedValues)
        } catch {
            XCTFail("Init failed with error '\(error)'")
        }
    }
    
    func testValueSetInitDuplicateError() {
        let duplicate = "a"
        do {
            let _ = try Number.Digit.ValueSet([duplicate, "b", duplicate])
        } catch {
            switch error {
            case Number.Digit.ValueSet.InitError.duplicateRepresentation(let value):
                XCTAssertEqual(value, duplicate)
            default:
                XCTFail("Expected init to fail with error '.duplicateRepresentation(\"a\")', failed with '\(error)' instead")
            }
        }
    }
    
    func testValueSetInitOffsetOverflowError() {
        typealias Offset = Number.Digit.Value.Offset
        do {
            var i = Offset.min
            var representations: [String] = ["foo"]
            representations.reserveCapacity(Int(Offset.max) + 1)
            while i < Offset.max {
                representations.append("\(i)")
                i += 1
            }
            let _ = try Number.Digit.ValueSet(representations)
        } catch {
            switch error {
            case Number.Digit.ValueSet.InitError.offsetOverflow:
                break
            default:
                XCTFail("Expected init to fail with error '.duplicateRepresentation(\"a\")', failed with '\(error)' instead")
            }
        }
    }

    static var allTests = [
        ("testValueSetInit", testValueSetInit),
        ("testValueSetInitValues", testValueSetInitValues),
        ("testValueSetInitDuplicateError", testValueSetInitDuplicateError),
        ("testValueSetInitOffsetOverflowError", testValueSetInitOffsetOverflowError),
    ]
}
