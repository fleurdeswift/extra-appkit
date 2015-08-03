//
//  OutlineViewDataSourceProxy.swift
//  ExtraAppKit
//
//  Copyright © 2015 Fleur de Swift. All rights reserved.
//

import Cocoa

public class OutlineViewDataSourceProxy : NSObject, NSOutlineViewDataSource {
    public let dataSource: NSOutlineViewDataSource;
    
    public init(dataSource: NSOutlineViewDataSource) {
        self.dataSource = dataSource;
    }

    public func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if let result = dataSource.outlineView?(outlineView, numberOfChildrenOfItem: item) {
            return result;
        }
        else {
            return 0;
        }
    }
    
    public func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if let result = dataSource.outlineView?(outlineView, child: index, ofItem: item) {
            return result;
        }
        else {
            return "<nil>";
        }
    }

    public func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        if let result = dataSource.outlineView?(outlineView, isItemExpandable: item) {
            return result;
        }
        else {
            return false;
        }
    }
    
    public func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
        return dataSource.outlineView?(outlineView, objectValueForTableColumn: tableColumn, byItem: item);
    }
    
    public func outlineView(outlineView: NSOutlineView, setObjectValue object: AnyObject?, forTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) {
        dataSource.outlineView?(outlineView, setObjectValue: object, forTableColumn: tableColumn, byItem: item);
    }
    
    public func outlineView(outlineView: NSOutlineView, itemForPersistentObject object: AnyObject) -> AnyObject? {
        return dataSource.outlineView?(outlineView, itemForPersistentObject: object);
    }
    
    public func outlineView(outlineView: NSOutlineView, persistentObjectForItem item: AnyObject?) -> AnyObject? {
        return dataSource.outlineView?(outlineView, persistentObjectForItem: item);
    }
    
    public func outlineView(outlineView: NSOutlineView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
        dataSource.outlineView?(outlineView, sortDescriptorsDidChange: oldDescriptors);
    }
    
    public func outlineView(outlineView: NSOutlineView, pasteboardWriterForItem item: AnyObject) -> NSPasteboardWriting? {
        return dataSource.outlineView?(outlineView, pasteboardWriterForItem: item);
    }
    
    public func outlineView(outlineView: NSOutlineView, draggingSession session: NSDraggingSession, willBeginAtPoint screenPoint: NSPoint, forItems draggedItems: [AnyObject]) {
        dataSource.outlineView?(outlineView, draggingSession: session, willBeginAtPoint: screenPoint, forItems: draggedItems);
    }
    
    public func outlineView(outlineView: NSOutlineView, draggingSession session: NSDraggingSession, endedAtPoint screenPoint: NSPoint, operation: NSDragOperation) {
        dataSource.outlineView?(outlineView, draggingSession: session, endedAtPoint: screenPoint, operation: operation);
    }
    
    public func outlineView(outlineView: NSOutlineView, writeItems items: [AnyObject], toPasteboard pasteboard: NSPasteboard) -> Bool {
        if let result = dataSource.outlineView?(outlineView, writeItems: items, toPasteboard: pasteboard) {
            return result;
        }
        else {
            return false;
        }
    }
    
    public func outlineView(outlineView: NSOutlineView, updateDraggingItemsForDrag draggingInfo: NSDraggingInfo) {
        dataSource.outlineView?(outlineView, updateDraggingItemsForDrag: draggingInfo);
    }
    
    public func outlineView(outlineView: NSOutlineView, validateDrop info: NSDraggingInfo, proposedItem item: AnyObject?, proposedChildIndex index: Int) -> NSDragOperation {
        if let result = dataSource.outlineView?(outlineView, validateDrop: info, proposedItem: item, proposedChildIndex: index) {
            return result;
        }
        else {
            return NSDragOperation.None;
        }
    }
    
    public func outlineView(outlineView: NSOutlineView, acceptDrop info: NSDraggingInfo, item: AnyObject?, childIndex index: Int) -> Bool {
        if let result = dataSource.outlineView?(outlineView, acceptDrop: info, item: item, childIndex: index) {
            return result;
        }
        else {
            return false;
        }
    }
    
    public func outlineView(outlineView: NSOutlineView, namesOfPromisedFilesDroppedAtDestination dropDestination: NSURL, forDraggedItems items: [AnyObject]) -> [String] {
        if let result = dataSource.outlineView?(outlineView, namesOfPromisedFilesDroppedAtDestination: dropDestination, forDraggedItems: items) {
            return result;
        }
        else {
            return [];
        }
    }
}
