//
//  PokeDetailVC.swift
//  pokedex
//
//  Created by Abhishek on 26/12/18.
//  Copyright © 2018 pmalik. All rights reserved.
//

import UIKit

class PokeDetailVC: UIViewController {

    @IBOutlet weak var pokeNameLbl: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokiDescription: UILabel!
    @IBOutlet weak var pokeTypeLbl: UILabel!
    @IBOutlet weak var pokeWeight: UILabel!
    @IBOutlet weak var pokeBestAttackVal: UILabel!
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var pokeDefenceVal: UILabel!
    @IBOutlet weak var pokeHeight: UILabel!
    @IBOutlet weak var pokeNextEvolution: UILabel!
    @IBOutlet weak var currentEvolImage: UIImageView!
    @IBOutlet weak var nextEvolImage: UIImageView!
    
    func updateUI(){
        pokeNameLbl.text = _poke.name
        let img = UIImage(named: "\(_poke.pokedexID)")
        pokeImage.image = img
        currentEvolImage.image = img
        pokeTypeLbl.text = _poke.pokeType
        pokeWeight.text = "\(_poke.pokeWeight)"
        pokeBestAttackVal.text = "\(_poke.pokeBestAttack)"
        pokeDefenceVal.text = "\(_poke.pokeDefenceVal)"
        pokeHeight.text = "\(_poke.pokeHeight)"
        
    }
    
    var _poke :Pokemon!
    
    @IBAction func BackBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    var pokeDetail : Pokemon {
        get{
            return _poke
        }set{
            _poke=newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _poke.downloadPokiDetail {
            self.updateUI()
        }
        
    }
    

    


}
