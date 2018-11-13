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

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pokemonUIImageView: UIImageView!
    
    @IBOutlet weak var errorLabel: UITextView!
    
    let pokedexAPIBaseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    let pokemonImageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func submitButton(_ sender: Any) {
        
        //Dismissing Keyboared
        nameOrIDTextView.resignFirstResponder()
        
        // Checking to make sure what was entered is a Pokemon or pokemon ID
        guard let pokemonName = nameOrIDTextView.text else {
                return
        }
        
        // Clears out text field
        nameOrIDTextView.text = ""
        
        //Replacing spaces in the name/title with + so they can be used as a part of the URL
        let pokemonURLComponant = pokemonName.replacingOccurrences(of: " ", with: "+")
        
        
        //Building our complete request url with name/song
        let requestURL = pokedexAPIBaseURL + pokemonName
        
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
        
                let json = JSON(value)

                
                
                
                
                
                
                
                
            case .failure(let error):
                self.nameLabel.text = "Invalid Selection please enter a valid Pokemon."
                print(error.localizedDescription)
            }
        }
    }
}

