//
//  Pokemon.swift
//  pokedex
//
//  Created by Abhishek on 25/12/18.
//  Copyright © 2018 pmalik. All rights reserved.
//

import Foundation

class Pokemon {
    var _pokedexID : Int!
    var _name : String!
    
    var pokedexID : Int{
        return _pokedexID
    }
    
    var name : String {
        return _name
    }
    
    init(name: String, pokedexID: Int){
        self._name = name
        self._pokedexID = pokedexID
    }
}
