//
//  ListOfUsersViewController.swift
//  CoreData_Assignment_new
//
//  Created by Deepali on 06/04/24.
//

import UIKit
import CoreData

class ListOfUsersViewController: UIViewController,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var usersTableView: UITableView!
    
    var usernames : [String] = []
    var passwords : [String] = []
    var retrievedUserRecords : [NSManagedObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //important step
        usersTableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
        retrieveUserRecords()
    }

    func retrieveUserRecords(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")

        do{
            retrievedUserRecords  = try managedContext.fetch(fetchRequest) as! [NSManagedObject]

            for eachRetrievedRecord in retrievedUserRecords  as! [NSManagedObject] {
                self.usernames.append(eachRetrievedRecord.value(forKey: "username") as! String)
                self.passwords.append(eachRetrievedRecord.value(forKey: "password") as! String)
                
                self.usersTableView.reloadData()   //to load table view
            }
        }
        catch
        {
            print(error)
        
        }
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            usernames.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.usersTableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
            cell.textLabel?.text = usernames[indexPath.row]
            //cell.textLabel?.text = passwords[indexPath.row]
            return cell
            
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            if editingStyle == .delete{
                
                self.usersTableView.beginUpdates()
                
                //deleting user records from core data permanently
                //managedContext.delete(retrievedUserRecords![indexPath.row])
                
                //to delete a row from users table
                self.usersTableView.deleteRows(at: [indexPath], with: .fade)
                
                //to delete elements from an array
                self.usernames.remove(at: indexPath.row)
                self.passwords.remove(at: indexPath.row)
                
                self.usersTableView.endUpdates()
            }
        }
    
    //code for serach bar is same as retrieve data but predictae is added over here
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mangedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username= %@", searchBar.text!)
        
        do {
            retrievedUserRecords = try mangedContext.fetch(fetchRequest) as! [NSManagedObject]
                    self.usernames.removeAll()
                    self.passwords.removeAll()

            for eachRetrivedRecord in retrievedUserRecords as! [NSManagedObject]{
            self.usernames.append(eachRetrivedRecord.value(forKey: "username") as! String)
            self.passwords.append(eachRetrivedRecord.value(forKey: "password") as! String)
                        
            self.usersTableView.reloadData() //reload tableview
                    }
            }catch{
        print(error)
         }
    }
    

}
