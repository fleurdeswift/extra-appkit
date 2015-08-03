//
//  NSViewController+Inject.swift
//  ExtraAppKit
//
//  Copyright © 2015 Fleur de Swift. All rights reserved.
//

import Cocoa

public extension NSViewController {
    public func injectNib(nibName: String) -> NSArray? {
        return self.injectNib(nibName, nibBundle: self.nibBundle);
    }
    
    public func injectNib(nibName: String, nibBundle: NSBundle?) -> NSArray? {
        if let nib = NSNib(nibNamed: nibName, bundle:nibBundle) {
            var topLevels: NSArray?;

            nib.instantiateWithOwner(self, topLevelObjects: &topLevels);
            
            if let topLevels = topLevels {
                for item in topLevels {
                    if let view = item as? NSView {
                        self.view = view;
                    }
                }
            }
            
            return topLevels;
        }
        
        return nil;
    }
}
