//
//  AddWaranteeController.swift
//  warantee
//
//  Created by Mahmoud Elmohtasseb on 2019-12-17.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class AddWaranteeController: UIViewController {

    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    
    @IBAction func NextPage(_ sender: Any) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let menuVC:Image_VideoController = storyboard.instantiateViewController(withIdentifier: "Image_VideoController") as! Image_VideoController
        
        //go to new screen in fullscreen
        menuVC.modalPresentationStyle = .fullScreen
        self.present(menuVC, animated: true, completion: nil)
    }
    
   private var datePicker: UIDatePicker?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    datePicker = UIDatePicker()
    datePicker?.datePickerMode = .date
    datePicker?.addTarget(self, action:#selector(AddWaranteeController.dateChanged(datePicker:)), for: .valueChanged)
    
    //this is to recognize when you click anywhewre on the screen
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddWaranteeController.viewTapped(gestureRecognaizer:)))
    
    view.addGestureRecognizer(tapGesture)
    
    //Display the date in the text field
    txtDate.inputView = datePicker
        
    }
    
    //function to dismiss the datepicker when click on the screen
    @objc func viewTapped(gestureRecognaizer: UITapGestureRecognizer){
         view.endEditing(true)
     }
     
    //to get and display the date after it is has been changed
    @objc func dateChanged(datePicker: UIDatePicker)
     {
         let dateFormater = DateFormatter()
         dateFormater.dateFormat = "MM/dd/yyyy"
         
         txtDate.text = dateFormater.string(from: datePicker.date)
         view.endEditing(true)
         
     }

    
}
