	// see https://en.wikipedia.org/wiki/Blend_modes or http://photoblogstop.com/photoshop/photoshop-blend-modes-explained
	// for a description of the formulas used here
	// todo: (after this is done: blend image.blend(with color: Color)) (and to gradients)
	// todo: specify color model to use (.RGB vs .CMYK vs …)
	@warn_unused_result
	public func blend(with target: Color, mode: BlendMode = .Normal) -> Color {
		let blend = self

		switch mode {
		case .Normal:
			return blend
		case .Multiply:
			return target * blend
		case .Screen:
			return (blend.inverse * target.inverse).inverse
		case .Overlay:
			// todo! verify
			if target.white > 0.5 {
				return (2.0 * (inverse * target.inverse)).inverse
			}

			return self * target * 2.0
		case .Darken:
			// per-channel basis, as opposed to DarkerColor that is `self > target ? target : self` to return the darker color.
			let xRGB = RGBView
			let yRGB = target.RGBView
			return Color(red: min(xRGB.red, yRGB.red), green: min(xRGB.green, yRGB.green), blue: min(xRGB.blue, yRGB.blue), alpha: min(AView, target.AView))
		case .Lighten:
			// per-channel basis, as opposed to LightererColor that is `self > target ? self : target` to return the lighter color.
			let xRGB = RGBView
			let yRGB = target.RGBView
			return Color(red: max(xRGB.red, yRGB.red), green: max(xRGB.green, yRGB.green), blue: max(xRGB.blue, yRGB.blue), alpha: max(AView, target.AView))
		case .ColorDodge:
			return target / inverse
		case .ColorBurn:
			return (target.inverse / self).inverse
		case .SoftLight:
			if white > 0.5 {
				// same as .Screen
				return (2.0 * (inverse * target.inverse)).inverse
			}

			// same as .Multiply
			return self * target * 2.0
		case .HardLight:
			if AView > 0.5 {
				return (2.0 * (inverse * target.inverse)).inverse
			}

			return self * target * 2.0
		case .Difference:
			let xRGB = RGBView
			let yRGB = target.RGBView
			let red = (xRGB.red - yRGB.red).absoluteValue
			let green = (xRGB.green - yRGB.green).absoluteValue
			let blue = (xRGB.blue - yRGB.blue).absoluteValue
			let alpha = (AView - target.AView).absoluteValue

			return Color(red: red, green: green, blue: blue, alpha: alpha)
		case .Exclusion:
			// 0.5 - (2 * target - 0.5) * (blend - 0.5)
			precondition(false, "todo!")
			break
		case .Hue:
			return withHue(float: target.hue)
		case .Saturation:
			return withSaturation(float: target.saturation)
		case .Color:
			return target.withHue(float: hue)
		case .Luminosity:
			return withBrightness(float: target.brightness)
		}
		return self
	}
