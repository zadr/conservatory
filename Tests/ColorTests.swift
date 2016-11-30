@testable import Conservatory

import XCTest

class ColorTests: XCTestCase {
	func testEquality() {
		XCTAssertEqual(Color.red, Color.red)
		XCTAssertNotEqual(Color.red, Color.blue)

		XCTAssertTrue(Color.blue > Color.red)
		XCTAssertFalse(Color.red > Color.blue)

		XCTAssertTrue(Color(h: 280.0, s: 1.0, b: 1.0, a: 1.0) > Color(h: 280.0, s: 0.0, b: 1.0, a: 1.0))
		XCTAssertTrue(Color(h: 280.0, s: 1.0, b: 1.0, a: 1.0) > Color(h: 280.0, s: 1.0, b: 0.0, a: 1.0))
		XCTAssertTrue(Color(h: 280.0, s: 1.0, b: 1.0, a: 1.0) > Color(h: 280.0, s: 1.0, b: 1.0, a: 0.0))
	}

	func testArithmetic() {
		XCTAssertEqual(Color.red + Color.blue, Color.purple)
		XCTAssertEqual(Color.purple - Color.blue, Color.red)
		XCTAssertEqual(Color.purple - Color.blue, Color.red)
	}
}

class ColorCompanionTests: XCTestCase {
	public func testSaturation() {
		XCTAssertTrue(Color.lavender.saturate() > Color.lavender)
		XCTAssertTrue(Color.lavender > Color.lavender.desaturate())
		XCTAssertEqual(Color.red, Color.red.saturate()) // Red can't be saturated anymore than it already is
		XCTAssertEqual(Color.white, Color.white.desaturate()) // White can't be desaturated anymore than it already is
	}

	public func testDarken() {
		XCTAssertTrue(Color.lavender.lighten() < Color.lavender)
		XCTAssertTrue(Color.lavender > Color.lavender.darken())
		XCTAssertEqual(Color.red, Color.red.lighten()) // Red can't be lightened anymore than it already is
		XCTAssertEqual(Color.black, Color.black.darken()) // Black can't be darkened anymore than it already is
	}

	public func testAnalog() {
		XCTAssertNotEqual(Color.mediumPurple, Color.mediumPurple.analog())
		XCTAssertNotEqual(Color.red, Color.red.analog(delta: 0.1))
	}

	public func testDrift() {
		XCTAssertNotEqual(Color.mediumPurple, Color.mediumPurple.drift())
	}

	public func testComplement() {
		XCTAssertEqual(Color.red.complement, Color(h: 138.0, s: 1.0, b: 1.0, a: 1.0))
	}

	public func testComplementary() { /* todo */ }

	public func testSplitComplementary() {
		let colors = Color.red.splitComplementary()
		XCTAssertEqual(colors[0], Color.red)
		XCTAssertEqual(colors[1], Color(h: 103.00000000000001, s: 1.0, b: 1.0, a: 1.0))
		XCTAssertEqual(colors[2], Color(h: 171.0, s: 1.0, b: 1.0, a: 1.0))
	}

	public func testLeftComplementary() { /* todo */ }

	public func testRightComplementary() { /* todo */ }

	public func testAnalogous() { /* todo */ }

	public func testMonochrome() { /* todo */ }

	public func testTriad() { /* todo */ }

	public func testTetrad() { /* todo */ }

	public func testCompound() { /* todo */ }

	public func testRotateRGB() { /* todo */ }
	
	public func testInverse() {
		XCTAssertEqual(Color.red.inverse, Color.red.inverse.inverse.inverse)
	}
}

class ColorCreationTests: XCTestCase {
	func testHex() {
		XCTAssertEqual(Color(hexString: "#FF0000"), Color.red)
		XCTAssertEqual(Color(hexString: "FF0000FF"), Color.red)
		XCTAssertEqual(Color(hexRGB: 0xFF0000), Color.red)
		XCTAssertEqual(Color(hexRGBA: 0xFF0000FF), Color.red)
	}

	func testRandom() {
		XCTAssertNotEqual(Color.random(), Color.random())
	}
}

class ColorRelationTests: XCTestCase {
	func testInterpolation() {
		XCTAssertEqual(Color.black.interpolate(Color.white, step: 0.5), Color.gray)
		XCTAssertEqual(Color.white.interpolate(Color.black, step: 0.5), Color.gray)
		XCTAssertEqual(Color.black.interpolate(Color.black, step: 0.5), Color.black)
		XCTAssertEqual(Color.white.interpolate(Color.white, step: 0.5), Color.white)
	}
}

