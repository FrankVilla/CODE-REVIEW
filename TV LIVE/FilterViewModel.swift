//
//  FilterViewModel.swift
//  Quickline
//
//  Created by Kristaps Freibergs on 17/07/2018.
//  Copyright © 2018 Ambrite Latvia. All rights reserved.
//

import Foundation

class FilterViewModel: BaseViewModel {
    
    @objc var filterUpdated : ((_ selectedItems: [[String]]) -> Void)?
    var deselectItems : ((_ arrIdx: Int, _ items: [Int]) -> Void)?
    var selectItems : ((_ arrIdx: Int, _ items: [Int]) -> Void)?
    
    internal var completeOptions : [[FilterItem]]
    
    @available(*, unavailable)
    override init() {
        fatalError("Use apropriate init")
    }
    
    init(options: [[FilterItem]]) {
        completeOptions = options
        super.init()
    }
    
    func titles() -> [String] {
        fatalError("Child class should overwrite this!")
    }
    
    func items() -> [[FilterItem]] {
        fatalError("Child class should overwrite this!")
    }
    
    func isMultiSelect() -> [Bool] {
        fatalError("Child class should overwrite this!")
    }
    
    func selectAllIdx() -> [Int] {
        fatalError("Child class should overwrite this!")
    }
    
    func selectedItem(arrIdx: Int, index: Int) {
        let allIdx = selectAllIdx()[arrIdx]
        var filterArr = completeOptions[arrIdx]
        
        if (allIdx == index){
            let indexes = filterArr.filter{$0.isSelected}.map { (item) -> Int in
                return filterArr.firstIndex(where: { (aItem) -> Bool in
                    aItem.title == item.title
                })!
            }
            for i in filterArr.indices {
                filterArr[i].isSelected = false
            }
            filterArr[index].isSelected = true
            if (deselectItems != nil && indexes.count != 0){
                deselectItems!(arrIdx, indexes)
            }
        } else {
            filterArr[index].isSelected = true
            if (filterArr[allIdx].isSelected){
                filterArr[allIdx].isSelected = false
                if (deselectItems != nil){
                    deselectItems!(arrIdx, [allIdx])
                }
            }
        }
        
        completeOptions[arrIdx] = filterArr
        
        if (filterUpdated != nil){
            filterUpdated!(selectedItems())
        }
    }
    
    func deselectedItem(arrIdx: Int, index: Int){
        
        let allIdx = selectAllIdx()[arrIdx]
        
        if (allIdx == index){
            // can't deselect all
            if (selectItems != nil){
                selectItems!(arrIdx, [allIdx])
            }
            return
        } else {
            var filterArr = completeOptions[arrIdx]
            let selections = selectionsInArr(array: filterArr)
            if (!selections.contains(index)){
                fatalError("Something got messed up, selection missing")
            }
            filterArr[index].isSelected = false
            completeOptions[arrIdx] = filterArr
            if (selections.count == 1) {
                selectedItem(arrIdx: arrIdx, index: allIdx)
                if (selectItems != nil){
                    selectItems!(arrIdx, [allIdx])
                }
                return
            } else {
                filterArr[index].isSelected = false
            }
        }
        
        if (filterUpdated != nil){
            filterUpdated!(selectedItems())
        }
    }
    
    private func selectedItems() -> [[String]] {
        var arr : [[String]] = []
        for aArr in completeOptions {
            arr.append(selectedFiltersInArr(array: aArr))
        }
        return arr
    }
    
    internal func selectedFiltersInArr(array:[FilterItem]) -> [String] {
        return array.filter{$0.isSelected}.map{$0.id}.flatMap{$0}
    }
    
    internal func selectionsInArr(array: [FilterItem]) ->[Int]{
        return array.filter{$0.isSelected}.map { (item) in
            array.firstIndex(where: {$0.title == item.title})!
        }
    }
    
    internal func title(arrIdx: Int, format: String) -> String {
        let selections = selectionsInArr(array: completeOptions[arrIdx])
        
        if (selections.count > 1){
            return String(format: format.localized, "Filter_Selection_Multiple".localized)
        } else {
            let title = completeOptions[arrIdx][selections.first!].title
            return String(format: format.localized, title)
        }
    }

    
}
