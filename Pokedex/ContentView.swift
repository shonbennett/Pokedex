//
//  ContentView.swift
//  Pokedex
//
//  Created by Shon Bennett on 11/1/23.
//

import SwiftUI
import UIKit
import PokemonAPI

struct ContentView: View {
    @State private var pokemon: PKMPokemon?
    @State var gifImageView: UIImageView!

    var body: some View {
        VStack {
            
            // Testing API functions
            if let pokemonReturned = pokemon {
                GifImage("8").frame(width: 100, height: 100)
                Text("Fetched Pokémon name: \(pokemonReturned.name ?? "empty")")
                
            } else {
                Text("Loading Pokémon name...")
            }
        }
        .onAppear {
            // Fetch the Pokémon name when the view appears
            pokemonServiceCall { result in
                switch result {
                case .success(let pokemonReturned):
                    // Update the @State variable to reflect the fetched name
                    pokemon = pokemonReturned
                case .failure(_):
                    print("Error")
                }
            }
        }
    }
}
#Preview {
    ContentView()
}

