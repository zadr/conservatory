import CoreGraphics
import ImageIO
#if os(iOS)
import MobileCoreServices
#elseif os(OSX)
import CoreServices
#endif

extension CGImageRef: ImageViewable {
	private func data(format: CFString) -> UnsafePointer<UInt8> {
		let data = CFDataCreateMutable(nil, 0)
		let destination = CGImageDestinationCreateWithData(data, format, 1, nil)!
		CGImageDestinationAddImage(destination, self, nil)
		CGImageDestinationFinalize(destination)
		return CFDataGetBytePtr(data)
	}

	public var bitmapView: UnsafePointer<UInt8> {
		get {
			return data(kUTTypeBMP)
		}
	}

	public var JPEGView: UnsafePointer<UInt8> {
		get {
			return data(kUTTypeJPEG)
		}
	}

	public var PNGView: UnsafePointer<UInt8> {
		get {
			return data(kUTTypePNG)
		}
	}
}

extension Image {
	public init(image: CGImageRef) {
		// todo: support non-RGBA pixel ordering so these preconditions can go away
		precondition(CGColorSpaceGetModel(CGImageGetColorSpace(image)) == .RGB, "Unable to initalize Image with non-RGB images")
		precondition(CGImageGetAlphaInfo(image) == .PremultipliedLast, "Unable to initalize Image without alpha component at end")

		let data = CGDataProviderCopyData(CGImageGetDataProvider(image))
		let bytes = CFDataGetBytePtr(data)
		let size = Size(width: CGImageGetWidth(image), height: CGImageGetHeight(image))

		self.init(data: bytes, size: size)
	}
}

public extension Image {
	internal var CGImage: CGImageRef {
		get {
			let bytes = UnsafeMutablePointer<Void>(storage)
			let context = CGBitmapContextCreate(bytes, Int(size.width), Int(size.height), 8, 4 * Int(size.width), CGColorSpaceCreateDeviceRGB(), CGImageAlphaInfo.PremultipliedLast.rawValue)
			return CGBitmapContextCreateImage(context)!
		}
	}
}
