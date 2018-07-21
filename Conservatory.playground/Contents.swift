import Conservatory
import UIKit

let length = 2000.0
let canvas = Canvas<CARenderer>(size: Size(width: length, height: length))
var color = Color.random()
canvas.appearance.background = .solid(color)
canvas.appearance.border = .solid(color.complement)
canvas.appearance.borderWidth = Double.random(50.0 ... 150.0)

let add: (Shape) -> Void = { (shape) -> Void in
	var colors = Color.random().compound()
	let shapeColor = colors.removeFirst()
	var shapeDrawer = ShapeDrawer(shape: shape)
	shapeDrawer.appearance.border = .solid(shapeColor.complement)
	shapeDrawer.appearance.background = Bool.random() ? .gradient(colors, GradientOptions()) : .solid(shapeColor)
	shapeDrawer.appearance.borderWidth = Double.random(5.0 ... 30.0)
	shapeDrawer.appearance.transform = Transform.move(Double.random(0 ... length), y: Double.random(0 ... length))
	shapeDrawer.appearance.aura = Aura(color: shapeColor.withAlpha(float: 0.4), offset: Size(width: 0.0, height: -5.0), blur: 25.0)

	canvas.add(shapeDrawer)
}

Int.random(5 ... 15).times { (x, _) in
	let side = Double.random(35.0 ... 350.0)

	let circle = Shape(circle: side)
	add(circle)

	let oval = Shape(oval: Size(width: side / 1.5, height: side * 1.5))
	add(oval)

	let polygon = Shape(sideCount: Int.random(3 ... 8), length: side)
	add(polygon)
}

canvas.currentRepresentation!
// UIImage(cgImage: canvas.currentRepresentation!) // changes every run!

let view = UIView(frame: CGRect(x: 0, y: 0, width: canvas.size.width, height: canvas.size.height))
