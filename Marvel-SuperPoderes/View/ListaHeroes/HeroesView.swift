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
                ForEach(viewModel.filteredHeros(filter: filter)) { data in
                    NavigationLink(
                        destination: SeriesView(hero: data),
                        label: {
                            HeroesRowView(hero: data)
                                .frame(height: 200)
                        }
                    )
                }
            }
            .id(0)
            .navigationTitle("Heroes Marvel")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.getHeros(filter: filter)
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
        .searchable(text: $filter)
    }
}

extension ViewModelHeros {
    func filteredHeros(filter: String) -> [Heros] {
        guard !filter.isEmpty else {
            return heros ?? []
        }
        return (heros ?? []).filter { $0.name.lowercased().contains(filter.lowercased()) }
    }
}

#Preview {
    HeroesView(viewModel: ViewModelHeros(testing: true))
}
