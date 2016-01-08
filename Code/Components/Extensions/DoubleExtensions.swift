#if os(iOS) || os(OSX)
import Darwin
#else
import Glibc
#endif

internal let CD_PI = 3.14159265358979323846264338327950288
internal let CD_2_PI = CD_PI * 2.0
internal let CD_PI_2 = CD_PI / 2.0

public typealias Radian = Double
public extension Radian {
	/**
	Convert a given value in degrees to radians.
	*/
	public init(degrees: Degree) {
		self.init(degrees * (CD_PI / 180.0))
	}

	/**
	- Returns: The sine of the current number.
	*/
	public var sine: Double {
		get {
			return sin(self)
		}
	}

	/**
	- Returns: The cosine of the current number.
	*/
	public var cosine: Double {
		get {
			return cos(self)
		}
	}

	/**
	- Returns: The tangent of the current number.
	*/
	public var tangent: Double {
		get {
			return tan(self)
		}
	}

	/**
	- Returns: The inverse cosine of the current number.
	*/
	public var arcCosine: Double {
		get {
			return acos(self)
		}
	}

	/**
	- Returns: The inverse tangent of the current number by x, that is, of y / x.
	*/
	@warn_unused_result
	public func arcTangent(x: Double) -> Double {
		return atan2(self, x)
	}
}

public typealias Degree = Double
public extension Degree {
	/**
	Convert a given value in radians to degrees.
	*/
	public init(radians: Radian) {
		self.init(radians * (180.0 / CD_PI))
	}
}

public extension Double {
	/**
	- Returns: The current number, rounded down to the preceeding integral value.
	*/
	public var roundedDown: Int {
		get {
			return Int(floor(self))
		}
	}

	/**
	- Returns: The square root of the current number.
	*/
	public var squareRoot: Double {
		return sqrt(self)
	}

	/**
	- Returns: The absolute value of an integer.
	*/
	public var absoluteValue: Double {
		get {
			return fabs(self)
		}
	}

	/**
	- Returns: A *Double* between 0.0 and 1.0.

	- Parameter max: The maximum value to return. The default value is **1.0**.
	- Parameter min: The minimum value to return. The default value is **0.0**.

	- Returns: A random value.
	*/
	@warn_unused_result
	public static func random(max: Double = 1.0, min: Double = 0.0) -> Double {
		let value = Double(UInt.random()) / Double(UInt.max)
		return (value * max) + min
	}

	/**
	Ensures that a number is in range of another number.

	- Parameter min: The minimum value to constrain ourselves to.
	- Parameter max: The maximum value to constrain ourselves to.

	- Returns: If the current number is below the *min* value, *min* is returned. If the current number is above the *max* value, *max* is returned. Otherwise the current number is returned.
	*/
	@warn_unused_result
	public func inRange(min: Double, max: Double) -> Double {
		if self < min {
			return min
		}

		if self > max {
			return max
		}

		return self
	}

	/**
	Wrap the current number if necessary.

	- Parameter min:
	- Parameter max:
	- Parameter add:

	If the max value is above *self - min*, return self plus the amount to wrap, specified by *add*. Otherwise, return self minus the minimum to wrap the other way.
	*/
	@warn_unused_result
	public func wrap(min: Double, max: Double, add: Double) -> Double {
		if self - min < max {
			return self + add
		}

		return self - min
	}
}

infix operator ** {}

/**
- Returns: The exponent of the current number to a new power.
*/
public func **(x: Double, to: Double) -> Double {
	return pow(x, to)
}

// http://floating-point-gui.de/errors/comparison/
public func ~=(x: Double, y: Double) -> Bool {
	let epsilon = 0.00001

	if x == y {
		return true
	}

	let difference = (x - y).absoluteValue
	if x == 0 || y == 0 || difference < Double.minNormal {
		return difference < (epsilon * Double.minNormal)
	}

	return difference / min((x.absoluteValue + y.absoluteValue), Double.maxValue) < epsilon
}
