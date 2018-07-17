//
//  NameAndGroupCodeViewController.swift
//  Bongo Room FINAL
//
//  Created by Peter Gustafson on 7/11/18.
//  Copyright © 2018 Peter Gustafson. All rights reserved.
//

import UIKit

class NameAndGroupCodeViewController: UIViewController {
    
    //Outlets for First Name and Group Code
    
    @IBOutlet weak var userFirstNameFieldOutlet: UITextField!
    
    @IBOutlet weak var userGroupCodeFieldOutlet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToSavoryFoodController", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSavoryFoodController" {
            
            let destinationVC = segue.destination as! SavoryFoodViewController
            
            destinationVC.userFirstName = userFirstNameFieldOutlet.text!
            destinationVC.groupCode = userGroupCodeFieldOutlet.text!
            
        }
    }
    

}
