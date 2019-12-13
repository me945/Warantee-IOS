//
//  ViewController.swift
//  warantee
//
//  Created by student on 07/12/2019.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    //logout
    @IBAction func signOut(_ sender: Any) {
    
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            print("user logged out")
            //dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
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
    }

    
    func goToLogin(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC:LoginController = storyboard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        
        //go to new screen in fullscreen
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }

}

