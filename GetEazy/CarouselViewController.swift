//
//  ListingsViewController.swift
//  GetEazy
//
//  Created by Idris Jafer on 6/30/15.
//  Copyright (c) 2015 Wrme. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController,iCarouselDataSource, iCarouselDelegate {

    // not Needed
    var items: [Int] = []
    
    // Just add the images and put the image name in this array ur carousel is ready for you :) Insert the Image names Here
    var pageImages: NSArray = NSArray(objects: "3","4","5","6","2","3","4","5","6","2","3","4","5","6","2","3","4","5","6","2","3","4","5","6","2","3","4","5","6","2","3","4","5","6","2","3","4","5","6","2","3","4","5","6","2","3","4","5","6")
    
    var carouselSize: CGFloat! = 2.0
    
    var carouselBorderWidth: CGFloat! = 0.5
    
    
    
    var imageView: UIImageView!
    
    //Values - Row1
    let carouselType = ["Linear", "Rotary", "InvertedRotary", "Cylinder", "InvertedCylinder", "Wheel", "InvertedWheel", "CoverFlow", "CoverFlow2", "TimeMachine","InvertedTimeMachine"]
    
    //Values - Row2
    let shape = ["Horizontal","Vertical"]
    
    let size = ["0","20","50","70","100","200"]
    
    @IBOutlet weak var carousel: iCarousel!
    
    func numberOfItemsInCarousel(carousel: iCarousel!) -> Int
    {
        
        return pageImages.count
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    //Customising the Carouselview
    func carousel(carousel: iCarousel!, viewForItemAtIndex index: Int, reusingView view: ReflectionView!) -> UIView {
        
        var label: UILabel! = nil
        
        var newView = view
        
        var itemWidth:CGFloat! = 0.0
        var itemHeight:CGFloat! = 0.0
        
        
        //create new view if no view is available for recycling
        if (newView == nil)
        {
            //don't do anything specific to the index within
            //this `if (view == nil) {...}` statement because the view will be
            //recycled and used with other index values later
            
            // Invoking the reflection View and Change the size of View according to device width and height - This code enable the reSizing for both iPhone and iPad
            
            
            switch (UIDevice.currentDevice().userInterfaceIdiom) {
                
            case .Phone:
                
                
                switch (UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
                    
                case true:
                    
                    //itemWidth =  self.view.frame.width/2.84
                    
                    itemHeight =  self.view.frame.height/1.5
                    
                    
                    itemWidth =  itemHeight
                    
                    
                    println(" iPhone LandsCape : Item Width: \(itemWidth) Item Height: \(itemHeight) : Screen Width: \(self.view.frame.width) : Screen Height: \(self.view.frame.height)")
                    
                    break;
                    
                case false:
                    
                    itemWidth =  self.view.frame.width/1.5
                    
                    itemHeight = itemWidth
                    
                    println(" iPhone Portait : Item Width: \(itemWidth) Item Height: \(itemHeight) : Screen Width: \(self.view.frame.width) : Screen Height: \(self.view.frame.height)")
                    
                    
                    break;
                    
                default:
                    
                    break;
                    
                }
                
                
                
                
                break;
                
            case .Pad:
                
                switch (UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
                    
                case true:
                    
                    itemHeight =  self.view.frame.height/2
                    
                    
                    itemWidth =  itemHeight
                    
                    println(" iPad LandsCape : Item Width: \(itemWidth) Item Height: \(itemHeight) : Screen Width: \(self.view.frame.width) : Screen Height: \(self.view.frame.height)")
                    
                    break;
                    
                case false:
                    
                    itemWidth =  self.view.frame.width/2
                    
                    itemHeight = itemWidth
                    
                    println(" iPad Portait : Item Width: \(itemWidth) Item Height: \(itemHeight) : Screen Width: \(self.view.frame.width) : Screen Height: \(self.view.frame.height)")
                    
                    
                    break;
                    
                default:
                    
                    break;
                    
                }
                
                
                
                
                break
            default:
                break;
            }
            
            
            
            
            newView = ReflectionView(frame:CGRectMake(0, 0, itemWidth, itemHeight))
            
            
        
            newView.layer.borderWidth = carouselBorderWidth
            
            
            
            
            newView.layer.borderColor = UIColor.whiteColor().CGColor
            
            //newView.layer.masksToBounds = true
            
            //newView.backgroundColor = UIColor.redColor()
            
            imageView = UIImageView(frame: newView.bounds)
            
            imageView.image = UIImage(named: pageImages[index] as! String)
            
            imageView.layer.cornerRadius = carouselSize
            
            imageView.layer.masksToBounds = true
            
            
            
            /*Change content mode to fit the Image*/
            imageView.contentMode = .ScaleToFill
            
            newView.addSubview(imageView)
            
            //(newView as! ReflectionView!).image = UIImage(named: "page.png")
            newView.contentMode = .Center
            
            
            // Not used as far of now - will be sued if u want to display bale in carousel
            label = UILabel(frame:newView.bounds)
            
            label.backgroundColor = UIColor.clearColor()
            
            label.textAlignment = .Center
            
            label.font = label.font.fontWithSize(50)
            
            label.tag = 1
            
            newView.addSubview(label)
            
        } else {
            
            //get a reference to the label in the recycled view
            label = newView.viewWithTag(1) as! UILabel!
        }
        
        
        // Retun the reflection View
        return newView
        
    }
    
    
    func carousel(carousel: iCarousel!, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
        
    {
        
        if (option == .Spacing)
        {
            
            return value * 1.1
            
        }
        
        return value
    }
    
    
    override func viewWillLayoutSubviews() {
        
        
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        carousel.type  = .Linear
        
        carousel.vertical = false
        
        carouselSize = 0.0
        
        
        carouselBorderWidth = 0.5
        
        carousel.reloadData()
    }
    
    

}
