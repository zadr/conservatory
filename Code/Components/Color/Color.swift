/**
I've been told that I spell *color* funnily, and that it should really be spelled *colour*.
*/
public typealias Colour = Color

// todo: this should be a struct. make it a struct when arrays can be extended by struct types (swift 2.2? 3.0?) (related code lives in Internal/ArrayExtensions.swift)

// todo: Color's native type should be L*a*b, not RGB
/**
The native Color type in Cotton Duck. Can be created with, and in turn, output RGB, HSL, HSV, XYZ, Yuv, and Lab values.
*/
public final class Color {
	fileprivate let red: Double
	fileprivate let green: Double
	fileprivate let blue: Double
	fileprivate let alpha: Double

	/**
	Initialize a *Color* object by passing in *red*, *green*, *blue*, and *alpha* components.

	- Parameter red: A decimal value between 0.0 and 1.0 that controls the *red* channel. There is no default value.
	- Parameter green: A decimal value between 0.0 and 1.0 that controls the *green* channel. There is no default value.
	- Parameter blue: A decimal value between 0.0 and 1.0 that controls the *blue* channel. There is no default value.
	- Parameter alpha: A decimal value between 0.0 and 1.0 that controls the *alpha* channel. There is no default value.
	*/
	public init(red _red: Double, green _green: Double, blue _blue: Double, alpha _alpha: Double) {
		red = _red.inRange(0.0, max: 1.0)
		green = _green.inRange(0.0, max: 1.0)
		blue = _blue.inRange(0.0, max: 1.0)
		alpha = _alpha.inRange(0.0, max: 1.0)
	}

	/**
	Returns a tuple containing the *red*, *green* and *blue* channels a given *Color*, as a decimal value between 0.0 and 1.0.

	See *AView* if you need the alpha channel.
	*/
	public var RGBView: (red: Double, green: Double, blue: Double) {
		return (red: red, green: green, blue: blue)
	}

	/**
	Returns the *alpha* channel of a given *Color*, as a decimal value between 0.0 and 1.0.
	*/
	public var AView: Double {
		return alpha
	}
}

extension Color: CustomStringConvertible {
	public var description: String {
		return "Color(red: \(red), green: \(green), blue: \(blue), alpha: \(alpha))"
	}
}

extension Color: Hashable {
	public var hashValue: Int {
		return [ red, green, blue, alpha ].hashValue
	}
}

/**
A *Color* is considered equal to another *Color* if it has identical hues
*/
public func ==(x: Color, y: Color) -> Bool {
	let xHSB = x.HSBView
	let yHSB = y.HSBView

	return xHSB.hue == yHSB.hue && xHSB.brightness == yHSB.brightness && xHSB.saturation == yHSB.saturation && x.AView == y.AView
}

/**
A *Color* is considered greater than another *Color* if it's hue is greater than that of the other color.

- Returns: A new *Color*.
*/
public func >(x: Color, y: Color) -> Bool {
	let xHSB = x.HSBView
	let yHSB = y.HSBView

	if xHSB.hue != yHSB.hue {
		return xHSB.hue > yHSB.hue
	}

	if xHSB.saturation != yHSB.saturation {
		return xHSB.saturation > yHSB.saturation
	}

	if xHSB.brightness != yHSB.brightness {
		return xHSB.brightness > yHSB.brightness
	}

	return x.AView > y.AView
}

/**
Add two *Color*s together. For example, `Color.red + Color.blue` will return `Color.purple`. This operation happens in the RGB color space.

- Returns: A new *Color*.
*/
public func +(x: Color, y: Color) -> Color {
	let red = (x.red + y.red) / 2.0
	let green = (x.green + y.green) / 2.0
	let blue = (x.blue + y.blue) / 2.0
	let alpha = (x.alpha + y.alpha) / 2.0

	return Color(red: red, green: green, blue: blue, alpha: alpha)
}

/**
Subtract one *Color* from another. For example, `Color.purple - Color.blue` will return `Color.red`. This operation happens in the RGB color space.

- Returns: A new *Color*.
*/
public func -(x: Color, y: Color) -> Color {
	let red = x.red > 0.0 ? ((x.red * 2.0) - y.red).absoluteValue : 0.0
	let green = x.green > 0.0 ? ((x.green * 2.0) - y.green).absoluteValue : 0.0
	let blue = x.blue > 0.0 ? ((x.blue * 2.0) - y.blue).absoluteValue : 0.0
	let alpha = x.alpha > 0.0 ? ((x.alpha * 2.0) - (y.alpha)).absoluteValue : 0.0

	return Color(red: red, green: green, blue: blue, alpha: alpha)
}

public func +=(x: inout Color, y: Color) {
	x = x + y
}

public func -=(x: inout Color, y: Color) {
	x = x - y
}
