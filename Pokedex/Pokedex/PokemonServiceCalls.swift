//
//  PokemonServiceCalls.swift
//  Pokedex
//
//  Created by Shon Bennett on 11/10/23.
//

import Foundation
import PokemonAPI

func pokemonServiceCall(num:Int, completion: @escaping (Result<PKMPokemon?, Error>) -> Void) {
    
    PokemonAPI().pokemonService.fetchPokemon(num) { result in
        switch result {
        case .success(let pokemon):
            //add pokemon to array if is a success
            completion(.success(pokemon))
        case .failure(let error):
            print(error.localizedDescription)
            completion(.failure(error))
        }
    }
}
