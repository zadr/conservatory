import ImageIO
import MobileCoreServices
import UIKit

extension UIImage: ImageViewable {
	public var bitmapView: UnsafePointer<UInt8> {
		get {
			return CGImage!.bitmapView
		}
	}

	public var JPEGView: UnsafePointer<UInt8> {
		get {
			return UnsafePointer<UInt8>(UIImageJPEGRepresentation(self, 1.0)!.bytes)
		}
	}

	public var PNGView: UnsafePointer<UInt8> {
		get {
			return UnsafePointer<UInt8>(UIImagePNGRepresentation(self)!.bytes)
		}
	}
}

extension Image {
	public init(image: UIImage) {
		self.init(data: image.bitmapView, size: Size(size: image.size))
	}
}

