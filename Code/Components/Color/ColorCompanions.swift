public extension Color {
	/**
	- Returns: A new *Color* that is saturated by *step*.

	- Parameter step: How much to saturate a color, as double between -1.0 and 1.0. The resulting saturation will be not be under 0.0 or above 1.0. The larger the value, the more saturated the result will be. Passing in a negative number is equivalent to calling *desaturate(positive_amount)*. The default value is **0.1**.
	*/
	public func saturate(_ step: Double = 0.1) -> Color {
		return withSaturation(float: HSBView.saturation + step)
	}

	/**
	- Returns: A new *Color* that is desaturated by *step*.

	- Parameter step: How much to desaturate a color, as double between -1.0 and 1.0. The resulting saturation will be not be under 0.0 or above 1.0. The larger the value, the more saturated the result will be. Passing in a negative number is equivalent to calling *saturate(positive_amount)*. The default value is **0.1**.
	*/
	public func desaturate(_ step: Double = 0.1) -> Color {
		return withSaturation(float: HSBView.saturation - step)
	}

	/**
	- Returns: A new *Color* that is darkened by *step*.

	- Parameter step: How much to darken a color, as double between -1.0 and 1.0. The resulting brightness will be not be under 0.0 or above 1.0. Passing in a negative number is equivalent to calling *lighten(positive_amount)*. The default value is **0.1**.
	*/
	public func darken(_ step: Double = 0.1) -> Color {
		return withBrightness(float: HSBView.brightness - step)
	}

	/**
	- Returns: A new *Color* that is lightened by *step*.

	- Parameter step: How much to lighten a color, as double between -1.0 and 1.0. The resulting brightness will be not be under 0.0 or above 1.0. Passing in a negative number is equivalent to calling *lighten(positive_amount)*. The default value is **0.1**.
	*/
	public func lighten(_ step: Double = 0.1) -> Color {
		return withBrightness(float: HSBView.brightness + step)
	}

	/**
	- Returns: A new *Color* that is up to *angle* degrees away on a **Red-Yellow-Blue** color wheel, and up to *delta* away in saturation.

	- Parameter angle: Maximum amount to rotate by on a color wheel. Passing in values below 0° or above 360° are equivalent to passing in *value % 360*. The default value is **20**.
	- Parameter delta: Maximum amount to saturate the rotated color by. The default value is **0.5**.
	*/
	
	public func analog(angle a: Double = 20.0, delta d: Double = 0.5) -> Color {
		let rotated = rotateRYB(Double.random(a))
		let lightened = rotated.lighten(Double.random(d))
		return lightened.saturate(Double.random(d))
	}

	/**
	- Returns: a new *Color* that is relatively close to the current color on a **Red-Yellow-Blue** color wheel.
	
	Each parameter is considered a maximum value to adjust the resulting color by; the actual value will be a random value between 0.0 and the provided value.

	- Parameter maxHue: Maximum amount to adjust the hue by. The resulting hue will not be under 0.0 or 1.0. The default value is **0.1**.
	- Parameter maxSaturation: Maximum amount to saturate the color by.The resulting saturation will not be under 0.0 or 1.0. The default value is **0.3**.
	- Parameter maxBrightness: Maximum amount to adjust the brigtness by. The resulting brightness will not be under 0.0 or 1.0. The default value is **0.3**.
	*/
	public func drift(maxHue h: Double = 0.1, maxSaturation s: Double = 0.3, maxBrightness b: Double = 0.3) -> Color {
		let originalHSB = HSBView

		var randomHue = ((Double.random() * h) - h / 2.0) + originalHSB.hue
		randomHue = randomHue.inRange(h / 2.0, max: originalHSB.hue + h / 2.0)

		var randomSaturation = ((Double.random() * s) - h / 2.0) + originalHSB.saturation
		randomSaturation = randomSaturation.inRange(s / 2.0, max: originalHSB.saturation + s / 2.0)

		var randomBrightness = ((Double.random() * b) - b / 2.0) + originalHSB.saturation
		randomBrightness = randomBrightness.inRange(b / 2.0, max: originalHSB.saturation + b / 2.0)

		return Color(h: randomHue, s: randomSaturation, b: randomBrightness, a: AView)
	}

	/**
	- Returns: a new *Color* that is 180° away on a **Red-Yellow-Blue** color wheel.
	*/
	public var complement: Color {
		return rotateRYB()
	}

	/**
	- Returns: An array of *Color*s that are complementary to the current color on a **Red-Yellow-Blue** color wheel. Specifically, we will have the following values:

	1. The current color.
	2. A contrasting color. If the current color is considered bright (*brightness* > 0.4), the brightness will be increased, otherwise the brightness will decrease.
	3. A softer supporting color. This color will be brighter and more saturated than the current color.
	4. A a contrasting color of our complement. If the complement is considered bright (*brightness* > 0.4), the brightness will be increased, otherwise the brightness will decrease.
	5. The exact complement of the current color, 180° away on a **Red-Yellow-Blue** color wheel.
	6. A softer supporting color of our complement. This color will be brighter and more saturated than our complement.
	*/
	public var complementary: [Color] {
		var complementary = [ self ]

		// A contrasting color: much darker or lighter than the original.
		if HSBView.brightness > 0.4 {
			complementary.append(withBrightness(float: 0.1 + HSBView.brightness * 0.25))
		} else {
			complementary.append(withBrightness(float: 1.0 - HSBView.brightness * 0.25))
		}

		// A soft supporting color: lighter and less saturated.
		var softSupporting = withBrightness(float: 0.3 + HSBView.brightness)
		complementary.append(softSupporting.withSaturation(float: 0.1 + HSBView.saturation * 0.3))

		// A contrasting complement: very dark or very light.
		let complementColor = complement
		if complementColor.HSBView.brightness > 0.3 {
			let color = complementColor.withBrightness(float: 0.1 + complementColor.HSBView.brightness * 0.25)
			complementary.append(color)
		} else {
			let color = complementColor.withBrightness(float: 0.1 + complementColor.HSBView.brightness * 0.25)
			complementary.append(color)
		}

		// The complement
		complementary.append(complementColor)

		// A soft supporting complement color: lighter and less saturated.
		softSupporting = complementColor.withBrightness(float: 0.3 + HSBView.brightness)
		complementary.append(softSupporting.withSaturation(float: 0.1 + HSBView.saturation * 0.3))

		return complementary
	}

	/**
	- Returns: An array of *Color*s that are spllit-complementary to the current color. That is, to the left and right of the current color on a **Red-Yellow-Blue** color wheel.

	- Parameter angle: How far to rotate left or right in the color wheel. Passing in values below 0° or above 360° are equivalent to passing in *value % 360*. The default value is **30**.

	1. The current color.
	2. The left-complement of the current color.
	3. The right-complement of the current color
	*/
	public func splitComplementary(_ angle: Double = 30.0) -> [Color] {
		var complementary = [ self ]

		complementary.append(complement.rotateRYB(-angle))
		complementary.append(complement.rotateRYB(angle))

		return complementary
	}

	/**
	- Returns: An array of *Color*s that are left-complementary to the current color on a **Red-Yellow-Blue** color wheel.
	
	The values returned are identical to that of *complement*, with the hue of the last three replaced by that of a color *angle* degrees away on the color wheel.
	
	Passing in a positive number is equivalent to calling *rightComplementary(angle)*.

	- Parameter angle: How far to rotate left or right in the color wheel. Passing in values below 0° or above 360° are equivalent to passing in *value % 360*. The default value is **-30**.

	1. The current color.
	2. A contrasting color. If the current color is considered bright (*brightness* > 0.4), the brightness will be increased, otherwise the brightness will decrease.
	3. A softer supporting color. This color will be brighter and more saturated than the current color.
	4. A a contrasting color of our left-complement. If the complement is considered bright (*brightness* > 0.4), the brightness will be increased, otherwise the brightness will decrease.
	5. The exact left-complement of the current color, 180° away on a **Red-Yellow-Blue** color wheel.
	6. A softer supporting color of our left-complement. This color will be brighter and more saturated than our complement.
	*/
	public func leftComplementary(_ angle: Double = -30.0) -> [Color] {
		let left = complement.rotateRYB(angle).lighten()

		var complementaryColors = complementary

		complementaryColors[3] = complementaryColors[3].withHue(float: left.HSBView.hue)
		complementaryColors[4] = complementaryColors[4].withHue(float: left.HSBView.hue)
		complementaryColors[5] = complementaryColors[5].withHue(float: left.HSBView.hue)

		return complementaryColors
	}

	/**
	Returns: An array of *Color*s that are right-complementary to the current color on a **Red-Yellow-Blue** color wheel.
	
	The values returned are identical to that of *complement*, with the hue of the last three replaced by that of a color *angle* degrees away on the color wheel.
	
	Passing in a negative number is equivalent to calling *leftComplementary(angle)*.

	- Parameter angle: How far to rotate left or right in the color wheel. Passing in values below 0° or above 360° are equivalent to passing in *value % 360*. The default value is **30**.

	1. The current color.
	2. A contrasting color. If the current color is considered bright (*brightness* > 0.4), the brightness will be increased, otherwise the brightness will decrease.
	3. A softer supporting color. This color will be brighter and more saturated than the current color.
	4. A a contrasting color of our right-complement. If the complement is considered bright (*brightness* > 0.4), the brightness will be increased, otherwise the brightness will decrease.
	5. The exact right-complement of the current color, 180° away on a **Red-Yellow-Blue** color wheel.
	6. A softer supporting color of our right-complement. This color will be brighter and more saturated than our complement.
	*/
	public func rightComplementary(_ angle: Double = 30.0) -> [Color] {
		let right = complement.rotateRYB(angle).lighten()

		var complementaryColors = complementary

		complementaryColors[3] = complementaryColors[3].withHue(float: right.HSBView.hue)
		complementaryColors[4] = complementaryColors[4].withHue(float: right.HSBView.hue)
		complementaryColors[5] = complementaryColors[5].withHue(float: right.HSBView.hue)

		return complementaryColors
	}

	/**
	Returns an array of *Color* that are *angle* degrees away on a **Red-Yellow-Blue** color wheel, with the saturation and brightness adjusted.

	- Parameter angle: Angle to start rotating by on a **Red-Yellow-Blue** color wheel. Passing in values below 0° or above 360° are equivalent to passing in *value % 360*. The default value is **10**.
	- Parameter contrast: Maximum amount to contrast the rotated color by. If the given value is below 0.0 or above 1.0, it is clamped to the nearest valid value. The default value is **0.1**.

	- Returns: Six values, the first of which is the current color, followed by five analogous colors.
	*/
	public func analogous(_ angle: Double = 10.0, contrast: Double = 0.25) -> [Color] {
		let rangedContrast = contrast.inRange(0.0, max: 1.0)

		var analogous = [ self ]

		let anglesAndContrasts: [(angle: Double, contrast: Double)] = [
			(1.0, 2.2), (2.0, 1.0), (-1.0, -0.5), (-2.0, 1.0)
		]

		anglesAndContrasts.forEach({
			var color = rotateRYB(angle * $0.angle)
			let newBrightness = 0.44 - $0.contrast * 0.1
			if HSBView.brightness - contrast * $0.contrast < newBrightness {
				color = color.withBrightness(float: newBrightness)
			} else {
				color = color.withBrightness(float: HSBView.brightness - rangedContrast * $0.contrast)
			}

			analogous.append(color.withSaturation(float: color.HSBView.saturation - 0.05))
		})

		return analogous
	}

	/**
	Returns an array of *Color* that have the same *hue* as the current color, and varying brightnesses and saturation values.

	- Returns: Five values, the first of which is the current color, followed by four analogous colors.
	*/
	public var monochrome: [Color] {
		var monochrome = [ self ]

		var color = self
		color = color.withBrightness(float: HSBView.brightness.wrap(0.5, max: 0.2, add: 0.3))
		color = color.withSaturation(float: HSBView.saturation.wrap(0.3, max: 0.1, add: 0.3))
		monochrome.append(color)

		color = self
		color = color.withBrightness(float: HSBView.brightness.wrap(0.2, max: 0.2, add: 0.6))
		monochrome.append(color)

		color = self
		color = color.withBrightness(float: max(0.2, HSBView.brightness + (1.0 - HSBView.brightness) * 0.2))
		color = color.withSaturation(float: HSBView.saturation.wrap(0.3, max: 0.1, add: 0.3))
		monochrome.append(color)

		color = self
		color = color.withBrightness(float: HSBView.brightness.wrap(0.5, max: 0.2, add: 0.3))
		monochrome.append(color)

		return monochrome
	}

	/**
	- Returns: An array of *Color*s that are analogs to the current color. That is, to the left and right of the current color on a **Red-Yellow-Blue** color wheel.

	- Parameter angle: How far to rotate left or right in the color wheel. Passing in values below 0° or above 360° are equivalent to passing in *value % 360*. The default value is **120**.

	1. The current color.
	2. The left-analog of the current color.
	3. The right-analog of the current color
	*/
	public func triad(_ angle: Double = 120.0) -> [Color] {
		var triad = [ self ]

		triad.append(rotateRYB(angle).lighten())
		triad.append(rotateRYB(-angle).lighten())

		return triad
	}

	/**
	- Returns: An array of *Color*s that are to the left, right, and opposite of the current color on a **Red-Yellow-Blue** color wheel after rotating by *angle*°.

	- Parameter angle: How far to rotate left or right in the color wheel. Passing in values below 0° or above 360° are equivalent to passing in *value % 360*. The default value is **90**.

	1. The current color.
	2. The current color rotated by *angle* degrees. If the color is considered bright (brightness > 0.5), the color is darkened, otherwise the color is lightened.
	2. The current color rotated by *angle * 2* degrees. If the color is considered bright (brightness > 0.5), the color is darkened, otherwise the color is lightened. In either case, the adjustment is less than the adjustment of the prior color.
	2. The current color rotated by *angle * 3* degrees.
	*/
	public func tetrad(_ angle: Double = 90.0) -> [Color] {
		var tetrad = [ self ]

		var rotated = rotateRYB(angle)
		if HSBView.brightness < 0.5 {
			tetrad.append(rotated.withBrightness(float: rotated.HSBView.brightness + 0.2))
		} else {
			tetrad.append(rotated.withBrightness(float: rotated.HSBView.brightness - 0.2))
		}

		rotated = rotateRYB(angle * 2.0)
		if HSBView.brightness < 0.5 {
			tetrad.append(rotated.withBrightness(float: rotated.HSBView.brightness + 0.1))
		} else {
			tetrad.append(rotated.withBrightness(float: rotated.HSBView.brightness - 0.1))
		}

		tetrad.append(rotateRYB(angle * 3.0).lighten())

		return tetrad
	}

	/**
	Returns an array of *Color*s that are complementary to the current color.

	- Parameter left: Do we want left-complementary colors? The default value is **false**, to result in right-complementary colors.

	- Returns: An array of six colors, the first of which is the current color.
	*/
	public func compound(_ left: Bool = false) -> [Color] {
		let d = (left ? -1.0 : 1.0)

		var compound = [ self ]

		var color = rotateRYB(30.0 * d)
		color = color.withBrightness(float: HSBView.brightness.wrap(0.25, max: 0.6, add: 0.25))
		compound.append(color)

		color = rotateRYB(30.0 * d)
		color = color.withSaturation(float: HSBView.saturation.wrap(0.4, max: 0.1, add: 0.4))
		color = color.withBrightness(float: HSBView.brightness.wrap(0.4, max: 0.2, add: 0.4))
		compound.append(color)

		color = rotateRYB(160.0 * d)
		color = color.withSaturation(float: HSBView.saturation.wrap(0.25, max: 0.1, add: 0.25))
		color = color.withBrightness(float: max(0.2, HSBView.brightness))
		compound.append(color)

		color = rotateRYB(150.0 * d)
		color = color.withSaturation(float: HSBView.saturation.wrap(0.1, max: 0.8, add: 0.1))
		color = color.withBrightness(float: HSBView.brightness.wrap(0.3, max: 0.6, add: 0.3))
		compound.append(color)

		color = rotateRYB(150.0 * d)
		color = color.withSaturation(float: HSBView.saturation.wrap(0.1, max: 0.8, add: 0.1))
		color = color.withBrightness(float: HSBView.brightness.wrap(0.4, max: 0.2, add: 0.4))
		compound.append(color)

		return compound
	}

	/**
	- Returns: a new *Color* that is rotated by *angle* degrees on a **[Red-Yellow-Blue](http://en.wikipedia.org/wiki/RYB_color_model)** color wheel.

	- Parameter angle: Maximum amount to rotate by on a color wheel. Passing in values below 0° or above 360° are equivalent to passing in *value % 360*. The default value is **180**, or the complement of a color.
	*/
	public func rotateRYB(_ angle: Double = 180.0) -> Color {
		// Approximation of Itten's RYB color wheel.
		// In HSB color hues range from 0-360, however, on the artistic color wheel these are not evenly distributed.
		// The second tuple value contains the actual distribution.
		let RYBWheel: [(x: Double, y: Double)] = [
			(0,  0), (15,  8), (30, 17), (45, 26), (60, 34),
			(75, 41), (90, 48), (105, 54), (120, 60), (135, 81),
			(150, 103), (165, 123), (180, 138), (195, 155), (210, 171),
			(225, 187), (240, 204), (255, 219), (270, 234), (285, 251),
			(300, 267), (315, 282), (330, 298), (345, 329), (360, 0)
		]

		var h = HSBView.hue
		let angle = angle.truncatingRemainder(dividingBy: 360.0)
		var a = 0.0

		// Given a hue, find out under what angle it is located on the artistic color wheel.
		(RYBWheel.count - 1).times { (i, stop) in
			let x0 = RYBWheel[i].x, y0 = RYBWheel[i].y
			var x1 = RYBWheel[i + 1].x, y1 = RYBWheel[i + 1].y

			if y1 < y0 {
				y1 += 360.0
			}

			if y0 <= h && h <= y1 {
				a = 1.0 * x0 + (x1 - x0) * (h - y0) / (y1 - y0)
				stop.pointee = true
			}
		}

		a = (a + angle).truncatingRemainder(dividingBy: 360.0)

		// For the given angle, find out what hue is located there on the artistic color wheel.
		(RYBWheel.count - 1).times { (i, stop) in
			let current = RYBWheel[i]
			let next = RYBWheel[i + 1]

			let x0 = current.x, y0 = current.y
			var x1 = next.x, y1 = next.y

			if y1 < y0 {
				y1 += 360.0
			}

			if x0 <= a && a <= x1 {
				h = 1.0 * y0 + (y1 - y0) * (a - x0) / (x1 - x0)
				stop.pointee = true
			}
		}

		h = h.truncatingRemainder(dividingBy: 360.0)

		let hsb = HSBView
		return Color(h: h, s: hsb.saturation, b: hsb.brightness, a: AView)
	}

	/**
	- Returns: A new *Color* that is rotated by *angle* degrees on a **Red-Green-Blue** color wheel.

	- Parameter angle: Maximum amount to rotate by on a color wheel. Passing in values below 0° or above 360° are equivalent to passing in *value % 360*. The default value is **180**, or the complement of a color.
	*/
	public func rotateRGB(_ angle: Double = 180.0) -> Color {
		let h = (HSBView.hue + 1.0 * angle / 360.0).truncatingRemainder(dividingBy: 1)
		return withHue(float: h)
	}

	/**
	Flips a color around, based on it's *hue*.

	- Returns: A new *Color* with the *hue* set to *360.0 - self.hue*.
	*/
	public var inverse: Color {
		return withHue(float: (360.0 - HSBView.hue).absoluteValue)
	}
}
