//
//  MosaicViewModel.swift
//  Quickline
//
//  Created by Kristaps Freibergs on 11/12/2018.
//  Copyright © 2018 Ambrite Latvia. All rights reserved.
//

import Foundation


class MosaicViewModel: BaseViewModel {
    
    var foceExitVC : (() -> Void)?
    var startLoadingUI : (() -> Void)?
    var finishedLoadingItems : (() -> Void)?
    var handleContentMetadataError : ((_ error : Error) -> Void)?
    var shouldUpdateTitle: (() -> Void)?
    var changedEditMode: ((_ editMode: Bool) -> Void)?
    @objc var selectedItem : ((_ item: QLVMedia) -> Void)?
    
    
    func title() -> String {
        fatalError("Child class should overwrite this!")
    }
    
    func subtitle() -> String {
        fatalError("Child class should overwrite this!")
    }
    
    func reloadDataOnEnteringScreen() -> Bool {
        return false
    }
    
    func reloadData() {
        fatalError("Child class should overwrite this!")
    }
    
    // Collection view
    
    func supportsMultiSelect() -> Bool {
        return false
    }

    func numOfSections() -> NSInteger {
        fatalError("Child class should overwrite this!")
    }
    
    func numOfItemsInSection(_ section: NSInteger) -> NSInteger {
        fatalError("Child class should overwrite this!")
    }
    
    func itemForIndexPath(_ indexPath: IndexPath) -> QLVMedia {
        fatalError("Child class should overwrite this!")
    }
    
    func selectedItemAtIndexPath(_ indexPath: IndexPath) {
        if selectedItem != nil {
            selectedItem!(itemForIndexPath(indexPath))
        }
    }
    
    func isItemAtIndexPathSelected(_ indexPath: IndexPath) -> Bool {
        return false
    }
    
}
