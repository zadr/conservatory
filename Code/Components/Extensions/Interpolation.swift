// http://paulbourke.net/miscellaneous/interpolation/

public protocol Interpolatable {
	@warn_unused_result
	func linearInterpolate(towards: Self, step: Self, of steps: Self?) -> Self

//	todo: func cubicInterpolate(…) -> Self
//	todo: func cosineInterpolate(…) -> Self
//	todo: func hermiteInterpolate(…) -> Self
//	todo: func gaussianInerpolate(…) -> Self
}

public extension Interpolatable where Self: IntegerArithmeticType {
	@warn_unused_result
	public func linearInterpolate(towards: Self, step: Self, of steps: Self?) -> Self {
		return ((self - towards) * step) / steps!
	}
}

extension Double: Interpolatable {
	@warn_unused_result
	public func linearInterpolate(towards: Double, step: Double, of steps: Double? = Double.NaN) -> Double {
		if self == towards {
			return self
		}

		return (self - towards) * step
	}
}
