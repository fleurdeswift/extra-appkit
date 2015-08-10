//
//  NSRange.swift
//  ExtraAppKit
//
//  Copyright © 2015 Fleur de Swift. All rights reserved.
//

import Foundation

public extension NSRange {
    public init(location: CGFloat, length: CGFloat) {
        let ix1   = Int(floor(location));
        let ix2   = Int(ceil(location + length));
        self.init(location: ix1, length: ix2 - ix1);
    }

    public init(start: CGFloat, end: CGFloat) {
        let ix1   = Int(floor(start));
        let ix2   = Int(ceil(end));
        self.init(location: ix1, length: ix2 - ix1);
    }

    public func intersects(range2: NSRange) -> Bool {
        return (self.location < range2.location + range2.length && range2.location < self.location + self.length);
    }
    
    public var end: NSInteger {
        get {
            return self.location + self.length;
        }
    }
}
