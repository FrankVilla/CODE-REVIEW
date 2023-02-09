//
//  QLVPleaseDefineMyClubAlertView.swift
//  Quickline
//
//  Created by Radosław Mariowski on 21/07/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import Foundation

class QLVPleaseDefineMyClubAlertView: NSObject, QLVAlertViewDelegate {
    
    let controller: UIViewController
    let closeCallbackForMyClubSelection: (() -> Void)
    
    var alertView: QLVAlertView?
    
    init(from: UIViewController, closeCallbackForMyClubSelection: @escaping () -> Void = {}) {
        self.controller = from
        self.closeCallbackForMyClubSelection = closeCallbackForMyClubSelection
        
        super.init()
        
        self.alertView = QLVAlertView(style: .pleaseDefineMyClub, title: "Please Define a My Club".localized, message: "To get access to the ice hockey page, please define a MyClub, so that we can provide to all hockey events that fit to your preferences.".localized, delegate: self, cancelButtonTitle: "", otherButtonTitle: "Define My Club".localized, from: from)
    }
    
    func show() {
        self.alertView?.show()
    }
    
    func pressedCancelButton(on alertView: QLVAlertView!) {
        self.alertView!.close()
    }
    
    func pressedOtherButton(on alertView: QLVAlertView!) {
        self.alertView!.close()
        self.openSelectMyClubOverlay()
    }
    
    func pressedCloseButton(on alertView: QLVAlertView!) {
        
    }
    
    private func openSelectMyClubOverlay() {
        let selectMyClubOverlay = QLVSelectMyClubAlertView(from: controller, closeCallback: self.closeCallbackForMyClubSelection)
        selectMyClubOverlay.show()
    }
}
