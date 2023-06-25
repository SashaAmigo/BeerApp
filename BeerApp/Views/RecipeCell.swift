//
//  RecipeCell.swift
//  BeerApp
//
//  Created by Саша Amigo on 22.06.2023.
//

import UIKit

final class RecipeCell: UITableViewCell {
    
    @IBOutlet var abv: UILabel!
    @IBOutlet var tagLine: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descript: UILabel!
    @IBOutlet var bottleImage: UIImageView!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with recipe: Recipe) {
        nameLabel.text = recipe.name
        abv.text = "ABV: \(recipe.abv )"
        descript.text = recipe.description
        tagLine.text = recipe.tagLine
        
        networkManager.fetchData(from: recipe.imageUrl ) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.bottleImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