class ColorViewTests: XCTestCase {
	func testRGB() {
		let redRGB = Color.red.RGBView
		XCTAssertTrue(redRGB.red ~= 1.0)
		XCTAssertTrue(redRGB.green ~= 0.0)
		XCTAssertTrue(redRGB.blue ~= 0.0)

		let orangeRGB = Color.orange.RGBView
		XCTAssertTrue(orangeRGB.red ~= 1.0)
		XCTAssertTrue(orangeRGB.green ~= 0.5)
		XCTAssertTrue(orangeRGB.blue ~= 0.0)

		let yellowRGB = Color.yellow.RGBView
		XCTAssertTrue(yellowRGB.red ~= 1.0)
		XCTAssertTrue(yellowRGB.green ~= 1.0)
		XCTAssertTrue(yellowRGB.blue ~= 0.0)

		let greenRGB = Color.green.RGBView
		XCTAssertTrue(greenRGB.red ~= 0.0)
		XCTAssertTrue(greenRGB.green ~= 1.0)
		XCTAssertTrue(greenRGB.blue ~= 0.0)

		let blueRGB = Color.blue.RGBView
		XCTAssertTrue(blueRGB.red ~= 0.0)
		XCTAssertTrue(blueRGB.green ~= 0.0)
		XCTAssertTrue(blueRGB.blue ~= 1.0)

		let magentaRGB = Color.magenta.RGBView
		XCTAssertTrue(magentaRGB.red ~= 1.0)
		XCTAssertTrue(magentaRGB.green ~= 0.0)
		XCTAssertTrue(magentaRGB.blue ~= 1.0)

		let whiteRGB = Color.white.RGBView
		XCTAssertTrue(whiteRGB.red ~= 1.0)
		XCTAssertTrue(whiteRGB.green ~= 1.0)
		XCTAssertTrue(whiteRGB.blue ~= 1.0)

		let brownRGB = Color.brown.RGBView
		XCTAssertTrue(brownRGB.red ~= 0.6)
		XCTAssertTrue(brownRGB.green ~= 0.4)
		XCTAssertTrue(brownRGB.blue ~= 0.2)

		let blackRGB = Color.black.RGBView
		XCTAssertTrue(blackRGB.red ~= 0.0)
		XCTAssertTrue(blackRGB.green ~= 0.0)
		XCTAssertTrue(blackRGB.blue ~= 0.0)
	}

	func testHSB() {
		let redHSB = Color.red.HSBView
		XCTAssertTrue(redHSB.hue ~= 0.0)
		XCTAssertTrue(redHSB.saturation ~= 1.0)
		XCTAssertTrue(redHSB.brightness ~= 1.0)

		let orangeHSB = Color.orange.HSBView
		XCTAssertTrue(orangeHSB.hue ~= 30.0)
		XCTAssertTrue(orangeHSB.saturation ~= 1.0)
		XCTAssertTrue(orangeHSB.brightness ~= 1.0)

		let yellowHSB = Color.yellow.HSBView
		XCTAssertTrue(yellowHSB.hue ~= 60.0)
		XCTAssertTrue(yellowHSB.saturation ~= 1.0)
		XCTAssertTrue(yellowHSB.brightness ~= 1.0)

		let greenHSB = Color.green.HSBView
		XCTAssertTrue(greenHSB.hue ~= 120.0)
		XCTAssertTrue(greenHSB.saturation ~= 1.0)
		XCTAssertTrue(greenHSB.brightness ~= 1.0)

		let blueHSB = Color.blue.HSBView
		XCTAssertTrue(blueHSB.hue ~= 240.0)
		XCTAssertTrue(blueHSB.saturation ~= 1.0)
		XCTAssertTrue(blueHSB.brightness ~= 1.0)

		let magentaHSB = Color.magenta.HSBView
		XCTAssertTrue(magentaHSB.hue ~= 300.0)
		XCTAssertTrue(magentaHSB.saturation ~= 1.0)
		XCTAssertTrue(magentaHSB.brightness ~= 1.0)

		let whiteHSB = Color.white.HSBView
		XCTAssertTrue(whiteHSB.hue ~= 0.0)
		XCTAssertTrue(whiteHSB.saturation ~= 0.0)
		XCTAssertTrue(whiteHSB.brightness ~= 1.0)

		let brownHSB = Color.brown.HSBView
		XCTAssertTrue(brownHSB.hue ~= 30.0)
		XCTAssertTrue(brownHSB.saturation ~= (2.0 / 3.0))
		XCTAssertTrue(brownHSB.brightness ~= 0.6)

		let blackHSB = Color.black.HSBView
		XCTAssertTrue(blackHSB.hue ~= 0.0)
		XCTAssertTrue(blackHSB.saturation ~= 0.0)
		XCTAssertTrue(blackHSB.brightness ~= 0.0)
	}

