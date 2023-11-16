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
        
        switch rootViewModel.status{
        case Status.none:
            withAnimation{
                LoadView()
            }
        case .loading:
            withAnimation{
                LoadView()
            }
        case .loaded:
            Text("Heroes")
            //HeroesView(viewModel: viewmodel)
        case .error(error: let errorString):
            withAnimation{
                ErrorView(error: errorString)
            }
        }
        
        ZStack {
            Image(decorative: colorScheme == .dark ? "fondo2" : "fondo1")
                .resizable()
                .opacity(1)
                .aspectRatio(contentMode: .fill)
                //.edgesIgnoringSafeArea(.all)
           
            VStack{
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .opacity(0.8)
                    .padding(.top, -350)
            }
            .padding([.leading, .trailing],20)
        }
        .ignoresSafeArea()
    }
}

#Preview{
        RootView()
            .environmentObject(RootViewModel())
            .environment(\.locale, .init(identifier: "es"))
            //.preferredColorScheme(.light)
        //.environment(\.locale, .init(identifier: "en"))
}

//




