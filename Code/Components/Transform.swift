public enum Axis {
	case Horizontal
	case Vertical
}

private enum Position: Int {
	case A = 0
	case B = 1
	case C = 3
	case D = 4
	case TX = 6
	case TY = 7
}

// possible starting points:
// http://iphonedevelopment.blogspot.com/2008/10/demystifying-cgaffinetransform.html
// https://en.wikipedia.org/wiki/Transformation_matrix#Affine_transformations
public struct Transform {
	internal let a: Double, b: Double, c: Double, d: Double
	internal let tx: Double, ty: Double

	private var matrix: [Double] {
		get {
			return [
				a, b, 0.0,
				c, d, 0.0,
				tx, ty, 1.0
			]
		}
	}

	public init(a _a: Double = 1.0, b _b: Double = 0.0, c _c: Double = 0.0, d _d: Double = 1.0, tx _tx: Double = 0.0, ty _ty: Double = 0.0) {
		a = _a
		b = _b
		c = _c
		d = _d
		tx = _tx
		ty = _ty
	}

	public init(transform: Transform) {
		self.init(matrix: transform.matrix)
	}

	private init(matrix: [Double]) {
		precondition(matrix.count == 9, "Unable to generate a matrix without 9 elements")

		self.init(a: matrix[0], b: matrix[1], c: matrix[3], d: matrix[4], tx: matrix[6], ty: matrix[7])
	}

	public static var identity: Transform {
		get {
			return Transform()
		}
	}

	/**
	Returns a matrix of `[ sx 0 0 sy 0 0 ]`.
	*/
	@warn_unused_result
	public static func scale(x: Double, y: Double) -> Transform {
		return Transform().scale(x, y: y)
	}

	@warn_unused_result
	public func scale(x: Double, y: Double) -> Transform {
		var replacement = matrix
		replacement[Position.A.rawValue] = x
		replacement[Position.D.rawValue] = y
		return Transform(matrix: replacement)
	}

	/**
	Returns a matrix of `[ 1 0 0 1 tx ty ]`.
	*/
	@warn_unused_result
	public static func move(x: Double, y: Double) -> Transform {
		return Transform().move(x, y: y)
	}

	@warn_unused_result
	public func move(x: Double, y: Double) -> Transform {
		var replacement = matrix
		replacement[Position.TX.rawValue] = x
		replacement[Position.TY.rawValue] = y
		return Transform(matrix: replacement)
	}

	/**
	Returns a matrix of `[ cos(angle) sin(angle) -sin(angle) cos(angle) 0 0 ]`.
	*/
	@warn_unused_result
	public static func rotate(angle: Degree) -> Transform {
		return Transform().rotate(angle)
	}

	@warn_unused_result
	public func rotate(angle: Degree) -> Transform {
		var replacement = matrix
		replacement[Position.A.rawValue] = Radian(angle).cosine
		replacement[Position.B.rawValue] = Radian(angle).sine
		replacement[Position.C.rawValue] = -Radian(angle).sine
		replacement[Position.D.rawValue] = Radian(angle).cosine
		return Transform(matrix: replacement)
	}

	/**
	Returns a matrix of `[ x, 0, 0, -x, 0, 0 ]`.
	*/
	@warn_unused_result
	public static func flip(axis: Axis = .Horizontal) -> Transform {
		if axis == .Horizontal {
			return Transform(a: -1, d: 1)
		}

		return Transform(a: 1, d: -1)
	}

	@warn_unused_result
	public func flip(axis: Axis = .Horizontal) -> Transform {
		var replacement = matrix
		if axis == .Horizontal {
			replacement[Position.A.rawValue] = -1
			replacement[Position.D.rawValue] = 1
		} else {
			replacement[Position.A.rawValue] = 1
			replacement[Position.D.rawValue] = -1
		}

		return Transform(matrix: replacement)
	}

	/**
	Returns a matrix of `[ 1, tan(y), -tan(y), 1, 0, 0 ]`.
	*/
	@warn_unused_result
	public static func skew(x: Double, y: Double) -> Transform {
		return Transform().skew(x, y: y)
	}

	@warn_unused_result
	public func skew(x: Double, y: Double) -> Transform {
		var replacement = matrix
		replacement[Position.A.rawValue] = 1
		replacement[Position.B.rawValue] = Radian(y).tangent
		replacement[Position.C.rawValue] = -Radian(x).tangent
		replacement[Position.D.rawValue] = 1

		return Transform(matrix: replacement)
	}

