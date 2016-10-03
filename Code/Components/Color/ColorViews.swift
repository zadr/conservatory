internal enum CIE {
	internal enum D65 {
		case X
		case Y
		case Z

		internal var rawValue: Double {
			switch self {
			case .X: return 95.047
			case .Y: return 100.00
			case .Z: return 108.883
			}
		}
	}
}

// MARK: converting to various color systems and models

// references:
// http://www.codeproject.com/Articles/19045/Manipulating-colors-in-NET-Part-1
// http://www.color.org/srgb.pdf
public extension Color {
	/**
	- Returns: A tuple of the current color View in terms of HSB. See [here](https://en.wikipedia.org/wiki/HSL_and_HSV) for further discussion of the HSB color coordinate system.
	*/
	public var HSBView: (hue: Double, saturation: Double, brightness: Double) {
		let color = RGBView
		var hue: Double = 0, saturation: Double = 0, brightness: Double = 0

		let maxValue = max(color.red, max(color.green, color.blue))
		let minValue = min(color.red, min(color.green, color.blue))

		brightness = maxValue
		saturation = (maxValue != 0.0) ? (maxValue - minValue) / maxValue : 0.0

		if saturation == 0 {
			hue = 0
		} else {
			let red = (maxValue - color.red) / (maxValue - minValue)
			let green = (maxValue - color.green) / (maxValue - minValue)
			let blue = (maxValue - color.blue) / (maxValue - minValue)

			if color.red == maxValue {
				hue = blue - green
			} else if color.green == maxValue {
				hue = 2.0 + red - blue
			} else {
				hue = 4.0 + green - red
			}

			hue /= 6.0

			if hue < 0.0 {
				hue += 1.0
			}

			hue *= 360.0 // todo: get rid of this
		}

		return (hue: hue, saturation: saturation, brightness: brightness)
	}

	/**
	- Returns: A tuple of the current color View in terms of HSL. See [here](https://en.wikipedia.org/wiki/HSL_and_HSV) for further discussion of the HSL color coordinate system.
	*/
	public var HSLView: (hue: Double, saturation: Double, luminosity: Double)? {
		let color = RGBView

		let maxView = max(color.red, max(color.green, color.blue))
		let minView = min(color.red, min(color.green, color.blue))

		guard let h: Double = {
			if minView == maxView {
				return 0.0
			}

			if maxView == color.red && color.green >= color.blue {
				return 60.0 * (color.green - color.blue) / (maxView - minView)
			}

			if maxView == color.red && color.green < color.blue {
				return 60.0 * (color.green - color.blue) / (maxView - minView) + 360.0
			}

			if maxView == color.green {
				return 60.0 * (color.blue - color.red) / (maxView - minView) + 120.0
			}

			if maxView == color.blue {
				return 60.0 * (color.red - color.green) / (maxView - minView) + 240.0
			}

			return nil
		}() else {
			return nil
		}

		let l = (minView + maxView) / 2.0

		let s: Double = {
			if l == 0.0 || maxView == minView {
				return 0.0
			}

			if l > 0 && l >= 0.5 {
				return (maxView - minView) / (maxView + minView)
			}
			// else l < 0.5 {
				return (maxView - minView) / (2 - (maxView + minView))
//			}
		}()

		return (hue: h, saturation: s, luminosity: l)
	}

	/**
	- Returns: A tuple of the current color View in terms of CMYK. Due to differences in RGB and CMYK color models, this conversion may be lossy. See [here](https://en.wikipedia.org/wiki/CMYK_color_model) for further discussion of the CMYK color model.
	*/
	public var CMYKView: (cyan: Double, magenta: Double, yellow: Double, key: Double) {
		let color = RGBView

		let c = 255.0 - color.red
		let m = 255.0 - color.green
		let y = 255.0 - color.blue
		let k = min(c, min(m, y))

		if k == 1.0 {
			return (cyan: c, magenta: m, yellow: y, key: 1.0)
		}

		return (cyan: (c - k) / (1 - k), magenta: (m - k) / (1 - k), yellow: (y - k) / (1 - k), key: k)
	}

	/**
	- Returns: A tuple of the current color View in terms of YUV444. Due to differences in RGB and YUV444 color models, this conversion may be lossy. See [here](https://en.wikipedia.org/wiki/YUV) for further discussion of the YUV444 color model.
	*/
	public var YUVView: (luminance: Double, chrominance: (u: Double, v: Double)) {
		let color = RGBView

		let y = 0.299 * color.red + 0.587 * color.green + 0.114 * color.blue
		let u = -0.14713 * color.red - 0.28886 * color.green + 0.436 * color.blue
		let v = 0.615 * color.red - 0.51499 * color.green - 0.10001 * color.blue

		return (luminance: y, (u: u, v: v))
	}

	/**
	- Returns: A tuple of the current color View in terms of XYZ. Due to differences in RGB and XYZ color models, this conversion may be lossy. See [here](https://en.wikipedia.org/wiki/CIE_1931_color_space) for further discussion of the XYZ color space.
	*/
	public var XYZView: (x: Double, y: Double, z: Double) {
		let color = RGBView

		let x = (color.red > 0.04045) ? ((color.red + 0.055) / (1 + 0.055)) ** (2.2) : (color.red / 12.92)
		let y = (color.green > 0.04045) ? ((color.green + 0.055) / (1 + 0.055))  **  (2.2) : (color.green / 12.92)
		let z = (color.blue > 0.04045) ? ((color.blue + 0.055) / (1 + 0.055))  **  (2.2) : (color.blue / 12.92)

		return (x: x, y: y, z: z)
	}

	/**
	- Returns: A tuple of the current color View in terms of L*a*b. Due to significant differences in RGB and L*a*b color models, this conversion may be lossy. See [here](https://en.wikipedia.org/wiki/Lab_color_space) for further discussion of the L*a*b color space.
	*/
	public var LabView: (L: Double, a: Double, b: Double) {
		let color = XYZView

		let Fxyz: (Double) -> (Double) = { (t) -> Double in
			return ((t > 0.008856) ? t ** (1.0 / 3.0) : (7.787 * t + 16.0 / 116.0))
		}

		let L = 116.0 * Fxyz(color.y / CIE.D65.Y.rawValue) - 16
		let a = 500.0 * (Fxyz(color.x / CIE.D65.X.rawValue) - Fxyz(color.y / CIE.D65.Y.rawValue))
		let b = 200.0 * (Fxyz(color.y / CIE.D65.Y.rawValue) - Fxyz(color.z / CIE.D65.Z.rawValue))

		return (L: L, a: a, b: b)
	}

	/**
	The current color as an uppercased hex string.

	- Parameter includeAlpha: Should we include the alpha as a hex component at the end of the string? The default value is **false**.

	- Returns: A 6 or 8 character hex string, in the format of *RRGGBB* or *RRGGBBAA*.
	*/
	
	public func hexView(_ includeAlpha: Bool = false) -> String {
		let color = RGBView

		var hexView = ""
		hexView += String(Int(color.red), radix: 16)
		hexView += String(Int(color.green), radix: 16)
		hexView += String(Int(color.blue), radix: 16)

		if includeAlpha {
			hexView += String(Int(AView), radix: 16)
		}

		return hexView
	}
}
