//
//  QLVSportGameDetailsViewController.swift
//  Quickline
//
//  Created by Radosław Mariowski on 23/08/2017.
//  Copyright © 2017 DCC Labs Sp. z o.o. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift

@objc class QLVSportGameDetailsViewController: QLVActionViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var channelImageView: UIImageViewAligned!
    @IBOutlet weak var watchButton: UIButton!
    @IBOutlet weak var notSubscribedLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var expireLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var recommendedForYouLabel: UILabel!
    @IBOutlet weak var recommendationsCollectionView: UICollectionView!
    
    var event: QLVMedia?
    var recommendationsDataSource: QLVSportGameDetailsRecommendationsDataSource?
    var activityIndicator: QLVActivityIndicator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details".localized
        self.view.backgroundColor = ColorScheme.shared.backgroundColor()
        self.edgesForExtendedLayout = []
        
        self.recommendationsDataSource = QLVSportGameDetailsRecommendationsDataSource(self)
        
        super.prepareVC()
        self.contentView.isHidden = true;

        // activity indicator
        self.activityIndicator = QLVActivityIndicator(frame: CGRect(x: (self.view.frame.size.width - 60.0) / 2.0, y: (self.view.frame.size.height - 60.0) / 2.0, width: 60.0, height: 60.0))
        self.view.addSubview(self.activityIndicator!)
        
        self.view.addSubview(super.actionViewBar)
        
        self.actionBarWidth = -195
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let actionCollectionViewFrame = CGRect(x: self.view.frame.size.width + 3, y: 0.0, width: 181.0, height: self.view.frame.size.height)
        super.actionViewBar.frame = actionCollectionViewFrame
        
        let collectionViewLayout = super.actionViewBar.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.sectionInset = UIEdgeInsets.init(top: collectionViewLayout.sectionInset.top, left: collectionViewLayout.sectionInset.left - 4.0, bottom: collectionViewLayout.sectionInset.bottom, right: collectionViewLayout.sectionInset.right)
        collectionViewLayout.invalidateLayout()
        
        self.loadEvent()
    }
    
    override func watch() {
        let event = self.event!
        guard event.channel.isEntitled && event.channel.isViewableOnCpe && ((event.isLiveEvent() || event.isAvailableForTimeshift()) && !event.isFutureEvent() && !event.isRecording()) else {
            return
        }
        
        let player =  QLVEPGPlayerViewController(media: event)!
        self.navigationController!.pushViewController(player, animated: true)
    }
    
    private func loadEvent() {
        self.activityIndicator?.startAnimating()
        
        QLVTraxis.sharedInstance().load(event, customer: QLVCustomer.sharedInstance(), success: { media in
            self.event = media
            self.activityIndicator?.stopAnimating()
            self.prepareUi()
            
            super.setMedia(media)
            
            self.contentView.isHidden = false;
            
            self.loadRecommendations()
            
        }, error: { error in
            self.activityIndicator?.stopAnimating()
            self.handleTraxisFailedError(error, method: "POST", with: self, from: self)
        })
    }
    
    private func loadRecommendations() {
        QLVTraxis.sharedInstance().loadRecommendations(for: event, customer: QLVCustomer.sharedInstance(), success: { recommendations in
            if let recommendations = recommendations as? [QLVMediaGroup] {
                if recommendations.count > 0 {
                    self.recommendationsDataSource!.updateEvents(recommendations)
                } else {
                    self.recommendedForYouLabel.superview!.isHidden = true
                }
            } else {
                self.recommendedForYouLabel.superview!.isHidden = true
            }
        }, error: { error in
            print(error ?? "")
        })
    }
    
    @IBAction func buttonTap(_ sender: UIButton) {
        if let event = self.event {
            if event.isRecording() {
                self.deleteRecording()
            } else {
                if self.isEventAvailableToWatch(event: event) {
                    self.watch()
                } else if self.isEventAvailableToRecord(event: event) {
                    self.record()
                }
            }
        }
    }
    
    @objc func setEvent(_ event: QLVMedia!) {
        self.event = event
    }
    
    private func moveViewsBack() {
        self.moveViews(toPositionX:0.0, animated: true)
    }
    
    @objc internal override func moveViews(toPositionX: CGFloat, animated: Bool) {
        let position = CGPoint(x: toPositionX, y: 0.0)
        
        var scrollViewFrame: CGRect
        var actionViewBarFrame: CGRect
        
        self.actionBarVisible = toPositionX > 0
        
        if position.x == 0.0 {
            scrollViewFrame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            actionViewBarFrame = CGRect(x: self.view.frame.size.width + 3, y: 0.0, width: 181, height: self.view.frame.size.height)
        } else {
            scrollViewFrame = CGRect(x: -toPositionX, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            actionViewBarFrame = CGRect(x: self.view.frame.size.width + 3 - toPositionX, y: 0.0, width: 181, height: self.view.frame.size.height)
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction, .curveEaseOut], animations: {
            self.scrollView.frame = scrollViewFrame
            self.actionViewBar.frame = actionViewBarFrame
        }, completion: nil)
    }
    
    // MARK: AlertViewDelegate
    override func pressedCloseButton(on alertView: QLVAlertView!) {
        super.pressedCloseButton(on: alertView)
        
        if alertView.tag == 0 {
            alertView.close()
            self.navigationController?.popViewController(animated: true);
        }
    }
    
    override func pressedOtherButton(on alertView: QLVAlertView!) {
        super.pressedOtherButton(on: alertView)
        
        if alertView.tag == 0 {
            alertView.close()
            self.navigationController?.popViewController(animated: true);
            
        } else if
            alertView.tag == QLVActionViewButton.record.rawValue ||
            alertView.tag == QLVActionViewButton.deleteRecording.rawValue ||
            alertView.tag == QLVActionViewButton.deleteSeason.rawValue ||
            alertView.tag == QLVActionViewButton.recordSeason.rawValue
        {
            self.moveViewsBack()
            self.loadEvent()
        }
    }
    
    private func isEventAvailableToWatch(event: QLVMedia) -> Bool {
        return ((event.isLiveEvent() || event.isAvailableForTimeshift()) && !event.isFutureEvent() && !event.isRecording())
    }
    
    private func isEventAvailableToRecord(event: QLVMedia) -> Bool {
        return (event.isFutureEvent() || event.isLiveEvent()) && !event.isRecording()
    }
    
    private func isEventAvailableToSeriesRecord(event: QLVMedia) -> Bool {
        if event.series != nil && event.series.id.count > 0 {
            return true
        }
        
        return false
    }
    
}

