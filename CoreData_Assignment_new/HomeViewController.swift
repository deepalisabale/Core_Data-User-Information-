//
//  HomeViewController.swift
//  CoreData_Assignment_new
//
//  Created by Deepali on 06/04/24.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var extractedName : String?
    var extractedPassword : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //This will be the code for saving the data
   
    @IBAction func saveData(_ sender: Any) {
        
        extractedName = self.userNameTextField.text
        extractedPassword = self.passwordTextField.text
        
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(
            forEntityName: "User", in: managedContext)
        let userObject = NSManagedObject(
            entity:userEntity!, insertInto: managedContext)
        
        userObject.setValue(extractedName, forKey: "username")
        userObject.setValue(extractedPassword, forKey: "password")
        
        do{
       try managedContext.save()
            
            print("Data Saved Successfully!")
        }
        catch{
            print("Error Occured...")
            
        }
        
        
        
    }
    
}
