//
//  ViewController.swift
//  BeerApp
//
//  Created by Саша Amigo on 22.06.2023.
//

import UIKit

final class RecipeViewController: UITableViewController {
    
    private var recipes: [Recipe] = []
    
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

}

// MARK: - Networking
extension RecipeViewController {
    private func fetchRecipes() {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                self.recipes = try decoder.decode([Recipe].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}


