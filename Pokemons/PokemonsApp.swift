//
//  PokemonsApp.swift
//  Pokemons
//
//  Created by Sharan Thakur on 02/07/24.
//

import SwiftUI

@main
struct PokemonsApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup(id: "main", for: Bool.self) { _ in
            ContentView()
                .frame(minWidth: 600, minHeight: 600)
                .environment(appModel)
        }
        .defaultSize(width: 600, height: 900)
        .windowResizability(.contentSize)

        ImmersiveSpace(id: appModel.immersiveSpaceID, for: URL.self) { $url in
            AnimatedPokemonSpace(uiImageURL: url ?? URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/125.gif")!)
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        WindowGroup(for: Data.self) { $data in
            AnimatedPokemonView(uiImage: .gifImageWithData(data!))
                .frame(minHeight: 100)
        }
        .defaultSize(width: 300, height: 300)
        .windowStyle(.volumetric)
        .windowResizability(.contentMinSize)
     }
}
