//
//  MosaicViewController.swift
//  Quickline
//
//  Created by Kristaps Freibergs on 11/12/2018.
//  Copyright © 2018 Ambrite Latvia. All rights reserved.
//

import Foundation

fileprivate let kPosterImageSizes = CGSize(width: 285, height: 424) // Hardcoded Image size
fileprivate let kMovieItemHeightForIPad = CGSize(width: 153, height: 220 + kMovieItemDescriptionHeight)
fileprivate let kMovieItemInset = 3
fileprivate let kMovieItemDescriptionHeight = CGFloat(UIDevice.isPad() ? 45 : 32)
fileprivate let kMovieItemCellIdent = "MOVIE_COLLECTION_VIEW_CELL_REUSE_IDENTIFIER"
fileprivate let kCollectionViewDefaultInsets = CGFloat(UIDevice.isPad() ? 45 : 10)
fileprivate let kCollectionViewTopInset = CGFloat(UIDevice.isPad() ? 20 : 10)
fileprivate let kCollectionViewRightInset = CGFloat(UIDevice.isPad() ? 45 : 30)
fileprivate let kTitleHeight = CGFloat(24)
fileprivate let kSubtitleHeight = CGFloat((UIDevice.isPad() ? 15 : 12))

class MosaicViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @objc var dismissVC : (() -> Void)?
    
    var titleView : QLVCenteredNavigationTitle?
    
    var topVCProtocol : MosaicScrollingProtocol?
    
    lazy var activityIndicator: QLVActivityIndicator  = {
        let indicator = QLVActivityIndicator(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        _ = indicator.pinWidthHeight(widthHeight: 60)
        indicator.layoutIfNeeded()
        indicator.forceCurrentColorScheme()
        return indicator
    }()
    
    lazy var loadingView: UIView = {
        let aView = UIView()
        aView.backgroundColor = ColorScheme.shared.backgroundColor()
        aView.addSubview(activityIndicator)
        _ = aView.pinCenter(aView: activityIndicator)
        activityIndicator.startAnimating()
        return aView
    }()
    
    @objc var topVC : UIViewController? {
        didSet {
            if let _ = topVC as? MosaicScrollingProtocol {
                topVCProtocol = topVC as? MosaicScrollingProtocol
                topVCProtocol?.navItem = navigationItem
                topVCProtocol?.contentHeightUpdated = {
                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                        self.topVC?.view.layoutIfNeeded()
                        self.collectionView.contentInset = UIEdgeInsets(top: kCollectionViewTopInset + self.topVCProtocol!.contentHeight(),
                                                                        left: kCollectionViewDefaultInsets,
                                                                        bottom: kCollectionViewDefaultInsets,
                                                                        right: kCollectionViewRightInset)
                        self.collectionView.contentOffset = CGPoint(x: -kCollectionViewDefaultInsets,
                                                                    y: -self.collectionView.contentInset.top)
                    }, completion: { (finished) in
                        if finished {
                            self.collectionView.reloadData()
                        }
                    })
                }
            }
        }
    }
    
    
    @objc var viewModel : MosaicViewModel? {
        didSet {
            viewModel?.finishedLoadingItems = {
                self.collectionView.reloadData()
                self.updateTitle()
                self.showActivityIndicator(false)
                
            }
            viewModel?.handleContentMetadataError = { (error) -> Void in
                self.handleContentMetadataError(error, with: nil, from: self)
                self.showActivityIndicator(false)
            }
            
            viewModel?.startLoadingUI = {
                self.showActivityIndicator(true)
            }
            
            viewModel?.foceExitVC = {
                if self.dismissVC != nil {
                    self.dismissVC!()
                }
            }
            
            viewModel?.shouldUpdateTitle = {
                self.updateTitle()
            }
            
            viewModel?.changedEditMode = { (editMode) -> Void in
                
                
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loadingView)
        _ = self.pinTopGuideAndRest(toView: loadingView)
        view.bringSubviewToFront(loadingView)
        view.layoutIfNeeded()
        
        collectionView.register(QLVMediaTile.self, forCellWithReuseIdentifier: kMovieItemCellIdent)
        collectionView.allowsMultipleSelection = viewModel!.supportsMultiSelect()
        
        if topVC != nil && topVCProtocol != nil {
            view.addSubview(topVC!.view)
            _ = self.pinTopGuideAndRest(toView: topVC!.view)
            view.layoutIfNeeded()
            collectionView.contentInset = UIEdgeInsets(top: kCollectionViewTopInset + topVCProtocol!.contentHeight(),
                                                       left: kCollectionViewDefaultInsets,
                                                       bottom: kCollectionViewDefaultInsets,
                                                       right: kCollectionViewRightInset)
        } else {
            collectionView.contentInset = UIEdgeInsets(top: kCollectionViewTopInset,
                                                       left: kCollectionViewDefaultInsets,
                                                       bottom: kCollectionViewDefaultInsets,
                                                       right: kCollectionViewRightInset)
        }
        
        if topVC != nil {
            topVC!.view.isHidden = true
        }
        
        view.backgroundColor = ColorScheme.shared.backgroundColor()
        
        titleView = QLVCenteredNavigationTitle(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        
        navigationItem.titleView = titleView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (viewModel?.reloadDataOnEnteringScreen())! {
            viewModel?.reloadData()
            self.activityIndicator.startAnimating()
            self.loadingView.isHidden = false
        }
    }

    func showActivityIndicator(_ show: Bool) {
        if show {
            self.activityIndicator.startAnimating()
            self.loadingView.isHidden = false
            if topVC != nil {
                topVC!.view.isHidden = true
            }
        } else {
            self.activityIndicator.stopAnimating()
            self.loadingView.isHidden = true
            if topVC != nil {
                topVC!.view.isHidden = false
            }
        }
    }
    
    func updateTitle() {
        let titleAttributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.customFont(ofSize: kTitleHeight),
                               NSAttributedString.Key.foregroundColor: ColorScheme.shared.textColor()]
        var subtitleAttributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.customFont(ofSize: kSubtitleHeight),
                                  NSAttributedString.Key.foregroundColor: ColorScheme.shared.textColor()]
        let title = NSMutableAttributedString(string: viewModel!.title(), attributes: titleAttributes as [NSAttributedString.Key : Any])
        if !viewModel!.subtitle().isEmpty {
            if UIDevice.isPad() {
                title.append(NSAttributedString(string: " "))
            } else {
                title.append(NSAttributedString(string: "\n"))
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                paragraphStyle.maximumLineHeight = 8
                subtitleAttributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
            }
            
            title.append(NSAttributedString(string: viewModel!.subtitle(), attributes: subtitleAttributes as [NSAttributedString.Key : Any]))
        }
        
        titleView?.titleLabel.attributedText = title
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if topVCProtocol != nil {
            topVCProtocol!.didScrollContent(offset: scrollView.contentOffset.y + kCollectionViewTopInset)
        }
    }
    
    // CollectionView delegate methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (viewModel?.numOfSections())!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.numOfItemsInSection(section))!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel?.itemForIndexPath(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMovieItemCellIdent, for: indexPath) as! QLVMediaTile
        cell.setMedia(item)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.isPad() {
            return kMovieItemHeightForIPad
        } else {
            let width = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right) - CGFloat(kMovieItemInset * 2))/3
            let height = (kPosterImageSizes.height/kPosterImageSizes.width) * width
            return CGSize(width: floor(width), height: height + kMovieItemDescriptionHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectedItemAtIndexPath(indexPath)
        if !(viewModel?.isItemAtIndexPathSelected(indexPath))! {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel?.selectedItemAtIndexPath(indexPath)
    }

}

protocol MosaicScrollingProtocol {
    func didScrollContent(offset: CGFloat)
    func contentHeight() -> CGFloat
    var contentHeightUpdated : (() -> Void) {get set}
    var navItem : UINavigationItem? {get set}
}
