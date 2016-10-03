import CoreText
import Foundation

internal extension String {
	internal func cocoaValue(_ effects: [TextEffect]) -> NSAttributedString {
		let result = NSMutableAttributedString(string: self)
		effects.forEach({
			var fontDescriptor = CTFontDescriptorCreateWithNameAndSize($0.font.name as CFString, CGFloat($0.font.size))
			if $0.bold {
				var attribute: Int = 0
				if let copiedAttribute = CTFontDescriptorCopyAttribute(fontDescriptor, kCTFontSymbolicTrait) {
					attribute = copiedAttribute as! Int
				}

				fontDescriptor = CTFontDescriptorCreateCopyWithAttributes(fontDescriptor, [
					String(kCTFontSymbolicTrait): Int(attribute | Int(CTFontSymbolicTraits.boldTrait.rawValue)) as AnyObject
				] as CFDictionary)
			}

			if $0.italic {
				var attribute: Int = 0
				if let copiedAttribute = CTFontDescriptorCopyAttribute(fontDescriptor, kCTFontSymbolicTrait) {
					attribute = copiedAttribute as! Int
				}

				fontDescriptor = CTFontDescriptorCreateCopyWithAttributes(fontDescriptor, [
					String(kCTFontSymbolicTrait): Int(attribute | Int(CTFontSymbolicTraits.italicTrait.rawValue)) as AnyObject
				] as CFDictionary)
			}

			var attributes: [String: AnyObject] = [
				String(kCTFontAttributeName): CTFontCreateWithFontDescriptor(fontDescriptor, CGFloat($0.font.size), nil),
				String(kCTLigatureAttributeName): $0.ligature as AnyObject,
				String(kCTKernAttributeName): $0.kerning as AnyObject
			]

			if $0.underline != .none {
				attributes[String(kCTUnderlineStyleAttributeName)] = Int($0.underline.coreTextView) as AnyObject?
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

	// todo: extend `Range` instead?
	fileprivate func toNSRange(_ range: Range<String.Index>) -> NSRange {
		let start = characters.distance(from: startIndex, to: range.lowerBound)
		let length = distance(from: range.lowerBound, to: range.upperBound)
		return NSMakeRange(start, length)
	}
}

// MARK: -

/*
private extension Aura {
	private var cocoaValue: NSShadow {
		let shadow = NSShadow()
		shadow.shadowOffset = CGSize(width: offset.width, height: offset.height)
		shadow.shadowColor = color.cocoaValue
		shadow.shadowBlurRadius = CGFloat(blur)
		return shadow
	}
}

private extension Color {
	#if os(iOS)
	private var cocoaValue: UIColor {
		let rgb = RGBView
		return UIColor(red: CGFloat(rgb.red), green: CGFloat(rgb.green), blue: CGFloat(rgb.blue), alpha: CGFloat(AView))
	}
	#elseif os(OSX)
	private var cocoaValue: NSColor {
		let rgb = RGBView
		return NSColor(red: CGFloat(rgb.red), green: CGFloat(rgb.green), blue: CGFloat(rgb.blue), alpha: CGFloat(AView))
	}
	#endif
}
*/

private extension LinePattern {
	var coreTextView: Int32 {
		switch self {
		case .none:
			return CTUnderlineStyle().rawValue
		case .single:
			return CTUnderlineStyle.single.rawValue
		case .thick:
			return CTUnderlineStyle.thick.rawValue
		case .double:
			return CTUnderlineStyle.double.rawValue
		case .dotted:
			return CTUnderlineStyle.single.rawValue | CTUnderlineStyleModifiers.patternDot.rawValue
		case .dashed:
			return CTUnderlineStyle.single.rawValue | CTUnderlineStyleModifiers.patternDash.rawValue
		case .dashedAndDotted:
			return CTUnderlineStyle.single.rawValue | CTUnderlineStyleModifiers.patternDashDot.rawValue
		case .dashedAndDottedTwice:
			return CTUnderlineStyle.single.rawValue | CTUnderlineStyleModifiers.patternDashDotDot.rawValue
		}
	}
}
