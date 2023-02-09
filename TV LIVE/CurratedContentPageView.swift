//
//  CurratedContentPageView.swift
//  Quickline
//
//  Created by Kristaps Freibergs on 28/10/2018.
//  Copyright © 2018 Ambrite Latvia. All rights reserved.
//

import Foundation

class CurratedContentPageView: BaseViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var viewModel : CurratedMoviesViewModel?
    private var pageVC : UIPageViewController?
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var hidableItems: [UIView]!
    
    @objc func setViewModel(viewModel: CurratedMoviesViewModel){
        self.viewModel = viewModel
        viewModel.updateMovies = initialPageSetup
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.currentPageIndicatorTintColor = ColorScheme.shared.primaryColor()
        pageControl.pageIndicatorTintColor = ColorScheme.shared.inactiveTextColor()
    }
    
    @IBAction func selectedPage() {
        if let vc = pageVC?.viewControllers?[0] {
            let index = (vc as! CurratedContentPage).index
            viewModel?.selectedPage(index: index!)
        }
    }
    
    @IBAction func switchPrev() {
        if let vc = pageVC?.viewControllers?[0] {
            let newVC = pageViewController(pageVC!, viewControllerBefore: vc)! as! CurratedContentPage
            pageControl.currentPage = newVC.index!
            pageVC?.setViewControllers([newVC], direction: .reverse, animated: true, completion: nil)
        }
    }
    
    @IBAction func switchNext() {
        if let vc = pageVC?.viewControllers?[0] {
            let newVC = pageViewController(pageVC!, viewControllerAfter: vc)! as! CurratedContentPage
            pageControl.currentPage = newVC.index!
            pageVC?.setViewControllers([newVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! CurratedContentPage).index! - 1
        if (index < 0){
            index = (viewModel?.getMaxIndex())!
        }
        return controllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! CurratedContentPage).index! + 1
        if (index > (viewModel?.getMaxIndex())!){
            index = 0;
        }
        
        return controllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let vc = pageVC?.viewControllers?[0] as! CurratedContentPage? {
            pageControl.currentPage = vc.index!
        }
    }
    
    func controllerAtIndex(index : Int) -> UIViewController {
        let vc = UIStoryboard.viewController(identifier: kCurratedContentSliderPageIdentifier) as! CurratedContentPage
        vc.imageUrl = viewModel?.getImageUrlAtIndex(idx: index)
        vc.titleText = viewModel?.getTitleAtIndex(idx: index)
        vc.index = index
        return vc
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UIPageViewController,
            segue.identifier == "Embedded" {
                pageVC = vc
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CurratedContentPageView.selectedPage))
                pageVC?.view.addGestureRecognizer(tapGesture)
                pageVC?.delegate = self
                pageVC?.dataSource = self
                initialPageSetup()
            
            }
    }
    
    func initialPageSetup() {
        pageVC?.setViewControllers([controllerAtIndex(index: 0)], direction: .forward, animated: false, completion: nil)
        if ((viewModel?.getMaxIndex())! > 0){
            _ = hidableItems.map{$0.isHidden = false}
            pageControl.numberOfPages = (viewModel?.getMaxIndex())!+1
        }
    }
    
}

class CurratedContentPage: BaseViewController {
    
    var imageUrl : URL?
    var index: Int?
    var titleText: String?
    
    @IBOutlet weak var movieImage: UIImageView?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelIPad: UILabel!
    @IBOutlet weak var titleLabelBackground: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabelBackground.backgroundColor = ColorScheme.shared.dimmedOutColor()
        titleLabel.textColor = ColorScheme.shared.textColor()
        titleLabel.font = UIFont.customFont(ofSize: 20)
        
        titleLabelIPad.textColor = ColorScheme.shared.textColor()
        titleLabelIPad.font = UIFont.customFont(ofSize: 24)
        titleLabelIPad.shadowOffset = CGSize(width: 0, height: 1)
        titleLabelIPad.shadowColor = ColorScheme.shared.supportingColor()
        
        if (UIDevice.isPad()){
            titleLabel.isHidden = true
            titleLabelBackground.isHidden = true
        } else {
            titleLabelIPad.isHidden = true
        }
        
        movieImage?.setImageWith(URLRequest.init(url: imageUrl!), placeholderImage: UIImage.init(named: "DefaultVideo"), success: { (_, _, image) in
            self.movieImage?.image = image
        }, failure: nil)
        titleLabel.text = titleText
        titleLabelIPad.text = titleText

    }
    
    
}
