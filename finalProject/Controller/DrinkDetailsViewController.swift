//
//  DrinkDetailsViewController.swift
//  finalProject
//
//  Created by Marina Carvalho on 2024-12-13.
//

import UIKit

class DrinkDetailsViewController: UIViewController {
    var drinkID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetch drink details
        if let id = drinkID {
            fetchDrinkDetails(with: id)
        }
    }

    private func fetchDrinkDetails(with id: String) {
        let viewModel = DrinkDetailsViewModel()
        viewModel.fetchDrinkDetails(id: id) {
            DispatchQueue.main.async {
                // Update UI with fetched details
                // For example:
                // self.nameLabel.text = viewModel.drinkDetail?.strDrink
            }
        }
    }
}
