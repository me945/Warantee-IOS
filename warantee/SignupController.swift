//
//  SignupController.swift
//  warantee
//
//  Created by Fidel Lim on 12/7/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import Firebase

class SignupController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func signin(_ sender: Any) {
        let email = txtEmail.text!
        let password = txtPassword.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          
            if let firebaseError = error {
                print(firebaseError.localizedDescription)
                return
            }
            
            //if success, logout and go to login
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
                print("user logged out")
                self.dismiss(animated: true, completion: nil)
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
           
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
