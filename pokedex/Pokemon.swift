//
//  Pokemon.swift
//  pokedex
//
//  Created by Abhishek on 25/12/18.
//  Copyright © 2018 pmalik. All rights reserved.
//

import Foundation
import Alamofire
class Pokemon {
    var _pokedexID : Int!
    var _name : String!
    var _pokeDescription : String!
    var _pokeType : String!
    var _pokeWeight : Int!
    var _pokeBestAttack : Int!
    var _pokeDefenceVal : Int!
    var _pokeHeight : Int!
    var _pokeNextEvolution : String!
    var _pokeURL : String!
    
    var pokeHeight : Int{
        return _pokeHeight
    }
    
    var pokeDefenceVal : Int {
        return _pokeDefenceVal
    }
    
    var pokeBestAttack : Int {
        return _pokeBestAttack
    }
    
    var pokeWeight : Int{
        return _pokeWeight
    }

    var pokeURL : String {
        return _pokeURL
    }

    var pokeNextEvolution : String {
        return _pokeNextEvolution
    }
    
    var pokeType : String {
        return _pokeType
    }
    
    var pokeDescription : String {
         return _pokeDescription
    }
    var pokedexID : Int{
        return _pokedexID
    }
    
    var name : String {
        return _name
    }
    
    init(name: String, pokedexID: Int){
        self._name = name
        self._pokedexID = pokedexID
        self._pokeURL = "\(API_BASE_URL)\(API_POKI_URL)\(pokedexID)/"
    }
    
    func processPokiJson(resp : DataResponse<Any>){
        
        if let pokiDict = resp.result.value as? Dictionary<String,Any?>{
            if let weight = pokiDict["weight"] as? Int{
                self._pokeWeight = weight
            }
            if let height = pokiDict["height"] as? Int{
                self._pokeHeight = height
            }
            
            if let stats = pokiDict["stats"] as? [Dictionary<String,Any?>]{
                if let defense = stats[3]["base_stat"] as? Int{
                    self._pokeDefenceVal = defense
                }
                
                if let attack = stats[4]["base_stat"] as? Int{
                    self._pokeBestAttack = attack
                }
            }
            
            if let types = pokiDict["types"] as? [Dictionary<String,Any?>], types.count>0{
                if let type = types[0]["type"] as? Dictionary<String,Any?>{
                    if let type = type["name"] as? String{
                        self._pokeType = type
                    }
                }
                
                if types.count > 1 {
                    for x in 1..<types.count{
                        if let nameType = types[x]["type"] as? Dictionary<String,Any?>{
                            if let name = nameType["name"] as? String{
                              self._pokeType! += "/" + name.capitalized
                                
                            }
                            
                        }
                    }
                }
                
            }else{
                self._pokeType = ""
            }
        }
        
    }
    
    func downloadPokiDetail(complete :@escaping DOWNLOAD_COMPLETE){
        print("URL===>>"+self._pokeURL)
        Alamofire.request(self._pokeURL).responseJSON{response in
           self.processPokiJson(resp: response)
            complete()
        }
    }
}
