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
import SDWebImage

class ViewController: UIViewController {
    
    // Variables
    @IBOutlet weak var nameOrIDTextView: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonUIImageView: UIImageView!
    @IBOutlet weak var halfView: UIView!
    
    // URL for pokedex api
    let pokedexAPIBaseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Submit Button
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
        let requestnameURL = pokedexAPIBaseURL + pokemonURLComponant
//        let requestImageURL = pokemonImageURL + nameLabel.text + ".png"
        
        Alamofire.request(requestnameURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.nameLabel.text = json["name"].stringValue.uppercased()
                let pokemonImageURL = json["sprites"]["front_default"].stringValue
                
                //creates variablesfor pokemon types
                var typeOne: String
                var typeTwo: String
                
                // Pulls the type of the pokemon out of the
                if json["types"].arrayValue.count == 1 {
                    typeOne = (json["types"].arrayValue)[0]["type"]["name"].stringValue
                    typeTwo = (json["types"].arrayValue)[0]["type"]["name"].stringValue
                    print(typeOne, typeTwo)
                }else{
                    typeOne = (json["types"].arrayValue)[0]["type"]["name"].stringValue
                    typeTwo = (json["types"].arrayValue)[1]["type"]["name"].stringValue
                    print(typeOne, typeTwo)
                }
                // calls the function
                typeToColor(typeOne: typeOne, typeTwo: typeTwo)
                
                // gets the Image
                guard let pokemonImage = URL(string: pokemonImageURL) else {
                    break
                }
                
                // sets the image to the UIImage
                self.pokemonUIImageView!.sd_setImage(with: pokemonImage)
            
            case .failure(let error): // an error that will appears when
                self.nameLabel.text = "That's not a Pokemon... Sorry pal"
                
                // sets backround colors to default
                self.view.backgroundColor = UIColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 255/255)
                self.halfView.backgroundColor = UIColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 255/255)
                print(error.localizedDescription)
            }
        }
        
        
        // calls the function that takes the string that we got from the JSON and truns it into colors that are placed in the backround
        func typeToColor(typeOne: String, typeTwo: String) {
            
            // Sets typeOne string to a UIColor
            switch typeOne {
            case "normal":
                self.view.backgroundColor = UIColor(red: 168 / 255, green: 167 / 255, blue: 122 / 255, alpha: 255/255)
            case "fire":
                self.view.backgroundColor = UIColor(red: 238 / 255, green: 128 / 255, blue: 059 / 255, alpha: 255/255)
            case "fighting":
                self.view.backgroundColor = UIColor(red: 190 / 255, green: 049 / 255, blue: 045 / 255, alpha: 255/255)
            case "water":
                self.view.backgroundColor = UIColor(red: 106 / 255, green: 146 / 255, blue: 237 / 255, alpha: 255/255)
            case "flying":
                self.view.backgroundColor = UIColor(red: 168 / 255, green: 147 / 255, blue: 237 / 255, alpha: 255/255)
            case "grass":
                self.view.backgroundColor = UIColor(red: 123 / 255, green: 198 / 255, blue: 087 / 255, alpha: 255/255)
            case "poison":
                self.view.backgroundColor = UIColor(red: 159 / 255, green: 068 / 255, blue: 158 / 255, alpha: 255/255)
            case "electric":
                self.view.backgroundColor = UIColor(red: 247 / 255, green: 206 / 255, blue: 067 / 255, alpha: 255/255)
            case "ground":
                self.view.backgroundColor = UIColor(red: 223 / 255, green: 191 / 255, blue: 110 / 255, alpha: 255/255)
            case "psychic":
                self.view.backgroundColor = UIColor(red: 246 / 255, green: 091 / 255, blue: 137 / 255, alpha: 255/255)
            case "rock":
                self.view.backgroundColor = UIColor(red: 183 / 255, green: 159 / 255, blue: 065 / 255, alpha: 255/255)
            case "ice":
                self.view.backgroundColor = UIColor(red: 154 / 255, green: 216 / 255, blue: 215 / 255, alpha: 255/255)
            case "bug":
                self.view.backgroundColor = UIColor(red: 168 / 255, green: 182 / 255, blue: 049 / 255, alpha: 255/255)
            case "dragon":
                self.view.backgroundColor = UIColor(red: 112 / 255, green: 067 / 255, blue: 244 / 255, alpha: 255/255)
            case "ghost":
                self.view.backgroundColor = UIColor(red: 112 / 255, green: 090 / 255, blue: 150 / 255, alpha: 255/255)
            case "dark":
                self.view.backgroundColor = UIColor(red: 112 / 255, green: 088 / 255, blue: 073 / 255, alpha: 255/255)
            case "steel":
                self.view.backgroundColor = UIColor(red: 184 / 255, green: 184 / 255, blue: 207 / 255, alpha: 255/255)
            case "fairy":
                self.view.backgroundColor = UIColor(red: 236 / 255, green: 154 / 255, blue: 172 / 255, alpha: 255/255)
            default:
                self.view.backgroundColor = UIColor(red: 236 / 255, green: 154 / 255, blue: 172 / 255, alpha: 255/255)
            }
            
            // Sets typeTwo string to a UIColor
            switch typeTwo {
            case "normal":
                self.halfView.backgroundColor = UIColor(red: 168 / 255, green: 167 / 255, blue: 122 / 255, alpha: 255/255)
            case "fire":
                self.halfView.backgroundColor = UIColor(red: 238 / 255, green: 128 / 255, blue: 059 / 255, alpha: 255/255)
            case "fighting":
                self.halfView.backgroundColor = UIColor(red: 190 / 255, green: 049 / 255, blue: 045 / 255, alpha: 255/255)
            case "water":
                self.halfView.backgroundColor = UIColor(red: 106 / 255, green: 146 / 255, blue: 237 / 255, alpha: 255/255)
            case "flying":
                self.halfView.backgroundColor = UIColor(red: 168 / 255, green: 147 / 255, blue: 237 / 255, alpha: 255/255)
            case "grass":
                self.halfView.backgroundColor = UIColor(red: 123 / 255, green: 198 / 255, blue: 087 / 255, alpha: 255/255)
            case "poison":
                self.halfView.backgroundColor = UIColor(red: 159 / 255, green: 068 / 255, blue: 158 / 255, alpha: 255/255)
            case "electric":
                self.halfView.backgroundColor = UIColor(red: 247 / 255, green: 206 / 255, blue: 067 / 255, alpha: 255/255)
            case "ground":
                self.halfView.backgroundColor = UIColor(red: 223 / 255, green: 191 / 255, blue: 110 / 255, alpha: 255/255)
            case "psychic":
                self.halfView.backgroundColor = UIColor(red: 246 / 255, green: 091 / 255, blue: 137 / 255, alpha: 255/255)
            case "rock":
                self.halfView.backgroundColor = UIColor(red: 183 / 255, green: 159 / 255, blue: 065 / 255, alpha: 255/255)
            case "ice":
                self.halfView.backgroundColor = UIColor(red: 154 / 255, green: 216 / 255, blue: 215 / 255, alpha: 255/255)
            case "bug":
                self.halfView.backgroundColor = UIColor(red: 168 / 255, green: 182 / 255, blue: 049 / 255, alpha: 255/255)
            case "dragon":
                self.halfView.backgroundColor = UIColor(red: 112 / 255, green: 067 / 255, blue: 244 / 255, alpha: 255/255)
            case "ghost":
                self.halfView.backgroundColor = UIColor(red: 112 / 255, green: 090 / 255, blue: 150 / 255, alpha: 255/255)
            case "dark":
                self.halfView.backgroundColor = UIColor(red: 112 / 255, green: 088 / 255, blue: 073 / 255, alpha: 255/255)
            case "steel":
                self.halfView.backgroundColor = UIColor(red: 184 / 255, green: 184 / 255, blue: 207 / 255, alpha: 255/255)
            case "fairy":
                self.halfView.backgroundColor = UIColor(red: 236 / 255, green: 154 / 255, blue: 172 / 255, alpha: 255/255)
            default:
                self.halfView.backgroundColor = UIColor(red: 236 / 255, green: 154 / 255, blue: 172 / 255, alpha: 255/255)
                
            }
        }
    }
}

