//
//  LoadView.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 15/11/23.
//

import SwiftUI

struct LoadView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            Image(decorative: colorScheme == .dark ? "fondo2" : "fondo1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.8)
                    .padding(.top, -340)

                ProgressView(NSLocalizedString("Loading", comment: ""))
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .foregroundColor(.blue)
                    .font(.system(size: 20, weight: .bold))
                    .scaleEffect(2.0)
                    .id(0)
            }
            .padding([.leading, .trailing], 20)
        }
        .ignoresSafeArea()
    }
}

#Preview {
        LoadView()
}
