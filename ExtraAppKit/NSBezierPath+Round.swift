//
//  NSBezierPath+Round.swift
//  DigitalAssetDatabase
//
//  Copyright © 2015 Fleur de Swift. All rights reserved.
//

import Cocoa

public extension NSBezierPath {
    public convenience init(roundedRect rect: NSRect, radius: CGFloat) {
        self.init();
    
        let roundFactor = CGFloat(0.55228);
        let maxPoint    = NSPoint(x: rect.maxX, y: rect.maxY);
        let radiusDelta = NSSize(width: radius * roundFactor, height: radius * roundFactor);
        
        // Top Left
        self.moveToPoint( NSPoint(x: rect.minX + radius,                      y: maxPoint.y));
        self.curveToPoint(NSPoint(x: rect.minX,                               y: maxPoint.y - radius),
            controlPoint1:NSPoint(x: rect.minX + radius - radiusDelta.width,  y: maxPoint.y),
            controlPoint2:NSPoint(x: rect.minX,                               y: maxPoint.y - radius + radiusDelta.height))

        // Bottom Left
        self.lineToPoint( NSPoint(x: rect.minX,                               y: rect.minY + radius));
        self.curveToPoint(NSPoint(x: rect.minX + radius,                      y: rect.minY),
            controlPoint1:NSPoint(x: rect.minX,                               y: rect.minY + radius - radiusDelta.height),
            controlPoint2:NSPoint(x: rect.minX + radius - radiusDelta.width,  y: rect.minY));
 
        // Bottom Right
        self.lineToPoint( NSPoint(x: maxPoint.x - radius,                     y: rect.minY));
        self.curveToPoint(NSPoint(x: maxPoint.x,                              y: rect.minY + radius),
            controlPoint1:NSPoint(x: maxPoint.x - radius + radiusDelta.width, y: rect.minY),
            controlPoint2:NSPoint(x: maxPoint.x,                              y: rect.minY + radius - radiusDelta.height));

        // Top Right
        self.lineToPoint( NSPoint(x: maxPoint.x,                              y: maxPoint.y - radius));
        self.curveToPoint(NSPoint(x: maxPoint.x - radius,                     y: maxPoint.y),
            controlPoint1:NSPoint(x: maxPoint.x,                              y: maxPoint.y - radius + radiusDelta.height),
            controlPoint2:NSPoint(x: maxPoint.x - radius + radiusDelta.width, y: maxPoint.y));
  
        self.closePath();
    }

    public convenience init(roundedLeftRect rect: NSRect, radius: CGFloat) {
        self.init();
    
        let roundFactor = CGFloat(0.55228);
        let maxPoint    = NSPoint(x: rect.maxX, y: rect.maxY);
        let radiusDelta = NSSize(width: radius * roundFactor, height: radius * roundFactor);
        
        self.moveToPoint( NSPoint(x: rect.minX + radius,                      y: maxPoint.y));
        self.curveToPoint(NSPoint(x: rect.minX,                               y: maxPoint.y - radius),
            controlPoint1:NSPoint(x: rect.minX + radius - radiusDelta.width,  y: maxPoint.y),
            controlPoint2:NSPoint(x: rect.minX,                               y: maxPoint.y - radius + radiusDelta.height))

        self.lineToPoint( NSPoint(x: rect.minX,                               y: rect.minY + radius));
        self.curveToPoint(NSPoint(x: rect.minX + radius,                      y: rect.minY),
            controlPoint1:NSPoint(x: rect.minX,                               y: rect.minY + radius - radiusDelta.height),
            controlPoint2:NSPoint(x: rect.minX + radius - radiusDelta.width,  y: rect.minY));
 
        self.lineToPoint( NSPoint(x: maxPoint.x, y: rect.minY));
        self.lineToPoint( NSPoint(x: maxPoint.x, y: maxPoint.y));
        self.closePath();
    }

    public convenience init(roundedRightRect rect: NSRect, radius: CGFloat) {
        self.init();
    
        let roundFactor = CGFloat(0.55228);
        let maxPoint    = NSPoint(x: rect.maxX, y: rect.maxY);
        let radiusDelta = NSSize(width: radius * roundFactor, height: radius * roundFactor);
        
        self.moveToPoint(NSPoint(x: rect.minX, y: maxPoint.y));
        self.lineToPoint(NSPoint(x: rect.minX, y: maxPoint.y));
        self.lineToPoint(NSPoint(x: rect.minX, y: rect.minY));
 
        self.lineToPoint( NSPoint(x: maxPoint.x - radius,                     y: rect.minY));
        self.curveToPoint(NSPoint(x: maxPoint.x,                              y: rect.minY + radius),
            controlPoint1:NSPoint(x: maxPoint.x - radius + radiusDelta.width, y: rect.minY),
            controlPoint2:NSPoint(x: maxPoint.x,                              y: rect.minY + radius - radiusDelta.height));

        self.lineToPoint( NSPoint(x: maxPoint.x,                              y: maxPoint.y - radius));
        self.curveToPoint(NSPoint(x: maxPoint.x - radius,                     y: maxPoint.y),
            controlPoint1:NSPoint(x: maxPoint.x,                              y: maxPoint.y - radius + radiusDelta.height),
            controlPoint2:NSPoint(x: maxPoint.x - radius + radiusDelta.width, y: maxPoint.y));
  
        self.closePath();
    }
}
