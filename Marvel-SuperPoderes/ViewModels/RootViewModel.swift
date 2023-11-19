//
//  RootViewModel.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 14/11/23.
//

import Foundation
import Combine

final class RootViewModel: ObservableObject {
    @Published var status = Status.none //Estado actual
    //@Published var tokenJWT: String = ""
    @Published var heros: [Heros]? //Almacenar la lista de héroes
    
    var suscriptors = Set<AnyCancellable>()
    
    func getHeros(sortBy order: OrderBy) {
        self.status = .loading // Estado cargando antes de la solicitud
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionHeros(sortBy: .id))
        
        // Manejo de errores y decodificacion de datos
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure:
                    self.status = Status.error(error: "Error al buscar heroes")
                case .finished:
                    self.status = .loaded
                }
            } receiveValue: { data in
                self.heros = data.data.results
            }
            .store(in: &suscriptors)
    }
}
