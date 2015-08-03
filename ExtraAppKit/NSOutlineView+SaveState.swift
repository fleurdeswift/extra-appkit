//
//  NSOutlineView+SaveState.swift
//  ExtraAppKit
//
//  Copyright © 2015 Fleur de Swift. All rights reserved.
//

import Cocoa

public struct OutlineViewState {
    public var scrollState:    [String: AnyObject];
    public var selectionState: NSSet;
    public var expansionState: [AnyObject];
    
    public init(scrollState: [String: AnyObject], selectionState: NSSet, expansionState: [AnyObject]) {
        self.scrollState    = scrollState;
        self.selectionState = selectionState;
        self.expansionState = expansionState;
    }
}

public extension NSOutlineView {
    public var scrollState: [String: AnyObject] {
        get {
            if let scrollView = self.enclosingScrollView {
                return [
                    "VisibleRect": NSValue(rect: scrollView.documentVisibleRect)
                ];
            }
            else {
                return [String: AnyObject]();
            }
        }
        
        set {
            if let value = newValue["VisibleRect"] as? NSValue {
                self.scrollPoint(value.rectValue.origin);
            }
        }
    }
    
    public var selectionState: NSSet {
        get {
            let selectedItems = NSMutableSet();
            let numberOfRows = self.numberOfRows;
            
            for (var row = 0; row < numberOfRows; row++) {
                if isRowSelected(row) {
                    selectedItems.addObject(itemAtRow(row)!);
                }
            }
            
            return NSSet(set: selectedItems);
        }
        
        set {
            let indexes = NSMutableIndexSet();
            
            for wanted in newValue {
                let index = rowForItem(wanted);

                if index < 0 {
                    continue;
                }
                
                indexes.addIndex(index);
            }
            
            selectRowIndexes(indexes, byExtendingSelection: false);
        }
    }
    
    public var expansionState: [AnyObject] {
        get {
            var expandedItems = [AnyObject]();
            let numberOfRows  = self.numberOfRows;
            
            for (var row = 0; row < numberOfRows; row++) {
                let item = itemAtRow(row);

                if isItemExpanded(item) {
                    expandedItems.append(item!);
                }
            }
            
            return expandedItems;
        }
        
        set {
            self.collapseItem(nil, collapseChildren: true)
        
            for wanted in newValue {
                self.expandItem(wanted)
            }
        }
    }
    
    public var state: OutlineViewState {
        get {
            return OutlineViewState(
                scrollState:    self.scrollState,
                selectionState: self.selectionState,
                expansionState: self.expansionState);
        }
        
        set {
            self.expansionState = newValue.expansionState;
            self.selectionState = newValue.selectionState;
            self.scrollState    = newValue.scrollState;
        }
    }
}

