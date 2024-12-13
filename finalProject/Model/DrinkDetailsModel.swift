//
//  DrinkDetailsModel.swift
//  finalProject
//
//  Created by Marina Carvalho on 2024-12-13.
//
import Foundation

class DrinkDetailsViewModel {
    var drinkDetail: DrinkDetail?

    func fetchDrinkDetails(id: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchDrinkDetails(id: id) { [weak self] result in
            switch result {
            case .success(let drink):
                self?.drinkDetail = drink
            case .failure(let error):
                print("Error fetching drink details: \(error)")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}

