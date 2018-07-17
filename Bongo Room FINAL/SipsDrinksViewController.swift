//
//  SipsDrinksViewController.swift
//  Bongo Room FINAL
//
//  Created by Peter Gustafson on 7/11/18.
//  Copyright © 2018 Peter Gustafson. All rights reserved.
//

import UIKit

class SipsDrinksViewController: UIViewController {
    
    //Variables to keep track of name and group code
    
    var userFirstName = ""
    
    var groupCode = ""
    
    //Outlets to keep track of user name and group code
    
    @IBOutlet weak var userFirstNameLabelOutlet: UILabel!
    
    @IBOutlet weak var groupCodeLabelOutlet: UILabel!
    
    
    //Variable to store User Order Dictionary
    var userOrder: [String: Double] = [:]
    
    //Actions to add items to User Order Dictionary
    
    @IBAction func coffeeAdded(_ sender: Any) {
        userOrder["Coffee"] = 3.25
    }
    
    @IBAction func latteAdded(_ sender: Any) {
        userOrder["Latte"] = 5.25
    }
    
    @IBAction func mochaAdded(_ sender: Any) {
        userOrder["Mocha"] = 5.25
    }
    
    
    //Outlet for Order so far label
    
    @IBOutlet weak var userOrderSoFarLabelOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Setting user label order equal to order so far
        var userOrderItemsArray = Array(userOrder.keys)
        
        if userOrderItemsArray.count > 0 {
            userOrderSoFarLabelOutlet.text = String(userOrderItemsArray[0])
        } else {
            userOrderSoFarLabelOutlet.text = "Nothing so far"
        }
        
        
        //Setting user name and group code labels
        
        userFirstNameLabelOutlet.text = userFirstName
        
        groupCodeLabelOutlet.text = groupCode
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkOutButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToCheckOutController", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToCheckOutController" {
            
            let destinationVC = segue.destination as! CheckOutViewController
            
            destinationVC.userOrder = userOrder
            
            destinationVC.userFirstName = userFirstName
            
            destinationVC.groupCode = groupCode
            
        }
        
    }
    

}
