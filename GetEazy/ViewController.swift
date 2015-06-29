//
//  ViewController.swift
//  GetEazy
//
//  Created by Idris Jafer on 6/28/15.
//  Copyright (c) 2015 Wrme. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import FBSDKCoreKit
import GoogleMaps

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, GMSMapViewDelegate  {

    @IBOutlet weak var mapView: UIView!
   
    var camera:GMSCameraPosition? = nil
    var maps:GMSMapView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
           }
    
    
    override func viewDidAppear(animated: Bool) {
        var user = PFUser.currentUser()
        
        if PFUser.currentUser() == nil
        {
            
        var login: MyLogInViewController = MyLogInViewController()
            login.fields = (PFLogInFields.UsernameAndPassword
                | PFLogInFields.Facebook
                | PFLogInFields.Twitter | PFLogInFields.LogInButton
                | PFLogInFields.SignUpButton
                | PFLogInFields.PasswordForgotten
                | PFLogInFields.DismissButton)
            login.delegate = self
            login.facebookPermissions=["email","public_profile","user_friends"]
            
            var signin: MySignUpViewController = MySignUpViewController()
            signin.delegate = self
            
            login.signUpController = signin
            
            self.presentViewController(login, animated: true, completion: nil)
            
        }
        else {
           self.dismissViewControllerAnimated(true, completion: nil)
            
            
            self.camera=GMSCameraPosition.cameraWithLatitude(17.37000,longitude: 78.48000, zoom: 10)
            self.maps=GMSMapView.mapWithFrame(mapView.bounds, camera: self.camera)
            self.maps!.delegate = self
            
            self.mapView.addSubview(self.maps!)
            
            var marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(17.3700, 78.4800)
            marker.title = "Hyderabad"
            marker.snippet = "Telangana"
            marker.map = self.maps
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if (!username.isEmpty || !password.isEmpty) {
            return true
        }else {
            return false
        }
        
    }

    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
        if (PFTwitterUtils.isLinkedWithUser(user)) {
            
            var twitterUsername = PFTwitterUtils.twitter()!.screenName
            
            PFUser.currentUser()!.username = twitterUsername
            
            PFUser.currentUser()!.saveEventually(nil)
            
        }
        else if(PFFacebookUtils.isLinkedWithUser(user)){
            
            
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
            graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                
                if ((error) != nil)
                {
                    // Process error
                    println("Error: \(error)")
                }
                else
                {
                    
                    PFUser.currentUser()!["name"] = result.valueForKey("name") as? String
                    PFUser.currentUser()!.email = result.valueForKey("email") as? String
                    PFUser.currentUser()!["gender"] = result.valueForKey("gender") as? String
                    
                    PFUser.currentUser()!.saveEventually(nil)

                    
                }
            })
            
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        
        
        if (PFTwitterUtils.isLinkedWithUser(user)) {
            
            var twitterUsername = PFTwitterUtils.twitter()!.screenName
            
            PFUser.currentUser()!.username = twitterUsername
            
            PFUser.currentUser()!.saveEventually(nil)
            
        } else if(PFFacebookUtils.isLinkedWithUser(user)){
            
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
            graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                
                if ((error) != nil)
                {
                    // Process error
                    println("Error: \(error)")
                }
                else
                {
                    
                    PFUser.currentUser()!["name"] = result.valueForKey("name") as? String
                    PFUser.currentUser()!.email = result.valueForKey("email") as? String
                    PFUser.currentUser()!["gender"] = result.valueForKey("gender") as? String
                    
                    PFUser.currentUser()!.saveEventually(nil)
                    
                    
                }
            })
           
        }
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        
        println("Failed to sign up...")
        
    }
    
    
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        
        println("User dismissed sign up.")
        
    }
    
   
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

