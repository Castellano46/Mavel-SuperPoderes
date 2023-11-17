//
//  ViewModelSeries.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 16/11/23.
//

import Foundation
import Combine

final class ViewModelSeries: ObservableObject {
    @Published var hero: Heros
    @Published var series: [Serie]?
    @Published var status = Status.none
    
    var suscriptors = Set<AnyCancellable>()
    
    init(hero: Heros, testing: Bool = false) {
        self.hero = hero
        if (testing) {
            self.getSeriesTest()
        } else {
            self.getHerosSerie()
        }
    }
    
    func getHerosSerie() {
        self.status = .loading
            
            URLSession.shared
                .dataTaskPublisher(for: BaseNetwork().getSessionHerosSeries(with: hero.id, sortBy: .startYear))
                .tryMap {
                    guard let response = $0.response as? HTTPURLResponse,
                          response.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return $0.data
                }
                .decode(type: Series.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .failure:
                        self.status = Status.error(error: "Error buscando series de héroes")
                    case .finished:
                        self.status = .loaded
                    }
                } receiveValue: { data in
                    self.series = data.data.results
                }
                .store(in: &suscriptors)
    }
    
    func getSeriesTest() {
        let series1 = Serie(id: 1, title: "test", description: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/4ce59d3a80ff7", thumbnailExtension: .jpg));
        let series2 = Serie(id: 1, title: "test", description: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/4ce59d3a80ff7", thumbnailExtension: .jpg));
     
        self.series = [series1, series2]
    }
}
