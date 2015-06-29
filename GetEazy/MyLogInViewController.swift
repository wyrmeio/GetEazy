//
//  MyLogInViewController.swift
//  GetEazy
//
//  Created by Idris Jafer on 6/29/15.
//  Copyright (c) 2015 Wrme. All rights reserved.
//

import Foundation
import Parse
import ParseUI


class MyLogInViewController : PFLogInViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
//        self.logInView!.usernameField?.placeholder = "Email"
        
        let logoView = UIImageView(image: UIImage(named: "name"))
        self.logInView!.logo = logoView
    }
    
}
