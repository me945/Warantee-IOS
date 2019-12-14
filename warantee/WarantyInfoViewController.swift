//
//  WarantyInfoViewController.swift
//  warantee
//
//  Created by Amad Khan on 14/12/2019.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import AVKit
import AVFoundation

class WarantyInfoViewController: UIViewController {

    var warantyId = -1
    @IBOutlet weak var sellerNameLabel: UILabel!
    
    @IBOutlet weak var sellerPhoneLabel: UILabel!
    
    @IBOutlet weak var sellerEmailLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var warantyPeriodLabel: UILabel!
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    @IBOutlet weak var warantyImage: UIImageView!
    
    
    @IBOutlet weak var warantyAvPlayer: UIView!
    
    private var warantyUId = ""
    var avPlayer: AVPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        let thisAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = thisAppDelegate.persistentContainer.viewContext
        
        let req:NSFetchRequest<Waranty> = Waranty.fetchRequest()
        req.predicate = NSPredicate(format: "id = %@", String(self.warantyId))
        do{
            let warantees = try context.fetch(req)
            // do something with data
            let waranty = warantees[0]
            sellerNameLabel.text = waranty.sellerName
            sellerPhoneLabel.text = waranty.sellerPhone
            sellerEmailLabel.text = waranty.sellerEmail
            amountLabel.text = String(waranty.amount)
            dateLabel.text = waranty.date
            warantyPeriodLabel.text = String(waranty.warantyPeriod)
            categoryLabel.text = String(waranty.category)
            self.warantyUId = waranty.uid ?? ""
            Auth.auth().currentUser?.getIDToken(completion: warantyVideoRequest)
            let documentsUrl:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsUrl.appendingPathComponent(String(waranty.id) + ".jpg")
            do{
                let imageData = try Data(contentsOf: fileURL)
                warantyImage.image = UIImage(data: imageData)
            } catch {
                print("Error loading image: \(error)")
            }
        }
        catch{
            print("CoreData request failed")
        }
        // Do any additional setup after loading the view.
    }
    
    func warantyVideoRequest(token:String?, error: Error?) {
        let documentsUrl:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationFileUrl = documentsUrl.appendingPathComponent(String(self.warantyId) + ".mp4")
        if let url = URL(string: "https://www.vrpacman.com/s3proxy?fileKey=" + self.warantyUId + String(self.warantyId) + ".mp4") {
            var request = URLRequest(url: url)
            request.setValue(token, forHTTPHeaderField:"AuthToken")
            request.httpMethod = "GET"
            URLSession.shared.downloadTask(with: request) { localURL, response, error in
            if let localURL = localURL {
                  do {
                    try? FileManager.default.removeItem(at: destinationFileUrl)
                    try FileManager.default.moveItem(at: localURL, to: destinationFileUrl)
                    DispatchQueue.main.async {
                        self.avPlayer = AVPlayer(url: destinationFileUrl)
                                                      let avPlayerController = AVPlayerViewController()
                        avPlayerController.player = self.avPlayer
                                                      avPlayerController.view.frame = CGRect(x: 0, y: 44, width: UIScreen.main.bounds.size.width, height: 196)

                                                      // Turn on video controlls
                                                      avPlayerController.showsPlaybackControls = true

                                                      // play video
                                                      avPlayerController.player?.play()
                                                      self.view.addSubview(avPlayerController.view)
                                                      self.addChild(avPlayerController)
                                           }
                    
                    
                  } catch let error {
                     print(error)
                  }
               }
           }.resume()
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