	func testHSL() {
		let redHSL = Color.red.HSLView!
		XCTAssertTrue(redHSL.hue ~= 0.0)
		XCTAssertTrue(redHSL.saturation ~= 1.0)
		XCTAssertTrue(redHSL.luminosity ~= 0.5)

		let orangeHSL = Color.orange.HSLView!
		XCTAssertTrue(orangeHSL.hue ~= 30.0)
		XCTAssertTrue(orangeHSL.saturation ~= 1.0)
		XCTAssertTrue(orangeHSL.luminosity ~= 0.5)

		let yellowHSL = Color.yellow.HSLView!
		XCTAssertTrue(yellowHSL.hue ~= 60.0)
		XCTAssertTrue(yellowHSL.saturation ~= 1.0)
		XCTAssertTrue(yellowHSL.luminosity ~= 0.5)

		let greenHSL = Color.green.HSLView!
		XCTAssertTrue(greenHSL.hue ~= 120.0)
		XCTAssertTrue(greenHSL.saturation ~= 1.0)
		XCTAssertTrue(greenHSL.luminosity ~= 0.5)

		let blueHSL = Color.blue.HSLView!
		XCTAssertTrue(blueHSL.hue ~= 240.0)
		XCTAssertTrue(blueHSL.saturation ~= 1.0)
		XCTAssertTrue(blueHSL.luminosity ~= 0.5)

		let magentaHSL = Color.magenta.HSLView!
		XCTAssertTrue(magentaHSL.hue ~= 300.0)
		XCTAssertTrue(magentaHSL.saturation ~= 1.0)
		XCTAssertTrue(magentaHSL.luminosity ~= 0.5)

		let whiteHSL = Color.white.HSLView!
		XCTAssertTrue(whiteHSL.hue ~= 0.0)
		XCTAssertTrue(whiteHSL.saturation ~= 0.0)
		XCTAssertTrue(whiteHSL.luminosity ~= 1.0)

		let brownHSL = Color.brown.HSLView!
		XCTAssertTrue(brownHSL.hue ~= 30.0)
		XCTAssertTrue(brownHSL.saturation ~= 0.5)
		XCTAssertTrue(brownHSL.luminosity ~= 0.4)

		let blackHSL = Color.black.HSLView!
		XCTAssertTrue(blackHSL.hue ~= 0.0)
		XCTAssertTrue(blackHSL.saturation ~= 0.0)
		XCTAssertTrue(blackHSL.luminosity ~= 0.0)
	}

