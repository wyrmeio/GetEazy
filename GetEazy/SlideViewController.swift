//
//  SlideViewController.swift
//  GetEazy
//
//  Created by Idris Jafer on 7/10/15.
//  Copyright (c) 2015 Wrme. All rights reserved.
//

import UIKit
import Parse

class SlideViewController: UIViewController,KASlideShowDelegate {

    @IBOutlet weak var slide: KASlideShow!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
        let userGeoPoint = PFGeoPoint(latitude: 17.402561, longitude: 78.484803)
        // Create a query for places
        var query = PFQuery(className:"Listings")
        // Interested in locations near user.
      
        
       query.includeKey("images")
    
        var placesObjects: PFObject? = query.getObjectWithId("jawroCGi94")
        
            let temp = placesObjects?.objectForKey("images")!.objectForKey("files")
            println(temp)
            println(placesObjects)
            
         slide.delegate = self
        
        slide.delay = 3.0
        slide.transitionDuration = 1
        slide.transitionType = KASlideShowTransitionType.Slide
        slide.imagesContentMode = UIViewContentMode.ScaleToFill
        
//        PFFile *eventImage = [[loadimagesarray objectAtIndex:indexPath.row] objectForKey:@"ProfileImageFile"]; //ProfileImageFile is the name of key you stored the image file
//        
//        if(eventImage != NULL)
//        {
//            
//            [eventImage getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
//                
//                UIImage *thumbnailImage = [UIImage imageWithData:imageData];
//                UIImageView *thumbnailImageView = [[UIImageView alloc] initWithImage:thumbnailImage];
//                
//                cell.yourimageview.image = thumbnailImageView.image;
//                
//                }];
//            
//        }

        
        for var i=1;i<=4;i++ {
            
            let image:PFFile = placesObjects?.objectForKey("images")!.objectForKey("p\(i)") as! PFFile
            
            image.getDataInBackgroundWithBlock { (data:NSData?, error:NSError?) -> Void in
                self.slide.addImage(UIImage(data: data!))
            }
            
        }
       

        
        
        
        
      //  slide.addImagesFromResources(["test_1.jpeg","test_2.jpeg","test_3.jpeg"])
        slide.addGesture(KASlideShowGestureType.Swipe)
        
        slide.start()
        
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

}
