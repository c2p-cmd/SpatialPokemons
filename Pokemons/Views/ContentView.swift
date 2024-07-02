//
//  ContentView.swift
//  Pokemons
//
//  Created by Sharan Thakur on 02/07/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @Environment(AppModel.self) var appModel
    
    var body: some View {
        NavigationStack {
            AddPokemonView()
                .navigationTitle("Animated Pokemon Viewer")
                .toolbar {
                    ToggleImmersiveSpaceButton(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/125.png")!)
                }
                .padding()
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
