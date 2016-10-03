internal extension Array where Element: Color {
	/**
	Given a list of colors, calculate the points to be used when drawing a gradient. Defaults to linear interpolation to come up with values.
	*/
	internal var positions: [Double] {
		let increment = 1.0 / Double(count - 1)

		return count.map(transform: { (i) -> Double in
			return Double(i) * increment
		})
	}
}

internal extension Array where Element: Hashable {
	/**
	Returns a modified djb hash of all of the segments in a list.
	See [here](http://www.eternallyconfuzzled.com/tuts/algorithms/jsw_tut_hashing.aspx) for a discussion of the hashing algorithm.
	*/
	internal var hashValue: Int {
		return reduce(0) {
			// &* is multiply-with-overflow
			return 33 &* $0 ^ $1.hashValue
		}
	}
}
