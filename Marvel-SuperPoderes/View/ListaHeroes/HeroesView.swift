//
//  HeroesView.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 16/11/23.
//

import SwiftUI

struct HeroesView: View {
    @StateObject var viewModel: ViewModelHeros
    @State private var filter: String = ""
    @EnvironmentObject var viewModelRoot: RootViewModel

    var body: some View {
        NavigationStack {
            List {
                if let heros = viewModel.heros {
                    ForEach(heros) { data in
                        NavigationLink(
                            destination: SeriesView(hero: data),
                            label: {
                                HeroesRowView(hero: data)
                                    .frame(height: 200)
                            }
                        )
                    }
                }
            }
            .navigationTitle("Héroes Marvel")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        //viewModelRoot.loading
                    }, label: {
                        HStack {
                            Image(systemName: "xmark.circle")
                            Text("Close")
                                .font(.caption2)
                        }
                    })
                }
            }
        }
        .searchable(text: $filter,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Buscar Héroe...")
        .onChange(of: filter) { oldValue, newValue in
            viewModel.getHeros(filter: oldValue)
        }
    }
}

#Preview {
    HeroesView(viewModel: ViewModelHeros(testing: true))
}
