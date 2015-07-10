//
//  ListingsViewController.swift
//  GetEazy
//
//  Created by Idris Jafer on 7/10/15.
//  Copyright (c) 2015 Wrme. All rights reserved.
//

import UIKit
import Parse

class ListingsViewController: UIViewController {

    
    
    @IBOutlet weak var imageView: PFImageView!
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
        
        imageView.image = UIImage(named: "coming_soon")
        imageView.file = listing["p1"] as! PFFile // remote image
        
        imageView.loadInBackground()
        
        self.name.text = listing["bhk"] as! String
        self.area.text = listing["area"] as! String
        self.address.text = listing["address"] as! String
        
        let amount = listing["price"] as! NSNumber
        self.price.text = "Rs. \(amount)"
        
        let house_type = listing["type"] as! String
        self.type.text = "For \(house_type)"
        
        self.bed.text = listing["bed"] as! String
        self.bath.text = listing["bath"] as! String
        self.parking.text = listing["parking"] as! String
        self.lift.text = listing["lift"] as! String
        
        self.desc.text = listing["desc"] as! String
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeListing(sender: AnyObject) {
        
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
