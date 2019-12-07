//
//  ViewController.swift
//  warantee
//
//  Created by student on 07/12/2019.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct Response: Codable { // or Decodable
      let foo: String
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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


}

