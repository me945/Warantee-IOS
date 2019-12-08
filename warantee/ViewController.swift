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
            dismiss(animated: true, completion: nil)
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
//        if Auth.auth().currentUser != nil {
//            if let url = URL(string: "https://www.vrpacman.com/waranty") {
//                var request = URLRequest(url: url)
//                request.setValue("AuthToken", forHTTPHeaderField:(Auth.auth().currentUser?.refreshToken)!)
//               URLSession.shared.dataTask(with: url) { data, response, error in
//                  if let data = data {
//                      do {
//                         //let res = try JSONDecoder().decode(Response.self, from: data)
//                         print(data)
//                      } catch let error {
//                         print(error)
//                      }
//                   }
//               }.resume()
//            }
//            print(Auth.auth().currentUser?.refreshToken)
//        }
    }


}

