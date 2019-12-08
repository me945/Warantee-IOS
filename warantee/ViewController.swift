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
    
    struct Response: Codable { // or Decodable
      let foo: String
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
        
        
        if let url = URL(string: "https://api.myjson.com/bins/yfua8") {
            var request = URLRequest(url: url)
            request.setValue("secret-keyValue", forHTTPHeaderField: "secret-key")
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                     let res = try JSONDecoder().decode(Response.self, from: data)
                     print(res.foo)
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

