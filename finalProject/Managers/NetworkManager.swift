//
//  NetworkingManager.swift
//  finalProject
//
//  Created by Marina Carvalho on 2024-12-13.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchDrinks(ingredient: String, completion: @escaping (Result<[Drink], Error>) -> Void) {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(ingredient)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(DrinksResponse.self, from: data)
                completion(.success(result.drinks))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchDrinkDetails(id: String, completion: @escaping (Result<DrinkDetail, Error>) -> Void) {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(DrinkDetailResponse.self, from: data)
                if let drink = result.drinks.first {
                    completion(.success(drink))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