// MARK: View
fileprivate extension QLVSportGameDetailsViewController {
    
    fileprivate func prepareUi() {
        let colorScheme = ColorScheme.shared
    
        let event = self.event!
        if event.channel.isEntitled && event.channel.isViewableOnCpe {
            self.notSubscribedLabel.superview!.isHidden = true
            
            self.addActionButtonToNavigation()
            self.prepareWatchButton(colorScheme)
            
            self.watchButton.isHidden = !self.isEventAvailableToWatch(event: event) && !self.isEventAvailableToSeriesRecord(event: event) && !event.isRecording()
            
        } else {
            self.watchButton.isHidden = true
            
            self.prepareNotSubscribedLabel(colorScheme)
        }
        
        self.prepareTitleLabel(colorScheme)
        self.prepareDateLabel(event.startDate, event.endDate, colorScheme)
        self.prepareImageView(event)
        self.prepareChannelImageView()
        self.prepareInfoLabel(colorScheme)
        self.prepareExpireLabel(colorScheme)
        self.prepareRecordLabel(colorScheme)
        self.prepareDescriptionLabel(colorScheme)
        self.prepareRecommendedForYouLabel(colorScheme)
        
        self.view.layoutIfNeeded()
    }
    
    private func prepareTitleLabel(_ colorScheme: ColorScheme) {
        let matchData = event!.matchData!
        self.prepareLabel(self.titleLabel, "\(matchData.team1.club.name) : \(matchData.team2.club.name)", 24.0, colorScheme)
    }
    
    private func prepareImageView(_ event: QLVMedia) {
        if let url = event.imageURL {
            self.imageView.setImageWith(url)
        } else {
            self.imageView.isHidden = true
        }
    }
    
    private func prepareDateLabel(_ startDate: Date, _ endDate: Date, _ colorScheme: ColorScheme) {
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = "EEEE, dd.MM., HH:mm"
        startDateFormatter.locale = NSLocale(localeIdentifier: QLVCustomer.sharedInstance().currentProfile.language) as Locale?
        
        let endDateFormatter = DateFormatter()
        endDateFormatter.dateFormat = "HH:mm"
        
        let text = "\(startDateFormatter.string(from: startDate)) - \(endDateFormatter.string(from: endDate))"
        self.prepareLabel(self.dateLabel, text, 18.0, colorScheme)
    }
    
    private func prepareChannelImageView() {
        self.channelImageView.setImageWith(event!.channel.imageURL)
    }
    
    private func prepareWatchButton(_ colorScheme: ColorScheme) {
        var title = "Watch".localized
        
        if let event = self.event {
            if event.isRecording() {
                if event.isFutureEvent() {
                    title = "Cancel recording".localized
                } else if event.isLiveEvent() {
                    title = "Stop recording".localized
                } else {
                    title = "Delete recording".localized
                }
                
            } else {
                if self.isEventAvailableToWatch(event: self.event!) {
                    title = "Watch".localized
                    
                } else if self.isEventAvailableToRecord(event: self.event!) {
                    title = "Record".localized
                    if self.isEventAvailableToSeriesRecord(event: self.event!) {
                        title = "Record episode".localized
                    }
                }
            }
        }
        
        self.watchButton.backgroundColor = colorScheme.primaryLowAlphaColor()
        self.watchButton.setTitle(title, for: .normal)
        self.watchButton.setTitleColor(colorScheme.textColor(), for: .normal)
        self.watchButton.isHidden = false
    }
    
    private func prepareNotSubscribedLabel(_ colorScheme: ColorScheme) {
        self.prepareLabel(self.notSubscribedLabel, "This content is broadcasted on an unsubscribed channel. Visit www.sports.quickline.tv to get more information.".localizedBrand, 13.0, colorScheme)
        
        self.notSubscribedLabel.superview!.isHidden = false
    }
    
    private func prepareInfoLabel(_ colorScheme: ColorScheme) {
        self.prepareLabel(self.infoLabel, event!.formattedMovieWithCategoryString(fromRecordings: false), 18.0, colorScheme)
    }
    
    private func prepareExpireLabel(_ colorScheme: ColorScheme) {
        if let availableUntilDate = self.event!.availableUntil() {
            let now = NSDate.traxisDatetime()!
            let remainingTime = now.timeIntervalSince(availableUntilDate)
            var text: String
            
            if remainingTime > 60 {
                text = String.init(format: "Available only for %@ hours".localized, "\(Int(remainingTime / 60)):\(Int(remainingTime.truncatingRemainder(dividingBy: 60)))")
            } else {
                text = String.init(format: "Available only for %d minutes".localized, remainingTime)
            }
            
            self.prepareLabel(self.expireLabel, text, 15.0, colorScheme)
            self.expireLabel.isHidden = false
        } else {
            self.expireLabel.isHidden = true
        }
    }
    
    private func prepareRecordLabel(_ colorScheme: ColorScheme) {
        if event!.isRecording() {
            let text = NSMutableAttributedString(attributedString: NSAttributedString.recordIcon(30.0, colorScheme))
            
            text.append(NSAttributedString(string: "Scheduled for recording".localized, attributes: [ NSAttributedString.Key.font: UIFont.customFont(ofSize: 15.0), NSAttributedString.Key.foregroundColor: colorScheme.textColor() ]))
            text.addAttribute(NSAttributedString.Key.kern, value: 7.0, range: NSMakeRange(text.length - 1, 1))

            self.recordLabel.text = ""
            self.recordLabel.attributedText = text
            
            self.recordLabel.isHidden = false
        } else {
            self.recordLabel.isHidden = true
        }
    }
    
    private func prepareDescriptionLabel(_ colorScheme: ColorScheme) {
        self.prepareLabel(self.descriptionLabel, event!.summary, 15.0, colorScheme)
    }
    
    private func prepareRecommendedForYouLabel(_ colorScheme: ColorScheme) {
        self.prepareLabel(self.recommendedForYouLabel, "Recommended for you".localized, 17.0, colorScheme)
    }
    
    private func prepareLabel(_ label: UILabel, _ text: String, _ fontSize: CGFloat, _ colorScheme: ColorScheme) {
        label.text = text
        label.font = UIFont.customFont(ofSize: fontSize)
        label.textColor = colorScheme.textColor()
    }
}
