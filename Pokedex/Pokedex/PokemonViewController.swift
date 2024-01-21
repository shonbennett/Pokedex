//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Shon Bennett on 11/10/23.
//

import UIKit
import PokemonAPI
/*
 This view controller creates a UITableView and populates it with data
 */
class PokemonViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var pokemonArray:[PKMPokemon] = []
    
    let collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad() { //view was loaded into memory
        super.viewDidLoad()
        view.addSubview(collectionView)
        configureView()
        // Do any additional setup after loading the view.
        //make asynchronous API call
        for i in 0..<100 {
            pokemonServiceCall(num: i) { result in
                        switch result {
                        case .success(let pokemon):
                            // Handle the success case
                            if let pokemon = pokemon {
                                // Now you can use the Pokemon object
                                self.pokemonArray.append(pokemon)
                                print("success: i caught \(pokemon.name)")
                                // Reload in main thread the table view to reflect the new data
                                DispatchQueue.main.async {
                                    self.collectionView.reloadData()
                                }
                            } else {
                                print("No Pokemon found")
                            }
                        case .failure(let error):
                            // Handle the failure case
                            print("Error fetching Pokemon: \(error.localizedDescription)")
                        }
                    }
        }
        
    }
    
    func configureView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false //use Auto Layout constraints instead of the older autoresizing mask system
        setCollectionConstraints()
        setCollectionDelegate()
        //must be included or we will not be able to use the table for populization
        collectionView.register(PokemonViewCell.self, forCellWithReuseIdentifier: "pokemoncell")
    }
    
    func setCollectionDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setCollectionConstraints() {
        //ensures the table is within the view of the window
        NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        collectionView.backgroundColor = .clear
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        collectionView.frame = view.bounds
    }
    
        //tells us the number of items for the collection view
        func collectionView(_ tableView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print("we will be adding \(pokemonArray.count) pokemon")
            return pokemonArray.count
        }
        
        //returns the custom Collection cell (PokemonViewCell) for a pokemon in the pokemonArray
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemoncell", for: indexPath) as! PokemonViewCell
            cell.setCellViewInfo(name: pokemonArray[indexPath.item].name ?? "Unknown", num: pokemonArray[indexPath.item].id ?? 1)
            print("cell created")
            //cell.textLabel?.text = pokemonArray[indexPath.item].name //label cell with pokemon name
            return cell
        }
}
