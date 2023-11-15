//
//  ErrorView.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 15/11/23.
//

import SwiftUI

struct ErrorView: View {
    private var error: String
    private var onRetry: (() -> Void)?

    init(error: String, onRetry: (() -> Void)? = nil) {
        self.error = error
        self.onRetry = onRetry
    }

    var body: some View {
        VStack {
            Spacer()

            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.red)
                .frame(width: 50, height: 50) // Ajusta el tamaño aquí
                .padding()
                .id(0)

            Text("\(error)")
                .foregroundColor(.red)
                .font(.title)
                .id(1)

            Spacer()

            Button(NSLocalizedString("BACK", comment: "")) {
                onRetry?()
            }
            .frame(width: 300, height: 50)
            .background(.orange)
            .font(.title2)
            .bold()
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(radius: 10.0, x: 10, y: 10)
            .id(2)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "Error!!")
            //.environmentObject(ViewModelHeros())
    }
}
