//
//  ViewController.swift
//  finalProject
//
//  Created by Marina Carvalho on 2024-12-13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // All Drinks fetched from the API
    var drinks: [Drink] = []
    
    // Filtered drinks based on search
    var filteredDrinks: [Drink] = []
    
    let viewModel = DrinksViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DrinkCell")
    }

    private func searchDrinks(with ingredient: String) {
        viewModel.searchDrinks(ingredient: ingredient) { [weak self] in
            guard let self = self else { return }
            self.drinks = self.viewModel.drinks
            self.filteredDrinks = self.drinks
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchBar.resignFirstResponder() // Dismiss the keyboard
        searchDrinks(with: searchText)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // Reset to all drinks if search text is cleared
            filteredDrinks = drinks
        } else {
            // Filter drinks by name
            filteredDrinks = drinks.filter { $0.strDrink.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDrinks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath)
        let drink = filteredDrinks[indexPath.row]
        cell.textLabel?.text = drink.strDrink
//        cell.imageView?.loadImage(from: drink.strDrinkThumb) // Use an extension for image loading
        return cell
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let selectedDrink = filteredDrinks[indexPath.row]
//
//        // Navigate to Drink Details Screen
//        DrinkDetailsViewController.drinkID = selectedDrink.idDrink
//        navigationController?.pushViewController(DrinkDetailsViewController, animated: true)
//    }
//}

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedDrink = filteredDrinks[indexPath.row]

        // Instantiate the DrinkDetailsViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
        guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "DrinkDetailsViewController") as? DrinkDetailsViewController else {
            return
        }

        // Assign the selected drink's ID to the drinkID property
        detailsVC.drinkID = selectedDrink.idDrink

        // Navigate to the DrinkDetailsViewController
        navigationController?.pushViewController(detailsVC, animated: true)
    }




// MARK: - UIImageView Extension for Loading Images
//extension UIImageView {
//    func loadImage(from urlString: String) {
//        guard let url = URL(string: urlString) else { return }
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self.image = image
//                }
//            }
//        }
//    }
//    }
}


