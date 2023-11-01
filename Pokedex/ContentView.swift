//
//  ContentView.swift
//  Pokedex
//
//  Created by Shon Bennett on 11/1/23.
//

import SwiftUI
import PokemonAPI

struct ContentView: View {
    @State private var pokemonName: String? // Store the fetched Pokémon name

    var body: some View {
        VStack {
            
            // Display the Pokémon name if it's available
            if let name = pokemonName {
                Text("Fetched Pokémon name: \(name)")
            } else {
                Text("Loading Pokémon name...")
            }
        }
        .onAppear {
            // Fetch the Pokémon name when the view appears
            pokemonServiceCall { result in
                switch result {
                case .success(let name):
                    // Update the @State variable to reflect the fetched name
                    pokemonName = name
                case .failure(let error):
                    print("Error")
                }
            }
        }
    }
}
#Preview {
    ContentView()
}

func pokemonServiceCall(completion: @escaping (Result<String, Error>) -> Void) {
    // Example of calling a web API using a name
    PokemonAPI().pokemonService.fetchPokemon("charizard") { result in
        switch result {
        case .success(let pokemon):
            pokemon.name = pokemon.name // bulbasaur
            completion(.success(pokemon.name ?? "empty"))
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

