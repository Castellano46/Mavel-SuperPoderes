//
//  KeyChain.swift
//  Marvel-SuperPoderes
//
//  Created by Pedro on 14/11/23.
//

import KeychainSwift

//Guardamos
func saveKC(key: String, value: String) -> Bool {
    if let data = value.data(using: .utf8){
        return KeychainSwift().set(data, forKey: key)
    } else {
        return false
    }
}

//Leemos
func loadKC(key: String) -> String? {
    if let data = KeychainSwift().get(key){
        return data
    } else {
        return ""
    }
}

//Borramos
func deleteKC(key: String) -> Bool{
    KeychainSwift().delete(key)
}
