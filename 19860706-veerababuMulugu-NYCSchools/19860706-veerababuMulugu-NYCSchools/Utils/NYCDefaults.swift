//
//  NYCDefaults.swift
//  19860706-veerababuMulugu-NYCSchools
//
//  Created by Veerababu Mulugu on 12/5/22.
//

import Foundation

private let favoritesKey = "favorites"

final class NYCDefaults {

    private var favorites = [String]()

    static let shared = NYCDefaults()
    private init() {
        if let _favorites = UserDefaults.standard.array(forKey: favoritesKey) as? [String] {
            favorites = _favorites
        } else {
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
        }
    }

    func toggleFavourite(id: String) {
        if favorites.contains(id) {
            favorites.removeAll(where: { $0 == id})
        } else {
            favorites.append(id)
        }
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
        UserDefaults.standard.synchronize()
    }

    func isFavorite(id: String) -> Bool {
        favorites.contains(id)
    }
}
