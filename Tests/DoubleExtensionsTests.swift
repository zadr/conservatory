@testable import Conservatory

import XCTest

class DoubleExtensionsTests: XCTestCase {
	func testRoundingDown() {
		XCTAssertEqual(5.0.roundedDown, 5)
		XCTAssertEqual(5.1.roundedDown, 5)
		XCTAssertEqual(5.6.roundedDown, 5)
	}

	func testAbsoluteValue() {
		XCTAssertEqual(5.0.absoluteValue, 5.0)
		XCTAssertEqual(-5.0.absoluteValue, 5.0)
		XCTAssertEqual(0.0.absoluteValue, 0.0)
		XCTAssertEqual(-0.0.absoluteValue, 0.0)
	}
}
