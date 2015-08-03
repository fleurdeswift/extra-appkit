//
//  FilterableOutlineView.swift
//  ExtraAppKit
//
//  Copyright © 2015 Fleur de Swift. All rights reserved.
//

import Cocoa

public typealias PredicateBlockType = (object: AnyObject) -> Bool;

@objc
public protocol FilterablePredicateGenerator {
    func generatePredicateFromString(string: String?) -> PredicateBlockType?;
}

public class FilterableOutlineView : NSOutlineView {
    private var filterDataSource: FilterableDataSource?;
    private var prefilterState:   OutlineViewState?;
    
    public override func reloadData() {
        if let filterDataSource = self.filterDataSource {
            filterDataSource.reloadData(self)
        }
        
        super.reloadData()
    }
    
    public override func setDataSource(dataSource: NSOutlineViewDataSource?) {
        if let dataSource = dataSource {
            filterDataSource = FilterableDataSource(dataSource: dataSource);
            filterDataSource!.setFilterPredicate(_filterPredicate, outlineView: self)
        }
        else {
            filterDataSource = nil;
        }
        
        super.setDataSource(filterDataSource)
    }

    private var _filterPredicate: PredicateBlockType?;

    public var filterPredicate: PredicateBlockType? {
        get {
            return _filterPredicate;
        }
        
        set {
            if _filterPredicate == nil {
                prefilterState = self.state;
            }
            
            _filterPredicate = newValue;
            
            if let dataSource = filterDataSource {
                dataSource.setFilterPredicate(newValue, outlineView: self);
            }
            
            super.reloadData();
            
            if newValue != nil {
                self.expandItem(nil, expandChildren: true);
                
                if let state = prefilterState {
                    self.selectionState = state.selectionState;
                }
            }
            else if let state = prefilterState {
                self.state = state;
                prefilterState = nil;
            }
        }
    }
    
    @IBOutlet
    public weak var predicateGenerator: FilterablePredicateGenerator?;
    
    @IBAction
    public func setSearchString(sender: AnyObject?) {
        if let field = sender as? NSControl {
            self.filterPredicate = predicateGenerator?.generatePredicateFromString(field.stringValue);
        }
        else {
            self.filterPredicate = nil;
        }
    }
    
    @objc
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        if predicateGenerator == nil {
            predicateGenerator = filterDataSource?.dataSource as? FilterablePredicateGenerator;
        }
    }
}
