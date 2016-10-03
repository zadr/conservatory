// http://paulbourke.net/miscellaneous/interpolation/

public protocol Interpolatable {
	func linearInterpolate(_ towards: Self, step: Self, of steps: Self?) -> Self

//	todo: func cubicInterpolate(…) -> Self
//	todo: func cosineInterpolate(…) -> Self
//	todo: func hermiteInterpolate(…) -> Self
//	todo: func gaussianInerpolate(…) -> Self
}

public extension Interpolatable where Self: IntegerArithmetic {
	public func linearInterpolate(_ towards: Self, step: Self, of steps: Self?) -> Self {
		return ((self - towards) * step) / steps!
	}
}

extension Double: Interpolatable {
	public func linearInterpolate(_ towards: Double, step: Double, of steps: Double? = Double.nan) -> Double {
		if self == towards {
			return self
		}

		return (self - towards) * step
	}
}
