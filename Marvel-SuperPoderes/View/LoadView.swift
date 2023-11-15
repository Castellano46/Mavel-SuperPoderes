//
//  LoadView.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 15/11/23.
//

import SwiftUI

struct LoadView: View {
    var body: some View {
        ProgressView(NSLocalizedString("loading", comment: ""))
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .foregroundColor(.blue)
    }
}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView()
    }
}
