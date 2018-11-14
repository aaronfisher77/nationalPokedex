//
//  pokemonVC.swift
//  nationalPokedex
//
//  Created by Aaron Fisher on 11/14/18.
//  Copyright © 2018 Aaron Fisher. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class pokemonVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    // Basic url
    let url = "https://pokeapi.co/api/v2/pokemon/"
    // Empty array ready to have pokemon name put in it.
    var pokemonArray: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Alamo Fire request
        let alamofireRequest = Alamofire.request(url)
        
        // Sends request to alamo fire and looks for response form JSON
        alamofireRequest.responseJSON { response in
            switch response.result { // Checks to see if the response was a .success or a .failure
            case .success(let value):
                    print(value)
                // converts our response JSON into a SwiftyJSON JSON object
                let json = JSON(value)
                    
                    
                    if let results = json["results"].array {
                    for result in results {
                        if let pokemonName = result["name"].string{
                            print(pokemonName)
                            self.pokemonArray.append(pokemonName.capitalized)
                        }
                    }
                    self.tableView.reloadData()
                }
          
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    
    
    
    @IBAction func backButton(_ sender: Any) {
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell")
        
        cell?.textLabel?.text = pokemonArray[indexPath.row]
        
        return cell!

    }
    
    
    
}
