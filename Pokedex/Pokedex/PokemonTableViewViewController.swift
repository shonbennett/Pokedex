//
//  PokemonTableViewViewController.swift
//  Pokedex
//
//  Created by Shon Bennett on 11/10/23.
//

import UIKit
import PokemonAPI
/*
 This view controller creates a UITableView and populates it with data
 */
class PokemonTableViewViewController: UIViewController {
    var pokemonArray:[PKMPokemon] = []
    
    var tableView: UITableView = UITableView();
    
    override func viewDidLoad() { //view was loaded into memory
        super.viewDidLoad()
        configureTableView()
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
                                // Reload in main thread the table view to reflect the new data
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
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
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false //use Auto Layout constraints instead of the older autoresizing mask system
        setTableConstraints()
        setTableViewDelegate()
        //must be included or we will not be able to use the table for populization
        tableView.register(PokemonCellTableViewCell.self, forCellReuseIdentifier: "pokemoncell")
    }
    
    func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setTableConstraints() {
        //ensures the table is within the view of the window
        NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension //height adjusts dynamically
        tableView.estimatedRowHeight = 40 //minimum height for a cell
        tableView.separatorStyle = .none //gets rid of table lines
    }

}

//manages data and provides cells for table view; implements data source methods for population
extension PokemonTableViewViewController: UITableViewDataSource, UITableViewDelegate {
    //tells us the number of rows needed for a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    //return the custome UITableViewCell (PokemonCellTableViewCell) for the given indexPath (indexPath has two ints; one is section, other is row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemoncell", for: indexPath) as! PokemonCellTableViewCell
        cell.setCellViewInfo(name: pokemonArray[indexPath.item].name ?? "Unknown", num: pokemonArray[indexPath.item].id ?? 1)
        
        //cell.textLabel?.text = pokemonArray[indexPath.item].name //label cell with pokemon name
        return cell
    }
}

