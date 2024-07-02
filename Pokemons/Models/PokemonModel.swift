//
//  PokemonModel.swift
//  Pokemons
//
//  Created by Sharan Thakur on 02/07/24.
//

import Foundation

struct PokemonModel: Codable, Hashable {
    let name: String
    let animated_sprites: AnimatedSprites
    let cries: PokemonCries
}

struct AnimatedSprites: Codable, Hashable {
    let back_default: String
    let back_shiny: String?
    
    let front_default: String
    let front_shiny: String?
    
    func allUrls() -> [URL] {
        [ back_default, back_shiny, front_default, front_shiny ].compactMap { urlString in
            if let urlString {
                URL(string: urlString)
            } else {
                nil
            }
        }
    }
}

struct PokemonCries: Codable, Hashable {
    let latest: String?, legacy: String?
}

enum PokemonError: String, LocalizedError {
    case notFound = "Pokemon not found!"
    
    var errorDescription: String? {
        rawValue
    }
}
