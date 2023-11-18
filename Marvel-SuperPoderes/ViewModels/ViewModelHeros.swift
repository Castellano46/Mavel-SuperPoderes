//
//  ViewModelHeros.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 16/11/23.
//

import Foundation
import Combine

final class ViewModelHeros: ObservableObject {
    @Published var heros: [Heros]?
    @Published var status = Status.none
    
    private var cancellables = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        if testing {
            getHerosTesting()
        } else {
            getHeros(filter: "")
        }
    }
    
    func getHeros(filter: String) {
        self.status = .loading
        
        fetchData()
            .decode(type: Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.handleFailure(error)
                case .finished:
                    self.status = .loaded
                }
            }, receiveValue: { [weak self] data in
                self?.heros = data.data.results
            })
            .store(in: &cancellables)
    }
    
    func getHerosTesting() {
        self.status = .loading
        self.heros = generateTestHeros()
        self.status = .loaded
    }
    
    private func fetchData() -> AnyPublisher<Data, URLError> {
        return URLSession.shared.dataTaskPublisher(for: BaseNetwork().getSessionHeros(sortBy: .formerModified))
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .mapError { $0 as? URLError ?? URLError(.unknown) }
            .eraseToAnyPublisher()
    }
    
    private func generateTestHeros() -> [Heros] {
        let hero1 = Heros(id: 0001, name: "Periquito", description: "En la naturaleza, son las aves con más población de toda Australia lo que podría deberse a su rápida reproducción ya que dejan de ser pichones y empiezan su reproducción a partir de los sesenta días de haber nacido, y a que las hembras ponen, en promedio, de cinco a seis huevos, lo cual las hace ser muy adaptables, aunque ellas habitan en Australia extendiéndose por el centro del país.", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: .jpg), resourceURI: "", comics: Comics(available: 1, collectionURI: "", items: [], returned: 12), series: Comics(available: 12, collectionURI: "", items: [], returned: 12), stories: Stories(available: 12, collectionURI: "", items: [], returned: 12), events: Comics(available: 12, collectionURI: "", items: [], returned: 2), urls: [])
        
        let hero2 = Heros(id: 0002, name: "El de los Palotes", description: "", modified: "", thumbnail: Thumbnail(path: "", thumbnailExtension: .jpg), resourceURI: "", comics: Comics(available: 1, collectionURI: "", items: [], returned: 12), series: Comics(available: 12, collectionURI: "", items: [], returned: 12), stories: Stories(available: 12, collectionURI: "", items: [], returned: 12), events: Comics(available: 12, collectionURI: "", items: [], returned: 2), urls: [])
        
        return [hero1, hero2]
    }
    
    private func handleFailure(_ error: Error) {
        print("Failure: \(error)")
        self.status = .error(error: error.localizedDescription)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
