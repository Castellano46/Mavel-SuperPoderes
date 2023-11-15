//
//  RootViewModel.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 14/11/23.
//

import Foundation
import Combine

final class RootViewModel: ObservableObject {
    @Published var status = Status.none
    @Published var tokenJWT: String = ""
    
    var suscriptors = Set<AnyCancellable>()
}
