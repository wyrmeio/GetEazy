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
import GooglePlacesAutocomplete

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, GMSMapViewDelegate,UITextFieldDelegate,GooglePlacesAutocompleteDelegate,CLLocationManagerDelegate  {

   
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var location: UITextField!
   
    var manager:CLLocationManager?
    var path:String!
    
    var locationMarker:GMSMarker!
    
    var locationManager = LocationManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       // self.location.rightView = UIView()
        
        path=fileInDocumentsDirectory("location.plist")
        self.location.delegate=self
        
        self.manager=CLLocationManager()
        self.manager?.requestWhenInUseAuthorization()
        
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
            
            
            let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(17.37000,longitude: 78.48000, zoom: 15)
            self.mapView.camera = camera
            self.mapView.delegate = self
            
            var marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(17.3700, 78.4800)
            marker.title = "Hyderabad"
            marker.snippet = "Telangana"
            marker.map = self.mapView
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        let gpaViewController = GooglePlacesAutocomplete(
            apiKey: "AIzaSyCAqLMNj_e3OHZfG9Qm1gRf6tsPLJGHGIA",
            placeType: .Address
        )
        
        gpaViewController.placeDelegate = self // Conforms to GooglePlacesAutocompleteDelegate
        
        gpaViewController.navigationBar.barStyle = UIBarStyle.Black
        gpaViewController.navigationBar.translucent = true
        gpaViewController.navigationBar.barTintColor = UIColor(red: 0.11, green: 0.27, blue: 0.53, alpha: 1.0)
        gpaViewController.navigationBar.tintColor = UIColor.whiteColor()
        gpaViewController.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Copperplate", size: 25.0)!]
        
        gpaViewController.navigationItem.title = "Enter Location"
        
        self.presentViewController(gpaViewController, animated: true, completion: nil)
    }
    
   
    @IBAction func getCurrentLocation(sender: UIBarButtonItem) {
        
        if CLLocationManager.authorizationStatus() ==  CLAuthorizationStatus.Denied || CLLocationManager.authorizationStatus() ==  CLAuthorizationStatus.Restricted{
            NSLog("Location permission denied" )
        }
        else{
            self.manager?.delegate = self
            self.manager?.desiredAccuracy=kCLLocationAccuracyBest
            self.manager?.startUpdatingLocation()
            
        }
        
    }
    
    @IBAction func changeMapType(sender: UIBarButtonItem) {
        
        let actionSheet = UIAlertController(title: "Map Types", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let normalMapTypeAction = UIAlertAction(title: "Normal", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.mapView.mapType = kGMSTypeNormal
        }
        
        let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.mapView.mapType = kGMSTypeTerrain
        }
        
        let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.mapView.mapType = kGMSTypeHybrid
        }
        
        let satelliteMapTypeAction = UIAlertAction(title: "Satellite", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.mapView.mapType = kGMSTypeSatellite
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(satelliteMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if let location = locations.last as? CLLocation{
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            self.manager?.stopUpdatingLocation()
            
            var newLoc: CLLocation =  CLLocation(latitude: lat, longitude: lng)
            NSKeyedArchiver.archiveRootObject(newLoc, toFile: path)

    
            locationManager.reverseGeocodeLocationUsingGoogleWithLatLon(latitude: lat, longitude: lng) { (reverseGeocodeInfo, placemark, error) -> Void in
              
                let place=reverseGeocodeInfo! as NSDictionary
               
                self.location.text = place["formattedAddress"]! as! String
            }
            
            let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(lat,longitude: lng, zoom: 15)
            self.mapView.camera = camera
            
            locationMarker = GMSMarker(position: location.coordinate)
            locationMarker.map = self.mapView
            
            locationMarker.appearAnimation = kGMSMarkerAnimationPop
            locationMarker.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
            locationMarker.opacity = 0.75
            
           // locationMarker.flat = true
           
        }
        
    }
    
    func documentsDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        return documentsFolderPath
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        return documentsDirectory().stringByAppendingPathComponent(filename)
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: GooglePlacesAutocompleteDelegate {
    func placeSelected(place: Place) {
        println(place.id)
        // A hotel in Saigon with an attribution.
        let placeID = place.id
        
        let placesClient:GMSPlacesClient=GMSPlacesClient()
        
        placesClient.lookUpPlaceID(placeID, callback: { (place:GMSPlace?, error:NSError?) -> Void in
            if error != nil {
                println("lookup place id query error: \(error!.localizedDescription)")
                return
            }
            
            if place != nil {
                
                self.location.text = place!.name as String
                println("Place name \(place!.name)")
                println("Place name \(place!.coordinate.latitude)")
                println("Place name \(place!.coordinate.longitude)")
                println("Place address \(place!.formattedAddress)")
                
            } else {
                println("No place details for \(placeID)")
            }
        })
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func placeViewClosed() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}



