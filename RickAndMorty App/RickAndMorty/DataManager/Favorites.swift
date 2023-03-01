//
//  Favorites.swift
//  RickAndMorty
//
//  Created by Andrii Stetsenko on 17.02.2023.
//

import Foundation

class Favorites {
    static let shared = Favorites()
    
    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let resultKey = "results"
    
    private var favorites: Set<Int> = [] {
        didSet {
            saveFavorites()
        }
    }
    
    init() {
        getFavorites()
    }
    
    func isFavorite(_ result: Result) -> Bool {
        favorites.contains(result.id)
    }
    
    func toggleFavorite(_ result: Result) {
        if favorites.contains(result.id) {
            favorites.remove(result.id)
        } else {
            favorites.insert(result.id)
        }
    }
    
    func saveFavorites() {
        if let encoded = try? encoder.encode(favorites) {
            defaults.set(encoded, forKey: resultKey)
        }
    }
    
    func getFavorites() {
        if let savedFavorites = defaults.object(forKey: resultKey) as? Data {
            if let loadedFavorites = try? decoder.decode(Set<Int>.self, from: savedFavorites) {
                self.favorites = loadedFavorites
            }
        }
    }
}
