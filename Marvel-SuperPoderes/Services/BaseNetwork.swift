//
//  BaseNetwork.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 15/11/23.
//

import Foundation

let server = "https://gateway.marvel.com"

struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
    static let content = "application/json"
}

enum endpoints: String {
    case herosList = "/v1/public/characters"
    case herosSeries = "/series"
}

enum auth: String {
    case ts = "1"
    case apikey = "00419db460a4abaf5d3b4fd97fa83ff1"
    case hash = "2101aa6ae87af4901488b0e34e59493d"
}

enum OrderBy: String {
    case formerModified = "-modified"
    case startYear = "startYear"
}

struct BaseNetwork {
    
    // Lista de heroes
    func getSessionHeros(sortBy orderMethod: OrderBy) -> URLRequest {
        
        let accessAuth = "?ts=\(auth.ts.rawValue)&apikey=\(auth.apikey.rawValue)&hash=\(auth.hash.rawValue)"
        let sortBy = "&orderBy=\(orderMethod.rawValue)"
        let urlcad: String = "\(server)\(endpoints.herosList.rawValue)\(accessAuth)\(sortBy)"
        let url = URL(string: urlcad)
        
        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethods.get
        
        return request
    }
    
    // Lista de series
    func getSessionHerosSeries(with heroId: Int, sortBy orderMethod: OrderBy) -> URLRequest {
        
        let accessAuth = "?ts=\(auth.ts.rawValue)&apikey=\(auth.apikey.rawValue)&hash=\(auth.hash.rawValue)"
        let sortBy = "&orderBy=\(orderMethod.rawValue)"
        let urlcad: String = "\(server)\(endpoints.herosList.rawValue)/\(heroId)\(endpoints.herosSeries.rawValue)\(accessAuth)\(sortBy)"
        let url = URL(string: urlcad)
        
        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethods.get
        
        return request
    }
}
