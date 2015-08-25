//
//  NSURL.swift
//  ExtraAppKit
//
//  Copyright © 2015 Fleur de Swift. All rights reserved.
//

import Foundation

public extension NSURL {
    public func URLByChangingPathExtension(newExtension: String) -> NSURL? {
        return self.URLByDeletingPathExtension?.URLByAppendingPathExtension(newExtension);
    }
    
    public func lastPathComponent(newExtension newExtension: String) -> String? {
        return self.URLByDeletingPathExtension?.URLByAppendingPathExtension(newExtension).lastPathComponent;
    }
}
