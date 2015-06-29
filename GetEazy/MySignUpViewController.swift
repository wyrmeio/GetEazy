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


class MySignUpViewController : PFSignUpViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let logoView = UIImageView(image: UIImage(named: "name"))
        self.signUpView!.logo = logoView
    }
    
}

