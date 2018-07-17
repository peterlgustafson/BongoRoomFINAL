//
//  CheckOutViewController.swift
//  Bongo Room FINAL
//
//  Created by Peter Gustafson on 7/11/18.
//  Copyright © 2018 Peter Gustafson. All rights reserved.
//

import UIKit
import CoreLocation

class CheckOutViewController: UIViewController, CLLocationManagerDelegate {
    
    //Instance Variables - Creating Object based on CLLocationManger class
    let locationManager = CLLocationManager()
    
    //Variables to keep track of name and group code
    
    var userFirstName = ""
    
    var groupCode = ""
    
    //Outlets to keep track of user name and group code
    
    @IBOutlet weak var userFirstNameLabelOutlet: UILabel!
    
    @IBOutlet weak var groupCodeLabelOutlet: UILabel!
    
    //Outlet to keep track of user location
    
    @IBOutlet weak var userLocationLabel: UILabel!
    
    //Outlet to keep track of user selected items
    
    @IBOutlet weak var userFirstItemSelected: UILabel!
    
    @IBOutlet weak var userFirstItemSelectedPrice: UILabel!
    
    @IBOutlet weak var userSecondItemSelected: UILabel!
    
    @IBOutlet weak var userSecondItemSelectedPrice: UILabel!
    
    
    //Outlets to keep track of subtotal and final total
    
    @IBOutlet weak var subtotalLabel: UILabel!
    
    @IBOutlet weak var finalTotalLabel: UILabel!
    
    //Outlet for Remove Items Buttons
    
    @IBOutlet weak var removeFirstItemButton: UIButton!
    
    @IBOutlet weak var removeSecondItemButton: UIButton!
    
    //Actions to Remove Items from Cart
    
    @IBAction func removeFirstItemInCart(_ sender: Any) {
        
        let userSelectedItemsArray = Array(userOrder.keys)
        
        userOrder[String(userSelectedItemsArray[0])] = nil
        
        userFirstItemSelected.text = ""
        userFirstItemSelectedPrice.text = ""
        
        removeFirstItemButton.isHidden = true
        
        loadUserSelectedItems()
        
        calculateSubTotal()
        
        calculateFinalTotal()
        
    }
    
    @IBAction func removeSecondItemInCart(_ sender: Any) {
        
        let userSelectedItemsArray = Array(userOrder.keys)
        
        if userSelectedItemsArray.count > 1 {
            userOrder[String(userSelectedItemsArray[1])] = nil

        } else {
            userOrder[String(userSelectedItemsArray[0])] = nil

        }
        
        userSecondItemSelected.text = ""
        userSecondItemSelectedPrice.text = ""
        
        removeSecondItemButton.isHidden = true
        
        loadUserSelectedItems()
        
        calculateSubTotal()
        
        calculateFinalTotal()
        
    }
    
    
    
    //Variable to store User Order Dictionary
    var userOrder: [String: Double] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Setting user name and group code labels
        
        userFirstNameLabelOutlet.text = userFirstName
        
        groupCodeLabelOutlet.text = groupCode
        
        //Calling Functions to Load User Selected Items, Subtotal and Total
        
        loadUserSelectedItems()
        
        calculateSubTotal()
        
        calculateFinalTotal()
        
        //Set up Location Manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUserSelectedItems() {
        
        let userSelectedItemsArray = Array(userOrder.keys)
        
        if userSelectedItemsArray.count == 0 {
            userFirstItemSelected.text = ""
            userSecondItemSelected.text = ""
            removeFirstItemButton.isHidden = true
            removeSecondItemButton.isHidden = true
        } else if userSelectedItemsArray.count > 1 {
            userFirstItemSelected.text = String(userSelectedItemsArray[0])
            userSecondItemSelected.text = String(userSelectedItemsArray[1])
        } else {
            userFirstItemSelected.text = String(userSelectedItemsArray[0])
            userSecondItemSelected.text = ""
            removeSecondItemButton.isHidden = true
        }
        
        
        let userSelectedItemsPricesArray = Array(userOrder.values)
        
        if userSelectedItemsPricesArray.count == 0 {
            userFirstItemSelectedPrice.text = ""
            userSecondItemSelectedPrice.text = ""
            removeFirstItemButton.isHidden = true
            removeSecondItemButton.isHidden = true
        } else if userSelectedItemsPricesArray.count > 1 {
            userFirstItemSelectedPrice.text = "$ " + String(userSelectedItemsPricesArray[0])
            userSecondItemSelectedPrice.text = "$ " + String(userSelectedItemsPricesArray[1])
        } else {
            userFirstItemSelectedPrice.text = "$ " + String(userSelectedItemsPricesArray[0])
            userSecondItemSelectedPrice.text = ""
            removeSecondItemButton.isHidden = true
        }
        
    }
    
    func calculateSubTotal() {
        
        let pricesOfAllUserSelectedItemsArray = Array(userOrder.values)
        
        let userItemsSelectedSubtotal : Double = pricesOfAllUserSelectedItemsArray.reduce(0, +)
        
        subtotalLabel.text = "$ " + String(NSString(format: "%.2f", userItemsSelectedSubtotal))
        
    }
    
    func calculateFinalTotal() {
        
        let pricesOfAllUserSelectedItemsArray = Array(userOrder.values)
        
        let userItemsSelectedSubtotal : Double = pricesOfAllUserSelectedItemsArray.reduce(0, +)
        
        let totalPriceWithTax : Double = userItemsSelectedSubtotal + (userItemsSelectedSubtotal * 0.095)
        
        finalTotalLabel.text = "$ " + String(NSString(format: "%.2f",  totalPriceWithTax))

        
    }
    
    @IBAction func goBackToHomeScreenButton(_ sender: Any) {
        
        performSegue(withIdentifier: "goBackToHomeScreen", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goBackToHomeScreen" {
             let destinationVC = segue.destination as! ViewController
        }
        
    }
    
    //MARK: - Location Manager Delegate Methods
    
    //DidUpdateLocation Method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        //To make sure location is valid - if horizontal accuracy is below 0 -> invalid result
        if location.horizontalAccuracy > 0 {
            //To save memory stop updating location once we have user coordinates
            locationManager.stopUpdatingLocation()
            
            print("Longitude: \(location.coordinate.longitude), Latitude: \(location.coordinate.latitude)")
            
            lookUpCurrentLocation { geoLoc in
                print(geoLoc?.locality ?? "Unknown Geolocation")
                self.userLocationLabel.text = String(geoLoc?.locality ?? "Unknown Geolocation")
            }
        }
    }
    
    //didFailWithError method
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        //Add in "Location Unavailable" to Label here once I add in Label
//        userLocationLabel.text = "Location unavailable"
    }
    
    //Built in Apple Method to get more user friendly location name, e.g. city name
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
        -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    completionHandler(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    completionHandler(nil)
                                                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    

}
