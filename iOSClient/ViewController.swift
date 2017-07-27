/*
 * Copyright (c) 2017 ChemADVISOR, Inc. All rights reserved.
 * Licensed under The MIT License (MIT)
 * https://opensource.org/licenses/MIT
 */

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//MARK: Actions
    @IBAction func setLabelText(_ sender: UIButton) {
        self.resultLabel.text = "Loading..."
        
        // set base address
        let baseAddress = "https://sandbox.chemadvisor.io/chem/rest/v2/"
        
        // set app_key header
        let appKey = "your_app_key"
		
		// set app_id header
        let appId = "your_app_id"
        
        // set accept header: "application/xml", "application/json"
        let acceptHeader = "application/json"
        
        // set api
        let api = "lists"
        
        // set query parameters:q, limit, offset
        let q = "{\"tages.tag.name\":\"Givernment Inventory Lists\"}"
        let limit = 10
        let offset = 0
        
        
        let urlComponents = NSURLComponents(string: baseAddress + api)!
        urlComponents.queryItems = [
            NSURLQueryItem(name: "q", value: q.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)) as URLQueryItem,
            NSURLQueryItem(name: "limit", value: String(limit)) as URLQueryItem,
            NSURLQueryItem(name: "offset", value: String(offset)) as URLQueryItem
        ]
       
        let request = NSMutableURLRequest(url: urlComponents.url!)
        request.setValue(appKey, forHTTPHeaderField: "app_key")
		request.setValue(appId, forHTTPHeaderField: "app_Id")
        request.setValue(acceptHeader, forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let apiCall = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if error != nil {
                print(error?.localizedDescription ?? "Request Error")
            } else {
                self.resultLabel.text = String(data: data!, encoding: String.Encoding.utf8)
                
            }
        }
        apiCall.resume()
    }
}

