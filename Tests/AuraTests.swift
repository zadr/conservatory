@testable import Conservatory

import XCTest

class AuraTests: XCTestCase {
	func testEquality() {
		XCTAssertEqual(Aura.darkShadow, Aura.darkShadow)
		XCTAssertNotEqual(Aura.darkShadow, Aura.lightGlow)
	}

	func testUsageConfirmation() {
		XCTAssertTrue(Aura.darkShadow.shouldApplyAura)
		XCTAssertFalse(Aura().shouldApplyAura)
	}
}