	func testCMYK() {
		let redCMYK = Color.red.CMYKView;
		XCTAssertTrue(redCMYK.cyan ~= 0.0)
		XCTAssertTrue(redCMYK.magenta ~= 1.0)
		XCTAssertTrue(redCMYK.yellow ~= 1.0)
		XCTAssertTrue(redCMYK.key ~= 0.0)

		let orangeCMYK = Color.orange.CMYKView
		XCTAssertTrue(orangeCMYK.cyan ~= 0.0)
		XCTAssertTrue(orangeCMYK.magenta ~= 0.5)
		XCTAssertTrue(orangeCMYK.yellow ~= 1.0)
		XCTAssertTrue(orangeCMYK.key ~= 0.0)

		let yellowCMYK = Color.yellow.CMYKView
		XCTAssertTrue(yellowCMYK.cyan ~= 0.0)
		XCTAssertTrue(yellowCMYK.magenta ~= 0.0)
		XCTAssertTrue(yellowCMYK.yellow ~= 1.0)
		XCTAssertTrue(yellowCMYK.key ~= 0.0)

		let greenCMYK = Color.green.CMYKView
		XCTAssertTrue(greenCMYK.cyan ~= 1.0)
		XCTAssertTrue(greenCMYK.magenta ~= 0.0)
		XCTAssertTrue(greenCMYK.yellow ~= 1.0)
		XCTAssertTrue(greenCMYK.key ~= 0.0)

		let blueCMYK = Color.blue.CMYKView
		XCTAssertTrue(blueCMYK.cyan ~= 1.0)
		XCTAssertTrue(blueCMYK.magenta ~= 1.0)
		XCTAssertTrue(blueCMYK.yellow ~= 0.0)
		XCTAssertTrue(blueCMYK.key ~= 0.0)

		let magentaCMYK = Color.magenta.CMYKView
		XCTAssertTrue(magentaCMYK.cyan ~= 0.0)
		XCTAssertTrue(magentaCMYK.magenta ~= 1.0)
		XCTAssertTrue(magentaCMYK.yellow ~= 0.0)
		XCTAssertTrue(magentaCMYK.key ~= 0.0)

		let whiteCMYK = Color.white.CMYKView
		XCTAssertTrue(whiteCMYK.cyan ~= 0.0)
		XCTAssertTrue(whiteCMYK.magenta ~= 0.0)
		XCTAssertTrue(whiteCMYK.yellow ~= 0.0)
		XCTAssertTrue(whiteCMYK.key ~= 0.0)

		let brownCMYK = Color.brown.CMYKView
		XCTAssertTrue(brownCMYK.cyan ~= 0.0)
		XCTAssertTrue(brownCMYK.magenta ~= (1.0 / 3.0))
		XCTAssertTrue(brownCMYK.yellow ~= (2.0 / 3.0))
		XCTAssertTrue(brownCMYK.key ~= 0.4)

		let blackCMYK = Color.black.CMYKView
		XCTAssertTrue(blackCMYK.cyan ~= 0.0)
		XCTAssertTrue(blackCMYK.magenta ~= 0.0)
		XCTAssertTrue(blackCMYK.yellow ~= 0.0)
		XCTAssertTrue(blackCMYK.key ~= 1.0)
	}

	func testYuv() {
		let redYuv = Color.red.YUVView;
		XCTAssertTrue(redYuv.luminance ~= 0.298)
		XCTAssertTrue(redYuv.chrominance.u ~= 0.333)
		XCTAssertTrue(redYuv.chrominance.v ~= 1.0)

		let orangeYuv = Color.orange.YUVView
		XCTAssertTrue(orangeYuv.luminance ~= 0.592)
		XCTAssertTrue(orangeYuv.chrominance.u ~= 0.167)
		XCTAssertTrue(orangeYuv.chrominance.v ~= 0.792)

		let yellowYuv = Color.yellow.YUVView
		XCTAssertTrue(yellowYuv.luminance ~= 0.886)
		XCTAssertTrue(yellowYuv.chrominance.u ~= 0.062)
		XCTAssertTrue(yellowYuv.chrominance.v ~= 0.583)

		let greenYuv = Color.green.YUVView
		XCTAssertTrue(greenYuv.luminance ~= 0.587)
		XCTAssertTrue(greenYuv.chrominance.u ~= 0.17)
		XCTAssertTrue(greenYuv.chrominance.v ~= 0.083)

		let blueYuv = Color.blue.YUVView
		XCTAssertTrue(blueYuv.luminance ~= 0.114)
		XCTAssertTrue(blueYuv.chrominance.u ~= 1.0)
		XCTAssertTrue(blueYuv.chrominance.v ~= 0.421)

		let magentaYuv = Color.magenta.YUVView
		XCTAssertTrue(magentaYuv.luminance ~= 0.412)
		XCTAssertTrue(magentaYuv.chrominance.u ~= 0.833)
		XCTAssertTrue(magentaYuv.chrominance.v ~= 0.920)

		let whiteYuv = Color.white.YUVView
		XCTAssertTrue(whiteYuv.luminance ~= 1.0)
		XCTAssertTrue(whiteYuv.chrominance.u ~= 0.502)
		XCTAssertTrue(whiteYuv.chrominance.v ~= 0.502)

		let brownYuv = Color.brown.YUVView
		XCTAssertTrue(brownYuv.luminance ~= 0.437)
		XCTAssertTrue(brownYuv.chrominance.u ~= 0.368)
		XCTAssertTrue(brownYuv.chrominance.v ~= 0.618)

		let blackYuv = Color.black.YUVView
		XCTAssertTrue(blackYuv.luminance ~= 0.0)
		XCTAssertTrue(blackYuv.chrominance.u ~= 0.502)
		XCTAssertTrue(blackYuv.chrominance.v ~= 0.502)
	}

