//
//  Marvel_SuperPoderesTests.swift
//  Marvel-SuperPoderesTests
//
//  Created by Pedro on 14/11/23.
//

import XCTest
import SwiftUI
import ViewInspector
import Combine
@testable import Marvel_SuperPoderes

final class Marvel_SuperPoderesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Test de UI

    func testLoaderView() throws {
        let view = LoadView().environmentObject(ViewModelHeros())

        XCTAssertNotNil(view)

        let text = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(text)
    }

    func testErrorView() throws {
        let view = ErrorView(error: "Testing")
            .environmentObject(ViewModelHeros())

        XCTAssertNotNil(view)

        let image = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(image)

        let text = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(text)

        let texto = try text.text().string()
        XCTAssertEqual(texto, "Testing")

        let boton = try view.inspect().find(viewWithId: 2)
        XCTAssertNotNil(boton)
        try boton.button().tap()
    }

    func testHeroesViewRow() throws {
        let view = HeroesRowView(hero: Heros(id: 95865, name: "Outlaw (Inez Temple)", description: "Prueba", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/4ce59d3a80ff7", thumbnailExtension: .jpg), resourceURI: "", comics: Comics(available: 2, collectionURI: "", items: [ComicsItem(resourceURI: "", name: ""), ComicsItem(resourceURI: "", name: "")], returned: 2), series: Comics(available: 2, collectionURI: "", items: [ComicsItem(resourceURI: "", name: ""), ComicsItem(resourceURI: "", name: "")], returned: 2), stories: Stories(available: 1, collectionURI: "", items: [StoriesItem(resourceURI: "", name: " ", type: .cover)], returned: 1), events: Comics(available: 2, collectionURI: "", items: [ComicsItem(resourceURI: "", name: ""), ComicsItem(resourceURI: "", name: " ")], returned: 2), urls: [URLElement(type: .detail, url: "")]))
            .environmentObject(ViewModelHeros())

        XCTAssertNotNil(view)

        let image = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(image)

        let text = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(text)
    }

    func testHeroesSeriesRowView() throws {
        let view = SeriesRowView(serie: Serie(id: 1, title: "test", description: "", thumbnail: Thumbnail(path: "",thumbnailExtension: .jpg)))
            .environmentObject(ViewModelHeros())

        XCTAssertNotNil(view)

        let title = try view.inspect().find(viewWithId: 0)
        XCTAssertNotNil(title)

        let image = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(image)

        let description = try view.inspect().find(viewWithId: 2)
        XCTAssertNotNil(description)
    }

    // MARK: - Test de Models

    func testModels() throws {
        let hero = Heros(id: 95865, name: "Hit-Monkey", description: "testeoHeroe", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/30/4ce69c2246c21", thumbnailExtension: .jpg), resourceURI: "", comics: Comics(available: 2, collectionURI: "", items: [ComicsItem(resourceURI: "", name: ""), ComicsItem(resourceURI: "", name: "")], returned: 2), series: Comics(available: 2, collectionURI: "", items: [ComicsItem(resourceURI: "", name: ""), ComicsItem(resourceURI: "", name: "")], returned: 2), stories: Stories(available: 1, collectionURI: "", items: [StoriesItem(resourceURI: "", name: " ", type: .cover)], returned: 1), events: Comics(available: 2, collectionURI: "", items: [ComicsItem(resourceURI: "", name: ""), ComicsItem(resourceURI: "", name: " ")], returned: 2), urls: [URLElement(type: .detail, url: "")])

        XCTAssertNotNil(hero)
        XCTAssertEqual(hero.name, "Hit-Monkey")
        XCTAssertEqual(hero.description, "testeoHeroe")
        XCTAssertEqual(hero.thumbnail.path, "http://i.annihil.us/u/prod/marvel/i/mg/6/30/4ce69c2246c21")

        let serie = Serie(id: 1, title: "testSerie", description: "descriptionSerie", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/30/4ce69c2246c21", thumbnailExtension: .jpg ))

        XCTAssertNotNil(serie)
        XCTAssertEqual(serie.title, "testSerie")
        XCTAssertEqual(serie.description, "descriptionSerie")
        XCTAssertEqual(serie.thumbnail.path, "http://i.annihil.us/u/prod/marvel/i/mg/6/30/4ce69c2246c21")
    }

    // MARK: - Test de Combine

    func testViewModelHero() throws {
            var cancellables = Set<AnyCancellable>()
            let expectation = self.expectation(description: "Models heroes")

            let vm = ViewModelHeros(testing: true)
            XCTAssertNotNil(vm)

        vm.$status
            .sink { status in
                switch status {
                case .error(let error):
                    XCTFail("Error: \(error)")
                    expectation.fulfill() // Llamada en caso de error
                case .loaded:
                    XCTAssert(true)
                    expectation.fulfill() // Llamada en caso de carga
                default:
                    break
                }
            }
            .store(in: &cancellables)

            vm.getHeros(filter: "-modified")

            self.waitForExpectations(timeout: 20)
        }

        func testViewModelSeries() throws {
            let expectation = XCTestExpectation(description: "Models series")

                let vm = ViewModelSeries()
                XCTAssertNotNil(vm)

                var cancellables = Set<AnyCancellable>()

                vm.$status
                    .sink { status in
                        switch status {
                        case .error(let error):
                            XCTFail("Error: \(error)")
                        case .loaded:
                            XCTAssert(true)
                        default:
                            break
                        }
                        expectation.fulfill()
                    }
                    .store(in: &cancellables)

                vm.getHerosSerie(for: Heros(id: 1, name: "Periquito", description: "En la naturaleza, son las aves con más población de toda Australia lo que podría deberse a su rápida reproducción ya que dejan de ser pichones y empiezan su reproducción a partir de los sesenta días de haber nacido, y a que las hembras ponen, en promedio, de cinco a seis huevos, lo cual las hace ser muy adaptables, aunque ellas habitan en Australia extendiéndose por el centro del país.", modified: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: .jpg), resourceURI: "", comics: Comics(available: 1, collectionURI: "", items: [], returned: 12), series: Comics(available: 12, collectionURI: "", items: [], returned: 12), stories: Stories(available: 12, collectionURI: "", items: [], returned: 12), events: Comics(available: 12, collectionURI: "", items: [], returned: 2), urls: []))

                wait(for: [expectation], timeout: 10)
            }
    }


