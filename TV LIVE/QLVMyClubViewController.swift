//
//  QLVMyClubViewController.swift
//  Quickline
//
//  Created by Radosław Mariowski on 29/08/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift

@objc class QLVMyClubViewController: QLVSportBasePagedViewController {

    // Phone only:
    @IBOutlet weak var tabsView: UIView!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var nlaButton: UIButton!
    @IBOutlet weak var nlbButton: UIButton!
    @IBOutlet weak var upcomingEventsCollectionViewHeightConstraint: NSLayoutConstraint!
    
    // Tablet
    @IBOutlet weak var sportTablePageViewMargin: NSLayoutConstraint!
    
    // Shared:
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sportPagesTableView: UITableView!
    @IBOutlet weak var myClubPageView: UIView!
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var myClubLabel: UILabel!
    @IBOutlet weak var myClubLogoImageView: UIImageView!
    @IBOutlet weak var myClubNameLabel: UILabel!
    @IBOutlet weak var myClubEditButton: UIButton!
    
    @IBOutlet weak var nextGameLabel: UILabel!
    @IBOutlet weak var nextGameTeam1LogoImageView: UIImageView!
    @IBOutlet weak var nextGameTeam1FallbackLabel: UILabel!
    @IBOutlet weak var nextGameSeparatorLabel: UILabel!
    @IBOutlet weak var nextGameTeam2LogoImageView: UIImageView!
    @IBOutlet weak var nextGameTeam2FallbackLabel: UILabel!
    @IBOutlet weak var nextGameTeamsLabel: UILabel!
    @IBOutlet weak var nextGameDateLabel: UILabel!
    @IBOutlet weak var nextGameChannelImageView: UIImageViewAligned!
    @IBOutlet weak var nextGameProgressView: UIProgressView!
    @IBOutlet weak var nextGameRecordLabel: UILabel!
    
    @IBOutlet weak var lastGameLabel: UILabel!
    @IBOutlet weak var lastGameTeam1LogoImageView: UIImageView!
    @IBOutlet weak var lastGameTeam1FallbackLabel: UILabel!
    @IBOutlet weak var lastGameSeparatorLabel: UILabel!
    @IBOutlet weak var lastGameTeam2LogoImageView: UIImageView!
    @IBOutlet weak var lastGameTeam2FallbackLabel: UILabel!
    @IBOutlet weak var lastGameTeamsLabel: UILabel!
    @IBOutlet weak var lastGameDateLabel: UILabel!
    @IBOutlet weak var lastGameChannelImageView: UIImageViewAligned!
    @IBOutlet weak var lastGameRecordLabel: UILabel!
    
    @IBOutlet weak var noGamesLabel: UILabel!
    @IBOutlet weak var noUpcomingEventsLabel: UILabel!
    
    @IBOutlet weak var upcomingHighlightsLabel: UILabel!
    @IBOutlet weak var mySportsGuideButton: UIButton!
    @IBOutlet weak var mySportsGuideArrowButton: UIButton!
    @IBOutlet weak var upcomingEventsCollectionView: UICollectionView!
    
    var upcommingEventsDataSource: QLVMyClubUpcomingEventsDataSource?
    var lastGameEvent: QLVMedia?
    var currentGameEvent: QLVMedia?
    var nextGameEvent: QLVMedia?
    
    @objc class func loadFromStoryboard() -> QLVMyClubViewController? {
        let controller =  UIStoryboard(name: UIDevice.isPad() ? "SportsPad" : "SportsPhone", bundle: nil).instantiateViewController(withIdentifier: "MyClubView") as? QLVMyClubViewController
        controller?.initialySelectedIndexPath = IndexPath.init(row: 1, section: 0)
        return controller;
    }
    
    override func viewDidLoad() {
        let cellNib = UINib(nibName: "QLVBaseMosaicEventCell", bundle: nil)
        upcomingEventsCollectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
        let margin = self.sportTablePageViewMargin != nil ? self.sportTablePageViewMargin.constant : 0
        self.initialySelectedIndexPath = IndexPath(row: 1, section: 0)
        
        super.viewDidLoad(title: "My Hockey".localized, controllerScrollView: self.scrollView, pagesTableView: self.sportPagesTableView, pagesTableViewMargin: margin)
    
        self.scrollView.isHidden = true
        
        self.upcommingEventsDataSource = QLVMyClubUpcomingEventsDataSource(self)
        self.upcomingEventsCollectionView.delegate = self.upcommingEventsDataSource
        self.upcomingEventsCollectionView.dataSource = self.upcommingEventsDataSource
        
        self.prepareUi()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.upcommingEventsDataSource!.setLayout()
    }
    
