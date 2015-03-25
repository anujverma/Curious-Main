//
//  DetailViewController.swift
//  Curious App
//
//  Created by Kevin Shay on 3/12/15.
//  Copyright (c) 2015 Anuj Verma. All rights reserved.
//

import UIKit
import PNChart

class DetailViewController: UIViewController {

    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var carouselImageView: UIImageView!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
    @IBOutlet weak var instructionsScrollView: UIScrollView!
    @IBOutlet weak var instructions: UIView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var instructionsStepNumber: UILabel!
    @IBOutlet weak var instructionsStepDescription: UILabel!
    
    //for scrubbing
    var imageNamePrefix:String = ""
    var imageNameMIN:Int = 0
    var imageNameMAX:Int = 0
    var imageNameMAXs: [String: Int!] = ["candles":32, "coaster":30, "plant":10, "string":22, "wood":16]
    var imageSpeed:CGFloat = 0.1
    var currentImage:Int!
    var initialImage:Int!
    
    //for auto scrubbing back to 1st step
    var rewind:PNCircleChart!
    var scrollBackSpeed:NSTimeInterval!
    
    // passing project information
    var carouselImage: String!
    var detailTitle: String!
    var detailSubLabel: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentImage = imageNameMIN

        carouselImageView.image = UIImage(named: carouselImage)
        carouselImageView.userInteractionEnabled = true
        
        projectTitle.text = detailTitle
        projectDescription.text = detailSubLabel
        
        instructionsStepDescription.numberOfLines = 0
        instructionsStepDescription.sizeToFit()
        
        imageNamePrefix=carouselImage.componentsSeparatedByString("-") [0]
        imageNameMAX = imageNameMAXs[imageNamePrefix] as Int!
        scrollBackSpeed = NSTimeInterval( 4 / Double(imageNameMAX) )
        
        //set up autoscrollback counter
        var rewindFrame:CGRect = CGRectMake(self.view.frame.width/2 - 50, 50, 100, 100)
        rewind = PNCircleChart(frame: rewindFrame, total: imageNameMAX, current: imageNameMAX, clockwise: false)
        rewind.total = imageNameMAX
        rewind.current = imageNameMAX
        rewind.duration = NSTimeInterval(0.5)
        rewind.chartType = PNChartFormatType.None
        rewind.countingLabel.textColor = UIColor.whiteColor()
        rewind.backgroundColor = UIColor.clearColor()
        rewind.strokeColor = UIColor.whiteColor()
        rewind.strokeChart()
        rewind.updateChartByCurrent(imageNameMAX)
        rewind.alpha = 0
        self.view.addSubview(rewind)
        
        //give everything time to load and then rewind back to first step
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "resetToFirstStep", userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetToFirstStep() {
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.rewind.alpha = 1
        })
        
        rewind.updateChartByCurrent(imageNameMAX)
        animateImageBackToFirstStep(imageNameMAX)
    }
    
    func animateImageBackToFirstStep(current: Int) {
        
        UIView.animateWithDuration(self.scrollBackSpeed, animations: { () -> Void in
            //animate to the previous image
            var newImage: Int = current - 1
            self.carouselImageView.alpha = 0.99
            self.carouselImageView.image = UIImage(named: self.imageNamePrefix + "-" + String(newImage) + ".jpg")
            self.currentImage = newImage
            
        }) { (Bool) -> Void in
            self.carouselImageView.alpha = 1
            self.rewind.updateChartByCurrent(current-1)

            //check if there is one more image to animate to
            if(current > 1) {
                self.animateImageBackToFirstStep(current-1)
            }
            
            else {
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.instructions.alpha = 1
                    self.rewind.alpha = 0
                }, completion: { (Bool) -> Void in
                    self.rewind.removeFromSuperview()
                })
                
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
