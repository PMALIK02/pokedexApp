//
//  PokeCellCollectionViewCell.swift
//  pokedex
//
//  Created by Abhishek on 25/12/18.
//  Copyright © 2018 pmalik. All rights reserved.
//

import UIKit

class PokeCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeimage: UIImageView!

    @IBOutlet weak var pokename: UILabel!
    
    required init?(coder aDecoder :NSCoder){ //failable initializers
        
        
        super.init(coder: aDecoder)
        
        if(layer == nil){
            return nil
        }
        
        /*
         CALayer
         An object that manages image-based content and allows you to perform animations on that content.
         https://developer.apple.com/documentation/quartzcore/calayer
         */
        layer.cornerRadius = 5.0
        
    }
    
    func updatePokeCell(pokemon : Pokemon){
        
        pokeimage.image = UIImage(named: "\(pokemon.pokedexID)")
        pokename.text = pokemon.name.capitalized
        
    }
    
}