    override func viewDidLayoutSubviews() {
        if UIDevice.isPad() {
            self.moveViewTo(positionX: self.myClubPageView.frame.origin.x, animated: false)
        } else {
            self.eventsTabSelected(self.eventsButton)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadData()
    }
    
    private func loadData() {
        self.activityIndicator!.startAnimating()
        
        let profile = QLVCustomer.sharedInstance().currentProfile!
        if let club = profile.myClub {
            let teamCode = club.code
            let mySportsProvider = QLVMySportsDataProvider.shared
            
            mySportsProvider.loadClubGames(teamCode: teamCode, profile: profile, successHandler: { channels in
                self.currentGameEvent = mySportsProvider.getClubCurrentGameEvent(channels)
                self.upcommingEventsDataSource!.updateEvents(channels)
                
                mySportsProvider.getClubNextAndLastGameEvent(channels, completetionHandler: { (nextEvent, lastEvent) in
                    self.nextGameEvent = nextEvent
                    self.lastGameEvent = lastEvent
                    
                    self.loadFinished()
                })
            }, errorHandler: { error in
                print(error ?? "")
                self.loadFinished()
            })
        } else {
            self.loadFinished()
        }
    }
    
    private func loadFinished() {
        self.updateMyClubView()
        self.activityIndicator!.stopAnimating()
        self.scrollView.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "details" {
            if let toViewController = segue.destination as? QLVSportGameDetailsViewController {
                switch sender {
                case let dataSource as QLVMyClubUpcomingEventsDataSource:
                    toViewController.event = dataSource.events[dataSource.collectionView.indexPathsForSelectedItems![0].item]
                    break;
                
                case let event as QLVMedia:
                    toViewController.event = event
                    break;
                    
                default:
                    break;
                }
            }
        }
    }
    
    @IBAction func eventsTabSelected(_ sender: UIButton) {
        let colorScheme = ColorScheme.shared
        
        self.eventsButton.backgroundColor = colorScheme.primaryColor()
        self.nlaButton.backgroundColor = colorScheme.primaryLowAlphaColor()
        self.nlbButton.backgroundColor = colorScheme.primaryLowAlphaColor()
        
        self.sportPagesTableView.isHidden = true
        
        self.scrollView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    @IBAction func nlaTabSelected(_ sender: UIButton) {
        let colorScheme = ColorScheme.shared
        
        self.eventsButton.backgroundColor = colorScheme.primaryLowAlphaColor()
        self.nlaButton.backgroundColor = colorScheme.primaryColor()
        self.nlbButton.backgroundColor = colorScheme.primaryLowAlphaColor()
        
        self.sportPagesTableView.isHidden = true
        
        self.scrollView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    @IBAction func nlbTabSelected(_ sender: UIButton) {
        let colorScheme = ColorScheme.shared
        
        self.eventsButton.backgroundColor = colorScheme.primaryLowAlphaColor()
        self.nlaButton.backgroundColor = colorScheme.primaryLowAlphaColor()
        self.nlbButton.backgroundColor = colorScheme.primaryColor()
        self.sportPagesTableView.isHidden = true
        
        self.scrollView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    @IBAction func myClubEdit(_ sender: UIButton) {
        if let activityIndicator = self.activityIndicator {
            if !activityIndicator.animating {
                activityIndicator.startAnimating()
                let selectMyClubOverlay = QLVSelectMyClubAlertView(from: self) {
                    
                    if !QLVCustomer.sharedInstance().currentProfile!.isMyClubDefined() {
                        super.sportPageSelected(sportPageIndex: IndexPath(row: QLVSportPageType.iceHockey.rawValue, section: 0), sportPage: nil)
                        return
                    }
                    
                    self.loadData()
                    if let pagesDataSource = super.pagesDataSource {
                        pagesDataSource.unselectAllCells()
                        pagesDataSource.selectCell(IndexPath(row: 0, section: 0))
                    }
                }
                
                selectMyClubOverlay.show() {
                    activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    @objc override func sportPages(sender: Any?) {
        if UIDevice.isPhone() {
            if self.pagesTableMenuOpened {
                self.sportPagesTableView.isHidden = true
//                self.tabsView.isHidden = false
                self.scrollView.isHidden = false
            } else {
                self.sportPagesTableView.isHidden = false
               // self.tabsView.isHidden = true
                self.scrollView.isHidden = true
            }
        }
        
        super.sportPages(sender: sender)
    }
    
    func calculateContentHeight() {
        if UIDevice.isPad() {
            return
        }
        
        self.contentHeightConstraint.constant = self.myClubLabel.superview!.bounds.size.height
        
        if !self.nextGameLabel.superview!.isHidden {
            self.contentHeightConstraint.constant += self.nextGameLabel.superview!.bounds.size.height
        }
        
        if !self.lastGameLabel.superview!.isHidden {
            self.contentHeightConstraint.constant += self.lastGameLabel.superview!.bounds.size.height
        }
        
        if !self.upcomingHighlightsLabel.superview!.isHidden {
            self.contentHeightConstraint.constant += self.upcomingHighlightsLabel.superview!.bounds.size.height + self.upcomingEventsCollectionViewHeightConstraint.constant
        }
        
        self.view.layoutIfNeeded()
    }
    
    func goToDetailPage(event: QLVMedia?) {
        guard event != nil else {
            return
        }
        
        if UIDevice.isPad() {
            let mediaViewController = QLVMediaViewController(media: event, fromRecordings: false)!
            self.navigationController!.pushViewController(mediaViewController, animated: true)
            
        } else {
            self.performSegue(withIdentifier: "details", sender: event)
        }
    }
    
    @IBAction func nextGameTap(_ sender: Any) {
        self.goToDetailPage(event: self.nextGameEvent)
    }
    
    @IBAction func lastGameTap(_ sender: Any) {
        self.goToDetailPage(event: self.lastGameEvent)
    }
}

// MARK: View
extension QLVMyClubViewController {
    
    override func prepareUi() {
        super.prepareUi()
        
        let colorScheme = ColorScheme.shared
        
        if UIDevice.isPhone() {
            self.prepareEventsButton(colorScheme)
            self.prepareNlaButton(colorScheme)
            self.prepareNlbButton(colorScheme)
        }
    }
    
    fileprivate func updateMyClubView() {
        let colorScheme = ColorScheme.shared
        let myClub = QLVCustomer.sharedInstance().currentProfile.myClub!
        
        self.prepareMyClubLabel(colorScheme)
        self.prepareMyClubLogoImageView(myClub)
        self.prepareMyClubNameLabel(myClub, colorScheme)
        self.prepareMyClubEditButton(colorScheme)
        
        self.prepareNextGameLabel(colorScheme)
        if !self.nextGameLabel.superview!.isHidden {
            let event = self.currentGameEvent ?? self.nextGameEvent!
            
            self.prepareNextGameTeam1LogoImageView()
            self.nextGameTeam1FallbackLabel.prepareMyClubLogoFallback(event.matchData.team1.club, colorScheme)
            self.prepareNextGameSeparatorLabel(colorScheme)
            self.prepareNextGameTeam2LogoImageView()
            self.prepareNextGameTeamsLabel(nextGameEvent!.matchData, colorScheme)
            self.nextGameTeam2FallbackLabel.prepareMyClubLogoFallback(event.matchData.team2.club, colorScheme)
            self.prepareNextGameDateLabel(colorScheme)
            self.prepareNextGameChannelImageView()
            self.prepareNextGameProgressView(colorScheme)
            self.prepareRecordLabel(self.nextGameRecordLabel, nextGameEvent!, colorScheme, "")
        }
        
        if let lastGameEvent = self.lastGameEvent {
            self.lastGameLabel.superview!.isHidden = false
            
            self.prepareLastGameLabel(colorScheme)
            self.prepareLastGameTeam1LogoImageView(lastGameEvent.matchData.team1.club)
            self.lastGameTeam1FallbackLabel.prepareMyClubLogoFallback(lastGameEvent.matchData.team1.club, colorScheme)
            self.prepareLastGameSeparatorLabel(lastGameEvent, colorScheme)
            self.prepareLastGameTeam2LogoImageView(lastGameEvent.matchData.team2.club)
            self.lastGameTeam2FallbackLabel.prepareMyClubLogoFallback(lastGameEvent.matchData.team2.club, colorScheme)
            self.prepareLastGameTeamsLabel(lastGameEvent.matchData, colorScheme)
            self.prepareLastGameDateLabel(lastGameEvent, colorScheme)
            self.prepareLastGameChannelImageView(lastGameEvent)
            self.prepareRecordLabel(self.lastGameRecordLabel, lastGameEvent, colorScheme, "")
        } else {
            self.lastGameLabel.superview!.isHidden = true
        }
        
        if self.nextGameLabel.superview!.isHidden && self.lastGameLabel.superview!.isHidden {
            self.prepareNotAvailableLabel(self.noGamesLabel, colorScheme)
        } else {
            if UIDevice.isPad() {
                self.noGamesLabel.superview!.isHidden = true
            } else {
                self.noGamesLabel.superview!.superview!.isHidden = true
            }
        }
        
        if self.upcomingEventsCollectionView.isHidden {
            self.prepareNotAvailableLabel(self.noUpcomingEventsLabel, colorScheme)
        } else {
            self.noUpcomingEventsLabel.superview!.isHidden = true
        }
        
        self.prepareUpcomingHighlightsLabel(colorScheme)
        
        self.calculateContentHeight()
    }
    
    private func prepareEventsButton(_ colorScheme: ColorScheme) {
        self.preparePhoneTabButton(self.eventsButton, "Events".localized, colorScheme)
    }
    
    private func prepareNlaButton(_ colorScheme: ColorScheme) {
        self.preparePhoneTabButton(self.nlaButton, "NLA".localized, colorScheme)
    }
    
    private func prepareNlbButton(_ colorScheme: ColorScheme) {
        self.preparePhoneTabButton(self.nlbButton, "NLB".localized, colorScheme)
    }
    
    private func prepareMyClubLabel(_ colorScheme: ColorScheme) {
        self.prepareSectionLabel(self.myClubLabel, "My Club".localized, colorScheme)
    }
    
    private func prepareMyClubLogoImageView(_ myClub: QLVMySportsClub) {
        self.myClubLogoImageView.setImageWith(myClub.imageUrl!)
    }
    
    private func prepareMyClubNameLabel(_ myClub: QLVMySportsClub, _ colorScheme: ColorScheme) {
        self.prepareMyClubTeamsLabel(self.myClubNameLabel, myClub.name, colorScheme)
    }
    
    private func prepareMyClubEditButton(_ colorScheme: ColorScheme) {
        self.myClubEditButton.titleLabel!.font = UIFont.iconFont(ofSize: UIDevice.isPad() ? 36 : 22)
        self.myClubEditButton.setTitleColor(colorScheme.textColor(), for: .normal)
    }
    
    private func prepareNextGameLabel(_ colorScheme: ColorScheme) {
        var text = ""
        if self.currentGameEvent != nil {
            text = "Current Game".localized
            self.nextGameLabel.superview!.isHidden = false
            
            self.prepareSubSectionLabel(self.nextGameLabel, text, colorScheme)
        } else if self.nextGameEvent != nil {
            text = "Next Game".localized
            self.nextGameLabel.superview!.isHidden = false
            
            self.prepareSubSectionLabel(self.nextGameLabel, text, colorScheme)
        } else {
            self.nextGameLabel.superview!.isHidden = true
        }
    }
    
    private func prepareNextGameTeam1LogoImageView() {
        if let currentGameEvent = self.currentGameEvent {
            if let imageUrl = currentGameEvent.matchData.team1.club.imageUrl {
                self.nextGameTeam1LogoImageView.setImageWith(imageUrl)
                self.nextGameTeam1LogoImageView.isHidden = false
            } else {
                self.nextGameTeam1LogoImageView.isHidden = true
            }
        } else if let nextGameEvent = self.nextGameEvent {
            if let imageUrl = nextGameEvent.matchData.team1.club.imageUrl {
                self.nextGameTeam1LogoImageView.setImageWith(imageUrl)
                self.nextGameTeam1LogoImageView.isHidden = false
            } else {
                self.nextGameTeam1LogoImageView.isHidden = true
            }
        } else {
            self.nextGameTeam1LogoImageView.isHidden = true
        }
    }
    
    private func prepareNextGameSeparatorLabel(_ colorScheme: ColorScheme) {
        if UIDevice.isPad() {
            if let currentGameEvent = self.currentGameEvent {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM."
                
                self.prepareMyClubSeparatorLabel(self.nextGameSeparatorLabel, dateFormatter.string(from: currentGameEvent.startDate), colorScheme)
            } else if let nextGameEvent = self.nextGameEvent {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM."
                
                self.prepareMyClubSeparatorLabel(self.nextGameSeparatorLabel, dateFormatter.string(from: nextGameEvent.startDate), colorScheme)
            }
        } else {
            self.prepareMyClubSeparatorLabel(self.nextGameSeparatorLabel, ":", colorScheme)
        }
    }
    
    private func prepareNextGameTeam2LogoImageView() {
        if let currentGameEvent = self.currentGameEvent {
            if let imageUrl = currentGameEvent.matchData.team2.club.imageUrl {
                self.nextGameTeam2LogoImageView.setImageWith(imageUrl)
                self.nextGameTeam2LogoImageView.isHidden = false
            } else {
                self.nextGameTeam2LogoImageView.isHidden = true
            }
        } else if let nextGameEvent = self.nextGameEvent {
            if let imageUrl = nextGameEvent.matchData.team2.club.imageUrl {
                self.nextGameTeam2LogoImageView.setImageWith(imageUrl)
                self.nextGameTeam2LogoImageView.isHidden = false
            } else {
                self.nextGameTeam2LogoImageView.isHidden = true
            }
        } else {
            self.nextGameTeam2LogoImageView.isHidden = true
        }
    }
    
    private func prepareNextGameTeamsLabel(_ matchData: QLVMySportsMatchData, _ colorScheme: ColorScheme) {
        if UIDevice.isPad() {
            return
        }

        if let event = self.nextGameEvent {
            if event.isRecording() || event.isRecorded {
                self.prepareRecordLabel(self.nextGameTeamsLabel, event, colorScheme, "\(matchData.team1.club.name) vs. \(matchData.team2.club.name)")
            } else {
                self.prepareMyClubTeamsLabel(self.nextGameTeamsLabel, "\(matchData.team1.club.name) vs. \(matchData.team2.club.name)", colorScheme)
            }
        }
    }
    
    private func prepareNextGameDateLabel(_ colorScheme: ColorScheme) {
        let dateFormatter = DateFormatter()
        var text = ""
        
        if let currentGameEvent = self.currentGameEvent {
            if UIDevice.isPad() {
                dateFormatter.dateFormat = "HH:mm"
                text = "\(dateFormatter.string(from: currentGameEvent.startDate)) - \(dateFormatter.string(from: currentGameEvent.endDate))"
                
            } else {
                dateFormatter.dateFormat = "dd.MM. HH:mm"
                
                let endTimeFormatter = DateFormatter()
                endTimeFormatter.dateFormat = "HH:mm"
                text = "\(dateFormatter.string(from: currentGameEvent.startDate))-\(endTimeFormatter.string(from: currentGameEvent.endDate))"
            }
            
            self.prepareMyClubDateLabel(self.nextGameDateLabel, text, colorScheme)
        } else if let nextGameEvent = self.nextGameEvent {
            if UIDevice.isPad() {
                dateFormatter.dateFormat = "HH:mm"
                text = "\(dateFormatter.string(from: nextGameEvent.startDate)) - \(dateFormatter.string(from: nextGameEvent.endDate))"
                
            } else {
                dateFormatter.dateFormat = "dd.MM. HH:mm"
                
                let endTimeFormatter = DateFormatter()
                endTimeFormatter.dateFormat = "HH:mm"
                text = "\(dateFormatter.string(from: nextGameEvent.startDate))-\(endTimeFormatter.string(from: nextGameEvent.endDate))"
            }
            
            self.prepareMyClubDateLabel(self.nextGameDateLabel, text, colorScheme)
        }
    }
    
    private func prepareNextGameChannelImageView() {
        if let currentGameEvent = self.currentGameEvent {
            if (currentGameEvent.channel != nil && currentGameEvent.channel.imageURL != nil) {
                self.nextGameChannelImageView.setImageWith(currentGameEvent.channel.imageURL)
            }
        } else if let nextGameEvent = self.nextGameEvent {
            if (nextGameEvent.channel != nil && nextGameEvent.channel.imageURL != nil) {
                self.nextGameChannelImageView.setImageWith(nextGameEvent.channel.imageURL)
            }
        }
    }
    
    private func prepareNextGameProgressView(_ colorScheme: ColorScheme) {
        if UIDevice.isPhone() {
            return
        }
        
        if let currentGameEvent = self.currentGameEvent {
            self.nextGameProgressView.progress = Float(NSDate.traxisDatetime().timeIntervalSince(currentGameEvent.startDate) / currentGameEvent.endDate.timeIntervalSince(currentGameEvent.startDate))
            self.nextGameProgressView.progressTintColor = colorScheme.primaryColor()
            self.nextGameProgressView.trackTintColor = colorScheme.primaryLowAlphaColor()
            self.nextGameProgressView.isHidden = false
        } else {
            self.nextGameProgressView.isHidden = true
        }
    }
    
    private func prepareLastGameLabel(_ colorScheme: ColorScheme) {
        self.prepareSubSectionLabel(self.lastGameLabel, "Last Game".localized, colorScheme)
    }
    
    private func prepareLastGameTeam1LogoImageView(_ team1: QLVMySportsClub) {
        if let imageUrl = team1.imageUrl {
            self.lastGameTeam1LogoImageView.setImageWith(imageUrl)
            self.lastGameTeam1LogoImageView.isHidden = false
        } else {
            self.lastGameTeam1LogoImageView.isHidden = true
        }
    }
    
    private func prepareLastGameSeparatorLabel(_ lastGameEvent: QLVMedia, _ colorScheme: ColorScheme) {
        if UIDevice.isPad() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM."
                
            self.prepareMyClubSeparatorLabel(self.lastGameSeparatorLabel, dateFormatter.string(from: lastGameEvent.startDate), colorScheme)
        } else {
            self.prepareMyClubSeparatorLabel(self.lastGameSeparatorLabel, ":", colorScheme)
        }
    }
    
    private func prepareLastGameTeam2LogoImageView(_ team2: QLVMySportsClub) {
        if let imageUrl = team2.imageUrl {
            self.lastGameTeam2LogoImageView.setImageWith(imageUrl)
            self.lastGameTeam2LogoImageView.isHidden = false
        } else {
            self.lastGameTeam2LogoImageView.isHidden = true
        }
    }
    
    private func prepareLastGameTeamsLabel(_ matchData: QLVMySportsMatchData, _ colorScheme: ColorScheme) {
        if UIDevice.isPad() {
            return
        }
        
        if let event = self.lastGameEvent {
            if event.isRecording() || event.isRecorded {
                self.prepareRecordLabel(self.lastGameTeamsLabel, event, colorScheme, "\(matchData.team1.club.name) vs. \(matchData.team2.club.name)")
            } else {
                self.prepareMyClubTeamsLabel(self.lastGameTeamsLabel, "\(matchData.team1.club.name) vs. \(matchData.team2.club.name)", colorScheme)
            }
        }
    }
    
    private func prepareLastGameDateLabel(_ lastGameEvent: QLVMedia, _ colorScheme: ColorScheme) {
        let dateFormatter = DateFormatter()
        var text = ""
        
        if UIDevice.isPad() {
            dateFormatter.dateFormat = "HH:mm"
            text = "\(dateFormatter.string(from: lastGameEvent.startDate)) - \(dateFormatter.string(from: lastGameEvent.endDate))"
        } else {
            dateFormatter.dateFormat = "dd.MM. HH:mm"
            
            let endTimeFormatter = DateFormatter()
            endTimeFormatter.dateFormat = "HH:mm"
            text = "\(dateFormatter.string(from: lastGameEvent.startDate))-\(endTimeFormatter.string(from: lastGameEvent.endDate))"
        }
        self.prepareMyClubDateLabel(self.lastGameDateLabel, text, colorScheme)
    }
    
    private func prepareLastGameChannelImageView(_ lastGameEvent: QLVMedia) {
        if lastGameEvent.channel != nil && lastGameEvent.channel.imageURL != nil {
            self.lastGameChannelImageView.setImageWith(lastGameEvent.channel.imageURL)
        }
    }
    
    private func prepareNotAvailableLabel(_ label: UILabel, _ colorScheme: ColorScheme) {
        label.text = "Currently there are no games of chosen club".localized
        label.font = UIFont.customFont(ofSize: UIDevice.isPad() ? 26 : 17)
        label.textColor = colorScheme.textColor()
        label.superview!.isHidden = false
    }
    
    private func prepareUpcomingHighlightsLabel(_ colorScheme: ColorScheme) {
        self.prepareSectionLabel(self.upcomingHighlightsLabel, "Upcoming MyClub Highlights".localized, colorScheme)
    }
    
    private func prepareToMySportsGuideButton(_ colorScheme: ColorScheme) {
        self.mySportsGuideButton.titleLabel!.font = UIFont.customFont(ofSize: UIDevice.isPad() ? 18 : 12)
        self.mySportsGuideButton.setTitle("All".localized, for: .normal)
        self.mySportsGuideButton.setTitleColor(colorScheme.textColor(), for: .normal)
    }
    
    private func prepareToMySportsGuideArrowButton(_ colorScheme: ColorScheme) {
        self.mySportsGuideArrowButton.titleLabel!.font = UIFont.iconFont(ofSize: 17)
        self.mySportsGuideArrowButton.setTitleColor(colorScheme.textColor(), for: .normal)
    }

    private func preparePhoneTabButton(_ button: UIButton, _ text: String, _ colorScheme: ColorScheme) {
        button.titleLabel!.font = UIFont.customFont(ofSize: 15)
        button.setTitle(text, for: .normal)
        button.setTitleColor(colorScheme.textColor(), for: .normal)
        button.backgroundColor = colorScheme.primaryColor()
    }
    
    private func prepareSectionLabel(_ label: UILabel, _ text: String, _ colorScheme: ColorScheme) {
        label.text = text
        label.font = UIFont.customFont(ofSize: UIDevice.isPad() ? 24 : 17)
        label.textColor = colorScheme.textColor()
    }
    
    private func prepareSubSectionLabel(_ label: UILabel, _ text: String, _ colorScheme: ColorScheme) {
        label.text = text
        label.font = UIFont.customFont(ofSize: UIDevice.isPad() ? 15 : 13)
        label.textColor = colorScheme.textColor()
    }
    
    private func prepareMyClubSeparatorLabel(_ label: UILabel, _ text: String, _ colorScheme: ColorScheme) {
        label.text = text
        label.font = UIFont.customFont(ofSize: UIDevice.isPad() ? 30 : 18)
        label.textColor = colorScheme.textColor()
    }
    
    private func prepareMyClubTeamsLabel(_ label: UILabel, _ text: String, _ colorScheme: ColorScheme) {
        label.text = text
        label.font = UIFont.customFont(ofSize: 15)
        label.textColor = colorScheme.textColor()
    }
    
    private func prepareMyClubDateLabel(_ label: UILabel, _ text: String, _ colorScheme: ColorScheme) {
        label.text = text
        label.font = UIFont.customFont(ofSize: UIDevice.isPad() ? 15 : 12)
        label.textColor = colorScheme.textColor()
    }
    
    private func prepareRecordLabel(_ label: UILabel?, _ event: QLVMedia, _ colorScheme: ColorScheme, _ textString: String) {
        guard label != nil else {
            return
        }
        
        if event.isRecording() || event.isRecorded {
            let text = NSMutableAttributedString()
            
            if !textString.isEmpty {
                text.append(NSAttributedString(string: textString + " ", attributes: [ NSAttributedString.Key.font: UIFont.customFont(ofSize: 15.0), NSAttributedString.Key.foregroundColor: colorScheme.textColor() ]))
            }
            
            text.append(NSAttributedString.recordIcon(UIDevice.isPhone() ? 20.0 : 30.0, colorScheme))
            
            label!.text = ""
            label!.attributedText = text
            
            label!.isHidden = false
        } else {
            label!.isHidden = true
        }
    }
}
