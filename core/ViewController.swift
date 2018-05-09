//
//  ViewController.swift
//  core
//
//  Created by apple on 3/25/18.
//  Copyright © 2018 Adithya. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arr1[indexPath.row]
        cell.detailTextLabel?.text = arr2[indexPath.row]

        return cell
    }
    
 
    var arr1 = [String]()
    var arr2 = [String]()
    var arr3 = [String]()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
}
    @IBOutlet var tableview: UITableView!
    @IBAction func saving(_ sender: Any) {
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Contacts", into: context)

            newUser.setValue(self.name.text!, forKey: "name")
            newUser.setValue(self.address.text!, forKey: "address")
            newUser.setValue(self.phone.text!, forKey: "phone")
            do {
                try self.context.save()
                print("done")
                print(newUser)
                
            } catch  {
                print(error)
            }
            
        }
     
      
    
    @IBAction func fnd(_ sender: Any) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        
        do {
            let arrStud = try self.context.fetch(fetch)
            
            for i in arrStud as! [NSManagedObject]{
                
                let strname:String = (i.value(forKey: "name")) as! String
                let strschool:String = (i.value(forKey: "address")) as! String
                let strClass:String = (i.value(forKey: "phone")) as! String
                self.arr1.append(strname)
                self.arr2.append(strschool)
                self.arr3.append(strClass)
            }
            print(self.arr1)
            print( self.arr2)
            print(self.arr3)
           
//
        } catch  {
            
            print("what went down !")
        }
        OperationQueue.main.addOperation {
            self.tableview.reloadData()
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

