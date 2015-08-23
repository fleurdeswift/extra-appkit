//
//  ScrollableView.swift
//  CodeEditorView
//
//  Copyright © 2015 Fleur de Swift. All rights reserved.
//

import Cocoa

/// This class make sure that it always uses all the possible space inside it's
/// NSClipView container.
public class ScrollableView : NSView {
    private var lastReportedIntrinsicContentSize = NSSize(width: -1, height: -1);

    public var contentSize: CGSize {
        get {
            return NSSize(width: 0, height: 0);
        }
    }
    
    public var clipBounds: CGSize {
        get {
            if let clipView = self.superview as? NSClipView {
                return clipView.bounds.size;
            }
            else {
                return self.bounds.size;
            }
        }
    }

    public func invalidateContentSize() {
        if hasIntrinsicContentSizeChanged() {
            invalidateIntrinsicContentSize();
        }
    }

    private final func setupScrollView() {
        if let clipView = self.superview as? NSClipView {
            clipView.postsBoundsChangedNotifications = true;
            clipView.postsFrameChangedNotifications = true;
            
            let center = NSNotificationCenter.defaultCenter();
            
            center.removeObserver(self, name: NSViewBoundsDidChangeNotification, object: nil);
            center.removeObserver(self, name: NSViewFrameDidChangeNotification,  object: nil);
            center.addObserver(self, selector: Selector("clipViewBoundDidChange:"), name: NSViewBoundsDidChangeNotification, object: clipView);
            center.addObserver(self, selector: Selector("clipViewFrameDidChange:"), name: NSViewFrameDidChangeNotification,  object: clipView);
        }
    }

    private final func hasIntrinsicContentSizeChanged() -> Bool {
        let calculatedSize = calculateIntrinsicContentSize();
    
        if abs(lastReportedIntrinsicContentSize.width  - calculatedSize.width)  > 0.9 ||
           abs(lastReportedIntrinsicContentSize.height - calculatedSize.height) > 0.9 {
           return true;
        }
        
        return false;
    }

    @objc
    private final func clipViewFrameDidChange(notification: NSNotification) -> Void {
        frameDidChange();
        invalidateContentSize();
    }

    @objc
    private final func clipViewBoundDidChange(notification: NSNotification) -> Void {
        boundsDidChange();
    }
    
    public func frameDidChange() {
    }
    
    public func boundsDidChange() {
    }
    
    private final func calculateIntrinsicContentSize() -> NSSize {
        if let clipView = self.superview as? NSClipView {
            let contentSize = self.contentSize;
            let clipBounds  = clipView.bounds;
            
            return  NSSize(width:  max(contentSize.width,  clipBounds.size.width),
                           height: max(contentSize.height, clipBounds.size.height));
        }
        else {
            return self.contentSize;
        }
    }
    
    @objc
    public final override var intrinsicContentSize: NSSize {
        get {
            lastReportedIntrinsicContentSize = calculateIntrinsicContentSize();
            return lastReportedIntrinsicContentSize;
        }
    }

    public override func viewDidMoveToSuperview() {
        setupScrollView();
    }
}