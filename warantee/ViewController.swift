//
//  ViewController.swift
//  warantee
//
//  Created by student on 07/12/2019.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import CoreData

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    //logout
    @IBAction func signOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            print("user logged out")
            self.deleteAllData(entity: "Waranty")
            //dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
        //logs out google account
        GIDSignIn.sharedInstance().signOut()
        
    }
    func deleteAllData(entity: String)
       {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           let context = appDelegate.persistentContainer.viewContext
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
           fetchRequest.returnsObjectsAsFaults = false
           do {
               let results = try context.fetch(fetchRequest)
               for object in results {
                   guard let objectData = object as? NSManagedObject else {continue}
                   context.delete(objectData)
               }
           } catch let error {
               print("Detele all data in \(entity) error :", error)
           }
       }
    struct Warantee: Codable { // or Decodable
        let id: Int
        let uid: String
        let date: String
        let amount: Float
        let category: Int
        let warantyPeriod: Int
        let sellerName: String
        let sellerPhone: String
        let sellerEmail: String
        let location: String
        let createdAt: String
        let updatedAt: String
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //if user logs out
        Auth.auth().addStateDidChangeListener
        { (auth, user) in
            
            if user == nil {
              self.goToLogin()
            }
            
        }
        picker.delegate = self
        picker.dataSource = self
    }

    
    func goToLogin(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC:LoginController = storyboard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        
        //go to new screen in fullscreen
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
    // UIPickerViewDatasource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    // UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myView = UIView()
        myView.frame = CGRect(x:0, y:0, width:pickerView.bounds.width - 30, height:60)
        let myImageView = UIImageView()
        myImageView.frame = CGRect(x:0, y:0, width:50, height:50)
       var rowString = String()
       switch row {
       case 0:
           rowString = "food"
           myImageView.image = UIImage(named:"food")
       case 1:
           rowString = "grocery"
           myImageView.image = UIImage(named:"grocery")
        case 2:
            rowString = "travel"
            myImageView.image = UIImage(named:"travel")
        case 3:
            rowString = "electronics"
            myImageView.image = UIImage(named:"electronics")
        case 4:
            rowString = "others"
            myImageView.image = UIImage(named:"others")
        case 5:
        rowString = "all"
        myImageView.image = UIImage(named:"warantee")
       default:
           rowString = "Error: too many rows"
           myImageView.image = nil
       }
       let myLabel = UILabel()
        myLabel.frame = CGRect(x:60, y:0, width:pickerView.bounds.width - 90, height:60 )
       myLabel.font = UIFont(name:"Helvetica", size: 18)
       myLabel.text = rowString

       myView.addSubview(myLabel)
       myView.addSubview(myImageView)

       return myView
    }

}

