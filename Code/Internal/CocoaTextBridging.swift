// todo: core text-ify attributed string building, so we don't have to rely on UIKit or AppKit
#if os(iOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

internal extension String {
	@warn_unused_result
	internal func cocoaValue(effects: [TextEffect]) -> NSAttributedString {
		let result = NSMutableAttributedString(string: self)
		effects.forEach({
			var fontDescriptor = UIFontDescriptor(name: $0.font.name, size: CGFloat($0.font.size))
			if $0.bold {
				fontDescriptor = fontDescriptor.fontDescriptorWithSymbolicTraits(.TraitBold)
			}
			if $0.italic {
				fontDescriptor = fontDescriptor.fontDescriptorWithSymbolicTraits(.TraitItalic)
			}

			var attributes = [
				NSFontAttributeName: UIFont(descriptor: fontDescriptor, size: fontDescriptor.pointSize),
				NSLigatureAttributeName: $0.ligature,
				NSKernAttributeName: $0.kerning
			]

			if $0.underline != .None {
				attributes[NSUnderlineStyleAttributeName] = $0.underline.cocoaValue
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
	private var cocoaValue: Int {
		switch self {
		case None:
			return NSUnderlineStyle.StyleNone.rawValue
		case Single:
			return NSUnderlineStyle.StyleSingle.rawValue
		case Thick:
			return NSUnderlineStyle.StyleThick.rawValue
		case Double:
			return NSUnderlineStyle.StyleDouble.rawValue
		case Dotted:
			return NSUnderlineStyle.PatternDot.rawValue
		case Dashed:
			return NSUnderlineStyle.PatternDash.rawValue
		case DashedAndDotted:
			return NSUnderlineStyle.PatternDashDot.rawValue
		case DashedAndDottedTwice:
			return NSUnderlineStyle.PatternDashDotDot.rawValue
		}
	}
}
