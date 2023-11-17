//
//  HeroesRowView.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 16/11/23.
//

import SwiftUI

struct HeroesRowView: View {
    var hero: Heros
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension)")) { photo in
                photo
                    .resizable()
                    .cornerRadius(20)
                    .opacity(0.8)
                    .id(0)
            } placeholder: {
                Image(systemName: "person")
                    .resizable()
                    .cornerRadius(20)
                    .opacity(0.8)
            }

            VStack {
                HStack {
                    Text(hero.name)
                        .font(.title2)
                        .foregroundStyle(.white)
                        .bold()
                        .padding([.top, .leading], 20)
                        .id(1)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    HeroesRowView(hero: Heros(id: 0001, name: "Periquito", description: "En la naturaleza, son las aves con más población de toda Australia lo que podría deberse a su rápida reproducción ya que dejan de ser pichones y empiezan su reproducción a partir de los sesenta días de haber nacido, y a que las hembras ponen, en promedio, de cinco a seis huevos, lo cual las hace ser muy adaptables, aunque ellas habitan en Australia extendiéndose por el centro del país.", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: .jpg), resourceURI: "", comics: Comics(available: 1, collectionURI: "", items: [], returned: 12), series: Comics(available: 12, collectionURI: "", items: [], returned: 12), stories: Stories(available: 12, collectionURI: "", items: [], returned: 12), events: Comics(available: 12, collectionURI: "", items: [], returned: 2), urls: []))
}
