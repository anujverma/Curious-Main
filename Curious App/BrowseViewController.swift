//
//  BrowseViewController.swift
//  Curious App
//
//  Created by Anuj Verma on 3/12/15.
//  Copyright (c) 2015 Anuj Verma. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var projectsTableView: UITableView!
    
    
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
        
        titles = ["OK String", "Plant Holder", "Colorful Coasters", "Candle Project", "OK String", "Plant Holder", "Colorful Coasters", "Candle Project", "OK String", "Plant Holder", "Colorful Coasters", "Candle Project",  ]
        images = ["string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg", "string-22.jpg", "plant-10.jpg",  "coaster-30.jpg", "candles-32.jpg"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
