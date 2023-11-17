//
//  RootView.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 14/11/23.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var rootViewModel: RootViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        switch rootViewModel.status {
        case Status.none, Status.loading:
            withAnimation {
                LoadView()
            }
        case .loaded:
            HeroesView(viewModel: ViewModelHeros())
        case .error(error: let errorString):
            withAnimation {
                ErrorView(error: errorString)
            }
        }
    }
}

#Preview{
        RootView()
            .environmentObject(RootViewModel())
            .environment(\.locale, .init(identifier: "es"))
            //.preferredColorScheme(.light)
        //.environment(\.locale, .init(identifier: "en"))
}
