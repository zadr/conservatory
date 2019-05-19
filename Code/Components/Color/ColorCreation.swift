public extension Color {
	enum InitializationMistake: Error {
		case invalidHexString
	}

	/**
	A convenience initializer, to create a *Color* given integral red, green, blue and alpha values.

	- Parameter red: The red value of a color. This parameter has a default value of **255**.
	- Parameter green: The red value of a color. This parameter has a default value of **255**.
	- Parameter blue: The red value of a color. This parameter has a default value of **255**.
	- Parameter alpha: The red value of a color. This parameter has a default value of **255**.

	`init(red: 127)`, `init(red: 12, green: 24, blue: 48)`, and `init(red: 12, green: 24, blue: 48, alpha: 96)` are all valid.
	*/
	init(red _red: UInt8 = 255, green _green: UInt8 = 255, blue _blue: UInt8 = 255, alpha _alpha: UInt8 = 255) {
		let red = (Double(_red) / 255.0)
		let green = (Double(_green) / 255.0)
		let blue = (Double(_blue) / 255.0)
		let alpha = (Double(_alpha) / 255.0)

		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	/**
	A convenience initializer, to create a *Color* given HSB View.
	init(hue: 0.0 to 360.0, saturation: 0.0 to 1.0, brightness: 0.0 to 1.0, alpha: 0.0 to 1.0)

	The parameters specifying *hue*, *saturation*, and *brightness* are required, and do not have any default values.
	The parameter specifying the *alpha* has a default value of **1.0**.
	*/
	init(h _hue: Double, s _saturation: Double, b _brightness: Double, a _alpha: Double = 1.0) {
		var red = 0.0, green = 0.0, blue = 0.0

		let c = _brightness * _saturation
		let x = c * (1 - (((_hue / 60.0).truncatingRemainder(dividingBy: 2.0)) - 1).absoluteValue)
		let m = _brightness - c

		switch _hue {
		case 0.0 ..< 60.0:
			red = c; green = x; blue = 0.0
		case 60.0 ..< 120.0:
			red = x; green = c; blue = 0.0
		case 120.0 ..< 180.0:
			red = 0; green = c; blue = x
		case 180.0 ..< 240.0:
			red = 0; green = x; blue = c
		case 240.0 ..< 300.0:
			red = x; green = 0.0; blue = c
		case 300.0 ... 360.0:
			red = c; green = 0.0; blue = x
		default:
			precondition(false, "invalid hue \(_hue)")
		}

		self.init(red: red + m, green: green + m, blue: blue + m, alpha: _alpha)

	}

	/**
	A convenience initializer, to create a *Color* given CMYK View.
	init(cyan: 0.0 to 1.0, magenta: 0.0 to 1.0, yellow: 0.0 to 1.0, key (black): 0.0 to 1.0, alpha: 0.0 to 1.0)

	The parameters specifying *cyan*, *magenta*, *yellow*, and *key* are required, and do not have any default values.
	The parameter specifying the *alpha* has a default value of **1.0**.
	*/
	init(c cyan: Double, m magenta: Double, y yellow: Double, k _key: Double, alpha: Double = 1.0) {
		let key = _key

		let red = (1.0 - cyan) * (1.0 - key)
		let green = (1.0 - magenta) * (1.0 - key)
		let blue = (1.0 - yellow) * (1.0 - key)

		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	/**
	A convenience initializer, to create a *Color* given YUV44 View.
	init(Y: 0.0 to 1.0, u: 0.0 to 1.0, v: 0.0 to 1.0, alpha: 0.0 to 1.0)

	The parameters specifying *Y*, *u*, and *v* are required, and do not have any default values.
	The parameter specifying the *alpha* has a default value of **1.0**.
	*/
	init(Y _luma: Double, u _u: Double, v _v: Double, alpha: Double = 1.0) {
		let luma = _luma
		let u = _u
		let v = _v

		let r = (luma + 1.139837398373983740 * v)
		let g = (luma - 0.3946517043589703515 * u - 0.5805986066674976801 * v)
		let b = (luma + 2.032110091743119266 * u)

		self.init(red: r, green: g, blue: b, alpha: alpha)
	}

	/**
	A convenience initializer, to create a *Color* given CIE-XYZ View.
	init(X: 0.0 to 1.0, Y: 0.0 to 1.0, Z: 0.0 to 1.0, alpha: 0.0 to 1.0)

	The parameters specifying *X*, *Y*, and *Z* are required, and do not have any default values.
	The parameter specifying the *alpha* has a default value of **1.0**.
	*/
	init(x _mix: Double, y _luminance: Double, z _blueStimulation: Double, alpha: Double = 1.0) {
		let Fxyz: (Double) -> (Double) = { (t: Double) in
			return t <= 0.0031308 ? 12.92 * t : (1 + 0.055) * (t ** (1.0 / 2.4)) - 0.055
		}

		let mix = _mix
		let luminance = _luminance
		let blueStimulation = _blueStimulation

		let red = Fxyz(mix * 3.2410 - luminance * 1.5374 - blueStimulation * 0.4986)
		let green = Fxyz(-mix * 0.9692 + luminance * 1.8760 - blueStimulation * 0.0416)
		let blue = Fxyz(mix * 0.0556 - luminance * 0.2040 + blueStimulation * 1.0570)

		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	/**
	A convenience initializer, to create a *Color* given CIE-XYZ View.
	init(X: 0.0 to 1.0, Y: 0.0 to 1.0, Z: 0.0 to 1.0, alpha: 0.0 to 1.0)

	The parameters specifying *L*, *a*, and *b* are required, and do not have any default values.
	The parameter specifying the *alpha* has a default value of **1.0**.
	*/
	init(L _lightness: Double, a _a: Double, b _b: Double, alpha: Double = 1.0) {
		let FLab: (Double, Double) -> Double = { (t: Double, tristimulus: Double) in
			let delta = 6.0 / 29.0
			return (t > delta) ? tristimulus * (t * t * t) : (t - 16.0 / 116.0) * 3.0 * (delta * delta) * tristimulus
		}

		let lightness = _lightness
		let a = _a
		let b = _b

		let fy = (lightness + 16) / 116.0
		let fx = fy + (a / 500.0)
		let fz = fy - (b / 200.0)

		let x = FLab(fx, CIE.D65.X.rawValue)
		let y = FLab(fy, CIE.D65.Y.rawValue)
		let z = FLab(fz, CIE.D65.Z.rawValue)

		self.init(x: x, y: y, z: z, alpha: alpha)
	}

	/**
	A convenience initializer, to create a *Color* given a hex string.
	
	If the string is #-prefixed, the prefix will be stripped out. If the resulting string is 6 characters long, it will be treated as an RGB string. If the resulting string is 8 characters long, it will be treated as an RGBA string.

	Any other length string will result in nil being returned.
	*/
	init(hexString hex: String) throws {
		let rgb: String
		if hex.hasPrefix("#") {
			rgb = String(hex[hex.index(hex.startIndex, offsetBy: 1) ... hex.endIndex])
		} else {
			rgb = hex
		}

		if let value = Int(rgb, radix: 16) , rgb.count == 8 {
			self.init(hexRGBA: value)
		} else if let value = Int(rgb, radix: 16) , rgb.count == 6 {
			self.init(hexRGB: value)
		} else {
			throw Color.InitializationMistake.invalidHexString
		}
	}

	/**
	A convenience initializer, to create a *Color* given a 32-bit integer.

	The 8 uppermost bits will be considered the *red* value, with the following two bits being the *green* value, and the next two bits being *blue* value.
	*/
	init(hexRGB hex: Int) {
		let r = UInt8((hex >> 16) & 0xFF)
		let g = UInt8((hex >> 8) & 0xFF)
		let b = UInt8(hex & 0xFF)

		self.init(red: r, green: g, blue: b)
	}

	/**
	A convenience initializer, to create a *Color* given a 32-bit integer.

	The 8 uppermost bits will be considered the *red* value, with the following two bits being the *green* value, and the next two bits being *blue* value. The last two bits will be considered the *alpha* value.
	*/
	init(hexRGBA hex: Int) {
		let r = UInt8((hex >> 24) & 0xFF)
		let g = UInt8((hex >> 16) & 0xFF)
		let b = UInt8((hex >> 8) & 0xFF)
		let a = UInt8(hex & 0xFF)

		self.init(red: r, green: g, blue: b, alpha: a)
	}

	/**
	Creates a color at random.

	- Returns: The return value is guaranteed to have an alpha of 1.0.
	*/
	static func random() -> Color {
		return Color(red: Double.random(in: 0.0 ..< 1.0), green: Double.random(in: 0.0 ..< 1.0), blue: Double.random(in: 0.0 ..< 1.0), alpha: 1.0)
	}
}

// MARK: - Modifying View

public extension Color {

	// MARK: - red

	/**
	- Returns: A new color with the *red* component replaced. Values below 0.0 will be treated as 0.0, and values above 1.0 will be treated as 1.0.
	*/
	func withRed(float r: Double = 1.0) -> Color {
		let color = RGBView
		return Color(red: r, green: color.green, blue: color.blue, alpha: AView)
	}

	/**
	- Returns: A new color with the *red* component replaced.
	*/
	func withRed(int red: UInt8 = 255) -> Color {
		let r = Double(red) / 255.0

		return withRed(float: r)
	}

	// MARK: - green

	/**
	- Returns: A new color with the *green* component replaced. Values below 0.0 will be treated as 0.0, and values above 1.0 will be treated as 1.0.
	*/
	func withGreen(float g: Double = 1.0) -> Color {
		let color = RGBView
		return Color(red: color.red, green: g, blue: color.blue, alpha: AView)
	}

	/**
	- Returns: A new color with the *green* component replaced.
	*/
	func withGreen(int green: UInt8 = 255) -> Color {
		let g = Double(green) / 255.0

		return withGreen(float: g)
	}

	// MARK: - blue

	/**
	- Returns: A new color with the *blue* component replaced. Values below 0.0 will be treated as 0.0, and values above 1.0 will be treated as 1.0.
	*/
	func withBlue(float b: Double = 1.0) -> Color {
		let color = RGBView
		return Color(red: color.red, green: color.green, blue: b, alpha: AView)
	}

	/**
	- Returns: A new color with the *blue* component replaced.
	*/
	func withBlue(int blue: UInt8 = 255) -> Color {
		let b = Double(blue) / 255.0

		return withBlue(float: b)
	}
}

// MARK: - HSB

public extension Color {

	// MARK: - hue

	/**
	- Returns: A new color with the *hue* component replaced.
	*/
	func withHue(float hue: Double = 1.0) -> Color {
		let View = HSBView

		return Color(h: hue, s: View.saturation, b: View.brightness, a: AView)
	}

	/**
	- Returns: A new color with the *hue* component replaced.
	*/
	func withHue(UInt8 hue: UInt8 = 255) -> Color {
		let h = Double(hue)

		return withHue(float: h)
	}

	// MARK: - saturation

	/**
	- Returns: A new color with the *saturation* component replaced.
	*/
	func withSaturation(float saturation: Double = 1.0) -> Color {
		let View = HSBView

		return Color(h: View.hue, s: saturation, b: View.brightness, a: AView)
	}

	/**
	- Returns: A new color with the *saturation* component replaced.
	*/
	func withSaturation(UInt8 saturation: UInt8 = 255) -> Color {
		let s = Double(saturation)

		return withSaturation(float: s)
	}

	// MARK: - brightness

	/**
	- Returns: A new color with the *brightness* component replaced.
	*/
	func withBrightness(float brightness: Double = 1.0) -> Color {
		let View = HSBView

		return Color(h: View.hue, s: View.saturation, b: brightness, a: AView)
	}

	/**
	- Returns: A new color with the *brightness* component replaced.
	*/
	func withBrightness(UInt8 hue: UInt8 = 255) -> Color {
		let b = Double(hue)

		return withBrightness(float: b)
	}
}

// MARK: - W

public extension Color {

	// MARK: - alpha

	func withWhite(float white: Double = 1.0) -> Color {
		return Color(red: white, green: white, blue: white, alpha: AView)
	}

	func withWhite(int white: UInt8 = 255) -> Color {
		let w = Double(white) / 255.0

		return withWhite(float: w)
	}
}

// MARK: - A

public extension Color {

	// MARK: - alpha

	/**
	- Returns: A new color with the *alpha* component replaced. Values below 0.0 will be treated as 0.0, and values above 1.0 will be treated as 1.0.
	*/
	func withAlpha(float alpha: Double = 1.0) -> Color {
		let View = RGBView

		return Color(red: View.red, green: View.green, blue: View.blue, alpha: alpha)
	}

	/**
	- Returns: A new color with the *alpha* component replaced.
	*/
	func withAlpha(int alpha: UInt8 = 255) -> Color {
		let a = Double(alpha) / 255.0
		
		return withAlpha(float: a)
	}
}
