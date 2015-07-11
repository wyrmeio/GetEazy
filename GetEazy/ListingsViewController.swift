//
//  ListingsViewController.swift
//  GetEazy
//
//  Created by Idris Jafer on 7/10/15.
//  Copyright (c) 2015 Wrme. All rights reserved.
//

import UIKit
import Parse

class ListingsViewController: UIViewController,KASlideShowDelegate {

    
    
    @IBOutlet weak var slideShow: KASlideShow!
   // @IBOutlet weak var imageView: PFImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var bed: UILabel!
    @IBOutlet weak var bath: UILabel!
    @IBOutlet weak var parking: UILabel!
    @IBOutlet weak var lift: UILabel!
    @IBOutlet weak var desc: UITextView!
    
    var data:AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let listing:PFObject = data as! PFObject
        
       // let imageView = PFImageView()
        
//        imageView.image = UIImage(named: "coming_soon")
//        imageView.file = listing["p1"] as? PFFile // remote image
//        
//        imageView.loadInBackground()
        
        
        self.name.text = listing["bhk"] as? String
        self.area.text = listing["area"] as? String
        self.address.text = listing["address"] as? String
        
        let amount = listing["price"] as! NSNumber
        self.price.text = "Rs. \(amount)"
        
        let house_type = listing["type"] as! String
        self.type.text = "For \(house_type)"
        
        self.bed.text = listing["bed"] as? String
        self.bath.text = listing["bath"] as? String
        self.parking.text = listing["parking"] as? String
        self.lift.text = listing["lift"] as? String
        
        self.desc.text = listing["desc"] as? String
        
        
        // Create a query for places
        var query = PFQuery(className:"Listings")
        // Interested in locations near user.
        
        
        query.includeKey("images")
        
        var placesObjects: PFObject? = query.getObjectWithId(listing.objectId!)
        
        let count = placesObjects?.objectForKey("images")!.objectForKey("files") as! Int
        
        
        slideShow.delegate = self
        
        slideShow.delay = 5.0
        slideShow.transitionDuration = 1
        slideShow.transitionType = KASlideShowTransitionType.Slide
        slideShow.imagesContentMode = UIViewContentMode.ScaleToFill
        

        for var i=1;i<=count;i++ {
            
            let image:PFFile = placesObjects?.objectForKey("images")!.objectForKey("p\(i)") as! PFFile
            
            image.getDataInBackgroundWithBlock { (data:NSData?, error:NSError?) -> Void in
                self.slideShow.addImage(UIImage(data: data!))
            }
            
        }
        
        slideShow.addGesture(KASlideShowGestureType.Swipe)
        
        slideShow.start()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeListing(sender: AnyObject) {
        
        self.slideShow.stop()
        self.dismissViewControllerAnimated(true, completion: nil)
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