	func testXYZ() {
		let redXYZ = Color.red.XYZView;
        XCTAssertTrue(redXYZ.x ~= 41.24)
        XCTAssertTrue(redXYZ.y ~= 21.26)
        XCTAssertTrue(redXYZ.z ~= 1.93)

		let orangeXYZ = Color.orange.XYZView
        XCTAssertTrue(orangeXYZ.x ~= 48.894)
        XCTAssertTrue(orangeXYZ.y ~= 36.568)
        XCTAssertTrue(orangeXYZ.z ~= 4.4813)

		let yellowXYZ = Color.yellow.XYZView
        XCTAssertTrue(yellowXYZ.x ~= 77.0)
        XCTAssertTrue(yellowXYZ.y ~= 92.78)
        XCTAssertTrue(yellowXYZ.z ~= 13.85)

		let greenXYZ = Color.green.XYZView
        XCTAssertTrue(greenXYZ.x ~= 35.76)
        XCTAssertTrue(greenXYZ.y ~= 71.52)
        XCTAssertTrue(greenXYZ.z ~= 11.92)

        let blueXYZ = Color.blue.XYZView
        XCTAssertTrue(blueXYZ.x ~= 18.05)
        XCTAssertTrue(blueXYZ.y ~= 7.22)
        XCTAssertTrue(blueXYZ.z ~= 95.05)

		let magentaXYZ = Color.magenta.XYZView
        XCTAssertTrue(magentaXYZ.x ~= 59.29)
        XCTAssertTrue(magentaXYZ.y ~= 28.48)
        XCTAssertTrue(magentaXYZ.z ~= 96.98)

		let whiteXYZ = Color.white.XYZView
        XCTAssertTrue(whiteXYZ.x ~= 95.05)
        XCTAssertTrue(whiteXYZ.y ~= 100.0)
        XCTAssertTrue(whiteXYZ.z ~= 108.9)

		let brownXYZ = Color.brown.XYZView
        XCTAssertTrue(brownXYZ.x ~= 18.485)
        XCTAssertTrue(brownXYZ.y ~= 16.514)
        XCTAssertTrue(brownXYZ.z ~= 5.3451)

		let blackXYZ = Color.black.XYZView
        XCTAssertTrue(blackXYZ.x ~= 0.0)
        XCTAssertTrue(blackXYZ.y ~= 0.0)
        XCTAssertTrue(blackXYZ.z ~= 0.0)
	}

	func testLab() {
		let redLab = Color.red.LabView;
		XCTAssertTrue(redLab.L ~= 53.232)
		XCTAssertTrue(redLab.a ~= 80.109)
		XCTAssertTrue(redLab.b ~= 67.22)

		let orangeLab = Color.orange.LabView
		XCTAssertTrue(orangeLab.L ~= 66.952)
		XCTAssertTrue(orangeLab.a ~= 43.078)
		XCTAssertTrue(orangeLab.b ~= 73.968)

		let yellowLab = Color.yellow.LabView
		XCTAssertTrue(yellowLab.L ~= 97.138)
		XCTAssertTrue(yellowLab.a ~= -21.556)
		XCTAssertTrue(yellowLab.b ~= 94.483)

		let greenLab = Color.green.LabView
		XCTAssertTrue(greenLab.L ~= 87.737)
		XCTAssertTrue(greenLab.a ~= -86.185)
		XCTAssertTrue(greenLab.b ~= 83.181)

		let blueLab = Color.blue.LabView
		XCTAssertTrue(blueLab.L ~= 32.303)
		XCTAssertTrue(blueLab.a ~= 79.197)
		XCTAssertTrue(blueLab.b ~= -107.864)

		let magentaLab = Color.magenta.LabView
		XCTAssertTrue(magentaLab.L ~= 60.32)
		XCTAssertTrue(magentaLab.a ~= 98.254)
		XCTAssertTrue(magentaLab.b ~= -60.843)

		let whiteLab = Color.white.LabView
		XCTAssertTrue(whiteLab.L ~= 100.0)
		XCTAssertTrue(whiteLab.a ~= 0.005)
		XCTAssertTrue(whiteLab.b ~= -0.010)

		let brownLab = Color.brown.LabView
		XCTAssertTrue(brownLab.L ~= 47.642)
		XCTAssertTrue(brownLab.a ~= 15.374)
		XCTAssertTrue(brownLab.b ~= 36.496)

		let blackLab = Color.black.LabView
		XCTAssertTrue(blackLab.L ~= 0.0)
		XCTAssertTrue(blackLab.a ~= 0.0)
		XCTAssertTrue(blackLab.b ~= 0.0)
	}
}
