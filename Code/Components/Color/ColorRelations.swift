public extension Color {
	// todo: `public func blend(with target: Color, mode: BlendMode = .Normal) -> Color { … }`

	
	public func interpolate(_ towards: Color, step: Double) -> Color {
		let HSB = HSBView
		let towardsHSB = towards.HSBView

		let h = HSB.hue.linearInterpolate(towardsHSB.hue, step: step).absoluteValue
		let s = HSB.saturation.linearInterpolate(towardsHSB.saturation, step: step).absoluteValue
		let b = HSB.brightness.linearInterpolate(towardsHSB.brightness, step: step).absoluteValue
		let a = AView.linearInterpolate(towards.AView, step: step).absoluteValue

		return Color(h: h, s: s, b: b, a: a)
	}
}