	/**
	Returns a matrix of `t1 * t2`.
	*/
	@warn_unused_result
	public func append(transform t: Transform) -> Transform {
		var result = [Double](count: 9, repeatedValue : 0.0)
		let x = matrix, y = t.matrix

		result[0] = (x[0 /* position(0, 0) */] * y[0 /* position(0, 0) */]) +
					(x[1 /* position(0, 1) */] * y[3 /* position(1, 0) */]) +
					(x[5 /* position(1, 2) */] * y[6 /* position(2, 0) */])
		result[1] = (x[0 /* position(0, 0) */] * y[1 /* position(0, 1) */]) +
					(x[1 /* position(0, 1) */] * y[4 /* position(1, 1) */]) +
					(x[2 /* position(0, 2) */] * y[7 /* position(2, 1) */])
		result[2] = (x[0 /* position(0, 0) */] * y[2 /* position(0, 2) */]) +
					(x[1 /* position(0, 1) */] * y[5 /* position(1, 2) */]) +
					(x[2 /* position(0, 2) */] * y[8 /* position(2, 2) */])

		result[3] = (x[3 /* position(1, 0) */] * y[0 /* position(0, 0) */]) +
					(x[4 /* position(1, 1) */] * y[3 /* position(1, 0) */]) +
					(x[5 /* position(1, 2) */] * y[6 /* position(2, 0) */])
		result[4] = (x[3 /* position(1, 0) */] * y[1 /* position(0, 1) */]) +
					(x[4 /* position(1, 1) */] * y[4 /* position(1, 1) */]) +
					(x[5 /* position(1, 2) */] * y[7 /* position(2, 1) */])
		result[5] = (x[3 /* position(1, 0) */] * y[2 /* position(0, 2) */]) +
					(x[4 /* position(1, 1) */] * y[5 /* position(1, 2) */]) +
					(x[5 /* position(1, 2) */] * y[8 /* position(2, 2) */])

		result[6] = (x[6 /* position(2, 0) */] * y[0 /* position(0, 0) */]) +
					(x[7 /* position(2, 1) */] * y[3 /* position(1, 0) */]) +
					(x[8 /* position(2, 2) */] * y[6 /* position(2, 0) */])
		result[7] = (x[6 /* position(2, 0) */] * y[1 /* position(0, 1) */]) +
					(x[7 /* position(2, 1) */] * y[4 /* position(1, 1) */]) +
					(x[8 /* position(2, 2) */] * y[7 /* position(2, 1) */])
		result[8] = (x[6 /* position(2, 0) */] * y[2 /* position(0, 2) */]) +
					(x[7 /* position(2, 1) */] * y[5 /* position(1, 2) */]) +
					(x[8 /* position(2, 2) */] * y[8 /* position(2, 2) */])

		return Transform(matrix: result)
	}
}

extension Transform: CustomStringConvertible {
	public var description: String {
		get {
			return "Transform(a: \(a), b: \(b), c: \(c), d: \(d), tx: \(tx), ty: \(ty))"
		}
	}
}

extension Transform: Hashable {
	public var hashValue: Int {
		get {
			return matrix.hashValue
		}
	}
}

public extension Transform {
	@warn_unused_result
	public func apply(to point: Point) -> Point {
		let x = (a * point.x + c * point.y + tx)
		let y = (b * point.x + d * point.y + ty)

		return Point(x: x, y: y)
	}

	@warn_unused_result
	public func apply(to size: Size) -> Size {
		let width = (a * size.width + c * size.height)
		let height = (b * size.width + d * size.height)

		return Size(width: width, height: height)
	}

	@warn_unused_result
	public func apply(to box: Box) -> Box {
		return Box(location: apply(to: box.location), size: apply(to: box.size))
	}
}

public func ==(x: Transform, y: Transform) -> Bool {
	return x.matrix == y.matrix
}

/**
t3 = t2 * t1
*/
public func +(x: Transform, y: Transform) -> Transform {
	return x.append(transform: y)
}

/**
t1 = t1 * t2
*/
public func +=(inout x: Transform, y: Transform) {
	x = x.append(transform: y)
}
