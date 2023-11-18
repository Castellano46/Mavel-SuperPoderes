//
//  ViewModelSeries.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 16/11/23.
//

import Foundation
import Combine

final class ViewModelSeries: ObservableObject {
    @Published var series: [Serie]?
    @Published var status = Status.none

    private var cancellables = Set<AnyCancellable>()

    init() {}

    func getHerosSerie(for hero: Heros) {
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
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.handleFailure(error)
                case .finished:
                    self.status = .loaded
                }
            } receiveValue: { [weak self] data in
                self?.series = data.data.results
            }
            .store(in: &cancellables)
    }

    private func handleFailure(_ error: Error) {
        print("Failure: \(error)")
        self.status = .error(error: error.localizedDescription)
    }

    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
