//
//  CartViewController.swift
//  Curious App
//
//  Created by Anuj Verma on 3/19/15.
//  Copyright (c) 2015 Anuj Verma. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var backgroundGreenView: UIView!
    @IBOutlet weak var cartBuyButton: UIButton!
    
    var isPresenting: Bool = true
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        cartBuyButton.center.y = 620
        cartBuyButton.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(0.4, animations: { () -> Void in
//            self.backgroundGreenView.frame = CGRect(x: 0, y: 0, width: 320, height: 30)
//        })
        
        UIView.animateKeyframesWithDuration(0.4, delay: 0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.backgroundGreenView.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
            }) { (Bool) -> Void in
                //
        }
        
        UIView.animateWithDuration(0.4, delay: 1.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 20, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.cartBuyButton.center.y = 520
            self.cartBuyButton.alpha = 1
        }) { (Bool) -> Void in
            //
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.cartBuyButton.center.y = 620
            self.cartBuyButton.alpha = 0
            }) { (Bool) -> Void in
                //
        }
        
        UIView.animateKeyframesWithDuration(0.4, delay: 0.2, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.backgroundGreenView.frame = CGRect(x: 16, y: 330, width: 288, height: 30)
        }, completion: nil)
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
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.2, delay: 0, options: nil, animations: { () -> Void in
                toViewController.view.alpha = 1

                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
        } else {
            UIView.animateWithDuration(0.4, delay: 0.4, options: nil, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}