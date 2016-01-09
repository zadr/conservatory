import CoreText
import Foundation

internal extension String {
	@warn_unused_result
	internal func cocoaValue(effects: [TextEffect]) -> NSAttributedString {
		let result = NSMutableAttributedString(string: self)
		effects.forEach({
			var fontDescriptor = CTFontDescriptorCreateWithNameAndSize($0.font.name, CGFloat($0.font.size))
			if $0.bold {
				let attribute = (CTFontDescriptorCopyAttribute(fontDescriptor, kCTFontSymbolicTrait) ?? 0) as! Int

				fontDescriptor = CTFontDescriptorCreateCopyWithAttributes(fontDescriptor, [
					String(kCTFontSymbolicTrait): attribute | Int(CTFontSymbolicTraits.BoldTrait.rawValue)
				] as [String: AnyObject]) ?? fontDescriptor
			}

			if $0.italic {
				let attribute = (CTFontDescriptorCopyAttribute(fontDescriptor, kCTFontSymbolicTrait) ?? 0) as! Int

				fontDescriptor = CTFontDescriptorCreateCopyWithAttributes(fontDescriptor, [
					String(kCTFontSymbolicTrait): attribute | Int(CTFontSymbolicTraits.ItalicTrait.rawValue)
				] as [String: AnyObject]) ?? fontDescriptor
			}

			var attributes: [String: AnyObject] = [
				String(kCTFontAttributeName): CTFontCreateWithFontDescriptor(fontDescriptor, CGFloat($0.font.size), nil),
				String(kCTLigatureAttributeName): $0.ligature,
				String(kCTKernAttributeName): $0.kerning
			]

			if $0.underline != .None {
				attributes[String(kCTUnderlineStyleAttributeName)] = Int($0.underline.coreTextView)
			}
/*
			if $0.strikethrough != .None {
				attributes[NSStrikethroughStyleAttributeName] = $0.strikethrough.cocoaValue
			}

			if $0.aura.shouldApplyAura {
				attributes[NSShadowAttributeName] = $0.aura.cocoaValue
			}
*/

			for (key, value) in $0.metadata {
				if let NSObjectValue = value as? NSObject {
					attributes[key] = NSObjectValue
				}
			}

			result.addAttributes(attributes, range: toNSRange($0.range))
		})

		return result
	}

	// todo: extend `Range` instead
	@warn_unused_result
	private func toNSRange(range: Range<String.Index>) -> NSRange {
		let start = startIndex.distanceTo(range.startIndex)
		let length = range.startIndex.distanceTo(range.endIndex)
		return NSMakeRange(start, length)
	}
}

// MARK: -

/*
private extension Aura {
	private var cocoaValue: NSShadow {
		get {
			let shadow = NSShadow()
			shadow.shadowOffset = CGSize(width: offset.width, height: offset.height)
			shadow.shadowColor = color.cocoaValue
			shadow.shadowBlurRadius = CGFloat(blur)
			return shadow
		}
	}
}

private extension Color {
	#if os(iOS)
	private var cocoaValue: UIColor {
		get {
			let rgb = RGBView
			return UIColor(red: CGFloat(rgb.red), green: CGFloat(rgb.green), blue: CGFloat(rgb.blue), alpha: CGFloat(AView))
		}
	}
	#elseif os(OSX)
	private var cocoaValue: NSColor {
		get {
			let rgb = RGBView
			return NSColor(red: CGFloat(rgb.red), green: CGFloat(rgb.green), blue: CGFloat(rgb.blue), alpha: CGFloat(AView))
		}
	}
	#endif
}
*/

private extension LinePattern {
	private var coreTextView: Int32 {
		switch self {
		case None:
			return CTUnderlineStyle.None.rawValue
		case Single:
			return CTUnderlineStyle.Single.rawValue
		case Thick:
			return CTUnderlineStyle.Thick.rawValue
		case Double:
			return CTUnderlineStyle.Double.rawValue
		case Dotted:
			return CTUnderlineStyle.Single.rawValue | CTUnderlineStyleModifiers.PatternDot.rawValue
		case Dashed:
			return CTUnderlineStyle.Single.rawValue | CTUnderlineStyleModifiers.PatternDash.rawValue
		case DashedAndDotted:
			return CTUnderlineStyle.Single.rawValue | CTUnderlineStyleModifiers.PatternDashDot.rawValue
		case DashedAndDottedTwice:
			return CTUnderlineStyle.Single.rawValue | CTUnderlineStyleModifiers.PatternDashDotDot.rawValue
		}
	}
}
