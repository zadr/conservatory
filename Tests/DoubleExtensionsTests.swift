@testable import Conservatory

import XCTest

class DoubleExtensionsTests: XCTestCase {
	func testConstraining() {
		XCTAssertEqual((0 ..< 5).constraining(4), 4)
		XCTAssertEqual((0 ..< 5).constraining(-1), 0)
		XCTAssertEqual((0 ..< 5).constraining(6), 5)
	}

	func testRandom() {
		XCTAssertNotEqual(Double.random(), Double.random())
	}
}
