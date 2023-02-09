//
//  IntrinsicTableView.swift
//  Quickline
//
//  Created by Kristaps Freibergs on 23/07/2018.
//  Copyright © 2018 Ambrite Latvia. All rights reserved.
//

import UIKit

class IntrinsicTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    var insetHeight: CGFloat = 0
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        var realContentHeight = contentSize.height
        if realContentHeight != 0 { realContentHeight += insetHeight }
        let height = min(realContentHeight, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}

