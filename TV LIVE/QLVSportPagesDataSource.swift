//
//  QLVSportPagesTableView.
//  Quickline
//
//  Created by Radosław Mariowski on 03/07/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import UIKit

class QLVSportPagesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    var controller: QLVSportBasePagedViewController
    var staticSection: QLVNavigationItem
    var initialySelectedIndexPath: IndexPath?
    var sportPages: [QLVNavigationItem] {
        didSet {
            self.sportPages = self.sportPages.filter({ $0.childs != nil && $0.childs!.count > 0 })
            self.sportPages.insert(staticSection, at: 0)
            
            if let tableView = self.controller.pagesTableView {
                tableView.reloadData()
            }
        }
    }
    
    init(_ controller: QLVSportBasePagedViewController) {
        self.controller = controller
   
        var staticButtons: [QLVNavigationItem] = []
        if QLVSportsSegue.isMyClubEnabled() {
            staticButtons = [ QLVNavigationItem(id: "", type: .button, title: "Sport Overview".localized, childs: nil, filters: nil), QLVNavigationItem(id: "", type: .button, title: "My Hockey".localized, childs: nil, filters: nil ) ]
        } else {
            staticButtons = [ QLVNavigationItem(id: "", type: .button, title: "Sport Overview".localized, childs: nil, filters: nil) ]
        }

        self.staticSection = QLVNavigationItem(id: "", type: .header, title: "", childs: staticButtons, filters: nil)
        self.sportPages = [self.staticSection]
        
        super.init()
        
        if let tableView = self.controller.pagesTableView {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sportPages[section].childs!.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 19
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 17
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            let text = NSMutableAttributedString()
            
            let attributes: [NSAttributedString.Key : Any] = [ NSAttributedString.Key.font: UIFont.customFont(ofSize: 15), NSAttributedString.Key.foregroundColor: ColorScheme.shared.textColor() ]
            text.append(NSAttributedString(string: header.textLabel?.text ?? "", attributes: attributes))

            header.textLabel?.text = ""
            header.textLabel?.attributedText = text
        }
        
        view.tintColor = .clear
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel!.backgroundColor = .clear
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sportPages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return createPageCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sportPages[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectCell(indexPath)
        let page: QLVNavigationItem = self.sportPages[indexPath.section].childs![indexPath.row]
        self.controller.sportPageSelected(sportPageIndex: indexPath, sportPage: page)
    }
    
    func selectCell(_ index: IndexPath) {
        self.unselectAllCells()
        
        let cell = self.controller.pagesTableView!.cellForRow(at: index) as! QLVSportPagesCell
        cell.setAsSelected()
    }
    
    func unselectAllCells() {
        let tableView = self.controller.pagesTableView!
        for index in 0..<self.sportPages.count {
            if let childs = self.sportPages[index].childs {
                for row in 0..<childs.count {
                    let indexPath = IndexPath(row: row, section: index)
                    if let cell = tableView.cellForRow(at: indexPath) as? QLVSportPagesCell {
                        cell.setAsUnselected()
                    }
                }
            }
        }
    }
}

extension QLVSportPagesDataSource {
    
    fileprivate func createPageCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = self.controller.pagesTableView!.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QLVSportPagesCell
        
        var selected = false

        if self.initialySelectedIndexPath != nil {
            if indexPath == self.initialySelectedIndexPath {
                selected = true
            }
        }
        
        cell.prepare(text: sportPages[indexPath.section].childs![indexPath.row].title, markAsSelected: selected)
        
        return cell
    }
}
