//
//  FilterableDataSource.swift
//  ExtraAppKit
//
//  Copyright © 2015 Fleur de Swift. All rights reserved.
//

import Cocoa

public class FilterableDataSource : OutlineViewDataSourceProxy {
    private let queue      = dispatch_queue_create("FilterableDataSource",     DISPATCH_QUEUE_CONCURRENT);
    private let queueMap   = dispatch_queue_create("FilterableDataSource.Map", DISPATCH_QUEUE_SERIAL);
    private let loadGroup  = dispatch_group_create();
    private var generation = UInt(0);
    private let root       = NSNull();
    
    public typealias PredicateBlockType = (object: AnyObject) -> Bool;
    
    private var filtered: NSMapTable?;
    
    public override init(dataSource: NSOutlineViewDataSource) {
        super.init(dataSource: dataSource);
    }

    private(set) public var filterPredicate: PredicateBlockType?
    
    public override func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if filterPredicate == nil {
            return super.outlineView(outlineView, numberOfChildrenOfItem: item)
        }
        
        var ritem: AnyObject;
    
        if let item = item {
            ritem = item;
        }
        else {
            ritem = root;
        }
        
        dispatch_group_wait(loadGroup, DISPATCH_TIME_FOREVER);
        
        if let a = filtered?.objectForKey(ritem) as? NSArray {
            return a.count;
        }
        
        return 0;
    }

    public override func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if filterPredicate == nil {
            return super.outlineView(outlineView, child: index, ofItem: item)
        }
        
        var ritem: AnyObject;
    
        if let item = item {
            ritem = item;
        }
        else {
            ritem = root;
        }
        
        dispatch_group_wait(loadGroup, DISPATCH_TIME_FOREVER);

        if let a = filtered?.objectForKey(ritem) as? NSArray {
            return a[index];
        }
        
        return Int();
    }
    
    public override func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        if filterPredicate == nil {
            return super.outlineView(outlineView, isItemExpandable: item)
        }
        
        dispatch_group_wait(loadGroup, DISPATCH_TIME_FOREVER);

        if let a = filtered?.objectForKey(item) as? NSArray {
            return a.count > 0;
        }
        
        return false;
    }

    public func loadDataForItem(
            outlineView:     NSOutlineView,
            item:            AnyObject?,
            table:           NSMapTable,
            container array: NSMutableArray,
            generation:      UInt,
            predicate:       PredicateBlockType,
            parentGroup:     dispatch_group_t) {
        dispatch_group_enter(parentGroup);
        dispatch_async(queue) {
            if (generation != self.generation) {
                dispatch_group_leave(parentGroup);
                return;
            }

            let count = super.outlineView(outlineView, numberOfChildrenOfItem: item);
            if count == 0 {
                if let item = item {
                    if !predicate(object: item) {
                        dispatch_async(self.queueMap) {
                            array.removeObject(item);
                            dispatch_group_leave(parentGroup);
                        }
                        
                        return;
                    }
                }
                
                dispatch_group_leave(parentGroup);
                return;
            }

            let childGroup = dispatch_group_create();
            let childArray = NSMutableArray();
            var hasSpinned = false;

            for (var index = 0; index < count; ++index) {
                let child      = super.outlineView(outlineView, child: index, ofItem: item);
                let expandable = super.outlineView(outlineView, isItemExpandable: child);

                if expandable {
                    if hasSpinned {
                        dispatch_async(self.queueMap) {
                            childArray.addObject(child);
                        }
                    }
                    else {
                        childArray.addObject(child);
                    }

                    hasSpinned = true;
                    self.loadDataForItem(outlineView,
                                     item: child,
                                    table: table,
                                container: childArray,
                               generation: generation,
                                predicate: predicate,
                              parentGroup: childGroup);
                }
                else {
                    if predicate(object: child) {
                        if hasSpinned {
                            dispatch_async(self.queueMap) {
                                childArray.addObject(child);
                            }
                        }
                        else {
                            childArray.addObject(child);
                        }
                    }
                }
            }

            dispatch_group_notify(childGroup, self.queueMap) {
                if let item = item {
                    if (childArray.count == 0) {
                        if !predicate(object: item) {
                            array.removeObject(item);
                        }
                    }
                    else {
                        table.setObject(childArray, forKey:item);
                    }
                }
                else {
                    table.setObject(childArray, forKey: self.root);
                }
                    
                dispatch_group_leave(parentGroup);
            };
        }
    }

    public func reloadData(outlineView: NSOutlineView) {
        if let predicate = filterPredicate {
            self.generation++;

            let f = NSMapTable(keyOptions: NSMapTableStrongMemory, valueOptions: NSMapTableStrongMemory, capacity: 0);

            dispatch_async(queueMap) {
                self.filtered = f;
            }

            loadDataForItem(outlineView,
                             item: nil,
                            table: f,
                        container: NSMutableArray(),
                       generation: generation,
                        predicate: predicate,
                      parentGroup: loadGroup);
        }
    }
    
    public func setFilterPredicate(predicate: PredicateBlockType?, outlineView: NSOutlineView) {
        self.filterPredicate = predicate;
        reloadData(outlineView);
    }
}
