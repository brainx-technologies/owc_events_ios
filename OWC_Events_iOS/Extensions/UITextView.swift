//
//  UITextView.swift
//  Animations
//
//  Created by BrainX 3096 on 14/06/2021.
//

import UIKit

public extension UITextView {
    /**
     Calls provided `test` block if point is in gliph range and there is no link detected at this point.
     Will pass in to `test` a character index that corresponds to `point`.
     Return `self` in `test` if text view should intercept the touch event or `nil` otherwise.
     */
    func hitTest(pointInGliphRange aPoint: CGPoint, event: UIEvent?, test: (Int) -> UIView?) -> UIView? {
        guard let charIndex = charIndexForPointInGlyphRect(point: aPoint) else {
            return super.hitTest(aPoint, with: event)
        }
        guard textStorage.attribute(NSAttributedString.Key.link, at: charIndex, effectiveRange: nil) == nil else {
            return super.hitTest(aPoint, with: event)
        }
        return test(charIndex)
    }

    /**
     Returns true if point is in text bounding rect adjusted with padding.
     Bounding rect will be enlarged with positive padding values and decreased with negative values.
     */
    func pointIsInTextRange(point aPoint: CGPoint, range: NSRange, padding: UIEdgeInsets) -> Bool {
        var boundingRect = layoutManager.boundingRectForCharacterRange(range: range, inTextContainer: textContainer)
        boundingRect = boundingRect.offsetBy(dx: textContainerInset.left, dy: textContainerInset.top)
        boundingRect = boundingRect.insetBy(dx: -(padding.left + padding.right), dy: -(padding.top + padding.bottom))
        return boundingRect.contains(aPoint)
    }

    /**
     Returns index of character for glyph at provided point. Returns `nil` if point is out of any glyph.
     */
    func charIndexForPointInGlyphRect(point aPoint: CGPoint) -> Int? {
        let point = CGPoint(x: aPoint.x, y: aPoint.y - textContainerInset.top)
        let glyphIndex = layoutManager.glyphIndex(for: point, in: textContainer)
        let glyphRect = layoutManager.boundingRect(forGlyphRange: NSMakeRange(glyphIndex, 1), in: textContainer)
        if glyphRect.contains(point) {
            return layoutManager.characterIndexForGlyph(at: glyphIndex)
        } else {
            return nil
        }
    }
}

public extension NSLayoutManager {
    /**
     Returns characters range that completely fits into container.
     */
    func characterRangeThatFits(textContainer container: NSTextContainer) -> NSRange {
        var rangeThatFits = glyphRange(for: container)
        rangeThatFits = characterRange(forGlyphRange: rangeThatFits, actualGlyphRange: nil)
        return rangeThatFits
    }

    /**
     Returns bounding rect in provided container for characters in provided range.
     */
    func boundingRectForCharacterRange(range aRange: NSRange, inTextContainer container: NSTextContainer) -> CGRect {
        let glyphRange = self.glyphRange(forCharacterRange: aRange, actualCharacterRange: nil)
        let boundingRect = self.boundingRect(forGlyphRange: glyphRange, in: container)
        return boundingRect
    }
}
