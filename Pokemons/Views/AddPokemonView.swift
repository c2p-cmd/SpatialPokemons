//
//  AddPokemonView.swift
//  Pokemons
//
//  Created by Sharan Thakur on 02/07/24.
//

import SwiftUI

struct AddPokemonView: View {
    @State private var vm = ViewModel()
    
    enum Field {
        case text
    }
    
    @FocusState var textFieldFocus: Field?
    
    var body: some View {
        Form {
            HStack {
                TextField(
                    "Pokemon id or name",
                    text: $vm.text,
                    prompt: Text("Enter pokemon name"),
                    axis: .vertical
                )
                .focused($textFieldFocus, equals: .text)
                .font(.title2)
                .disabled(vm.isBusy)
                .onSubmit(of: .text) {
                    self.textFieldFocus = nil
                }
                
                Divider()
                
                Button("Find!", systemImage: "magnifyingglass.circle") {
                    vm.findPokemon(focusStateChange: {
                        self.textFieldFocus = nil
                    })
                }
                .buttonStyle(PlainButtonStyle())
                .font(.title3)
                .disabled(vm.isBusy)
                .alert("Alert!", isPresented: $vm.showError, presenting: vm.error) { _ in
                } message: { errorText in
                    Text(errorText)
                }
            }
            .overlay {
                if vm.isBusy {
                    ProgressView()
                }
            }
            
            ForEach(Array(vm.pokemonMap.keys), id: \.name) { (p: PokemonModel) in
                if let sprites = self.vm.pokemonMap[p] {
                    LabeledContent(p.name) {
                        PokemonGrid(pokemonGifData: sprites)
                    }
                } else {
                    Text("nothing for \(p.name)")
                }
            }
        }
    }
}

fileprivate struct PokemonGrid: View {
    let pokemonGifData: [Data]
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.openImmersiveSpace) var openSpace
    @Environment(\.dismissImmersiveSpace) var closeSpace
    
    var body: some View {
        LazyHGrid(rows: [
            GridItem(.flexible(minimum: 100, maximum: 200)),
            GridItem(.flexible(minimum: 100, maximum: 200)),
        ]) {
            ForEach(pokemonGifData, id: \.self) { data in
                if let uiImage = UIImage.gifImageWithData(data) {
                    VStack(alignment: .center, spacing: 5) {
                        ImageView(uiImage: uiImage)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                        
                        Button("Add Pokemon", systemImage: "plus.circle") {
                            openWindow(value: data)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                } else {
                    Text("Problem!")
                }
            }
        }
    }
}

extension AddPokemonView {
    @Observable
    class ViewModel {
        var text = ""
        var isBusy = false
        var error: String?
        var showError = false
        
        var pokemonMap: [PokemonModel: [Data]] = [:]
        
        func findPokemon(focusStateChange: (() -> ())? = nil) {
            Task {
                if text.isEmpty || isBusy { return }
                
                isBusy = true
                focusStateChange?()
                do {
                    var url = URL(string: "http://localhost:8000/sprites")!
                    url.append(queryItems: [
                        URLQueryItem(name: "pokemon", value: text.trimmingCharacters(in: .whitespaces))
                    ])
                    
                    let (data, response) = try await URLSession.shared.data(from: url)
                    
                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                        throw PokemonError.notFound
                    }
                    
                    let pokemonModel = try JSONDecoder().decode(PokemonModel.self, from: data)
                    
                    self.pokemonMap[pokemonModel] = await downloadAllPokemons(for: pokemonModel.animated_sprites.allUrls())
                    self.isBusy = false
                } catch {
                    print(error)
                    if let localError = error as? LocalizedError {
                        self.error = localError.errorDescription ?? localError.localizedDescription
                    } else {
                        self.error = String(describing: error)
                    }
                    self.showError = true
                    self.isBusy = false
                }
            }
        }
        
        func downloadAllPokemons(for urls: [URL]) async -> [Data] {
            var data: [Data] = []
            
            for url in urls {
                if let (d, response) = try? await URLSession.shared.data(from: url),
                   let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 200 {
                    data.append(d)
                } else {
                    print("a problem!")
                }
            }
            
            return data
        }
    }
}

#Preview(windowStyle: .plain) {
    AddPokemonView()
        .frame(width: 400, height: 500)
}
