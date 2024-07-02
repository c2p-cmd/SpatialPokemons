//
//  ImmersiveView.swift
//  Pokemons
//
//  Created by Sharan Thakur on 02/07/24.
//

import SwiftUI
import RealityKit

struct AnimatedPokemonSpace: View {
    let uiImageURL: URL
    
    var body: some View {
        RealityView { content in
            do {
                let plane = MeshResource.generatePlane(width: 0.33, height: 0.33)
                
                let (url, _) = try await URLSession.shared.download(from: uiImageURL)
                
                let texture = try await TextureResource(contentsOf: url)
                
                let color = MaterialParameters.Texture(texture)
                let baseColor = PhysicallyBasedMaterial.BaseColor(texture: color)
                
                var mat = PhysicallyBasedMaterial()
                mat.baseColor = baseColor
                
                let modelEntity = ModelEntity(mesh: plane, materials: [mat])
                
                content.add(modelEntity)
            } catch {
                print(error)
            }
        }
    }
}

#Preview(windowStyle: .plain) {
    AnimatedPokemonSpace(uiImageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/125.png")!)
}
