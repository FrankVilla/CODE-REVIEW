//
//  QLVSportEventsDataSource.swift
//  Quickline
//
//  Created by Radosław Mariowski on 11/07/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import UIKit

class QLVSportEventsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let cellHeightForPhone = 86
    
    let controller: QLVSportsViewController
    let tableView: UITableView
    
    var events: [QLVMedia] = []
    
    init(_ controller: QLVSportsViewController) {
        self.controller = controller
        self.tableView = controller.tvGuideTableView
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.isPad() {
            return self.tableView.frame.height / 3.0 - 2
        }
        return CGFloat(self.cellHeightForPhone)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel!.backgroundColor = .clear
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.createEventCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = self.events[indexPath.section]

        if UIDevice.isPad() || !event.isSportMatchEvent() || !event.matchData.isTeamMatch {
            let mediaViewController = QLVMediaViewController(media: event, fromRecordings: false)!
            self.controller.navigationController!.pushViewController(mediaViewController, animated: true)
        } else {
            self.controller.performSegue(withIdentifier: "details", sender: self)
        }
    }

    func updateData(_ events: [QLVMedia]) {
        self.events = events
        
        self.tableView.reloadData()
        
        if UIDevice.isPhone() {
            self.controller.tvGuideTableViewHeightConstraint.constant = CGFloat(min(self.events.count, 2) * (self.cellHeightForPhone + 2))
            self.controller.view.layoutIfNeeded()
        }
    }
    
    func updateCellsAndCheckForReload() -> Bool {
        var reload = false
        
        for row in 0..<self.events.count {
            if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: row)) as? QLVSportEventsCell {
                cell.progressBarView.progress = Float(self.events[row].progress())
                if cell.progressBarView.progress >= 1 {
                    reload = true
                }
            }
        }
        
        return reload
    }
}

fileprivate extension QLVSportEventsDataSource {
    
    fileprivate func createEventCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QLVSportEventsCell
        let event = self.events[indexPath.section]
        
        cell.prepare(event: event)
        
        return cell
    }
}
