//
//  NSPopUpButton+Object.swift
//  ExtraAppKit
//
//  Copyright © 2015 Fleur de Swift. All rights reserved.
//

import Cocoa

public extension NSPopUpButton {
    public func addItemWithTitle(title: String, representedObject: AnyObject) -> NSMenuItem {
        self.addItemWithTitle(title);

        if let item = self.lastItem {
            item.representedObject = representedObject;
            return item;
        }

        assert(false);
    }
}
