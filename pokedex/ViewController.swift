//
//  ViewController.swift
//  pokedex
//
//  Created by Abhishek on 24/12/18.
//  Copyright © 2018 pmalik. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    var musicPlayer : AVAudioPlayer!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var musicBtn: UIButton!
    
    
    var pokemonList = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var searchMode = false
    
    @IBAction func musicToggleBtn(_ sender: Any) {
        if(musicPlayer.isPlaying){
            musicBtn.alpha = 0.5
            musicPlayer.pause()
        }else{
            musicBtn.alpha = 1
            musicPlayer.play()
        }
        
    }
    
    func initAudio(){
     let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string : path)!)
            musicPlayer.pause()
            musicBtn.alpha = 0.5
        } catch let error as NSError{
            print(error)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        initAudio()
        parsePokemonCSV()
        searchBar.returnKeyType = UIReturnKeyType.done
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do{
            let csvparse = try CSV(contentsOfURL: path!)
            let rows = csvparse.rows
            
            for row in rows {
                let poke = Pokemon(name: row["identifier"]!, pokedexID: Int(row["species_id"]!)!)
                pokemonList.append(poke)
            }
            
            
        } catch let error as NSError{
            print(error)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(searchMode){
            return filteredPokemon.count
        }else{
            return pokemonList.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCellCollectionViewCell{
            
            if(searchMode){
                cell.updatePokeCell(pokemon: filteredPokemon[indexPath.row])
            }else{
                cell.updatePokeCell(pokemon: pokemonList[indexPath.row])
            }
            
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == nil || searchText == ""){
            searchMode=false
            collection.reloadData()
            searchBar.endEditing(true)
        }else{
            filteredPokemon = pokemonList.filter{($0.name.range(of: searchText.lowercased()) != nil)}
            searchMode=true
            collection.reloadData()
        }
        
        
    }

}

