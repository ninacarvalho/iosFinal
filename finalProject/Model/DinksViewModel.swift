//
//  DinksViewModel.swift
//  finalProject
//
//  Created by Marina Carvalho on 2024-12-13.
//
import Foundation

class DrinksViewModel {
    var drinks: [Drink] = []
    var filteredDrinks: [Drink] = []

    func searchDrinks(ingredient: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchDrinks(ingredient: ingredient) { [weak self] result in
            switch result {
            case .success(let drinks):
                self?.drinks = drinks
                self?.filteredDrinks = drinks
            case .failure(let error):
                print("Error fetching drinks: \(error)")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
