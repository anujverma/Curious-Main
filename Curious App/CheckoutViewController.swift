//
//  CheckoutViewController.swift
//  Curious App
//
//  Created by Anuj Verma on 3/25/15.
//  Copyright (c) 2015 Anuj Verma. All rights reserved.
//

import UIKit
import Spring

class CheckoutViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    var isPresenting: Bool = true
    
    @IBOutlet weak var sendMeButton: UIButton!
    @IBOutlet weak var checkoutMainImage: SpringImageView!
    @IBOutlet weak var checkoutGiftBox: SpringImageView!
    @IBOutlet weak var checkoutGiftBoxTop: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundView.alpha = 0.9
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 1.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.checkoutMainImage.transform = CGAffineTransformMakeTranslation(0, 100)
            self.checkoutGiftBox.transform = CGAffineTransformMakeTranslation(0, 100)
            
            }, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        var cartVC = fromViewController as CartViewController
        var imageFromCart = cartVC.cartMainImage
        self.checkoutMainImage.image = imageFromCart.image
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
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
    

    
    @IBAction func finalBuyButton(sender: AnyObject) {
//        checkoutGiftBox.animation = "zoomOut"
//        checkoutGiftBox.animate()
        
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.checkoutGiftBox.center.y = -300
            self.checkoutGiftBox.animation = "fadeOut"
            self.checkoutGiftBox.animationDuration = NSTimeInterval(1.0)
            self.checkoutGiftBox.animate()
            
            self.checkoutMainImage.center.y = -300
            self.checkoutMainImage.animation = "fadeOut"
            self.checkoutMainImage.animationDuration = NSTimeInterval(1.0)
            self.checkoutMainImage.animate()
            
            UIView.animateKeyframesWithDuration(0.2, delay: 0.1, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.sendMeButton.center.y = 1000
            }, completion: nil)
            
        }) { (Bool) -> Void in
            self.performSegueWithIdentifier("backBrowseSegue", sender: self)
        }
        
    }
    


}
