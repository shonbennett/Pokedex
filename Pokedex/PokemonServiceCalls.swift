//
//  PokemonServiceCalls.swift
//  Pokedex
//
//  Created by Shon Bennett on 11/8/23.
//

import Foundation
import PokemonAPI

func pokemonServiceCall(completion: @escaping (Result<PKMPokemon?, Error>) -> Void) {
    // Example of calling a web API using a name
    PokemonAPI().pokemonService.fetchPokemon("squirtle") { result in
        switch result {
        case .success(let pokemon):
//            pokemon.name = pokemon.name // charizard
            completion(.success(pokemon))
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
