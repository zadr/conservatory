import CoreGraphics
import ImageIO
#if os(iOS)
import MobileCoreServices
#elseif os(OSX)
import CoreServices
#endif

extension CGImage: ImageViewable {
	private func data(_ format: CFString) -> UnsafePointer<UInt8> {
		let data = CFDataCreateMutable(nil, 0)
		let destination = CGImageDestinationCreateWithData(data!, format, 1, nil)!
		CGImageDestinationAddImage(destination, self, nil)
		CGImageDestinationFinalize(destination)
		return CFDataGetBytePtr(data)
	}

	public var bitmapView: UnsafePointer<UInt8> {
		return data(kUTTypeBMP)
	}

	public var JPEGView: UnsafePointer<UInt8> {
		return data(kUTTypeJPEG)
	}

	public var PNGView: UnsafePointer<UInt8> {
		return data(kUTTypePNG)
	}
}

extension Image {
	public init(image: CGImage) {
		// todo: support non-RGBA pixel ordering so these preconditions can go away
		precondition(image.colorSpace?.model == .rgb, "Unable to initalize Image with non-RGB images")
		precondition(image.alphaInfo == .premultipliedLast, "Unable to initalize Image without alpha component at end")

		let data = image.dataProvider?.data
		let bytes = CFDataGetBytePtr(data)
		let size = Size(width: image.width, height: image.height)

		self.init(data: bytes!, size: size)
	}
}

public extension Image {
	internal var CGImageView: CGImage {
		let bytes = UnsafeMutableRawPointer(mutating: storage)
		let context = CGContext(data: bytes, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 4 * Int(size.width), space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
		return context!.makeImage()!
	}
}
