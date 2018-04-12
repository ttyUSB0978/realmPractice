//
//  ListViewController.swift
//  realmTest
//
//  Created by Jake Lin on 03/04/2018.
//  Copyright © 2018 ttyUSB0978. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UITableViewController{
    
    
    @IBOutlet var listTableView: UITableView!
    let realm = try! Realm()
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let myData = realm.objects(myCharacter.self)
        
        return myData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TestTableViewCell
        
        let myData = realm.objects(myCharacter.self)
        cell.nameLabel?.text = myData[indexPath.row].name
        cell.testImageView?.image = UIImage(data: myData[indexPath.row].picture as! Data)
        
        //cell.testImageView.image = #imageLiteral(resourceName: "defaultImage")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Delete button
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete",handler: { (action, indexPath) -> Void in
            
            let myData = self.realm.objects(myCharacter.self)
            //action
            self.deleteData(name: myData[indexPath.row].name)
            self.listTableView.reloadData()
            
        })
        
        
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction]
    }
    
    func deleteData(name:String) {
        
        let realm = try! Realm()
        if let user = realm.objects(myCharacter.self).filter("name = '" + name + "'").first {
            try! realm.write {
                realm.delete(user)
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
