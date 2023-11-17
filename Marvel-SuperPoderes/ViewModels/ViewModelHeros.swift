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
    
    var suscriptors = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        if (testing) {
          getHerosTesting()
        } else {
          getHeros(filter: "")
        }
    }
    
    func getHeros(filter: String){
        self.status = .loading
            
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionHeros(sortBy: .formerModified))
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    print("Error: \(output.response)")
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Failure: \(error)")
                    self.status = .error(error: error.localizedDescription)
                case .finished:
                    self.status = .loaded
                }
            } receiveValue: { data in
                //print("Received data: \(data)")
                self.heros = data.data.results
            }
            .store(in: &suscriptors)
    }
    
    func getHerosTesting(){
        self.status = .loading
        self.heros = getHerosDesign()
        self.status = .loaded
       
    }
    
    func getHerosDesign() -> [Heros]{
        let hero1 = Heros(id: 0001, name: "Periquito", description: "En la naturaleza, son las aves con más población de toda Australia lo que podría deberse a su rápida reproducción ya que dejan de ser pichones y empiezan su reproducción a partir de los sesenta días de haber nacido, y a que las hembras ponen, en promedio, de cinco a seis huevos, lo cual las hace ser muy adaptables, aunque ellas habitan en Australia extendiéndose por el centro del país.", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: .jpg), resourceURI: "", comics: Comics(available: 1, collectionURI: "", items: [], returned: 12), series: Comics(available: 12, collectionURI: "", items: [], returned: 12), stories: Stories(available: 12, collectionURI: "", items: [], returned: 12), events: Comics(available: 12, collectionURI: "", items: [], returned: 2), urls: [])
        
        let hero2 = Heros(id: 0002, name: "El de los Palotes", description: "", modified: "", thumbnail: Thumbnail(path: "", thumbnailExtension: .jpg), resourceURI: "", comics: Comics(available: 1, collectionURI: "", items: [], returned: 12), series: Comics(available: 12, collectionURI: "", items: [], returned: 12), stories: Stories(available: 12, collectionURI: "", items: [], returned: 12), events: Comics(available: 12, collectionURI: "", items: [], returned: 2), urls: [])
        
        return [hero1, hero2]
    }
}
       

