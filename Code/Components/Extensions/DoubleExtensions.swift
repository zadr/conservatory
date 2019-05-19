#if os(iOS) || os(OSX)
import Darwin
#else
import Glibc
#endif

internal let CV_2_PI = Double.pi * 2.0
internal let CV_PI_2 = Double.pi / 2.0

public typealias Radian = Double
public extension Radian {
	/**
	Convert a given value in degrees to radians.
	*/
	init(degrees: Degree) {
		self.init(degrees * (Double.pi / 180.0))
	}

	/**
	- Returns: The sine of the current number.
	*/
	var sine: Double {
		return sin(self)
	}

	/**
	- Returns: The cosine of the current number.
	*/
	var cosine: Double {
		return cos(self)
	}

	/**
	- Returns: The tangent of the current number.
	*/
	var tangent: Double {
		return tan(self)
	}

	/**
	- Returns: The inverse cosine of the current number.
	*/
	var arcCosine: Double {
		return acos(self)
	}

	/**
	- Returns: The inverse tangent of the current number by x, that is, of y / x.
	*/
	
	func arcTangent(_ x: Double) -> Double {
		return atan2(self, x)
	}
}

public typealias Degree = Double
public extension Degree {
	/**
	Convert a given value in radians to degrees.
	*/
	init(radians: Radian) {
		self.init(radians * (180.0 / Double.pi))
	}
}

public extension Range {
	func constraining(_ value: Bound) -> Bound {
        if value < lowerBound {
            return lowerBound
        }

        if value > upperBound {
            return upperBound
        }
        
        return value
    }
}

public extension Double {
	/**
	- Returns: The current number, rounded down to the preceeding integral value.
	*/
	var roundedDown: Int {
		return Int(floor(self))
	}

	/**
	- Returns: The absolute value of an integer.
	*/
	var absoluteValue: Double {
		return fabs(self)
	}


	/**
	Wrap the current number if necessary.

	- Parameter min:
	- Parameter max:
	- Parameter add:

	- Todo: move this into `extension Range where Bound: …some protocol that can be added and subtracted… {}

	If the max value is above *self - min*, return self plus the amount to wrap, specified by *add*. Otherwise, return self minus the minimum to wrap the other way.
	*/
	func wrap(_ min: Double, max: Double, add: Double) -> Double {
		if self - min < max {
			return self + add
		}

		return self - min
	}
}

infix operator **

/**
- Returns: The exponent of the current number to a new power.
*/
public func **(x: Double, to: Double) -> Double {
	return pow(x, to)
}

// http://floating-point-gui.de/errors/comparison/
public func ~=(x: Double, y: Double) -> Bool {
	return Double(round(x.distance(to: y).absoluteValue * 1000) / 1000) <= 0.001
}
