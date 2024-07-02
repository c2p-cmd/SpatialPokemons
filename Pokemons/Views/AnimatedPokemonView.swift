//
//  AnimatedPokemonView.swift
//  Pokemons
//
//  Created by Sharan Thakur on 02/07/24.
//

import SwiftUI

struct AnimatedPokemonView: View {
    @State var uiImage: UIImage?
    
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        ZStack(alignment: .center) {
            if let uiImage {
                ImageView(uiImage: uiImage)
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "circle.circle")
                    .resizable()
                    .scaledToFit()
                    .symbolEffect(.pulse.byLayer)
            }
        }
        .ornament(visibility: .automatic, attachmentAnchor: .scene(.bottom)) {
            Button("Home", systemImage: "house.fill") {
                openWindow(id: "main", value: true)
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    AnimatedPokemonView(uiImage: .gifImageWithName("25"))
        .frame(height: 400)
}
