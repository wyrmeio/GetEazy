//
//  ListingsViewController.swift
//  GetEazy
//
//  Created by Idris Jafer on 6/30/15.
//  Copyright (c) 2015 Wrme. All rights reserved.
//

import UIKit

class ListingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeListing(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func makeCall(sender: AnyObject) {
        
//        NSString *phoneNumber = [@"tel://" stringByAppendingString:mymobileNO.titleLabel.text];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];

        
        UIApplication.sharedApplication().openURL(NSURL(string: "9700957948")!)
        
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
