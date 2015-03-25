//
//  DetailViewController.swift
//  Curious App
//
//  Created by Kevin Shay on 3/12/15.
//  Copyright (c) 2015 Anuj Verma. All rights reserved.
//

import UIKit
import PNChart

class DetailViewController: UIViewController, UIScrollViewDelegate {

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
    var rewindDuration:Double = 4
    var rewind:PNCircleChart!
    var scrollBackSpeed:NSTimeInterval!
    var rewindLabel:UILabel!
    
    // passing project information
    var carouselImage: String!
    var detailTitle: String!
    var detailSubLabel: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //VIGNESH - to remove instructions view from the storyboard when possible
        //Reason - Adding all of it by code
        instructions.removeFromSuperview()

        
        // Do any additional setup after loading the view.
        currentImage = imageNameMIN

        carouselImageView.image = UIImage(named: carouselImage)
        carouselImageView.userInteractionEnabled = true
        
        projectTitle.text = detailTitle
        projectDescription.text = detailSubLabel
        
        imageNamePrefix=carouselImage.componentsSeparatedByString("-") [0]
        imageNameMAX = imageNameMAXs[imageNamePrefix] as Int!
        scrollBackSpeed = NSTimeInterval( rewindDuration / Double(imageNameMAX) )
        
        //set up auto-rewind counter
        setupRewindCounter()
        
        //set up rewind message
        setupRewindLabel()

        //set up instructions
        setupInstructions()
        
        //give everything time to load and then rewind back to first step
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "resetToFirstStep", userInfo: nil, repeats: false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRewindCounter() {
        var rewindFrame:CGRect = CGRectMake(self.view.frame.width/2 - 50, 25, 100, 100)
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
        
        //setup shadow
        var layer = rewind.layer
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 6
        
        rewind.alpha = 0
        self.view.addSubview(rewind)
    }
    
    func setupRewindLabel() {
        var rewindLabelFrame:CGRect = CGRectMake(0, 150, self.view.frame.width, 40)
        rewindLabel = UILabel(frame: rewindLabelFrame)
        rewindLabel.text = "Taking you back to how it all started..."
        rewindLabel.textColor = UIColor.whiteColor()
        rewindLabel.textAlignment = NSTextAlignment.Center
        
        //setup shadow
        var layer = rewindLabel.layer
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 6
        
        rewindLabel.alpha = 0
        self.view.addSubview(rewindLabel)
    }
    
    func setupInstructions() {

        //for each image, create an instruction view and add it to the scrollview
        for var i=0; i<=imageNameMAX; i++ {
            var vframe:CGRect = CGRectMake(instructionsScrollView.frame.width * CGFloat(i), 0.0, instructionsScrollView.frame.width, instructionsScrollView.frame.height)
            var instructionView:UIView = UIView(frame: vframe)
            instructionView.userInteractionEnabled = true
            
            var stepNumFrame:CGRect = CGRectMake(10, 20, 40, 30)
            var stepNum:UILabel = UILabel(frame: stepNumFrame)
            var num = i+1
            if (num < 10) {
                stepNum.text = "0" + String(num)
            }
            else {
                stepNum.text = String(num)
            }
            stepNum.textAlignment = NSTextAlignment.Right
            stepNum.font = UIFont(name: "Edmondsans-Regular", size: 30.0)!
            instructionView.addSubview(stepNum)
            
            var stepDescFrame:CGRect = CGRectMake(60, 20, 240, instructionsScrollView.frame.height-40.0)
            var stepDesc:UILabel = UILabel(frame: stepDescFrame)
            stepDesc.text = Lorem.sentences(2)
            stepDesc.font = UIFont(name: "Edmondsans-Regular", size: 18.0)!
            stepDesc.numberOfLines = 0
            stepDesc.sizeToFit()
            instructionView.addSubview(stepDesc)
            
            instructionsScrollView.addSubview(instructionView)
            instructionsScrollView.delegate = self
        }
        
        instructionsScrollView.contentSize = CGSize(width: CGFloat(imageNameMAX+1)*instructionsScrollView.frame.width, height: instructionsScrollView.frame.height)
        println(instructionsScrollView.contentSize)
    }
    
    func resetToFirstStep() {
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.rewind.alpha = 1
            self.rewindLabel.alpha = 1
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
                    self.rewind.alpha = 0
                    self.rewindLabel.alpha = 0
                }, completion: { (Bool) -> Void in
                    self.rewind.removeFromSuperview()
                    self.rewindLabel.removeFromSuperview()
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
    
    @IBAction func instructionsDidPan(sender: UIPanGestureRecognizer) {
        println("panning")
    }
    
}
