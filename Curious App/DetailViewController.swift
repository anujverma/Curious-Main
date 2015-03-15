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
    
    
    
    var carouselImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func backButtonDidTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
