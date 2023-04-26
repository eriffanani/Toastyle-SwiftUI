import XCTest
@testable import Toastyle

final class ToastyleTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Toastyle(state: .info, show: .constant(true)).text, "Hello, World!")
    }
}
