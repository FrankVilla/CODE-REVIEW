//
//  FilterViewController.swift
//  Quickline
//
//  Created by Kristaps Freibergs on 17/07/2018.
//  Copyright © 2018 Ambrite Latvia. All rights reserved.
//

import Foundation

private let cellIdent = "FilterCell"
private let cellHeight : CGFloat = UIDevice.isPad() ? 54 : 44
private let cellTextSize : CGFloat = UIDevice.isPad() ? 21 : 17
private let headerTextSize : CGFloat = UIDevice.isPad() ? 21 : 15
private let topBottomTableInset : CGFloat = 3
private let headerTopPadding: CGFloat = UIDevice.isPad() ? 30 : 10


class FilterViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @objc let tableTopInset : CGFloat = UIDevice.isPad() ? 90 : 50
    @objc let indexTopInset : CGFloat = UIDevice.isPad() ? 100 : 60
    
    private var viewModel : FilterViewModel?

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var headerColorView: UIView!
    
    @IBOutlet var headerCollection: [UIButton]!
    
    @IBOutlet var tableCollection: [UITableView]!

    @IBOutlet weak var containerLeadingConstr: NSLayoutConstraint!
    @IBOutlet weak var heaaderTopConstr: NSLayoutConstraint!
    
    weak var expandedTable: UITableView! = nil
    var lastHeaderPosition: CGFloat = headerTopPadding
    
    
    @objc func setViewModel(viewModel: FilterViewModel){
        self.viewModel = viewModel
        self.viewModel?.deselectItems = deselectItems(tableIdx:indexes:)
        self.viewModel?.selectItems = selectItems(tableIdx:indexes:)
        
        if (tableCollection != nil){
            for table in tableCollection {
                let tableIdx = tableCollection.firstIndex(of: table)!
                table.allowsMultipleSelection = (self.viewModel?.isMultiSelect()[tableIdx])!
                let header = headerCollection[tableIdx]
                header.setTitle(self.viewModel?.titles()[tableIdx], for: .normal)
                table.reloadData()
            }
            view.layoutIfNeeded()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissButton.isUserInteractionEnabled = false
        
        // Design setup
        
        dismissButton.backgroundColor = ColorScheme.shared.backgroundColor()
        headerColorView.backgroundColor = ColorScheme.shared.supportingColor()
        dismissButton.alpha = 0

        // Table View setup
        
        for tableView in tableCollection {
            
            
            let tableIdx = tableCollection.firstIndex(of: tableView)!
            let header = headerCollection[tableIdx]
            
            header.backgroundColor = ColorScheme.shared.supportingColor()
            header.titleLabel?.font = UIFont.customFont(ofSize: headerTextSize)
            header.titleLabel?.adjustsFontSizeToFitWidth = true
            header.titleLabel?.minimumScaleFactor = 0.7
            header.setTitleColor(ColorScheme.shared.textColor(), for: .normal)
            
            tableView.contentInset = UIEdgeInsets.init(top: topBottomTableInset, left: 0, bottom: topBottomTableInset, right: 0)
            (tableView as! IntrinsicTableView).insetHeight = topBottomTableInset*2
            tableView.backgroundColor = ColorScheme.shared.undefienedColor()
            tableView.bounces = false
            tableView.tableFooterView = UIView(frame: .zero)
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: "FilterCell", bundle: Bundle.main),
                               forCellReuseIdentifier: cellIdent)
            tableView.allowsSelection = true
            tableView.delegate = self
            tableView.dataSource = self
            
            if (viewModel != nil){
                tableView.allowsMultipleSelection = (viewModel?.isMultiSelect()[tableIdx])!
                header.setTitle(viewModel?.titles()[tableIdx], for: .normal)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let aHeader = headerCollection.first
        for table in tableCollection {
            (table as! IntrinsicTableView).maxHeight =
                containerView.frame.size.height - (headerTopPadding + (aHeader?.frame.size.height)! + 5)
        }
    }
    
    @IBAction func dismissTapped() {
        let idx = tableCollection.firstIndex(of: expandedTable)
        self.headerTapped(headerCollection[idx!])
    }
    
    @IBAction func headerTapped(_ tappedHeader: UIButton) {
        
        func reloadTable(table:UITableView, anim:UITableView.RowAnimation){
            table.beginUpdates()
            table.reloadSections([0], with: anim)
            table.invalidateIntrinsicContentSize()
            table.endUpdates()
            table.reloadData() // Fix for iOS 9 & 10
        }
        
        let tappedIdx = headerCollection.firstIndex(of: tappedHeader)
        let tappedTable = tableCollection[tappedIdx!]
        
        var tableToColapse : UITableView? = nil
        var tableToExpand  : UITableView? = nil
        var headerToExpand : UIButton? = nil
        
        if (expandedTable == nil){ // expand
            tableToExpand = tappedTable
            headerToExpand = tappedHeader
            
            expandedTable = tappedTable
            
            dismissButton.isUserInteractionEnabled = true
        } else if (expandedTable == tappedTable){ // colapse
            tableToColapse = tappedTable
            
            expandedTable = nil
            dismissButton.isUserInteractionEnabled = false
        } else { // switch expandables
            tableToExpand = tappedTable
            headerToExpand = tappedHeader
            
            tableToColapse = expandedTable
            
            expandedTable = tappedTable
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .curveEaseOut, .allowUserInteraction], animations: {

            if (tableToExpand != nil){
                reloadTable(table: tableToExpand!, anim: .top)
                
                for aHeader in self.headerCollection {
                    aHeader.alpha = (aHeader == headerToExpand) ? 1 : 0.5
                }
                
                self.updateHeader(offset: headerTopPadding)
            } else {
                for aHeader in self.headerCollection {
                    aHeader.alpha = 1
                }
                self.updateHeader(offset: self.lastHeaderPosition)
            }
            if (tableToColapse != nil){
                reloadTable(table: tableToColapse!, anim: .fade)
            }

            self.view.layoutIfNeeded()
            
            self.dismissButton.alpha = (self.dismissButton.isUserInteractionEnabled) ? 0.9 : 0

        }, completion: nil)
        
    }
    
    private func deselectItems(tableIdx: Int, indexes: [Int]){
        let table = tableCollection[tableIdx]
        for idx in indexes {
            table.deselectRow(at: IndexPath(item: idx, section: 0), animated: false)
        }
    }
    
    private func selectItems(tableIdx: Int, indexes: [Int]){
        let table = tableCollection[tableIdx]
        for idx in indexes {
            table.selectRow(at: IndexPath(item: idx, section: 0), animated: false, scrollPosition: .none)
        }
    }
    
    private func updateHeader(offset: CGFloat){
        heaaderTopConstr.constant = max(0, offset)
        headerColorView.alpha = 1 - heaaderTopConstr.constant/headerTopPadding
    }
    
    @objc func didScrollContent(offset: CGFloat) {
        let padding =  max(0, -(offset + tableTopInset - headerTopPadding))
        lastHeaderPosition = padding
        if (expandedTable == nil){
            updateHeader(offset: padding)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == expandedTable){
            let tableIdx = tableCollection.firstIndex(of: tableView)!
            if (viewModel != nil){
                return (viewModel?.items()[tableIdx])!.count
            }
        }
        return 0

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdent) as! FilterCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let aCell = cell as! FilterCell
        let tableIdx = tableCollection.firstIndex(of: tableView)!
        let item = viewModel?.items()[tableIdx][indexPath.row]
        aCell.title.text = item?.title
        if (item?.isSelected)!{
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableIdx = tableCollection.firstIndex(of: tableView)!
        let item = viewModel?.items()[tableIdx][indexPath.row]
        
        if (item?.isSelected)!{
            tableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
            viewModel?.deselectedItem(arrIdx: tableIdx, index: indexPath.row)
        } else {
            tableView.cellForRow(at: indexPath)?.setSelected(true, animated: false)
            viewModel?.selectedItem(arrIdx: tableIdx, index: indexPath.row)
        }
        
        let header = headerCollection[tableIdx]
        header.setTitle(viewModel?.titles()[tableIdx], for: .normal)
    }
    
    
}

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        containerView.backgroundColor = backgroundColor(isSelected: highlighted)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        containerView.backgroundColor = backgroundColor(isSelected: selected)
    }
    
    private func backgroundColor(isSelected: Bool) -> UIColor{
        return isSelected ? ColorScheme.shared.primaryColor() : ColorScheme.shared.undefienedColor()
    }
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        containerView.backgroundColor = ColorScheme.shared.undefienedColor()
        title.textColor = ColorScheme.shared.textColor()
        title.font = UIFont.customFont(ofSize: cellTextSize)
    }
    
    
    
}
