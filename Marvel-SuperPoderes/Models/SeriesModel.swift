//
//  SeriesModel.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 15/11/23.
//

import Foundation

// MARK: - Series
struct Series: Codable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let etag: String
    let data: DataClassSerie
}

// MARK: - DataClass
struct DataClassSerie: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Serie]
}

// MARK: - Result
struct Serie: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [CharactersItem]
    let returned: Int
}

// MARK: - CharactersItem
struct CharactersItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String
    let name, role: String
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}
