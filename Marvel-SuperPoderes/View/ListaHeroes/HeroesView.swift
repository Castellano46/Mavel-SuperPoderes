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
    @State private var isLoading: Bool = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredHeros(filter: filter)) { data in
                    NavigationLink(
                        destination: SeriesView(viewModel: ViewModelSeries(), hero: data)
                            .onAppear {
                                isLoading = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    isLoading = false
                                }
                            },label: {
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
            .overlay(
                Group {
                    if isLoading {
                        LoadView()
                    }
                }
            )
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

