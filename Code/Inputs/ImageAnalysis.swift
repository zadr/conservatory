extension Image {
	/**
	Find the color of a pixel within our image. Returns nil if the point is outside of the image.
	*/
	public func color(_ position: Point) -> Color {
		precondition(Box(size: size).contains(position), "Cannot find the color of a pixel at position \(position) that is not in our image bounds \(size).")

		let pixel = ((Int(size.width) * Int(position.y)) + Int(position.x)) * 4

		let r = Double(storage[pixel]) / 255.0
		let g = Double(storage[pixel + 1]) / 255.0
		let b = Double(storage[pixel + 2]) / 255.0
		let a = Double(storage[pixel + 3]) / 255.0

		return Color(red: r, green: g, blue: b, alpha: a)
	}

	/**
	A color at random that is picked from the image.
	*/
	public func randomColor() -> Color {
		return color(Box(size: size).randomCoordinate())
	}

	/**
	The average color of every pixel in an image.
	*/
	public var averageColor: Color {
		var red: Double = 0.0, green: Double = 0.0, blue: Double = 0.0, alpha: Double = 0.0

		Int(size.width).times(body: { (x, _) in
			Int(size.height).times(body: { (y, _) in
				let color = self.color(Point(x: x, y: y))
				let rgbView = color.RGBView

				red += rgbView.red
				green += rgbView.green
				blue += rgbView.blue
				alpha += color.AView
			})
		})

		let pixelCount = (size.width * size.height)
		red /= pixelCount
		green /= pixelCount
		blue /= pixelCount
		alpha /= pixelCount

		return Color(red: red, green: green, blue: blue, alpha: alpha)
	}
}
