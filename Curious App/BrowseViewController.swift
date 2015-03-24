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
    @IBOutlet weak var bottomYellowC: UIImageView!
    @IBOutlet weak var bottomPinkC: UIImageView!
    @IBOutlet weak var bottomGreenC: UIImageView!
    @IBOutlet weak var topPinkC: UIImageView!
    @IBOutlet weak var topGreenC: UIImageView!
    @IBOutlet weak var launchScreenBackgroundView: UIView!
    
    
    //Passing info over
    var movingImageView: UIImageView!
    var isPresenting: Bool = true
    var selectedImage: NSIndexPath!

    
    var titles = [String]()
    var subLabels = [String]()
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
        
        titles = ["OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT", "OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT", "OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT", "OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT","OK STRING", "PLANT HOLDER", "COLORFUL COASTERS", "CANDLE PROJECT"]
        
        subLabels = ["Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use", "Candle so sick, you'll never want to light","Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use", "Candle so sick, you'll never want to light","Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use", "Candle so sick, you'll never want to light","Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use","Candle so sick, you'll never want to light","Colorful strings artwork", "Wooden planters that pop", "Fresh coasters that you'll want to use", "Candle so sick, you'll never want to light"]
        
        images = ["string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg"]
        
        selectedImage = NSIndexPath(forRow: 0, inSection: 0)
        
        var animateDuration = 0.5
        
        animateLaunchScreen()
        
    }
    
    //Custom Transition
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationVC = segue.destinationViewController as DetailViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        destinationVC.carouselImage = images[selectedImage.row]
        destinationVC.detailTitle = titles[selectedImage.row]
        destinationVC.detailSubLabel = subLabels[selectedImage.row]
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
        
        movingImageView = UIImageView()
        movingImageView.image = UIImage(named: images[selectedImage.row])
        
        
        var rectInTableView: CGRect = projectsTableView.rectForRowAtIndexPath(selectedImage)
        var rectInSuperview: CGRect = projectsTableView.convertRect(rectInTableView, toView: projectsTableView.superview)
        movingImageView.frame = rectInSuperview
        movingImageView.contentMode = UIViewContentMode.ScaleAspectFill
        movingImageView.clipsToBounds = true
        
        var window = UIApplication.sharedApplication().keyWindow!
       
        
        
        if (isPresenting) {
            var destinationVC = toViewController as DetailViewController
            containerView.addSubview(toViewController.view)
            
             window.addSubview(movingImageView)
        
            
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
            
            //println(images[selectedImage.row])
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                
                toViewController.view.alpha = 1
                
                self.movingImageView.frame = destinationVC.carouselImageView.frame
                
                }) { (finished: Bool) -> Void in
                    
                    self.movingImageView.removeFromSuperview()
                    self.projectsTableView.reloadData()
                    
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
        //println("\(indexPath.row)")
        selectedImage = indexPath
    
        performSegueWithIdentifier("detailSegue", sender: self)
        
        
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //println(indexPath.row)
        projectCell = tableView.dequeueReusableCellWithIdentifier("projectCellId") as ProjectCell
        projectCell.projectLabel.text = titles[indexPath.row]
        projectCell.projectSubLabel.text = subLabels[indexPath.row]
        var image = UIImage(named: images[indexPath.row])
    
        projectCell.projectImageView.image = image
        
        
        if(indexPath.row < topPhotoIndexRow) {
            projectCell.mask.alpha = TOP_alpha
            projectCell.projectLabel.transform = CGAffineTransformMakeScale(TOP_scale, TOP_scale)
            projectCell.projectLabel.center.y = 100
            projectCell.projectSubLabel.alpha = 1

        }
        else if(indexPath.row == topPhotoIndexRow) {
            projectCell.mask.alpha = newAlpha
            projectCell.projectLabel.transform = CGAffineTransformMakeScale(newScale, newScale)
            projectCell.projectLabel.center.y = newHeight/2
            projectCell.projectSubLabel.alpha = (newHeight - 100) / 100
        }
        else {
            projectCell.mask.alpha = BOTTOM_alpha
            projectCell.projectLabel.transform = CGAffineTransformMakeScale(BOTTOM_scale, BOTTOM_scale)
            projectCell.projectLabel.center.y = 50
            projectCell.projectSubLabel.alpha = 0
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
    
    func animateLaunchScreen(){
        
        UIView.animateKeyframesWithDuration(0.4, delay: 0.1, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.bottomYellowC.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(-200), CGAffineTransformMakeTranslation(0, 300))
        }) { (Bool) -> Void in
            //
        }
        
        UIView.animateKeyframesWithDuration(0.4, delay: 0.4, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            //
            self.bottomPinkC.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(200), CGAffineTransformMakeTranslation(0, 300))
            
            }) { (Bool) -> Void in
                //
        }
        
        UIView.animateKeyframesWithDuration(0.4, delay: 0.6, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            //
            self.bottomGreenC.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(-300), CGAffineTransformMakeTranslation(0, 300))
            
            }) { (Bool) -> Void in
                //
        }
        
        UIView.animateKeyframesWithDuration(0.4, delay: 0.8, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            //
            self.topPinkC.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(300), CGAffineTransformMakeTranslation(0, 400))
            
            }) { (Bool) -> Void in
                //
        }
        
        UIView.animateKeyframesWithDuration(0.4, delay: 0.9, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            //
            self.topGreenC.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(-400), CGAffineTransformMakeTranslation(0, 450))
            
            }) { (Bool) -> Void in
                //
        }
        
        UIView.animateKeyframesWithDuration(0.4, delay: 1.0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.launchScreenBackgroundView.transform = CGAffineTransformMakeTranslation(0, 600)
            
            }) { (Bool) -> Void in
                //
                self.launchScreenBackgroundView.hidden = true
                self.bottomYellowC.hidden = true
                self.bottomPinkC.hidden = true
                self.bottomGreenC.hidden = true
                self.topPinkC.hidden = true
                self.topGreenC.hidden = true
        }
    }

    
}




















