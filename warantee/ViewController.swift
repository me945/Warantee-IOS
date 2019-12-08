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
        Auth.auth().currentUser?.getIDToken(completion: warantyRequest)
        
       
    }

    func warantyRequest(token:String?, error: Error?) {
        print(token)
            if let url = URL(string: "https://www.vrpacman.com/waranty") {
                var request = URLRequest(url: url)
                request.setValue(token, forHTTPHeaderField:"AuthToken")
                request.httpMethod = "GET"
               URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                      do {
                        let output = String(data: data,encoding:String.Encoding.utf8) as String?
                         let res = try JSONDecoder().decode([Warantee].self, from: data)
                        for w in res{
                            print(w.sellerName)
                        }
                        print("\(data)")
                      } catch let error {
                         print(error)
                      }
                   }
               }.resume()
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

