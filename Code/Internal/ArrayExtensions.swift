internal extension Array where Element == Color {
	/**
	Given a list of colors, calculate the points to be used when drawing a gradient. Defaults to linear interpolation to come up with values.
	*/
	var positions: [Double] {
		let increment = 1.0 / Double(count - 1)

		return count.map {
			return Double($0) * increment
		}
	}
}
