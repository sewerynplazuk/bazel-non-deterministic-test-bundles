@testable import NonDeterministicBundles
import XCTest
// I believe imports do not matter that much but they seem to increase
// chances to get non-deterministic test bundles.
// The file cannot be empty though.

final class FooTests {
    func testSomething() {
        XCTAssertEqual("42", "42")
    }
}
