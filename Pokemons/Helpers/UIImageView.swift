//
//  UIImageView.swift
//  Pokemons
//
//  Created by Sharan Thakur on 02/07/24.
//

import SwiftUI

struct ImageView: UIViewRepresentable {
    let uiImage: UIImage?
    
    func makeUIView(context: Context) -> UIImageView {
        let uiView = UIImageView(image: uiImage)
        uiView.layer.magnificationFilter = .trilinear
        return uiView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = uiImage
    }
}
