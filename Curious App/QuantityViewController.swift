//
//  QuantityViewController.swift
//  Curious App
//
//  Created by Anuj Verma on 3/24/15.
//  Copyright (c) 2015 Anuj Verma. All rights reserved.
//

import UIKit

protocol QuantityNumberDelegate{

    func quantityAmount(info:NSString)
    
}


class QuantityViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    var isPresenting: Bool = true

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var quantityOneButton: UIButton!
    @IBOutlet weak var quantityTwoButton: UIButton! = UIButton()
    @IBOutlet weak var quantityThreeButton: UIButton!
    
    var delegate:QuantityNumberDelegate? = nil
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundView.alpha = 0.9
        println(quantityTwoButton.titleLabel!.text!)
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
    
    

    @IBAction func quantityButtonPressed(sender: AnyObject) {
        
        var btn = sender as UIButton
        
        if (delegate != nil) {
            
            if btn.tag == 2 {
            let information: NSString = quantityTwoButton.titleLabel!.text!
            delegate!.quantityAmount(information)
//            dismissViewControllerAnimated(true, completion: nil)
            } else if btn.tag == 3 {
                let information: NSString = quantityThreeButton.titleLabel!.text!
                delegate!.quantityAmount(information)
//                dismissViewControllerAnimated(true, completion: nil)
            } else if btn.tag == 1 {
                let information: NSString = quantityOneButton.titleLabel!.text!
                delegate!.quantityAmount(information)
//                dismissViewControllerAnimated(true, completion: nil)
            }
            
            dismissViewControllerAnimated(true, completion: nil)
        }
        }
    
    


}
