//
//  BrowseViewController.swift
//  Curious App
//
//  Created by Anuj Verma on 3/12/15.
//  Copyright (c) 2015 Anuj Verma. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning  {
    
    @IBOutlet weak var projectsTableView: UITableView!
    
    
    var isPresenting: Bool = true
    var selectedImage: Int!
    
    var titles = [String]()
    var images = [String]()
    var projectCell: ProjectCell!
    
    var topPhotoIndexRow:Int = 0
    var newHeight:CGFloat! = 200
    var newAlpha:CGFloat!
    var newScale:CGFloat!
    
    var TOP_alpha:CGFloat! = 0.2
    var BOTTOM_alpha:CGFloat! = 0.7
    var TOP_scale:CGFloat! = 1.5
    var BOTTOM_scale:CGFloat! = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newAlpha = TOP_alpha
        newScale = TOP_scale
        
        projectsTableView.dataSource = self
        projectsTableView.delegate = self
        
        titles = ["OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT", "OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT", "OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT", "OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT"]
        images = ["string-23.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-23.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-23.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-23.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg"]
        
        var animateDuration = 0.5
    }
    
    //Custom Transition
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationVC = segue.destinationViewController as DetailViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        destinationVC.carouselImage = images[selectedImage]
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
 
    
        
        if (isPresenting) {
            var destinationVC = toViewController as DetailViewController
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            destinationVC.detailView.alpha = 0
            destinationVC.instructions.alpha = 0
            destinationVC.step1Button.transform = CGAffineTransformMakeScale(0, 0)
            destinationVC.step2Button.transform = CGAffineTransformMakeScale(0, 0)
            destinationVC.step3Button.transform = CGAffineTransformMakeScale(0, 0)
            destinationVC.step4Button.transform = CGAffineTransformMakeScale(0, 0)
            destinationVC.step5Button.transform = CGAffineTransformMakeScale(0, 0)
            destinationVC.step6Button.transform = CGAffineTransformMakeScale(0, 0)
            destinationVC.step7Button.transform = CGAffineTransformMakeScale(0, 0)
            destinationVC.step8Button.transform = CGAffineTransformMakeScale(0, 0)
            
            
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    
                    // Give time for the scrubbable carousel image to rewind back, and then fade in everything else below.
                    UIView.animateWithDuration(0.5, delay: 0.1, options: nil, animations: { () -> Void in
                        destinationVC.detailView.alpha = 1
                        }, completion: { (finished) -> Void in
                            
                            //animating the steps buttons in when detailView is loaded
                            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                                destinationVC.step1Button.transform = CGAffineTransformMakeScale(1, 1)
                                destinationVC.instructions.alpha = 1
                                
                                UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                                    destinationVC.step2Button.transform = CGAffineTransformMakeScale(1, 1)
                                    }, completion: nil)
                                
                                UIView.animateWithDuration(0.3, delay: 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                                    destinationVC.step3Button.transform = CGAffineTransformMakeScale(1, 1)
                                    }, completion: nil)
                                
                                UIView.animateWithDuration(0.3, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                                    destinationVC.step4Button.transform = CGAffineTransformMakeScale(1, 1)
                                    }, completion: nil)
                                
                                UIView.animateWithDuration(0.3, delay: 0.15, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil
                                    , animations: { () -> Void in
                                        destinationVC.step5Button.transform = CGAffineTransformMakeScale(1, 1)
                                    }, completion: nil)
                                
                                UIView.animateWithDuration(0.3, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                                    destinationVC.step6Button.transform = CGAffineTransformMakeScale(1, 1)
                                    }, completion: nil)
                                
                                UIView.animateWithDuration(0.3, delay: 0.25, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                                    destinationVC.step7Button.transform = CGAffineTransformMakeScale(1, 1)
                                    }, completion: nil)
                                
                                UIView.animateWithDuration(0.3, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                                    destinationVC.step8Button.transform = CGAffineTransformMakeScale(1, 1)
                                    }, completion: { (finished) -> Void in
                                        
                                })
                                
                                
                                }, completion: nil)
                    })
                    
                    transitionContext.completeTransition(true)
            }
            
            
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("\(indexPath.row)")
        selectedImage = indexPath.row
        performSegueWithIdentifier("detailSegue", sender: self)
        
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        projectCell = tableView.dequeueReusableCellWithIdentifier("projectCellId") as ProjectCell
        projectCell.projectLabel.text = titles[indexPath.row]
        var image = UIImage(named: images[indexPath.row])

    
        projectCell.projectImageView.image = image
        
        
        if(indexPath.row < topPhotoIndexRow) {
            projectCell.mask.alpha = TOP_alpha
            projectCell.projectLabel.transform = CGAffineTransformMakeScale(TOP_scale, TOP_scale)
            projectCell.projectLabel.center.y = 100
        }
        else if(indexPath.row == topPhotoIndexRow) {
            projectCell.mask.alpha = newAlpha
            projectCell.projectLabel.transform = CGAffineTransformMakeScale(newScale, newScale)
            projectCell.projectLabel.center.y = newHeight/2
        }
        else {
            projectCell.mask.alpha = BOTTOM_alpha
            projectCell.projectLabel.transform = CGAffineTransformMakeScale(BOTTOM_scale, BOTTOM_scale)
            projectCell.projectLabel.center.y = 50
        }
        
        
        return projectCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return images.count
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var visiblePhotos = projectsTableView.indexPathsForVisibleRows() as [NSIndexPath]
        var rectInTableView: CGRect = projectsTableView.rectForRowAtIndexPath(visiblePhotos[1])
        var rectInSuperview: CGRect = projectsTableView.convertRect(rectInTableView, toView: projectsTableView.superview)
        
        newHeight = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, 200, 200, 100))
        newAlpha = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, 200, Float(self.TOP_alpha), Float(self.BOTTOM_alpha)))
        newScale = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, 200, Float(self.TOP_scale), Float(self.BOTTOM_scale)))
        topPhotoIndexRow = visiblePhotos[1].row
        
        projectsTableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row < topPhotoIndexRow) { return 200 }
        else if(indexPath.row == topPhotoIndexRow) { return newHeight }
        else { return 100 }
    }
    
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var visiblePhotos = projectsTableView.indexPathsForVisibleRows() as [NSIndexPath]
        
        if(velocity.y <= 0) {
            var rectInTableView: CGRect = projectsTableView.rectForRowAtIndexPath(visiblePhotos[0])
            targetContentOffset.memory.y = rectInTableView.origin.y
            
        }
        else {
            var rectInTableView: CGRect = projectsTableView.rectForRowAtIndexPath(visiblePhotos[1])
            targetContentOffset.memory.y = rectInTableView.origin.y
            
        }
        
    }
    

    
}




















