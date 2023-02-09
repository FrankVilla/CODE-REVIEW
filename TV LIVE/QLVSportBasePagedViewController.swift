//
//  QLVSportBasePagedViewController.swift
//  Quickline
//
//  Created by Radosław Mariowski on 29/08/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import UIKit

enum QLVSportPageType: Int {
    case landing = 0
    case iceHockey = 1
    case league = 2
}

@objc class QLVSportBasePagedViewController: QLVBaseViewController {
    
    var tabView: UIView?
    var eventButton: UIButton?
    var controllerScrollView: UIScrollView?
    var pagesTableView: UITableView?
    var pagesDataSource: QLVSportPagesDataSource?
    var selectedPage: QLVNavigationItem?
    var initialySelectedIndexPath: IndexPath?
    var pagesTableViewMargin: CGFloat = 0
    var pagesTableMenuOpened = false
    
    func viewDidLoad(title: String, controllerScrollView: UIScrollView?, pagesTableView: UITableView, pagesTableViewMargin: CGFloat = 0) {
        super.viewDidLoad(title: title)
        
        if self.initialySelectedIndexPath == nil {
            self.initialySelectedIndexPath = IndexPath(row: 0, section: 0)
        }
        
        self.controllerScrollView = controllerScrollView
        self.pagesTableView = pagesTableView
        self.pagesDataSource = QLVSportPagesDataSource(self)
        self.pagesDataSource?.initialySelectedIndexPath = self.initialySelectedIndexPath
        self.pagesTableViewMargin = pagesTableViewMargin
        
        QLVMySportsDataProvider.shared.loadNavigation(for: QLVCustomer.sharedInstance().currentProfile, successHandler: { (navigation) in
            if let navigation = navigation {
                self.pagesDataSource!.sportPages = navigation
            }
            
        }) { (error) in
            print(error ?? "")
        }
    }
    
    func sportPageSelected(sportPageIndex: IndexPath, sportPage: QLVNavigationItem?) {
        if UIDevice.isPad() {
            self.moveViewTo(positionX: self.pagesTableView!.frame.origin.x + self.pagesTableView!.frame.size.width + self.pagesTableViewMargin , animated: true)
        } else {
            self.navigationItem.leftBarButtonItem!.isEnabled = true
            self.pagesTableView?.isHidden = true
            self.controllerScrollView?.isHidden = true
            self.controllerScrollView?.setContentOffset(CGPoint.zero, animated: true)
            self.activityIndicator?.isHidden = true
        }
        
        if self.initialySelectedIndexPath != sportPageIndex {
            let type = sportPageIndex.section == 0 ? QLVSportPageType(rawValue: sportPageIndex.row) : .league
            
            switch type! {
            case .iceHockey:
                self.iceHockeyPageSelected()
                
            case .landing:
                self.landingPageSelected()
                
            case .league:
                if let sportPage = sportPage {
                    self.leaguePageSelected(page: sportPage)
                }
            }
        } else {
            self.sportPages(sender: nil)
        }
    }
    
    func landingPageSelected() {
        self.performSegue(withIdentifier: "landing", sender: self)
    }
    
    func iceHockeyPageSelected() {
        self.showMyClub()
    }
    
    func showMyClub() {
        if QLVCustomer.sharedInstance().currentProfile!.isMyClubDefined() {
            self.performSegue(withIdentifier: "myClub", sender: self)
        } else {
            self.openPleaseDefineMyClubOverlay()
        }
    }
    
    private func openPleaseDefineMyClubOverlay() {
        let pleaseDefineMyClubOverlay = QLVPleaseDefineMyClubAlertView(from: self) {
            if QLVCustomer.sharedInstance().currentProfile!.isMyClubDefined() {
                self.sportPageSelected(sportPageIndex: IndexPath(row: QLVSportPageType.iceHockey.rawValue, section: 0), sportPage: nil)
            } else {
                let landing = IndexPath(row: QLVSportPageType.landing.rawValue, section: 0)
                self.pagesDataSource!.selectCell(landing)
                self.sportPageSelected(sportPageIndex: landing, sportPage: nil)
            }
        }
        pleaseDefineMyClubOverlay.show()
    }
    
    func leaguePageSelected(page: QLVNavigationItem) {
        guard page.type == .button else {
            return
        }
        
        guard page.filters != nil else {
            return
        }
        
        self.selectedPage = page
        self.performSegue(withIdentifier: "league", sender: self)
    }
    
    func moveViewsBack() {
        self.moveViewTo(positionX: 0.0, animated: true)
    }
    
    func moveViewTo(positionX: CGFloat, animated: Bool) {
        if UIDevice.isPhone() {
            return
        }
        
        let position = CGPoint(x: positionX, y: 0.0)
        
        if let scrollView = self.controllerScrollView {
            scrollView.setContentOffset(position, animated: animated)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let toViewController = segue.destination as? QLVSportBasePagedViewController {
            toViewController.initialySelectedIndexPath = self.pagesTableView?.indexPathForSelectedRow
        }
        
        if segue.identifier == "league" {
            if let toViewController = segue.destination as? QLVSportsLeaguePageViewController {
                toViewController.page = selectedPage!
            }
        }
    }
    
    @objc func sportPages(sender: Any?) {
        if (self.pagesTableMenuOpened) {
            if UIDevice.isPad() {
                self.moveViewTo(positionX: self.pagesTableView!.frame.origin.x + self.pagesTableView!.frame.size.width + self.pagesTableViewMargin , animated: true)
            } else {
                self.pagesTableView?.isHidden = true
            }

            if let button = self.navigationItem.leftBarButtonItem?.customView?.subviews[0] as? UIButton {
                button.isSelected = false
                if UIDevice.isPhone() {
                self.activityIndicator?.isHidden = false
                self.controllerScrollView?.alpha=1
                }
            }
        } else {
            if let button = self.navigationItem.leftBarButtonItem?.customView?.subviews[0] as? UIButton {
                button.isSelected = true
                 if UIDevice.isPhone() {
                self.activityIndicator?.isHidden = true
                self.controllerScrollView?.alpha=0
                }
            }
            if UIDevice.isPad() {
                self.moveViewsBack()
            } else {
                self.pagesTableView?.isHidden = false
            }
        }
        self.pagesTableMenuOpened = !self.pagesTableMenuOpened
    }
}

// MARK: View
extension QLVSportBasePagedViewController {
    
    @objc func prepareUi() {
        let colorScheme = ColorScheme.shared
        
        self.addActivityIndicator()
        self.addSportPagesButton(colorScheme)
    }
    
    func addSportPagesButton(_ colorScheme: ColorScheme) {
        let barButtonView = QLVTextBarButtonView(target: self, fontSize: 17, title: "Sport Pages".localized, action: #selector(sportPages))
        let sportPagesButton = UIBarButtonItem(customView: barButtonView!)
        
        self.navigationItem.leftBarButtonItem = sportPagesButton
    }
}
