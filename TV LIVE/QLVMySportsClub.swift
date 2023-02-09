//
//  QLVMySportsClub.swift
//  Quickline
//
//  Created by Radosław Mariowski on 21/07/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import Foundation

@objc class QLVMySportsClub: NSObject {
    
    @objc var id = ""
    @objc var code = ""
    @objc var name = ""
    @objc var imageUrl: URL?
    
    @objc override init() {
        super.init()
    }
    
    @objc init(code: String) {
        self.code = code
        
        super.init()
    }
    
    @objc init(name: String, imageUrl: URL?) {
        self.name = name
        self.imageUrl = imageUrl
        
        super.init()
    }
}
