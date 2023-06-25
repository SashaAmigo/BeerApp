//
//  ViewController.swift
//  BeerApp
//
//  Created by Саша Amigo on 22.06.2023.
//

import UIKit

final class RecipeViewController: UITableViewController {
    
    private var recipes: [Recipe] = []
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 300
        fetchRecipes()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeCell
        
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        
        return cell
    }
    private func fetchRecipes() {
        networkManager.fetchRecipes(from: Link.randomURL.url) { [weak self] result in
            switch result {
            case .success(let recipes):
                self?.recipes = recipes
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}



