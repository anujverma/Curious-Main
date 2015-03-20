//
//  DetailViewController.swift
//  Curious App
//
//  Created by Kevin Shay on 3/12/15.
//  Copyright (c) 2015 Anuj Verma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var carouselImageView: UIImageView!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
    @IBOutlet weak var projectDate: UILabel!
    @IBOutlet weak var step1Button: UIButton!
    @IBOutlet weak var step2Button: UIButton!
    @IBOutlet weak var step3Button: UIButton!
    @IBOutlet weak var step4Button: UIButton!
    @IBOutlet weak var step5Button: UIButton!
    @IBOutlet weak var step6Button: UIButton!
    @IBOutlet weak var step7Button: UIButton!
    @IBOutlet weak var step8Button: UIButton!
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var buyButton: UIButton!

    //for scrubbing
    var imageNamePrefix:String = ""
    var imageNameMIN:Int = 0
    var imageNameMAX:Int = 0
    var imageNameMAXs: [String: Int!] = ["candles":32, "coaster":30, "plant":10, "string":22, "wood":16]
    var imageSpeed:CGFloat = 0.1
    var currentImage:Int!
    var initialImage:Int!
    
    
    var carouselImage: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentImage = imageNameMIN

        carouselImageView.image = UIImage(named: carouselImage)
        carouselImageView.userInteractionEnabled = true
        
        imageNamePrefix=carouselImage.componentsSeparatedByString("-") [0]
        imageNameMAX = imageNameMAXs[imageNamePrefix] as Int!
        
        
        animateImageBackToFirstStep(imageNameMAX)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateImageBackToFirstStep(current: Int) {
        
        UIView.animateWithDuration(0.05, animations: { () -> Void in
            //animate to the previous image
            var newImage: Int = current - 1
            self.carouselImageView.alpha = 0.99
            self.carouselImageView.image = UIImage(named: self.imageNamePrefix + "-" + String(newImage) + ".jpg")
            self.currentImage = newImage
            
        }) { (Bool) -> Void in
            //check if there is one more image to animate to
            self.carouselImageView.alpha = 1
            if(current > 1) {
                self.animateImageBackToFirstStep(current-1)
            }
        }
    }

    @IBAction func backButtonDidTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
  
    @IBAction func imageDidPan(sender: UIPanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            initialImage = currentImage
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            currentImage = initialImage + Int(translation.x * imageSpeed)
            if(currentImage < imageNameMIN) {
                currentImage = imageNameMIN
            }
            else if(currentImage > imageNameMAX) {
                currentImage = imageNameMAX
            }
            
            carouselImageView.image = UIImage(named: imageNamePrefix + "-" + String(currentImage) + ".jpg")
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            
        }
    }
    
    @IBAction func buyButtonWasTapped(sender: AnyObject) {
        performSegueWithIdentifier("cartSegue", sender: self)
    }
    
    
}
