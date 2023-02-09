//
//  MovieFilterViewModel.swift
//  Quickline
//
//  Created by Kristaps Freibergs on 17/07/2018.
//  Copyright © 2018 Ambrite Latvia. All rights reserved.
//

import Foundation

class MovieFilterViewModel: FilterViewModel {


    private var languageFilterItems : [FilterItem]
    
    @objc init(currLangCode: String, selectedGenreItems: [String]) {
        languageFilterItems = FilterUtility.languageFilterItem(langCode: currLangCode)
        super.init(options: [kMovieGenreFilterItems, languageFilterItems])
        if (selectedGenreItems.count > 0) {
            var genreArr = completeOptions[0]
            for i in genreArr.indices {
                if Set(selectedGenreItems).isSubset(of:Set(genreArr[i].id)) {
                    genreArr[0].isSelected = false;
                    genreArr[i].isSelected = true;
                }
            }
            completeOptions[0] = genreArr;
        }
    }
    
    override func titles() -> [String] {
        return [title(arrIdx: 0, format: "Filter_Header_Genres"),
                title(arrIdx: 1, format: "Filter_Header_Languages")]
    }
    
    override func items() -> [[FilterItem]] {
        return completeOptions
    }
    
    override func isMultiSelect() -> [Bool] {
        return [true, true]
    }
    
    override func selectAllIdx() -> [Int] {
        return [0, 0]
    }
    
    
}
