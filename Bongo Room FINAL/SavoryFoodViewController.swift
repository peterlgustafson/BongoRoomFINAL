//
//  SavoryFoodViewController.swift
//  Bongo Room FINAL
//
//  Created by Peter Gustafson on 7/11/18.
//  Copyright © 2018 Peter Gustafson. All rights reserved.
//

import UIKit

class SavoryFoodViewController: UIViewController {
    
    //Variables to keep track of name and group code
    
    var userFirstName = ""
    
    var groupCode = ""
    
    //Outlets for User First Name and Group Code
    
    @IBOutlet weak var userFirstNameLabelOutlet: UILabel!
    
    @IBOutlet weak var groupCodeLabelOutlet: UILabel!
    
    //Variable to store User Order Dictionary
    var userOrder: [String: Double] = [:]
    
    //Actions to add Items to User Order Dictionary
    
    @IBAction func breakfastBurritoAdded(_ sender: Any) {
        userOrder["Breakfast Burrito"] = 9.75
    }
    
    @IBAction func croissantSandwichAdded(_ sender: Any) {
        userOrder["Croissant Sandwich"] = 10.25
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Setting Name and Code Labels to user entry
        
        userFirstNameLabelOutlet.text = userFirstName
        
        groupCodeLabelOutlet.text = groupCode
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToSipsDrinksContoller", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSipsDrinksContoller" {
            
            let destinationVC = segue.destination as! SipsDrinksViewController
            
            destinationVC.userOrder = userOrder
            
            destinationVC.userFirstName = userFirstName
            
            destinationVC.groupCode = groupCode
            
        }
        
    }


}
