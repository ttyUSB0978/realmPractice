//
//  ViewController.swift
//  realmTest
//
//  Created by Jake Lin on 22/03/2018.
//  Copyright © 2018 ttyUSB0978. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let fullScreenSize = UIScreen.main.bounds.size
    
    @IBOutlet weak var testCollectionView: UICollectionView!
    
    @IBOutlet weak var testCollectionViewLayout: UICollectionViewFlowLayout!
    
    var myImages = [ #imageLiteral(resourceName: "images-1"), #imageLiteral(resourceName: "images-3"), #imageLiteral(resourceName: "images-4"), #imageLiteral(resourceName: "images-5"), #imageLiteral(resourceName: "images-6"), #imageLiteral(resourceName: "images-7")]
    var myAvatarIndex = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return myImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! TestCollectionViewCell
        
        cell.testCellImageView.image = myImages[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2
        myAvatarIndex = indexPath.row
        //print("selected")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0
        
    }
    
    let realm = try! Realm()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let myData = realm.objects(myCharacter.self)
        
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "tableviewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TestTableViewCell
        
        let myData = realm.objects(myCharacter.self)
        cell.nameLabel?.text = myData[indexPath.row].name
        cell.jobLabel?.text = myData[indexPath.row].job
        cell.expLabel?.text = String(myData[indexPath.row].exp)
        cell.testImageView?.image = UIImage(data: myData[indexPath.row].picture as! Data)
        
        return cell
    }
    
    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Delete button
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete",handler: { (action, indexPath) -> Void in
            
            let myData = self.realm.objects(myCharacter.self)
            //action
            self.deleteData(name: myData[indexPath.row].name)
            self.dataTableView.reloadData()
            
        })
        
        // modify button
        let modifyAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Modify",handler: { (action, indexPath) -> Void in
            
            let myData = self.realm.objects(myCharacter.self)
            //action
            self.updateData(name: myData[indexPath.row].name)
            self.dataTableView.reloadData()
            
        })
        
        
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, modifyAction]
    }
    
    
    @IBOutlet weak var dataTableView: UITableView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var jobTextfield: UITextField!
    
    @IBAction func addBtn(_ sender: Any) {
    
        
        let mycharacter: myCharacter = myCharacter()
        
        mycharacter.name = nameTextField.text!
        mycharacter.job = jobTextfield.text!
        mycharacter.exp = 5
        mycharacter.picture = myImages[myAvatarIndex].jpeg
        //mycharacter.picture = #imageLiteral(resourceName: "meter-D40").jpeg
        try! realm.write {
            realm.add(mycharacter)
        }
        
        self.dataTableView.reloadData()
    }
    
    /*
    @IBAction func listBtn(_ sender: Any) {
    
        // 查詢資料
        //let realm = try! Realm()
        let orders = realm.objects(myCharacter.self)
        
        
        for result in orders {
            print("id: \(result.id)")
            print("name: \(result.name)")
            print("amount: \(result.job)")
            
        }
        
    }*/
    
    func deleteData(name:String) {
        
        let realm = try! Realm()
        if let user = realm.objects(myCharacter.self).filter("name = '" + name + "'").first {
            try! realm.write {
                realm.delete(user)
            }
        }
    }
    
    func updateData(name:String) {
        
        let realm = try! Realm()
        if let user = realm.objects(myCharacter.self).filter("name = '" + name + "'").first {
            try! realm.write {
                user.name = nameTextField.text!
                user.job = jobTextfield.text!
                user.picture = myImages[myAvatarIndex].jpeg
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension UIImage {
    var jpeg: Data? {
        return UIImageJPEGRepresentation(self, 1)   // QUALITY min = 0 / max = 1
    }
    var png: Data? {
        return UIImagePNGRepresentation(self)
    }
}
