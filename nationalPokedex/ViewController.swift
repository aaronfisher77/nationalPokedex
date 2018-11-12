//
//  ViewController.swift
//  nationalPokedex
//
//  Created by Aaron Fisher on 11/12/18.
//  Copyright © 2018 Aaron Fisher. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var nameOrIDTextView: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    
    let pokedexAPIBaseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func submitButton(_ sender: Any) {
        
        //Dismissing Keyboared
        nameOrIDTextView.resignFirstResponder()
        
        // Checking to make sure both fields have values
        guard let pokemonName = nameOrIDTextView.text else {
                return
        }
        
        // Clearing out text field
        nameOrIDTextView.text = ""
        
        //Building our complete request url with name/song
        let requestURL = pokedexAPIBaseURL + pokemonName
        
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.infoTextView.text = String(describing: json)
            case .failure(let error):
                self.infoTextView.text = "Invalid Selection entered or an error occured. Please try again!"
                print(error.localizedDescription)
            }
        }
    }
}

