// MARK: Triangles, Squares, Stars, and Line-y shapes in general -

extension Shape {
	/**
	Create an n-sided polygon, where each side is the same length. A polygon represents a shape with an area without a location, which is held by the ShapeDrawer.

	- Parameter sideCount: The number of sides in a polygon. A polygon must have at least three sides.
	- Parameter length: the length of one side of the resulting polygon. This value must be above 0.
	*/
	public init(sideCount: Int, length: Double) {
		precondition(length > 0, "Unable to draw a polygon with a negative side (length = \(length)).")
		precondition(sideCount > 2, "n-sided polygons are required to have at least three sides.")

		let radius = (length / 2.0)
		let interiorAngle = CV_2_PI / Double(sideCount)
		let startAngle: Double = {
			if sideCount % 2 == 1 {
				return CV_PI_2
			}

			return CV_PI_2 - interiorAngle / 2.0
		}()

		let points = sideCount.map(transform: { (x) -> Point in
			let angle = Radian(startAngle + (Double(x) * interiorAngle))
			return Point.zero.coordinate(radius, angle: angle)
		})

		self.init(points: points)
	}

	/**
	Create an n-pointed star, where the line between each point is represented by *length*. A star represents a shape with an area without a location, which is held by the ShapeDrawer.
	https://www.khanacademy.org/computer-programming/star-and-regular-polygon-drawer/5913270801137664

	- Parameter pointCount: The number of points in a star. A star must have at least five points.
	- Parameter length: the length of one side of the resulting polygon. This value must be above 0.
	- Parameter depth: the length of one side of the resulting polygon. This value must be above 0.
	*/
	public init(pointCount: Int, length: Size, depth: Double = 50) {
		precondition(pointCount > 3, "n-pointed stars must have at least four points")

		var out: Double = -1
		var angle = 360.0 / Double(pointCount * 2)
		let points = (pointCount * 2).map(transform: { (x) -> Point in
			defer { out *= -1 }

			let currentAngle = Radian(Double(x) * angle)
			return Point(x: currentAngle.sine * (length.width + out * depth),
						 y: currentAngle.cosine * (length.height + out * depth))
		})

		self.init(points: points)
	}

	/**
	Create a triangle. Given two sides, we come up with the length of the third side in order to build a valid triangle.

	- Parameter sideA: The length of one side of a triangle. This value must be above 0.
	- Parameter sideB: The length of one side of a triangle. This value must be above 0.
	*/
	public init(triangle a: Double, sideB b: Double) {
		precondition(a > 0, "Unable to draw a triangle with a negative side (a = \(a)).")
		precondition(b > 0, "Unable to draw a triangle with a negative side (b = \(b)).")

		precondition(false, "todo! fix")
		// pythagorean theorem, a^2 + b^2 = c^2
//		let c = (a.power(2.0) + b.power(2.0)).squareRoot

		// http://stackoverflow.com/questions/4001948/drawing-a-triangle-in-a-coordinate-plane-given-its-three-sides
//		C1: (x - a) * (x - a) + y * y = c * c
//		C2: x * x + y * y = b * b
//		y * y = b * b - x * x
//		(x - a) * (x - a) + b * b - x * x = c * c
//		x * x - 2 * a * x + a * a + b * b - x * x - c * c = 0
//		2 * a * x = (a * a + b * b - c * c)
//		x = (a * a + b * b - c * c) / (2 * a)
//		y * y = b * b - ((a * a + b * b - c * c) / (2 * a)) * ((a * a + b * b - c * c) / (2 * a))
//		y = +- sqrt(b * b - ((a * a + b * b - c * c) / (2 * a)) * ((a * a + b * b - c * c) / (2 * a)))
//		
		close()
	}
}

// MARK: - Circles and Ovals -

extension Shape {
	/**
	Create a circle given a radius from the center to the edge.

	- Parameter circle: The radius of the circle. This value must be above 0.
	*/
	public init(circle radius: Double) {
		precondition(radius > 0, "Unable to draw a circle with a negative radius (\(radius)).")

		self.init()

		// draw from 360° (2π) to 0°, instead of the other way around. Although a circle has 360°, and we start at 0°, many renderers treat 0° and 360°
		// differently enough that it can otherwise result in a gap at the start-end of our circle.
		addArc(Point(x: 0.0, y: 0.0), radius: radius, startAngle: Radian(degrees: 360.0), endAngle: Radian(0.0))
		close()
	}

	/**
	Create an oval, given a radius from the center to the edge in either direction.

	- Parameter oval: When rotated by 0°, the radius' *width* is from from the center of the circle to the *leftmost* (or *rightmost*) edge, and the *height* is from the center of the circle to the *topmost* (or *bottommost*) edge. Both values must be above 0.
	*/
	public init(oval radius: Size) {
		precondition(radius.height > 0, "Unable to draw an oval with a negative height radius (height = \(radius.height)).")
		precondition(radius.width > 0, "Unable to draw an oval with a negative width radius (width = \(radius.width)).")

		// http://scienceprimer.com/draw-oval-html5-canvas
		let angleSine = Double.pi.sine
		let angleCosine = Double.pi.cosine
		let points = stride(from: 0, to: CV_2_PI, by: 0.01).map({ (x) -> Point in
			let xSine = x.sine
			let xCosine = x.cosine

			let x = (radius.width * xSine) * angleSine + (radius.height * xCosine) * angleCosine
			let y = (radius.height * xCosine) * angleSine + (radius.width * xSine) * angleCosine

			return Point(x: x, y: y)
		})

		self.init(points: points)
	}
}
